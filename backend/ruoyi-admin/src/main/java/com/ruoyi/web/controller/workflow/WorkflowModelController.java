package com.ruoyi.web.controller.workflow;

import java.util.Collections;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 流程模型管理
 */
@RestController
@RequestMapping("/workflow/model")
public class WorkflowModelController extends BaseController
{
    @PreAuthorize("@ss.hasPermi('workflow:model:list')")
    @GetMapping("/list")
    public TableDataInfo list()
    {
        return getDataTable(Collections.emptyList());
    }

    @PreAuthorize("@ss.hasPermi('workflow:model:add')")
    @PostMapping
    public AjaxResult add()
    {
        return error("流程模型在线维护将在流程增强阶段接入");
    }

    @PreAuthorize("@ss.hasPermi('workflow:model:edit')")
    @PutMapping
    public AjaxResult edit()
    {
        return error("流程模型在线维护将在流程增强阶段接入");
    }

    @PreAuthorize("@ss.hasPermi('workflow:model:remove')")
    @DeleteMapping("/{modelIds}")
    public AjaxResult remove(@PathVariable String modelIds)
    {
        return error("流程模型在线维护将在流程增强阶段接入");
    }

    @PreAuthorize("@ss.hasPermi('workflow:model:deploy')")
    @PostMapping("/{modelId}/deploy")
    public AjaxResult deploy(@PathVariable String modelId)
    {
        return error("流程模型部署将在流程增强阶段接入；当前使用内置BPMN自动部署");
    }
}
