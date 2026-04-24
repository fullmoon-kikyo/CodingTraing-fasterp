import request from '@/utils/request'

export function listWorkflowTodo(query) {
  return request({
    url: '/workflow/task/todo',
    method: 'get',
    params: query
  })
}

export function listWorkflowDone(query) {
  return request({
    url: '/workflow/task/done',
    method: 'get',
    params: query
  })
}

export function completeWorkflowTask(taskId, data) {
  return request({
    url: '/workflow/task/' + taskId + '/complete',
    method: 'post',
    data: data
  })
}

export function rejectWorkflowTask(taskId, data) {
  return request({
    url: '/workflow/task/' + taskId + '/reject',
    method: 'post',
    data: data
  })
}

export function returnWorkflowTask(taskId, data) {
  return request({
    url: '/workflow/task/' + taskId + '/return',
    method: 'post',
    data: data
  })
}
