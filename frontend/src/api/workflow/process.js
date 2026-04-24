import request from '@/utils/request'

export function startWorkflowProcess(data) {
  return request({
    url: '/workflow/process/start',
    method: 'post',
    data: data
  })
}

export function listMyStartedProcess(query) {
  return request({
    url: '/workflow/process/myStarted',
    method: 'get',
    params: query
  })
}

export function getWorkflowProcess(processInstanceId) {
  return request({
    url: '/workflow/process/' + processInstanceId,
    method: 'get'
  })
}

export function listWorkflowProcessHistory(processInstanceId) {
  return request({
    url: '/workflow/process/' + processInstanceId + '/history',
    method: 'get'
  })
}
