-- 通用流程审批平台（Flowable）初始化脚本

set @schema_name = database();

set @sql = (
  select if(count(*) = 0,
    'alter table tool_machining_tool add column material_version varchar(10) not null default ''A01'' comment ''物料版本'' after status',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'material_version'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_machining_tool add column material_status varchar(20) not null default ''draft'' comment ''物料状态（draft草稿 processing审签中 effective生效）'' after status',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'material_status'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_machining_tool add column change_apply_by varchar(64) default null comment ''变更申请人'' after approval_status',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'change_apply_by'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_machining_tool add column process_instance_id varchar(64) default null comment ''流程实例ID'' after approval_status',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'process_instance_id'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_machining_tool add column process_definition_key varchar(100) default null comment ''流程定义Key'' after process_instance_id',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'process_definition_key'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

update tool_machining_tool
set material_version = 'A01'
where material_version is null or material_version = '';

alter table tool_machining_tool modify column material_version varchar(10) not null default 'A01' comment '物料版本';
alter table tool_machining_tool modify column material_status varchar(20) not null default 'draft' comment '物料状态（draft草稿 processing审签中 effective生效）';
alter table tool_machining_tool modify column approval_status varchar(20) not null default 'draft' comment '流程状态（draft待提交 processing审批流 effective审签完成 rejected驳回 change_processing变更审批中 changing变更中 change_rejected变更驳回）';

update tool_machining_tool
set approval_status = 'processing'
where approval_status in ('checking', 'auditing');

update tool_machining_tool
set material_status = case
  when approval_status = 'processing' then 'processing'
  when approval_status = 'effective' then 'effective'
  when approval_status in ('change_processing', 'change_rejected') then 'effective'
  when approval_status = 'changing' then 'draft'
  else 'draft'
end;

create table if not exists tool_machining_tool_version (
  version_id bigint not null auto_increment comment '快照ID',
  tool_id bigint not null comment '刀具ID',
  material_code varchar(64) not null comment '刀具物料编码',
  tool_name varchar(100) not null comment '刀具名称',
  tool_brand varchar(100) default '' comment '刀具牌号',
  tool_spec varchar(100) default '' comment '刀具规格',
  tool_model varchar(100) default '' comment '刀具型号',
  tool_category varchar(100) default '' comment '刀具类别',
  manufacturer varchar(100) default '' comment '生产厂家',
  status char(1) default '0' comment '状态（0正常 1停用）',
  material_version varchar(10) not null comment '物料版本',
  material_status varchar(20) not null default 'effective' comment '物料状态',
  approval_status varchar(20) not null default 'effective' comment '流程状态',
  process_instance_id varchar(64) default null comment '流程实例ID',
  process_definition_key varchar(100) default null comment '流程定义Key',
  create_by varchar(64) default '' comment '创建者',
  create_time datetime comment '创建时间',
  update_by varchar(64) default '' comment '更新者',
  update_time datetime comment '更新时间',
  remark varchar(500) default null comment '备注',
  snapshot_by varchar(64) default '' comment '快照创建人',
  snapshot_time datetime comment '快照创建时间',
  primary key (version_id),
  unique key uk_tool_version (tool_id, material_version),
  key idx_tool_version_tool_id (tool_id)
) engine=innodb auto_increment=1 default charset=utf8mb4 collate=utf8mb4_general_ci comment='机加刀具历史版本快照表';

insert ignore into tool_machining_tool_version(
  tool_id, material_code, tool_name, tool_brand, tool_spec, tool_model, tool_category,
  manufacturer, status, material_version, material_status, approval_status, process_instance_id,
  process_definition_key, create_by, create_time, update_by, update_time, remark, snapshot_by, snapshot_time
)
select tool_id, material_code, tool_name, tool_brand, tool_spec, tool_model, tool_category,
       manufacturer, status, material_version, material_status, approval_status, process_instance_id,
       process_definition_key, create_by, create_time, update_by, update_time, remark,
       coalesce(nullif(update_by, ''), nullif(create_by, ''), 'admin'), sysdate()
from tool_machining_tool
where material_status = 'effective' or approval_status = 'effective';

delete from sys_role_menu where menu_id in (2020, 2023, 2024, 2025, 2026);
delete from sys_menu where menu_id in (2020, 2023, 2024, 2025, 2026);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2023, '机加刀具强制删除', 2002, 7, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:machiningTool:forceRemove', '#', 'admin', sysdate(), '', null, '')
on duplicate key update menu_name = values(menu_name), parent_id = values(parent_id), order_num = values(order_num), perms = values(perms), status = values(status);
delete from sys_dict_data where dict_type = 'tool_approval_status' and dict_value in ('checking', 'auditing');
drop table if exists tool_approval_record;

set @sql = (
  select if(count(*) = 1,
    'alter table tool_machining_tool drop column submit_by',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'submit_by'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 1,
    'alter table tool_machining_tool drop column submit_time',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'submit_time'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 1,
    'alter table tool_machining_tool drop column check_by',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'check_by'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 1,
    'alter table tool_machining_tool drop column check_time',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'check_time'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 1,
    'alter table tool_machining_tool drop column audit_by',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'audit_by'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 1,
    'alter table tool_machining_tool drop column audit_time',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_machining_tool' and column_name = 'audit_time'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_part_tool_list add column approval_status varchar(20) not null default ''draft'' comment ''流程状态（draft待提交 processing审批流 effective审签完成 rejected驳回）'' after status',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_part_tool_list' and column_name = 'approval_status'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_part_tool_list add column process_instance_id varchar(64) default null comment ''流程实例ID'' after approval_status',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_part_tool_list' and column_name = 'process_instance_id'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
  select if(count(*) = 0,
    'alter table tool_part_tool_list add column process_definition_key varchar(100) default null comment ''流程定义Key'' after process_instance_id',
    'select 1'
  )
  from information_schema.columns
  where table_schema = @schema_name and table_name = 'tool_part_tool_list' and column_name = 'process_definition_key'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

alter table tool_part_tool_list modify column approval_status varchar(20) not null default 'draft' comment '流程状态（draft待提交 processing审批流 effective审签完成 rejected驳回）';

update tool_part_tool_list
set approval_status = 'effective'
where approval_status is null or approval_status = '';

create table if not exists wf_process_definition_ext (
  id bigint not null auto_increment comment '主键',
  process_definition_id varchar(64) not null comment '流程定义ID',
  process_definition_key varchar(100) not null comment '流程定义Key',
  process_name varchar(200) default '' comment '流程名称',
  category varchar(100) default '' comment '流程分类',
  status char(1) default '0' comment '状态（0启用 1停用）',
  create_by varchar(64) default '' comment '创建者',
  create_time datetime comment '创建时间',
  update_by varchar(64) default '' comment '更新者',
  update_time datetime comment '更新时间',
  remark varchar(500) default null comment '备注',
  primary key (id),
  key idx_wf_def_ext_key (process_definition_key)
) engine=innodb comment='流程定义扩展信息';

create table if not exists wf_business_binding (
  id bigint not null auto_increment comment '主键',
  business_type varchar(100) not null comment '业务类型',
  business_name varchar(100) not null comment '业务名称',
  process_definition_key varchar(100) not null comment '流程定义Key',
  status char(1) default '0' comment '状态（0启用 1停用）',
  create_by varchar(64) default '' comment '创建者',
  create_time datetime comment '创建时间',
  update_by varchar(64) default '' comment '更新者',
  update_time datetime comment '更新时间',
  remark varchar(500) default null comment '备注',
  primary key (id),
  unique key uk_wf_business_binding_type (business_type)
) engine=innodb comment='业务模块与流程定义绑定';

create table if not exists wf_process_instance_ext (
  id bigint not null auto_increment comment '主键',
  process_instance_id varchar(64) not null comment '流程实例ID',
  process_definition_key varchar(100) not null comment '流程定义Key',
  business_type varchar(100) not null comment '业务类型',
  business_id bigint not null comment '业务ID',
  title varchar(255) default '' comment '业务标题',
  start_by varchar(64) default '' comment '发起人',
  start_time datetime comment '发起时间',
  end_time datetime comment '结束时间',
  status varchar(20) default 'running' comment '状态',
  primary key (id),
  unique key uk_wf_instance_ext_pi (process_instance_id),
  key idx_wf_instance_ext_business (business_type, business_id)
) engine=innodb comment='流程实例业务扩展';

create table if not exists wf_task_ext (
  id bigint not null auto_increment comment '主键',
  task_id varchar(64) not null comment '任务ID',
  process_instance_id varchar(64) not null comment '流程实例ID',
  task_name varchar(100) default '' comment '任务名称',
  business_type varchar(100) default '' comment '业务类型',
  business_id bigint default null comment '业务ID',
  status varchar(20) default 'todo' comment '状态',
  create_time datetime comment '创建时间',
  finish_time datetime comment '完成时间',
  primary key (id),
  unique key uk_wf_task_ext_task (task_id),
  key idx_wf_task_ext_pi (process_instance_id)
) engine=innodb comment='任务业务扩展';

create table if not exists wf_comment_attachment (
  id bigint not null auto_increment comment '主键',
  comment_id varchar(64) default null comment 'Flowable意见ID',
  task_id varchar(64) default null comment '任务ID',
  process_instance_id varchar(64) default null comment '流程实例ID',
  file_name varchar(255) not null comment '附件名称',
  file_url varchar(500) not null comment '附件地址',
  upload_by varchar(64) default '' comment '上传人',
  upload_time datetime comment '上传时间',
  primary key (id),
  key idx_wf_attach_task (task_id),
  key idx_wf_attach_pi (process_instance_id)
) engine=innodb comment='审批意见附件';

create table if not exists wf_copy (
  id bigint not null auto_increment comment '主键',
  process_instance_id varchar(64) not null comment '流程实例ID',
  task_id varchar(64) default null comment '任务ID',
  business_type varchar(100) default '' comment '业务类型',
  business_id bigint default null comment '业务ID',
  copy_to varchar(64) not null comment '抄送接收人',
  copy_by varchar(64) default '' comment '抄送人',
  copy_time datetime comment '抄送时间',
  read_flag char(1) default '0' comment '是否已读（0未读 1已读）',
  primary key (id),
  key idx_wf_copy_to (copy_to),
  key idx_wf_copy_pi (process_instance_id)
) engine=innodb comment='流程抄送记录';

insert into wf_business_binding(business_type, business_name, process_definition_key, status, create_by, create_time, remark)
select 'machining_tool', '机加刀具信息', 'machining_tool_approval', '0', 'admin', sysdate(), '内置刀具审批流程'
where not exists (select 1 from wf_business_binding where business_type = 'machining_tool');
insert into wf_business_binding(business_type, business_name, process_definition_key, status, create_by, create_time, remark)
select 'machining_tool_change', '机加刀具修改申请', 'machining_tool_change_approval', '0', 'admin', sysdate(), '内置刀具修改审批流程'
where not exists (select 1 from wf_business_binding where business_type = 'machining_tool_change');
insert into wf_business_binding(business_type, business_name, process_definition_key, status, create_by, create_time, remark)
select 'part_tool_list', '零件刀具清单', 'part_tool_list_approval', '0', 'admin', sysdate(), '内置零件刀具清单审批流程'
where not exists (select 1 from wf_business_binding where business_type = 'part_tool_list');

update sys_dict_data set dict_label = '待提交', list_class = 'info'
where dict_type = 'tool_approval_status' and dict_value = 'draft';
update sys_dict_data set dict_label = '审签完成', list_class = 'success'
where dict_type = 'tool_approval_status' and dict_value = 'effective';
update sys_dict_data set dict_label = '审批流', list_class = 'warning'
where dict_type = 'tool_approval_status' and dict_value = 'processing';
update sys_dict_data set dict_label = '驳回', list_class = 'danger'
where dict_type = 'tool_approval_status' and dict_value = 'rejected';

insert into sys_dict_data(dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 20004, 2, '审批流', 'processing', 'tool_approval_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '审批流'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_approval_status' and dict_value = 'processing');
insert into sys_dict_data(dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 20005, 4, '驳回', 'rejected', 'tool_approval_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '驳回'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_approval_status' and dict_value = 'rejected');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 5, '变更审批中', 'change_processing', 'tool_approval_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '变更审批中'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_approval_status' and dict_value = 'change_processing');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 6, '变更中', 'changing', 'tool_approval_status', '', 'primary', 'N', '0', 'admin', sysdate(), '', null, '变更中'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_approval_status' and dict_value = 'changing');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 7, '变更驳回', 'change_rejected', 'tool_approval_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '变更驳回'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_approval_status' and dict_value = 'change_rejected');
delete from sys_dict_data where dict_type = 'tool_approval_status' and dict_value = 'terminated';

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(3000, '流程管理', 0, 5, 'workflow', null, '', '', 1, 0, 'M', '0', '0', '', 'tree', 'admin', sysdate(), '', null, '流程管理目录')
on duplicate key update menu_name = values(menu_name), parent_id = values(parent_id), order_num = values(order_num), path = values(path), component = values(component), status = values(status);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values
(3001, '流程模型', 3000, 1, 'model', 'workflow/model/index', '', 'WorkflowModel', 1, 0, 'C', '0', '0', 'workflow:model:list', 'build', 'admin', sysdate(), '', null, '流程模型'),
(3002, '流程定义', 3000, 2, 'definition', 'workflow/definition/index', '', 'WorkflowDefinition', 1, 0, 'C', '0', '0', 'workflow:definition:list', 'list', 'admin', sysdate(), '', null, '流程定义'),
(3003, '业务流程配置', 3000, 3, 'business', 'workflow/business/index', '', 'WorkflowBusiness', 1, 0, 'C', '0', '0', 'workflow:definition:bind', 'edit', 'admin', sysdate(), '', null, '业务流程配置'),
(3004, '我的待办', 3000, 4, 'todo', 'workflow/task/todo', '', 'WorkflowTodo', 1, 0, 'C', '0', '0', 'workflow:task:todo', 'validCode', 'admin', sysdate(), '', null, '我的待办'),
(3005, '我的已办', 3000, 5, 'done', 'workflow/task/done', '', 'WorkflowDone', 1, 0, 'C', '0', '0', 'workflow:task:done', 'log', 'admin', sysdate(), '', null, '我的已办'),
(3006, '我的发起', 3000, 6, 'myStarted', 'workflow/process/myStarted', '', 'WorkflowMyStarted', 1, 0, 'C', '0', '0', 'workflow:process:myStarted', 'user', 'admin', sysdate(), '', null, '我的发起'),
(3007, '抄送我的', 3000, 7, 'copy', 'workflow/copy/index', '', 'WorkflowCopy', 1, 0, 'C', '0', '0', 'workflow:copy:list', 'message', 'admin', sysdate(), '', null, '抄送我的'),
(3008, '流程监控', 3000, 8, 'monitor', 'workflow/monitor/index', '', 'WorkflowMonitor', 1, 0, 'C', '0', '0', 'workflow:monitor:list', 'monitor', 'admin', sysdate(), '', null, '流程监控')
on duplicate key update menu_name = values(menu_name), parent_id = values(parent_id), order_num = values(order_num), path = values(path), component = values(component), route_name = values(route_name), perms = values(perms), status = values(status);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2016, '零件刀具提交', 2010, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:submit', '#', 'admin', sysdate(), '', null, '')
on duplicate key update menu_name = values(menu_name), parent_id = values(parent_id), order_num = values(order_num), perms = values(perms), status = values(status);

delete from sys_role_menu where menu_id in (2020, 2023, 2024, 2025, 2026);
delete from sys_menu where menu_id in (2020, 2023, 2024, 2025, 2026);

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values
(3010, '流程模型新增', 3001, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:model:add', '#', 'admin', sysdate(), '', null, ''),
(3011, '流程模型修改', 3001, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:model:edit', '#', 'admin', sysdate(), '', null, ''),
(3012, '流程模型删除', 3001, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:model:remove', '#', 'admin', sysdate(), '', null, ''),
(3013, '流程模型部署', 3001, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:model:deploy', '#', 'admin', sysdate(), '', null, ''),
(3014, '流程定义维护', 3002, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:definition:edit', '#', 'admin', sysdate(), '', null, ''),
(3015, '任务同意', 3004, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:task:complete', '#', 'admin', sysdate(), '', null, ''),
(3016, '任务驳回', 3004, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:task:reject', '#', 'admin', sysdate(), '', null, ''),
(3017, '任务退回', 3004, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:task:return', '#', 'admin', sysdate(), '', null, ''),
(3018, '任务转办', 3004, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:task:transfer', '#', 'admin', sysdate(), '', null, ''),
(3019, '任务委派', 3004, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:task:delegate', '#', 'admin', sysdate(), '', null, ''),
(3020, '任务加签', 3004, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:task:addSign', '#', 'admin', sysdate(), '', null, ''),
(3021, '流程发起', 3006, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:process:start', '#', 'admin', sysdate(), '', null, ''),
(3022, '流程详情', 3006, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:process:detail', '#', 'admin', sysdate(), '', null, ''),
(3023, '流程终止', 3008, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:monitor:terminate', '#', 'admin', sysdate(), '', null, ''),
(3024, '流程跳转', 3008, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'workflow:monitor:jump', '#', 'admin', sysdate(), '', null, '')
on duplicate key update menu_name = values(menu_name), parent_id = values(parent_id), order_num = values(order_num), perms = values(perms), status = values(status);

insert into sys_role(role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark)
select 210, '流程管理员', 'workflow_admin', 20, '1', 1, 1, '0', '0', 'admin', sysdate(), '', null, '流程模型、定义、配置与监控'
where not exists (select 1 from sys_role where role_key = 'workflow_admin');
insert into sys_role(role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark)
select 211, '审批人员', 'workflow_approver', 21, '1', 1, 1, '0', '0', 'admin', sysdate(), '', null, '审批待办与已办'
where not exists (select 1 from sys_role where role_key = 'workflow_approver');
insert into sys_role(role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark)
select 212, '业务发起人', 'workflow_starter', 22, '1', 1, 1, '0', '0', 'admin', sysdate(), '', null, '流程发起与我的发起'
where not exists (select 1 from sys_role where role_key = 'workflow_starter');

insert ignore into sys_role_menu(role_id, menu_id)
select 210, menu_id from sys_menu where menu_id between 3000 and 3024;

insert ignore into sys_role_menu(role_id, menu_id) values
(211, 3000), (211, 3004), (211, 3005), (211, 3015), (211, 3016), (211, 3017), (211, 3022),
(212, 3000), (212, 3006), (212, 3021), (212, 3022),
(200, 3000), (200, 3006), (200, 3021), (200, 3022),
(201, 3000), (201, 3004), (201, 3005), (201, 3015), (201, 3016), (201, 3017), (201, 3022),
(202, 3000), (202, 3004), (202, 3005), (202, 3015), (202, 3016), (202, 3017), (202, 3022);

insert ignore into sys_role_menu(role_id, menu_id) values
(200, 2005),
(200, 2016),
(202, 2005),
(202, 2006),
(202, 2023);
