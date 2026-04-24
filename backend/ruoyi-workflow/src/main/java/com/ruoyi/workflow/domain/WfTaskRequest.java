package com.ruoyi.workflow.domain;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * 审批任务处理请求
 */
public class WfTaskRequest implements Serializable
{
    private static final long serialVersionUID = 1L;

    private String comment;

    private Map<String, Object> variables = new HashMap<>();

    public String getComment()
    {
        return comment;
    }

    public void setComment(String comment)
    {
        this.comment = comment;
    }

    public Map<String, Object> getVariables()
    {
        return variables;
    }

    public void setVariables(Map<String, Object> variables)
    {
        this.variables = variables;
    }
}
