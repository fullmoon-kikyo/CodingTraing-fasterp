package com.ruoyi.workflow.flowable;

import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.delegate.JavaDelegate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.workflow.service.IWorkflowBusinessCallbackService;

/**
 * 流程结束前同步业务数据为生效状态。
 */
@Component("workflowBusinessCallbackDelegate")
public class WorkflowBusinessCallbackDelegate implements JavaDelegate
{
    @Autowired
    private IWorkflowBusinessCallbackService businessCallbackService;

    @Override
    public void execute(DelegateExecution execution)
    {
        String businessType = (String) execution.getVariable("businessType");
        Long businessId = toLong(execution.getVariable("businessId"));
        String username = (String) execution.getVariable("lastOperator");
        if (StringUtils.isBlank(username))
        {
            username = (String) execution.getVariable("submitUser");
        }
        businessCallbackService.onProcessApproved(businessType, businessId, execution.getProcessInstanceId(), username);
    }

    private Long toLong(Object value)
    {
        if (value == null)
        {
            return null;
        }
        if (value instanceof Number)
        {
            return ((Number) value).longValue();
        }
        return Long.valueOf(String.valueOf(value));
    }
}
