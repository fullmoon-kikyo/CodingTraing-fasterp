package com.ruoyi.web.controller.tooling;

import java.util.List;
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
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.PartToolList;
import com.ruoyi.system.service.IPartToolListService;
import com.ruoyi.system.domain.ToolApprovalRequest;
import com.ruoyi.workflow.domain.WfStartProcessRequest;
import com.ruoyi.workflow.service.IWorkflowService;

/**
 * 零件刀具清单
 *
 * @author lemon
 */
@RestController
@RequestMapping("/tooling/partToolList")
public class PartToolListController extends BaseController
{
    @Autowired
    private IPartToolListService partToolListService;

    @Autowired
    private IWorkflowService workflowService;

    /**
     * 获取零件刀具清单列表
     */
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:list')")
    @GetMapping("/list")
    public TableDataInfo list(PartToolList partToolList)
    {
        startPage();
        List<PartToolList> list = partToolListService.selectPartToolListList(partToolList);
        return getDataTable(list);
    }

    @Log(title = "零件刀具清单", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, PartToolList partToolList)
    {
        List<PartToolList> list = partToolListService.selectPartToolListList(partToolList);
        ExcelUtil<PartToolList> util = new ExcelUtil<PartToolList>(PartToolList.class);
        util.exportExcel(response, list, "零件刀具清单数据");
    }

    /**
     * 根据清单ID获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:query')")
    @GetMapping(value = "/{listId}")
    public AjaxResult getInfo(@PathVariable Long listId)
    {
        return success(partToolListService.selectPartToolListById(listId));
    }

    /**
     * 新增零件刀具清单
     */
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:add')")
    @Log(title = "零件刀具清单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody PartToolList partToolList)
    {
        partToolList.setCreateBy(getUsername());
        return toAjax(partToolListService.insertPartToolList(partToolList));
    }

    /**
     * 修改零件刀具清单
     */
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:edit')")
    @Log(title = "零件刀具清单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody PartToolList partToolList)
    {
        partToolList.setUpdateBy(getUsername());
        return toAjax(partToolListService.updatePartToolList(partToolList));
    }

    /**
     * 删除零件刀具清单
     */
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:remove')")
    @Log(title = "零件刀具清单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{listIds}")
    public AjaxResult remove(@PathVariable Long[] listIds)
    {
        return toAjax(partToolListService.deletePartToolListByIds(listIds));
    }

    /**
     * 提交审批
     */
    @PreAuthorize("@ss.hasPermi('tooling:partToolList:submit')")
    @Log(title = "零件刀具清单", businessType = BusinessType.UPDATE)
    @PostMapping("/{listId}/submit")
    public AjaxResult submit(@PathVariable Long listId, @RequestBody(required = false) ToolApprovalRequest request)
    {
        WfStartProcessRequest startRequest = new WfStartProcessRequest();
        startRequest.setBusinessType("part_tool_list");
        startRequest.setBusinessId(listId);
        startRequest.setProcessDefinitionKey("part_tool_list_approval");
        startRequest.setComment(request == null ? null : request.getOpinion());
        return success(workflowService.startProcess(startRequest, getUsername()));
    }
}
