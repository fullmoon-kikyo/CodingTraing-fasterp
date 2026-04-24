package com.ruoyi.workflow.service;

/**
 * 流程与业务数据状态同步服务
 */
public interface IWorkflowBusinessCallbackService
{
    public void onProcessStarted(String businessType, Long businessId, String processInstanceId, String processDefinitionKey, String username);

    public void onProcessApproved(String businessType, Long businessId, String processInstanceId, String username);

    public void onProcessRejected(String businessType, Long businessId, String processInstanceId, String username, String opinion);
}
