package com.ruoyi.workflow.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * 流程定义列表信息
 */
public class WfProcessDefinitionInfo implements Serializable
{
    private static final long serialVersionUID = 1L;

    private String definitionId;
    private String deploymentId;
    private String category;
    private String name;
    private String key;
    private Integer version;
    private Boolean suspended;
    private Date deploymentTime;

    public String getDefinitionId()
    {
        return definitionId;
    }

    public void setDefinitionId(String definitionId)
    {
        this.definitionId = definitionId;
    }

    public String getDeploymentId()
    {
        return deploymentId;
    }

    public void setDeploymentId(String deploymentId)
    {
        this.deploymentId = deploymentId;
    }

    public String getCategory()
    {
        return category;
    }

    public void setCategory(String category)
    {
        this.category = category;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getKey()
    {
        return key;
    }

    public void setKey(String key)
    {
        this.key = key;
    }

    public Integer getVersion()
    {
        return version;
    }

    public void setVersion(Integer version)
    {
        this.version = version;
    }

    public Boolean getSuspended()
    {
        return suspended;
    }

    public void setSuspended(Boolean suspended)
    {
        this.suspended = suspended;
    }

    public Date getDeploymentTime()
    {
        return deploymentTime;
    }

    public void setDeploymentTime(Date deploymentTime)
    {
        this.deploymentTime = deploymentTime;
    }
}
