package com.ruoyi.web.controller.workflow;

import java.util.List;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.workflow.domain.WfTaskInfo;
import com.ruoyi.workflow.domain.WfTaskRequest;
import com.ruoyi.workflow.service.IWorkflowService;

/**
 * 流程任务
 */
@RestController
@RequestMapping("/workflow/task")
public class WorkflowTaskController extends BaseController
{
    @Autowired
    private IWorkflowService workflowService;

    @PreAuthorize("@ss.hasPermi('workflow:task:todo')")
    @GetMapping("/todo")
    public TableDataInfo todo()
    {
        List<WfTaskInfo> list = workflowService.selectTodoTasks(getUsername());
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('workflow:task:done')")
    @GetMapping("/done")
    public TableDataInfo done()
    {
        List<WfTaskInfo> list = workflowService.selectDoneTasks(getUsername());
        return getDataTable(list);
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:complete')")
    @PostMapping("/{taskId}/complete")
    public AjaxResult complete(@PathVariable String taskId, @Valid @RequestBody(required = false) WfTaskRequest request)
    {
        workflowService.completeTask(taskId, request, getUsername());
        return success();
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:reject')")
    @PostMapping("/{taskId}/reject")
    public AjaxResult reject(@PathVariable String taskId, @Valid @RequestBody WfTaskRequest request)
    {
        workflowService.rejectTask(taskId, request, getUsername());
        return success();
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:return')")
    @PostMapping("/{taskId}/return")
    public AjaxResult returnTask(@PathVariable String taskId, @Valid @RequestBody WfTaskRequest request)
    {
        workflowService.rejectTask(taskId, request, getUsername());
        return success();
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:transfer')")
    @PostMapping("/{taskId}/transfer")
    public AjaxResult transfer(@PathVariable String taskId, @RequestBody(required = false) WfTaskRequest request)
    {
        return error("转办将在流程增强阶段接入");
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:delegate')")
    @PostMapping("/{taskId}/delegate")
    public AjaxResult delegate(@PathVariable String taskId, @RequestBody(required = false) WfTaskRequest request)
    {
        return error("委派将在流程增强阶段接入");
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:addSign')")
    @PostMapping("/{taskId}/addSign")
    public AjaxResult addSign(@PathVariable String taskId, @RequestBody(required = false) WfTaskRequest request)
    {
        return error("加签将在流程增强阶段接入");
    }

    @Log(title = "流程任务", businessType = BusinessType.UPDATE)
    @PreAuthorize("@ss.hasPermi('workflow:task:delegate')")
    @PostMapping("/{taskId}/resolveDelegate")
    public AjaxResult resolveDelegate(@PathVariable String taskId, @RequestBody(required = false) WfTaskRequest request)
    {
        return error("委派完成将在流程增强阶段接入");
    }
}
