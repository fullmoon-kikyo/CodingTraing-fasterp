package com.ruoyi.web.controller.workflow;

import java.io.InputStream;
import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.workflow.domain.WfHistoryInfo;
import com.ruoyi.workflow.domain.WfProcessInfo;
import com.ruoyi.workflow.domain.WfStartProcessRequest;
import com.ruoyi.workflow.service.IWorkflowService;

/**
 * 流程实例
 */
@RestController
@RequestMapping("/workflow/process")
public class WorkflowProcessController extends BaseController
{
    @Autowired
    private IWorkflowService workflowService;

    @PreAuthorize("@ss.hasPermi('workflow:process:start')")
    @PostMapping("/start")
    public AjaxResult start(@Valid @RequestBody WfStartProcessRequest request)
    {
        return success(workflowService.startProcess(request, getUsername()));
    }

    @PreAuthorize("@ss.hasPermi('workflow:process:myStarted')")
    @GetMapping("/myStarted")
    public TableDataInfo myStarted()
    {
        List<WfProcessInfo> list = workflowService.selectMyStarted(getUsername());
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('workflow:process:detail')")
    @GetMapping("/{processInstanceId}")
    public AjaxResult detail(@PathVariable String processInstanceId)
    {
        return success(workflowService.selectProcessDetail(processInstanceId));
    }

    @PreAuthorize("@ss.hasPermi('workflow:process:detail')")
    @GetMapping("/{processInstanceId}/history")
    public TableDataInfo history(@PathVariable String processInstanceId)
    {
        List<WfHistoryInfo> list = workflowService.selectProcessHistory(processInstanceId);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('workflow:process:detail')")
    @GetMapping("/{processInstanceId}/diagram")
    public void diagram(@PathVariable String processInstanceId, HttpServletResponse response) throws Exception
    {
        try (InputStream inputStream = workflowService.getProcessDiagram(processInstanceId))
        {
            if (inputStream == null)
            {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                return;
            }
            response.setContentType("image/png");
            IOUtils.copy(inputStream, response.getOutputStream());
        }
    }
}
