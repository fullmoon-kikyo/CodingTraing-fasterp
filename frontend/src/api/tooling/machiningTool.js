import request from '@/utils/request'

// 查询机加刀具信息列表
export function listMachiningTool(query) {
  return request({
    url: '/tooling/machiningTool/list',
    method: 'get',
    params: query
  })
}

// 查询机加刀具信息详细
export function getMachiningTool(toolId) {
  return request({
    url: '/tooling/machiningTool/' + toolId,
    method: 'get'
  })
}

// 新增机加刀具信息
export function addMachiningTool(data) {
  return request({
    url: '/tooling/machiningTool',
    method: 'post',
    data: data
  })
}

// 修改机加刀具信息
export function updateMachiningTool(data) {
  return request({
    url: '/tooling/machiningTool',
    method: 'put',
    data: data
  })
}

// 删除机加刀具信息
export function delMachiningTool(toolId) {
  return request({
    url: '/tooling/machiningTool/' + toolId,
    method: 'delete'
  })
}

// 强制删除机加刀具信息
export function forceDelMachiningTool(toolId) {
  return request({
    url: '/tooling/machiningTool/force/' + toolId,
    method: 'delete'
  })
}

// 提交机加刀具信息
export function submitMachiningTool(toolId, data) {
  return request({
    url: '/tooling/machiningTool/' + toolId + '/submit',
    method: 'post',
    data: data
  })
}

// 提交机加刀具修改申请
export function changeApplyMachiningTool(toolId, data) {
  return request({
    url: '/tooling/machiningTool/' + toolId + '/change-apply',
    method: 'post',
    data: data
  })
}

// 查询机加刀具历史版本
export function listMachiningToolVersions(toolId) {
  return request({
    url: '/tooling/machiningTool/' + toolId + '/versions',
    method: 'get'
  })
}
