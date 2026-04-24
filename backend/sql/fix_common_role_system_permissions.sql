-- 修复普通角色(common)误拥有“系统管理 / 系统监控 / 系统工具”目录及其子菜单/按钮权限的问题。
-- 可安全重复执行。

START TRANSACTION;

WITH RECURSIVE restricted_menu_tree AS (
  SELECT menu_id
  FROM sys_menu
  WHERE menu_id IN (1, 2, 3)
  UNION ALL
  SELECT m.menu_id
  FROM sys_menu m
  INNER JOIN restricted_menu_tree t ON m.parent_id = t.menu_id
)
DELETE rm
FROM sys_role_menu rm
INNER JOIN sys_role r ON r.role_id = rm.role_id
INNER JOIN restricted_menu_tree t ON t.menu_id = rm.menu_id
WHERE r.role_key = 'common';

COMMIT;

SELECT
  r.role_key,
  COUNT(*) AS remaining_restricted_menu_count
FROM sys_role_menu rm
INNER JOIN sys_role r ON r.role_id = rm.role_id
INNER JOIN sys_menu m ON m.menu_id = rm.menu_id
WHERE r.role_key = 'common'
  AND (m.menu_id IN (1, 2, 3) OR m.parent_id IN (1, 2, 3) OR m.parent_id IN (
    SELECT menu_id FROM sys_menu WHERE parent_id IN (1, 2, 3)
  ))
GROUP BY r.role_key;
