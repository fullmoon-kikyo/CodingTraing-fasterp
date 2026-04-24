import request from '@/utils/request'

// 查询零件刀具清单列表
export function listPartToolList(query) {
  return request({
    url: '/tooling/partToolList/list',
    method: 'get',
    params: query
  })
}

// 查询零件刀具清单详细
export function getPartToolList(listId) {
  return request({
    url: '/tooling/partToolList/' + listId,
    method: 'get'
  })
}

// 新增零件刀具清单
export function addPartToolList(data) {
  return request({
    url: '/tooling/partToolList',
    method: 'post',
    data: data
  })
}

// 修改零件刀具清单
export function updatePartToolList(data) {
  return request({
    url: '/tooling/partToolList',
    method: 'put',
    data: data
  })
}

// 提交零件刀具清单审批
export function submitPartToolList(listId, data) {
  return request({
    url: '/tooling/partToolList/' + listId + '/submit',
    method: 'post',
    data: data
  })
}

// 删除零件刀具清单
export function delPartToolList(listId) {
  return request({
    url: '/tooling/partToolList/' + listId,
    method: 'delete'
  })
}
