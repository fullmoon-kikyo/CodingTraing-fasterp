import request from '@/utils/request'

export function listWorkflowDefinition(query) {
  return request({
    url: '/workflow/definition/list',
    method: 'get',
    params: query
  })
}

export function suspendWorkflowDefinition(definitionId) {
  return request({
    url: '/workflow/definition/' + definitionId + '/suspend',
    method: 'put'
  })
}

export function activateWorkflowDefinition(definitionId) {
  return request({
    url: '/workflow/definition/' + definitionId + '/activate',
    method: 'put'
  })
}

export function getBusinessBindings() {
  return request({
    url: '/workflow/definition/businessBindings',
    method: 'get'
  })
}
