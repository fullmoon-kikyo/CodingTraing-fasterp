package com.ruoyi.workflow.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.flowable.engine.HistoryService;
import org.flowable.engine.IdentityService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.PartToolList;
import com.ruoyi.system.mapper.MachiningToolMapper;
import com.ruoyi.system.mapper.PartToolListMapper;
import com.ruoyi.workflow.domain.WfHistoryInfo;
import com.ruoyi.workflow.domain.WfProcessDefinitionInfo;
import com.ruoyi.workflow.domain.WfProcessInfo;
import com.ruoyi.workflow.domain.WfStartProcessRequest;
import com.ruoyi.workflow.domain.WfTaskInfo;
import com.ruoyi.workflow.domain.WfTaskRequest;
import com.ruoyi.workflow.service.IWorkflowBusinessCallbackService;
import com.ruoyi.workflow.service.IWorkflowService;

/**
 * 通用流程服务实现
 */
@Service
public class WorkflowServiceImpl implements IWorkflowService
{
    private static final String BUSINESS_MACHINING_TOOL = "machining_tool";
    private static final String BUSINESS_MACHINING_TOOL_CHANGE = "machining_tool_change";
    private static final String BUSINESS_PART_TOOL_LIST = "part_tool_list";

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService;

    @Autowired
    private HistoryService historyService;

    @Autowired
    private IdentityService identityService;

    @Autowired
    private MachiningToolMapper machiningToolMapper;

    @Autowired
    private PartToolListMapper partToolListMapper;

    @Autowired
    private IWorkflowBusinessCallbackService businessCallbackService;

    @Override
    public List<WfProcessDefinitionInfo> selectDefinitionList()
    {
        List<ProcessDefinition> definitions = repositoryService.createProcessDefinitionQuery()
                .latestVersion()
                .orderByProcessDefinitionKey()
                .asc()
                .list();
        List<WfProcessDefinitionInfo> rows = new ArrayList<>();
        for (ProcessDefinition definition : definitions)
        {
            WfProcessDefinitionInfo info = new WfProcessDefinitionInfo();
            info.setDefinitionId(definition.getId());
            info.setDeploymentId(definition.getDeploymentId());
            info.setCategory(definition.getCategory());
            info.setName(definition.getName());
            info.setKey(definition.getKey());
            info.setVersion(definition.getVersion());
            info.setSuspended(definition.isSuspended());
            Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(definition.getDeploymentId()).singleResult();
            if (deployment != null)
            {
                info.setDeploymentTime(deployment.getDeploymentTime());
            }
            rows.add(info);
        }
        return rows;
    }

    @Override
    public void suspendDefinition(String definitionId)
    {
        repositoryService.suspendProcessDefinitionById(definitionId, true, null);
    }

    @Override
    public void activateDefinition(String definitionId)
    {
        repositoryService.activateProcessDefinitionById(definitionId, true, null);
    }

    @Override
    @Transactional
    public WfProcessInfo startProcess(WfStartProcessRequest request, String username)
    {
        Map<String, Object> variables = new HashMap<>();
        if (request.getVariables() != null)
        {
            variables.putAll(request.getVariables());
        }
        variables.put("businessType", request.getBusinessType());
        variables.put("businessId", request.getBusinessId());
        variables.put("submitUser", username);
        variables.put("lastOperator", username);

        String businessKey = buildBusinessKey(request.getBusinessType(), request.getBusinessId());
        identityService.setAuthenticatedUserId(username);
        try
        {
            ProcessInstance instance = runtimeService.startProcessInstanceByKey(request.getProcessDefinitionKey(), businessKey, variables);
            businessCallbackService.onProcessStarted(request.getBusinessType(), request.getBusinessId(), instance.getProcessInstanceId(),
                    request.getProcessDefinitionKey(), username);
            return toProcessInfo(instance, variables);
        }
        finally
        {
            identityService.setAuthenticatedUserId(null);
        }
    }

    @Override
    public List<WfProcessInfo> selectMyStarted(String username)
    {
        List<HistoricProcessInstance> instances = historyService.createHistoricProcessInstanceQuery()
                .startedBy(username)
                .orderByProcessInstanceStartTime()
                .desc()
                .list();
        return instances.stream().map(this::toProcessInfo).collect(Collectors.toList());
    }

    @Override
    public WfProcessInfo selectProcessDetail(String processInstanceId)
    {
        ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        if (instance != null)
        {
            return toProcessInfo(instance, runtimeService.getVariables(processInstanceId));
        }
        HistoricProcessInstance historic = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();
        if (historic == null)
        {
            throw new ServiceException("流程实例不存在");
        }
        return toProcessInfo(historic);
    }

    @Override
    public List<WfHistoryInfo> selectProcessHistory(String processInstanceId)
    {
        List<HistoricActivityInstance> activities = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .orderByHistoricActivityInstanceStartTime()
                .asc()
                .list();
        List<WfHistoryInfo> rows = new ArrayList<>();
        for (HistoricActivityInstance activity : activities)
        {
            WfHistoryInfo info = new WfHistoryInfo();
            info.setId(activity.getId());
            info.setActivityId(activity.getActivityId());
            info.setActivityName(activity.getActivityName());
            info.setActivityType(activity.getActivityType());
            info.setAssignee(activity.getAssignee());
            info.setStartTime(activity.getStartTime());
            info.setEndTime(activity.getEndTime());
            info.setDurationInMillis(activity.getDurationInMillis());
            rows.add(info);
        }
        return rows;
    }

    @Override
    public InputStream getProcessDiagram(String processInstanceId)
    {
        String definitionId = null;
        ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        if (instance != null)
        {
            definitionId = instance.getProcessDefinitionId();
        }
        else
        {
            HistoricProcessInstance historic = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .singleResult();
            if (historic != null)
            {
                definitionId = historic.getProcessDefinitionId();
            }
        }
        if (definitionId == null)
        {
            throw new ServiceException("流程实例不存在");
        }
        return repositoryService.getProcessDiagram(definitionId);
    }

    @Override
    public List<WfTaskInfo> selectTodoTasks(String username)
    {
        Map<String, Task> taskMap = new LinkedHashMap<>();
        if (SecurityUtils.isAdmin())
        {
            for (Task task : taskService.createTaskQuery().active().orderByTaskCreateTime().desc().list())
            {
                taskMap.put(task.getId(), task);
            }
        }
        else
        {
            for (Task task : taskService.createTaskQuery().taskAssignee(username).active().orderByTaskCreateTime().desc().list())
            {
                taskMap.put(task.getId(), task);
            }
            List<String> roleKeys = getLoginRoleKeys();
            if (!roleKeys.isEmpty())
            {
                for (Task task : taskService.createTaskQuery().taskCandidateGroupIn(roleKeys).active().orderByTaskCreateTime().desc().list())
                {
                    taskMap.put(task.getId(), task);
                }
            }
        }
        List<WfTaskInfo> rows = new ArrayList<>();
        for (Task task : taskMap.values())
        {
            rows.add(toTaskInfo(task));
        }
        return rows;
    }

    @Override
    public List<WfTaskInfo> selectDoneTasks(String username)
    {
        List<HistoricTaskInstance> tasks = historyService.createHistoricTaskInstanceQuery()
                .taskAssignee(username)
                .finished()
                .orderByHistoricTaskInstanceEndTime()
                .desc()
                .list();
        return tasks.stream().map(this::toTaskInfo).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void completeTask(String taskId, WfTaskRequest request, String username)
    {
        Task task = requireTask(taskId);
        if (StringUtils.isBlank(task.getAssignee()))
        {
            taskService.claim(taskId, username);
        }
        if (request != null && StringUtils.isNotBlank(request.getComment()))
        {
            taskService.addComment(taskId, task.getProcessInstanceId(), "complete", request.getComment());
        }
        Map<String, Object> variables = new HashMap<>();
        if (request != null && request.getVariables() != null)
        {
            variables.putAll(request.getVariables());
        }
        variables.put("lastOperator", username);
        taskService.complete(taskId, variables);
    }

    @Override
    @Transactional
    public void rejectTask(String taskId, WfTaskRequest request, String username)
    {
        if (request == null || StringUtils.isBlank(request.getComment()))
        {
            throw new ServiceException("驳回意见不能为空");
        }
        Task task = requireTask(taskId);
        Map<String, Object> variables = runtimeService.getVariables(task.getProcessInstanceId());
        String businessType = (String) variables.get("businessType");
        Long businessId = toLong(variables.get("businessId"));
        taskService.addComment(taskId, task.getProcessInstanceId(), "reject", request.getComment());
        businessCallbackService.onProcessRejected(businessType, businessId, task.getProcessInstanceId(), username, request.getComment());
        runtimeService.deleteProcessInstance(task.getProcessInstanceId(), "reject:" + request.getComment());
    }

    private Task requireTask(String taskId)
    {
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        if (task == null)
        {
            throw new ServiceException("审批任务不存在或已处理");
        }
        return task;
    }

    private WfTaskInfo toTaskInfo(Task task)
    {
        Map<String, Object> variables = runtimeService.getVariables(task.getProcessInstanceId());
        WfTaskInfo info = new WfTaskInfo();
        info.setTaskId(task.getId());
        info.setTaskName(task.getName());
        info.setAssignee(task.getAssignee());
        info.setCreateTime(task.getCreateTime());
        info.setProcessInstanceId(task.getProcessInstanceId());
        info.setProcessDefinitionId(task.getProcessDefinitionId());
        fillDefinitionKey(info, task.getProcessDefinitionId());
        fillBusiness(info, (String) variables.get("businessType"), toLong(variables.get("businessId")));
        info.setStatus("todo");
        return info;
    }

    private WfTaskInfo toTaskInfo(HistoricTaskInstance task)
    {
        WfTaskInfo info = new WfTaskInfo();
        info.setTaskId(task.getId());
        info.setTaskName(task.getName());
        info.setAssignee(task.getAssignee());
        info.setCreateTime(task.getCreateTime());
        info.setEndTime(task.getEndTime());
        info.setProcessInstanceId(task.getProcessInstanceId());
        info.setProcessDefinitionId(task.getProcessDefinitionId());
        fillDefinitionKey(info, task.getProcessDefinitionId());
        HistoricProcessInstance process = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(task.getProcessInstanceId()).singleResult();
        fillBusinessByKey(info, process == null ? null : process.getBusinessKey());
        info.setStatus("done");
        return info;
    }

    private WfProcessInfo toProcessInfo(ProcessInstance instance, Map<String, Object> variables)
    {
        WfProcessInfo info = new WfProcessInfo();
        info.setProcessInstanceId(instance.getProcessInstanceId());
        info.setProcessDefinitionId(instance.getProcessDefinitionId());
        info.setBusinessKey(instance.getBusinessKey());
        fillDefinition(info, instance.getProcessDefinitionId());
        fillBusiness(info, (String) variables.get("businessType"), toLong(variables.get("businessId")));
        info.setStatus("running");
        return info;
    }

    private WfProcessInfo toProcessInfo(HistoricProcessInstance instance)
    {
        WfProcessInfo info = new WfProcessInfo();
        info.setProcessInstanceId(instance.getId());
        info.setProcessDefinitionId(instance.getProcessDefinitionId());
        info.setBusinessKey(instance.getBusinessKey());
        info.setStartUserId(instance.getStartUserId());
        info.setStartTime(instance.getStartTime());
        info.setEndTime(instance.getEndTime());
        fillDefinition(info, instance.getProcessDefinitionId());
        fillBusinessByKey(info, instance.getBusinessKey());
        info.setStatus(instance.getEndTime() == null ? "running" : "finished");
        return info;
    }

    private void fillDefinition(WfProcessInfo info, String definitionId)
    {
        if (StringUtils.isBlank(definitionId))
        {
            return;
        }
        ProcessDefinition definition = repositoryService.createProcessDefinitionQuery().processDefinitionId(definitionId).singleResult();
        if (definition != null)
        {
            info.setProcessDefinitionKey(definition.getKey());
            info.setProcessDefinitionName(definition.getName());
        }
    }

    private void fillDefinitionKey(WfTaskInfo info, String definitionId)
    {
        if (StringUtils.isBlank(definitionId))
        {
            return;
        }
        ProcessDefinition definition = repositoryService.createProcessDefinitionQuery().processDefinitionId(definitionId).singleResult();
        if (definition != null)
        {
            info.setProcessDefinitionKey(definition.getKey());
        }
    }

    private void fillBusiness(WfTaskInfo info, String businessType, Long businessId)
    {
        info.setBusinessType(businessType);
        info.setBusinessId(businessId);
        info.setBusinessTitle(selectBusinessTitle(businessType, businessId));
    }

    private void fillBusiness(WfProcessInfo info, String businessType, Long businessId)
    {
        info.setBusinessType(businessType);
        info.setBusinessId(businessId);
        info.setBusinessTitle(selectBusinessTitle(businessType, businessId));
    }

    private void fillBusinessByKey(WfTaskInfo info, String businessKey)
    {
        BusinessKey key = parseBusinessKey(businessKey);
        fillBusiness(info, key.businessType, key.businessId);
    }

    private void fillBusinessByKey(WfProcessInfo info, String businessKey)
    {
        BusinessKey key = parseBusinessKey(businessKey);
        fillBusiness(info, key.businessType, key.businessId);
    }

    private String selectBusinessTitle(String businessType, Long businessId)
    {
        if ((BUSINESS_MACHINING_TOOL.equals(businessType) || BUSINESS_MACHINING_TOOL_CHANGE.equals(businessType)) && businessId != null)
        {
            MachiningTool tool = machiningToolMapper.selectMachiningToolById(businessId);
            if (tool != null)
            {
                return tool.getMaterialCode() + " - " + tool.getToolName();
            }
        }
        if (BUSINESS_PART_TOOL_LIST.equals(businessType) && businessId != null)
        {
            PartToolList partToolList = partToolListMapper.selectPartToolListById(businessId);
            if (partToolList != null)
            {
                return partToolList.getPartNo() + " - " + partToolList.getPartName() + " / " + partToolList.getMaterialCode();
            }
        }
        return businessType + ":" + businessId;
    }

    private List<String> getLoginRoleKeys()
    {
        if (SecurityUtils.getLoginUser().getUser().getRoles() == null)
        {
            return new ArrayList<>();
        }
        return SecurityUtils.getLoginUser().getUser().getRoles().stream()
                .map(SysRole::getRoleKey)
                .filter(StringUtils::isNotBlank)
                .collect(Collectors.toList());
    }

    private String buildBusinessKey(String businessType, Long businessId)
    {
        return businessType + ":" + businessId;
    }

    private BusinessKey parseBusinessKey(String businessKey)
    {
        BusinessKey key = new BusinessKey();
        if (StringUtils.isBlank(businessKey) || !businessKey.contains(":"))
        {
            return key;
        }
        String[] parts = businessKey.split(":", 2);
        key.businessType = parts[0];
        key.businessId = toLong(parts[1]);
        return key;
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

    private static class BusinessKey
    {
        private String businessType;
        private Long businessId;
    }
}
