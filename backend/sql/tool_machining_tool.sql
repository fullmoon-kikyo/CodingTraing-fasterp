-- 刀具管理 - 机加刀具信息

update sys_menu set visible = '1', status = '1' where menu_id = 4 and menu_name = '若依官网';

insert into sys_dict_type(dict_id, dict_name, dict_type, status, create_by, create_time, remark)
select 100, '刀具使用状态', 'tool_usage_status', '0', 'admin', sysdate(), '刀具业务使用状态列表'
where not exists (select 1 from sys_dict_type where dict_type = 'tool_usage_status');

insert into sys_dict_data(dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 20100, 1, '生效', '0', 'tool_usage_status', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '生效状态'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_usage_status' and dict_value = '0');

insert into sys_dict_data(dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 20101, 2, '失效', '1', 'tool_usage_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '失效状态'
where not exists (select 1 from sys_dict_data where dict_type = 'tool_usage_status' and dict_value = '1');

create table if not exists tool_machining_tool (
  tool_id bigint not null auto_increment comment '刀具ID',
  material_code varchar(64) not null comment '刀具物料编码',
  tool_name varchar(100) not null comment '刀具名称',
  tool_brand varchar(100) default '' comment '刀具牌号',
  tool_spec varchar(100) default '' comment '刀具规格',
  tool_model varchar(100) default '' comment '刀具型号',
  tool_category varchar(100) default '' comment '刀具类别',
  manufacturer varchar(100) default '' comment '生产厂家',
  status char(1) default '0' comment '状态（0生效 1失效）',
  material_version varchar(10) not null default 'A01' comment '物料版本',
  material_status varchar(20) not null default 'draft' comment '物料状态（draft草稿 processing审签中 effective已归档）',
  approval_status varchar(20) not null default 'draft' comment '流程状态（draft待提交 processing审批流 effective审签完成 rejected驳回 change_processing变更审批中 changing变更中 change_rejected变更驳回）',
  change_apply_by varchar(64) default null comment '变更申请人',
  process_instance_id varchar(64) default null comment '流程实例ID',
  process_definition_key varchar(100) default null comment '流程定义Key',
  create_by varchar(64) default '' comment '创建者',
  create_time datetime comment '创建时间',
  update_by varchar(64) default '' comment '更新者',
  update_time datetime comment '更新时间',
  remark varchar(500) default null comment '备注',
  primary key (tool_id),
  unique key uk_tool_material_code (material_code)
) engine=innodb auto_increment=1 default charset=utf8mb4 collate=utf8mb4_general_ci comment='机加刀具信息表';

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
  status char(1) default '0' comment '状态（0生效 1失效）',
  material_version varchar(10) not null comment '物料版本',
  material_status varchar(20) not null default 'effective' comment '物料状态（draft草稿 processing审签中 effective已归档）',
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

delete from sys_role_menu where menu_id between 2000 and 2008;
delete from sys_menu where menu_id between 2000 and 2008;

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2000, '刀具管理', 0, 5, 'tooling', null, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', sysdate(), '', null, '刀具管理目录');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2001, '刀具数据库', 2000, 1, 'database', null, '', '', 1, 0, 'M', '0', '0', '', 'table', 'admin', sysdate(), '', null, '刀具数据库目录');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2002, '机加刀具信息', 2001, 1, 'machiningTool', 'tooling/machiningTool/index', '', 'MachiningTool', 1, 0, 'C', '0', '0', 'tooling:machiningTool:list', 'list', 'admin', sysdate(), '', null, '机加刀具信息菜单');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2003, '机加刀具查询', 2002, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:machiningTool:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2004, '机加刀具新增', 2002, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:machiningTool:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2005, '机加刀具修改', 2002, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:machiningTool:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2006, '机加刀具删除', 2002, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:machiningTool:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2007, '机加刀具导出', 2002, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:machiningTool:export', '#', 'admin', sysdate(), '', null, '');

insert into sys_role_menu(role_id, menu_id) select 2, menu_id from sys_menu where menu_id between 2000 and 2007;
