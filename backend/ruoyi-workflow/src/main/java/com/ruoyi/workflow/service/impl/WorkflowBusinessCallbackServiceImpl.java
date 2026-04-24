package com.ruoyi.workflow.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.MachiningToolVersion;
import com.ruoyi.system.domain.PartToolList;
import com.ruoyi.system.mapper.MachiningToolMapper;
import com.ruoyi.system.mapper.PartToolListMapper;
import com.ruoyi.workflow.service.IWorkflowBusinessCallbackService;

/**
 * 通用流程业务回调实现。
 */
@Service
public class WorkflowBusinessCallbackServiceImpl implements IWorkflowBusinessCallbackService
{
    private static final String BUSINESS_MACHINING_TOOL = "machining_tool";
    private static final String BUSINESS_MACHINING_TOOL_CHANGE = "machining_tool_change";
    private static final String BUSINESS_PART_TOOL_LIST = "part_tool_list";
    private static final String ROLE_TOOL_AUDITOR = "tool_auditor";
    private static final String STATUS_DRAFT = "draft";
    private static final String STATUS_PROCESSING = "processing";
    private static final String STATUS_EFFECTIVE = "effective";
    private static final String STATUS_REJECTED = "rejected";
    private static final String STATUS_CHANGE_PROCESSING = "change_processing";
    private static final String STATUS_CHANGING = "changing";
    private static final String STATUS_CHANGE_REJECTED = "change_rejected";
    private static final String INITIAL_VERSION = "A01";

    @Autowired
    private MachiningToolMapper machiningToolMapper;

    @Autowired
    private PartToolListMapper partToolListMapper;

    @Override
    public void onProcessStarted(String businessType, Long businessId, String processInstanceId, String processDefinitionKey, String username)
    {
        if (BUSINESS_MACHINING_TOOL.equals(businessType))
        {
            MachiningTool old = requireMachiningTool(businessId);
            assertMachiningToolSubmitOperator(old);
            if (!isMachiningToolSubmittable(old))
            {
                throw new ServiceException("只有待提交、驳回或变更中的流程可以提交审签");
            }
            MachiningTool update = workflowUpdate(businessId, old.getMaterialVersion(), STATUS_PROCESSING, STATUS_PROCESSING,
                    old.getChangeApplyBy(), processInstanceId, processDefinitionKey, username);
            machiningToolMapper.updateMachiningToolWorkflow(update);
            return;
        }
        if (BUSINESS_MACHINING_TOOL_CHANGE.equals(businessType))
        {
            MachiningTool old = requireMachiningTool(businessId);
            assertMachiningToolChangeStartable(old);
            MachiningTool update = workflowUpdate(businessId, old.getMaterialVersion(), STATUS_EFFECTIVE, STATUS_CHANGE_PROCESSING,
                    username, processInstanceId, processDefinitionKey, username);
            machiningToolMapper.updateMachiningToolWorkflow(update);
            return;
        }
        if (BUSINESS_PART_TOOL_LIST.equals(businessType))
        {
            PartToolList old = requirePartToolList(businessId);
            if (!STATUS_DRAFT.equals(old.getApprovalStatus()) && !STATUS_REJECTED.equals(old.getApprovalStatus()))
            {
                throw new ServiceException("只有待提交或驳回状态的流程可以提交审签");
            }
            PartToolList update = partToolListWorkflowUpdate(businessId, STATUS_PROCESSING, processInstanceId, processDefinitionKey, username);
            partToolListMapper.updatePartToolListWorkflow(update);
            return;
        }
        throw new ServiceException("暂不支持的流程业务类型：" + businessType);
    }

    @Override
    public void onProcessApproved(String businessType, Long businessId, String processInstanceId, String username)
    {
        if (BUSINESS_MACHINING_TOOL.equals(businessType))
        {
            MachiningTool old = requireMachiningTool(businessId);
            String nextVersion = StringUtils.isBlank(old.getChangeApplyBy()) ? defaultVersion(old.getMaterialVersion()) : nextVersion(old.getMaterialVersion());
            MachiningTool update = workflowUpdate(businessId, nextVersion, STATUS_EFFECTIVE, STATUS_EFFECTIVE,
                    null, processInstanceId, old.getProcessDefinitionKey(), username);
            machiningToolMapper.updateMachiningToolWorkflow(update);
            insertVersionSnapshot(businessId, username);
            return;
        }
        if (BUSINESS_MACHINING_TOOL_CHANGE.equals(businessType))
        {
            MachiningTool old = requireMachiningTool(businessId);
            MachiningTool update = workflowUpdate(businessId, old.getMaterialVersion(), STATUS_DRAFT, STATUS_CHANGING,
                    old.getChangeApplyBy(), processInstanceId, old.getProcessDefinitionKey(), username);
            machiningToolMapper.updateMachiningToolWorkflow(update);
            return;
        }
        if (BUSINESS_PART_TOOL_LIST.equals(businessType))
        {
            PartToolList update = partToolListWorkflowUpdate(businessId, STATUS_EFFECTIVE, processInstanceId, null, username);
            partToolListMapper.updatePartToolListWorkflow(update);
            return;
        }
        throw new ServiceException("暂不支持的流程业务类型：" + businessType);
    }

    @Override
    public void onProcessRejected(String businessType, Long businessId, String processInstanceId, String username, String opinion)
    {
        if (BUSINESS_MACHINING_TOOL.equals(businessType))
        {
            MachiningTool old = requireMachiningTool(businessId);
            MachiningTool update = workflowUpdate(businessId, old.getMaterialVersion(), STATUS_DRAFT, STATUS_REJECTED,
                    old.getChangeApplyBy(), processInstanceId, old.getProcessDefinitionKey(), username);
            machiningToolMapper.updateMachiningToolWorkflow(update);
            return;
        }
        if (BUSINESS_MACHINING_TOOL_CHANGE.equals(businessType))
        {
            MachiningTool old = requireMachiningTool(businessId);
            MachiningTool update = workflowUpdate(businessId, old.getMaterialVersion(), STATUS_EFFECTIVE, STATUS_CHANGE_REJECTED,
                    null, processInstanceId, old.getProcessDefinitionKey(), username);
            machiningToolMapper.updateMachiningToolWorkflow(update);
            return;
        }
        if (BUSINESS_PART_TOOL_LIST.equals(businessType))
        {
            PartToolList update = partToolListWorkflowUpdate(businessId, STATUS_REJECTED, processInstanceId, null, username);
            partToolListMapper.updatePartToolListWorkflow(update);
            return;
        }
        throw new ServiceException("暂不支持的流程业务类型：" + businessType);
    }

    private MachiningTool requireMachiningTool(Long toolId)
    {
        MachiningTool tool = machiningToolMapper.selectMachiningToolById(toolId);
        if (tool == null)
        {
            throw new ServiceException("刀具信息不存在或已删除");
        }
        return tool;
    }

    private PartToolList requirePartToolList(Long listId)
    {
        PartToolList partToolList = partToolListMapper.selectPartToolListById(listId);
        if (partToolList == null)
        {
            throw new ServiceException("零件刀具清单不存在或已删除");
        }
        return partToolList;
    }

    private MachiningTool workflowUpdate(Long toolId, String materialVersion, String materialStatus, String approvalStatus,
            String changeApplyBy, String processInstanceId, String processDefinitionKey, String username)
    {
        MachiningTool update = new MachiningTool();
        update.setToolId(toolId);
        update.setMaterialVersion(defaultVersion(materialVersion));
        update.setMaterialStatus(materialStatus);
        update.setApprovalStatus(approvalStatus);
        update.setChangeApplyBy(changeApplyBy);
        update.setProcessInstanceId(processInstanceId);
        update.setProcessDefinitionKey(processDefinitionKey);
        update.setUpdateBy(username);
        return update;
    }

    private void assertMachiningToolSubmitOperator(MachiningTool tool)
    {
        if (isChangeSubmit(tool))
        {
            if (StringUtils.equals(SecurityUtils.getUsername(), tool.getChangeApplyBy()))
            {
                return;
            }
            throw new ServiceException("仅当前变更申请人可以提交当前物料");
        }
        if (isToolAuditor())
        {
            return;
        }
        if (StringUtils.equals(SecurityUtils.getUsername(), tool.getCreateBy()))
        {
            return;
        }
        throw new ServiceException("仅物料申请人可以提交当前物料");
    }

    private boolean isMachiningToolSubmittable(MachiningTool tool)
    {
        return STATUS_DRAFT.equals(tool.getApprovalStatus())
                || STATUS_REJECTED.equals(tool.getApprovalStatus())
                || STATUS_CHANGING.equals(tool.getApprovalStatus());
    }

    private boolean isChangeSubmit(MachiningTool tool)
    {
        return StringUtils.isNotBlank(tool.getChangeApplyBy())
                && (STATUS_CHANGING.equals(tool.getApprovalStatus()) || STATUS_REJECTED.equals(tool.getApprovalStatus()));
    }

    private void assertMachiningToolChangeStartable(MachiningTool tool)
    {
        if (!STATUS_EFFECTIVE.equals(currentMaterialStatus(tool)))
        {
            throw new ServiceException("只有已生效物料可以发起修改申请");
        }
        if (!STATUS_EFFECTIVE.equals(tool.getApprovalStatus()) && !STATUS_CHANGE_REJECTED.equals(tool.getApprovalStatus()))
        {
            throw new ServiceException("当前流程状态不允许发起修改申请");
        }
    }

    private String currentMaterialStatus(MachiningTool tool)
    {
        if (StringUtils.isNotBlank(tool.getMaterialStatus()))
        {
            return tool.getMaterialStatus();
        }
        if (STATUS_PROCESSING.equals(tool.getApprovalStatus()))
        {
            return STATUS_PROCESSING;
        }
        if (STATUS_EFFECTIVE.equals(tool.getApprovalStatus()) || STATUS_CHANGE_PROCESSING.equals(tool.getApprovalStatus())
                || STATUS_CHANGE_REJECTED.equals(tool.getApprovalStatus()))
        {
            return STATUS_EFFECTIVE;
        }
        return STATUS_DRAFT;
    }

    private String defaultVersion(String materialVersion)
    {
        return StringUtils.isBlank(materialVersion) ? INITIAL_VERSION : materialVersion;
    }

    private String nextVersion(String materialVersion)
    {
        String current = defaultVersion(materialVersion);
        if (!current.matches("A\\d{2}"))
        {
            throw new ServiceException("当前版本号格式不正确，无法递增");
        }
        int number = Integer.parseInt(current.substring(1));
        if (number >= 99)
        {
            throw new ServiceException("版本号已达A99上限，不能继续变更");
        }
        return String.format("A%02d", number + 1);
    }

    private void insertVersionSnapshot(Long toolId, String username)
    {
        MachiningTool tool = requireMachiningTool(toolId);
        MachiningToolVersion snapshot = new MachiningToolVersion();
        snapshot.setToolId(tool.getToolId());
        snapshot.setMaterialCode(tool.getMaterialCode());
        snapshot.setToolName(tool.getToolName());
        snapshot.setToolBrand(tool.getToolBrand());
        snapshot.setToolSpec(tool.getToolSpec());
        snapshot.setToolModel(tool.getToolModel());
        snapshot.setToolCategory(tool.getToolCategory());
        snapshot.setManufacturer(tool.getManufacturer());
        snapshot.setStatus(tool.getStatus());
        snapshot.setMaterialVersion(defaultVersion(tool.getMaterialVersion()));
        snapshot.setMaterialStatus(tool.getMaterialStatus());
        snapshot.setApprovalStatus(tool.getApprovalStatus());
        snapshot.setProcessInstanceId(tool.getProcessInstanceId());
        snapshot.setProcessDefinitionKey(tool.getProcessDefinitionKey());
        snapshot.setCreateBy(tool.getCreateBy());
        snapshot.setCreateTime(tool.getCreateTime());
        snapshot.setUpdateBy(tool.getUpdateBy());
        snapshot.setUpdateTime(tool.getUpdateTime());
        snapshot.setRemark(tool.getRemark());
        snapshot.setSnapshotBy(username);
        machiningToolMapper.insertMachiningToolVersion(snapshot);
    }

    private boolean isToolAuditor()
    {
        return SecurityUtils.isAdmin() || SecurityUtils.hasRole(ROLE_TOOL_AUDITOR);
    }

    private PartToolList partToolListWorkflowUpdate(Long listId, String approvalStatus, String processInstanceId, String processDefinitionKey, String username)
    {
        PartToolList update = new PartToolList();
        update.setListId(listId);
        update.setApprovalStatus(approvalStatus);
        update.setProcessInstanceId(processInstanceId);
        update.setProcessDefinitionKey(processDefinitionKey);
        update.setUpdateBy(username);
        return update;
    }

}
