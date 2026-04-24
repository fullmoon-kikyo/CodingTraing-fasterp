package com.ruoyi.web.controller.workflow;

import java.util.Collections;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 流程监控
 */
@RestController
@RequestMapping("/workflow/monitor")
public class WorkflowMonitorController extends BaseController
{
    @PreAuthorize("@ss.hasPermi('workflow:monitor:list')")
    @GetMapping("/running")
    public TableDataInfo running()
    {
        return getDataTable(Collections.emptyList());
    }

    @PreAuthorize("@ss.hasPermi('workflow:monitor:terminate')")
    @PostMapping("/{processInstanceId}/terminate")
    public AjaxResult terminate(@PathVariable String processInstanceId)
    {
        return error("流程终止将在流程增强阶段接入");
    }

    @PreAuthorize("@ss.hasPermi('workflow:monitor:jump')")
    @PostMapping("/{processInstanceId}/jump")
    public AjaxResult jump(@PathVariable String processInstanceId)
    {
        return error("流程跳转将在流程增强阶段接入");
    }
}
