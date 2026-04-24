package com.ruoyi.workflow.domain;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 流程启动请求
 */
public class WfStartProcessRequest implements Serializable
{
    private static final long serialVersionUID = 1L;

    @NotBlank(message = "业务类型不能为空")
    private String businessType;

    @NotNull(message = "业务ID不能为空")
    private Long businessId;

    @NotBlank(message = "流程定义Key不能为空")
    private String processDefinitionKey;

    private Map<String, Object> variables = new HashMap<>();

    private String comment;

    public String getBusinessType()
    {
        return businessType;
    }

    public void setBusinessType(String businessType)
    {
        this.businessType = businessType;
    }

    public Long getBusinessId()
    {
        return businessId;
    }

    public void setBusinessId(Long businessId)
    {
        this.businessId = businessId;
    }

    public String getProcessDefinitionKey()
    {
        return processDefinitionKey;
    }

    public void setProcessDefinitionKey(String processDefinitionKey)
    {
        this.processDefinitionKey = processDefinitionKey;
    }

    public Map<String, Object> getVariables()
    {
        return variables;
    }

    public void setVariables(Map<String, Object> variables)
    {
        this.variables = variables;
    }

    public String getComment()
    {
        return comment;
    }

    public void setComment(String comment)
    {
        this.comment = comment;
    }
}
