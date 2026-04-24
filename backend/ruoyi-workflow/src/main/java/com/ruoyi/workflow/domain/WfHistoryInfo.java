package com.ruoyi.workflow.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * 流程历史节点信息
 */
public class WfHistoryInfo implements Serializable
{
    private static final long serialVersionUID = 1L;

    private String id;
    private String activityId;
    private String activityName;
    private String activityType;
    private String assignee;
    private Date startTime;
    private Date endTime;
    private Long durationInMillis;

    public String getId()
    {
        return id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getActivityId()
    {
        return activityId;
    }

    public void setActivityId(String activityId)
    {
        this.activityId = activityId;
    }

    public String getActivityName()
    {
        return activityName;
    }

    public void setActivityName(String activityName)
    {
        this.activityName = activityName;
    }

    public String getActivityType()
    {
        return activityType;
    }

    public void setActivityType(String activityType)
    {
        this.activityType = activityType;
    }

    public String getAssignee()
    {
        return assignee;
    }

    public void setAssignee(String assignee)
    {
        this.assignee = assignee;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public Long getDurationInMillis()
    {
        return durationInMillis;
    }

    public void setDurationInMillis(Long durationInMillis)
    {
        this.durationInMillis = durationInMillis;
    }
}
