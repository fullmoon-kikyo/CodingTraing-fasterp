package com.ruoyi.web.controller.tooling;

import java.util.List;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.runtime.ProcessInstance;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.MachiningToolVersion;
import com.ruoyi.system.domain.ToolApprovalRequest;
import com.ruoyi.system.service.IMachiningToolService;
import com.ruoyi.workflow.domain.WfStartProcessRequest;
import com.ruoyi.workflow.service.IWorkflowService;

/**
 * 机加刀具信息
 *
 * @author lemon
 */
@RestController
@RequestMapping("/tooling/machiningTool")
public class MachiningToolController extends BaseController
{
    private static final String ROLE_TOOL_AUDITOR = "tool_auditor";

    @Autowired
    private IMachiningToolService machiningToolService;

    @Autowired
    private IWorkflowService workflowService;

    @Autowired
    private RuntimeService runtimeService;

    /**
     * 获取机加刀具信息列表
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:list')")
    @GetMapping("/list")
    public TableDataInfo list(MachiningTool machiningTool)
    {
        startPage();
        List<MachiningTool> list = machiningToolService.selectMachiningToolList(machiningTool);
        return getDataTable(list);
    }

    @Log(title = "机加刀具信息", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, MachiningTool machiningTool)
    {
        List<MachiningTool> list = machiningToolService.selectMachiningToolList(machiningTool);
        ExcelUtil<MachiningTool> util = new ExcelUtil<MachiningTool>(MachiningTool.class);
        util.exportExcel(response, list, "机加刀具信息数据");
    }

    /**
     * 根据刀具ID获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:query')")
    @GetMapping(value = "/{toolId}")
    public AjaxResult getInfo(@PathVariable Long toolId)
    {
        return success(machiningToolService.selectMachiningToolById(toolId));
    }

    /**
     * 查询机加刀具历史版本
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:query')")
    @GetMapping(value = "/{toolId}/versions")
    public AjaxResult versions(@PathVariable Long toolId)
    {
        List<MachiningToolVersion> list = machiningToolService.selectMachiningToolVersions(toolId);
        return success(list);
    }

    /**
     * 新增机加刀具信息
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:add')")
    @Log(title = "机加刀具信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody MachiningTool machiningTool)
    {
        if (!machiningToolService.checkMaterialCodeUnique(machiningTool))
        {
            return error("新增刀具'" + machiningTool.getToolName() + "'失败，刀具物料编码已存在");
        }
        machiningTool.setCreateBy(getUsername());
        return toAjax(machiningToolService.insertMachiningTool(machiningTool));
    }

    /**
     * 修改机加刀具信息
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:edit')")
    @Log(title = "机加刀具信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody MachiningTool machiningTool)
    {
        machiningTool.setUpdateBy(getUsername());
        return toAjax(machiningToolService.updateMachiningTool(machiningTool));
    }

    /**
     * 删除机加刀具信息
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:remove')")
    @Log(title = "机加刀具信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{toolIds}")
    public AjaxResult remove(@PathVariable Long[] toolIds)
    {
        if (isToolAuditor())
        {
            terminateProcessInstances(toolIds);
            return toAjax(machiningToolService.forceDeleteMachiningToolByIds(toolIds));
        }
        return toAjax(machiningToolService.deleteMachiningToolByIds(toolIds));
    }

    /**
     * 强制删除机加刀具信息
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:forceRemove')")
    @Log(title = "机加刀具信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/force/{toolIds}")
    public AjaxResult forceRemove(@PathVariable Long[] toolIds)
    {
        terminateProcessInstances(toolIds);
        return toAjax(machiningToolService.forceDeleteMachiningToolByIds(toolIds));
    }

    private void terminateProcessInstances(Long[] toolIds)
    {
        for (Long toolId : toolIds)
        {
            MachiningTool tool = machiningToolService.selectMachiningToolById(toolId);
            if (tool == null || StringUtils.isBlank(tool.getProcessInstanceId()))
            {
                continue;
            }
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                    .processInstanceId(tool.getProcessInstanceId()).singleResult();
            if (processInstance != null)
            {
                runtimeService.deleteProcessInstance(processInstance.getProcessInstanceId(), "forceRemove:" + getUsername());
            }
        }
    }

    private boolean isToolAuditor()
    {
        return SecurityUtils.isAdmin() || SecurityUtils.hasRole(ROLE_TOOL_AUDITOR);
    }

    /**
     * 提交审签
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:submit')")
    @Log(title = "机加刀具信息", businessType = BusinessType.UPDATE)
    @PostMapping("/{toolId}/submit")
    public AjaxResult submit(@PathVariable Long toolId, @RequestBody(required = false) ToolApprovalRequest request)
    {
        WfStartProcessRequest startRequest = new WfStartProcessRequest();
        startRequest.setBusinessType("machining_tool");
        startRequest.setBusinessId(toolId);
        startRequest.setProcessDefinitionKey("machining_tool_approval");
        startRequest.setComment(getOpinion(request));
        return success(workflowService.startProcess(startRequest, getUsername()));
    }

    /**
     * 提交修改申请审签
     */
    @PreAuthorize("@ss.hasPermi('tooling:machiningTool:edit')")
    @Log(title = "机加刀具修改申请", businessType = BusinessType.UPDATE)
    @PostMapping("/{toolId}/change-apply")
    public AjaxResult changeApply(@PathVariable Long toolId, @RequestBody(required = false) ToolApprovalRequest request)
    {
        machiningToolService.assertCanApplyChange(toolId);
        WfStartProcessRequest startRequest = new WfStartProcessRequest();
        startRequest.setBusinessType("machining_tool_change");
        startRequest.setBusinessId(toolId);
        startRequest.setProcessDefinitionKey("machining_tool_change_approval");
        startRequest.setComment(getOpinion(request));
        return success(workflowService.startProcess(startRequest, getUsername()));
    }

    private String getOpinion(ToolApprovalRequest request)
    {
        return request == null ? null : request.getOpinion();
    }
}
