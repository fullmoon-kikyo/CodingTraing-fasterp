package com.ruoyi.web.controller.workflow;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.workflow.domain.WfProcessDefinitionInfo;
import com.ruoyi.workflow.service.IWorkflowService;

/**
 * 流程定义管理
 */
@RestController
@RequestMapping("/workflow/definition")
public class WorkflowDefinitionController extends BaseController
{
    @Autowired
    private IWorkflowService workflowService;

    @PreAuthorize("@ss.hasPermi('workflow:definition:list')")
    @GetMapping("/list")
    public TableDataInfo list()
    {
        List<WfProcessDefinitionInfo> list = workflowService.selectDefinitionList();
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('workflow:definition:edit')")
    @PutMapping("/{definitionId}/suspend")
    public AjaxResult suspend(@PathVariable String definitionId)
    {
        workflowService.suspendDefinition(definitionId);
        return success();
    }

    @PreAuthorize("@ss.hasPermi('workflow:definition:edit')")
    @PutMapping("/{definitionId}/activate")
    public AjaxResult activate(@PathVariable String definitionId)
    {
        workflowService.activateDefinition(definitionId);
        return success();
    }

    @PreAuthorize("@ss.hasPermi('workflow:definition:bind')")
    @PostMapping("/bindBusiness")
    public AjaxResult bindBusiness()
    {
        return success("第一版已内置 machining_tool -> machining_tool_approval 绑定");
    }

    @PreAuthorize("@ss.hasPermi('workflow:definition:bind')")
    @GetMapping("/businessBindings")
    public AjaxResult businessBindings()
    {
        return success("第一版已内置 machining_tool -> machining_tool_approval 绑定");
    }
}
