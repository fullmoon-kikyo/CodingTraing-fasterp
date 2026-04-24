package com.ruoyi.workflow.service;

import java.io.InputStream;
import java.util.List;
import com.ruoyi.workflow.domain.WfHistoryInfo;
import com.ruoyi.workflow.domain.WfProcessDefinitionInfo;
import com.ruoyi.workflow.domain.WfProcessInfo;
import com.ruoyi.workflow.domain.WfStartProcessRequest;
import com.ruoyi.workflow.domain.WfTaskInfo;
import com.ruoyi.workflow.domain.WfTaskRequest;

/**
 * 通用流程服务
 */
public interface IWorkflowService
{
    public List<WfProcessDefinitionInfo> selectDefinitionList();

    public void suspendDefinition(String definitionId);

    public void activateDefinition(String definitionId);

    public WfProcessInfo startProcess(WfStartProcessRequest request, String username);

    public List<WfProcessInfo> selectMyStarted(String username);

    public WfProcessInfo selectProcessDetail(String processInstanceId);

    public List<WfHistoryInfo> selectProcessHistory(String processInstanceId);

    public InputStream getProcessDiagram(String processInstanceId);

    public List<WfTaskInfo> selectTodoTasks(String username);

    public List<WfTaskInfo> selectDoneTasks(String username);

    public void completeTask(String taskId, WfTaskRequest request, String username);

    public void rejectTask(String taskId, WfTaskRequest request, String username);
}
