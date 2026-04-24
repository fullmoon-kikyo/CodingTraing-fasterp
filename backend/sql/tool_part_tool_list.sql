-- 刀具管理 - 零件刀具清单

create table if not exists tool_part_tool_list (
  list_id bigint not null auto_increment comment '清单ID',
  part_no varchar(64) not null comment '零件号',
  part_name varchar(100) not null comment '零件名称',
  production_unit varchar(100) default '' comment '生产机组',
  process_no varchar(64) default '' comment '工序号',
  process_name varchar(100) default '' comment '工序名称',
  tool_id bigint not null comment '引用刀具ID',
  material_code varchar(64) not null comment '刀具物料编码快照',
  tool_name varchar(100) not null comment '刀具名称快照',
  tool_brand varchar(100) default '' comment '刀具牌号快照',
  tool_spec varchar(100) default '' comment '刀具规格快照',
  tool_model varchar(100) default '' comment '刀具型号快照',
  tool_category varchar(100) default '' comment '刀具类别快照',
  manufacturer varchar(100) default '' comment '生产厂家快照',
  tool_life decimal(18,4) default null comment '刀具寿命',
  tool_life_unit varchar(32) default '' comment '寿命单位',
  status char(1) default '0' comment '状态（0正常 1停用）',
  approval_status varchar(20) not null default 'draft' comment '流程状态（draft待提交 processing审签中 effective审签完成 rejected驳回）',
  process_instance_id varchar(64) default null comment '流程实例ID',
  process_definition_key varchar(100) default null comment '流程定义Key',
  create_by varchar(64) default '' comment '创建者',
  create_time datetime comment '创建时间',
  update_by varchar(64) default '' comment '更新者',
  update_time datetime comment '更新时间',
  remark varchar(500) default null comment '备注',
  primary key (list_id),
  key idx_part_tool_part_no (part_no),
  key idx_part_tool_tool_id (tool_id),
  key idx_part_tool_material_code (material_code)
) engine=innodb auto_increment=1 default charset=utf8mb4 collate=utf8mb4_general_ci comment='零件刀具清单表';

delete from sys_role_menu where menu_id between 2010 and 2016;
delete from sys_menu where menu_id between 2010 and 2016;

insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2010, '零件刀具清单', 2000, 2, 'partToolList', 'tooling/partToolList/index', '', 'PartToolList', 1, 0, 'C', '0', '0', 'tooling:partToolList:list', 'table', 'admin', sysdate(), '', null, '零件刀具清单菜单');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2011, '零件刀具查询', 2010, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2012, '零件刀具新增', 2010, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2013, '零件刀具修改', 2010, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2014, '零件刀具删除', 2010, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2015, '零件刀具导出', 2010, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:export', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values(2016, '零件刀具提交', 2010, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tooling:partToolList:submit', '#', 'admin', sysdate(), '', null, '');

insert into sys_role_menu(role_id, menu_id) select 2, menu_id from sys_menu where menu_id between 2010 and 2016;
