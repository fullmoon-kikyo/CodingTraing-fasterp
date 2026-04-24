package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.MachiningToolVersion;
import com.ruoyi.system.mapper.MachiningToolMapper;
import com.ruoyi.system.service.IMachiningToolService;

/**
 * 机加刀具信息 服务层处理
 *
 * @author lemon
 */
@Service
public class MachiningToolServiceImpl implements IMachiningToolService
{
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

    @Override
    public List<MachiningTool> selectMachiningToolList(MachiningTool machiningTool)
    {
        fillEmptyMaterialVersion();
        return machiningToolMapper.selectMachiningToolList(machiningTool);
    }

    @Override
    public MachiningTool selectMachiningToolById(Long toolId)
    {
        fillEmptyMaterialVersion();
        return machiningToolMapper.selectMachiningToolById(toolId);
    }

    @Override
    public List<MachiningToolVersion> selectMachiningToolVersions(Long toolId)
    {
        fillEmptyMaterialVersion();
        requireTool(toolId);
        return machiningToolMapper.selectMachiningToolVersions(toolId);
    }

    @Override
    public boolean checkMaterialCodeUnique(MachiningTool machiningTool)
    {
        Long toolId = StringUtils.isNull(machiningTool.getToolId()) ? -1L : machiningTool.getToolId();
        MachiningTool info = machiningToolMapper.checkMaterialCodeUnique(machiningTool.getMaterialCode());
        if (StringUtils.isNotNull(info) && info.getToolId().longValue() != toolId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    @Override
    @Transactional
    public int insertMachiningTool(MachiningTool machiningTool)
    {
        machiningTool.setMaterialVersion(INITIAL_VERSION);
        machiningTool.setMaterialStatus(STATUS_DRAFT);
        machiningTool.setApprovalStatus(STATUS_DRAFT);
        machiningTool.setChangeApplyBy(null);
        return machiningToolMapper.insertMachiningTool(machiningTool);
    }

    @Override
    @Transactional
    public int updateMachiningTool(MachiningTool machiningTool)
    {
        MachiningTool old = requireTool(machiningTool.getToolId());
        assertNotEffectiveMaterial(old);
        assertMaterialCodeUnique(machiningTool);
        if (isChangeEditable(old))
        {
            assertChangeApplicant(old, "修改");
            return updateKeepSystemFields(machiningTool, old);
        }
        if (isToolAuditor())
        {
            return updateKeepSystemFields(machiningTool, old);
        }
        assertApplicantOperator(old, "修改");
        assertEditableMaterial(old);
        return updateKeepSystemFields(machiningTool, old);
    }

    @Override
    public void assertCanApplyChange(Long toolId)
    {
        MachiningTool old = requireTool(toolId);
        if (!STATUS_EFFECTIVE.equals(currentMaterialStatus(old)))
        {
            throw new ServiceException("只有已生效物料可以发起修改申请");
        }
        if (!STATUS_EFFECTIVE.equals(old.getApprovalStatus()) && !STATUS_CHANGE_REJECTED.equals(old.getApprovalStatus()))
        {
            throw new ServiceException("当前流程状态不允许发起修改申请");
        }
    }

    private int updateKeepSystemFields(MachiningTool machiningTool, MachiningTool old)
    {
        machiningTool.setMaterialVersion(defaultVersion(old.getMaterialVersion()));
        machiningTool.setMaterialStatus(old.getMaterialStatus());
        machiningTool.setApprovalStatus(old.getApprovalStatus());
        machiningTool.setChangeApplyBy(old.getChangeApplyBy());
        machiningTool.setProcessInstanceId(old.getProcessInstanceId());
        machiningTool.setProcessDefinitionKey(old.getProcessDefinitionKey());
        return machiningToolMapper.updateMachiningTool(machiningTool);
    }

    private void fillEmptyMaterialVersion()
    {
        machiningToolMapper.updateEmptyMaterialVersion(INITIAL_VERSION);
    }

    @Override
    public int deleteMachiningToolById(Long toolId)
    {
        return machiningToolMapper.deleteMachiningToolById(toolId);
    }

    @Override
    @Transactional
    public int deleteMachiningToolByIds(Long[] toolIds)
    {
        for (Long toolId : toolIds)
        {
            MachiningTool tool = requireTool(toolId);
            assertApplicantOperator(tool, "删除");
            assertDraftMaterial(tool, "删除");
        }
        return machiningToolMapper.deleteMachiningToolByIds(toolIds);
    }

    @Override
    @Transactional
    public int forceDeleteMachiningToolByIds(Long[] toolIds)
    {
        for (Long toolId : toolIds)
        {
            requireTool(toolId);
        }
        return machiningToolMapper.deleteMachiningToolByIds(toolIds);
    }

    private MachiningTool requireTool(Long toolId)
    {
        if (toolId == null)
        {
            throw new ServiceException("刀具ID不能为空");
        }
        MachiningTool tool = machiningToolMapper.selectMachiningToolById(toolId);
        if (tool == null)
        {
            throw new ServiceException("刀具信息不存在或已删除");
        }
        return tool;
    }

    private void assertApplicantOperator(MachiningTool tool, String action)
    {
        if (StringUtils.equals(SecurityUtils.getUsername(), tool.getCreateBy()))
        {
            return;
        }
        throw new ServiceException("仅物料申请人可以" + action + "当前物料");
    }

    private void assertChangeApplicant(MachiningTool tool, String action)
    {
        if (StringUtils.equals(SecurityUtils.getUsername(), tool.getChangeApplyBy()))
        {
            return;
        }
        throw new ServiceException("仅当前变更申请人可以" + action + "当前物料");
    }

    private void assertMaterialCodeUnique(MachiningTool machiningTool)
    {
        if (!checkMaterialCodeUnique(machiningTool))
        {
            throw new ServiceException("修改刀具'" + machiningTool.getToolName() + "'失败，刀具物料编码已存在");
        }
    }

    private void assertNotEffectiveMaterial(MachiningTool tool)
    {
        if (STATUS_EFFECTIVE.equals(currentMaterialStatus(tool)))
        {
            throw new ServiceException("物料已生效，不能修改物料");
        }
    }

    private void assertEditableMaterial(MachiningTool tool)
    {
        String materialStatus = currentMaterialStatus(tool);
        if (STATUS_DRAFT.equals(materialStatus))
        {
            return;
        }
        if (STATUS_PROCESSING.equals(materialStatus))
        {
            throw new ServiceException("物料审签中，普通用户不能修改物料");
        }
        if (STATUS_EFFECTIVE.equals(materialStatus))
        {
            throw new ServiceException("物料已生效，普通用户不能修改物料");
        }
        throw new ServiceException("当前物料状态不允许修改");
    }

    private boolean isChangeEditable(MachiningTool tool)
    {
        return StringUtils.isNotBlank(tool.getChangeApplyBy())
                && (STATUS_CHANGING.equals(tool.getApprovalStatus()) || STATUS_REJECTED.equals(tool.getApprovalStatus()));
    }

    private String defaultVersion(String materialVersion)
    {
        return StringUtils.isBlank(materialVersion) ? INITIAL_VERSION : materialVersion;
    }

    private void assertDraftMaterial(MachiningTool tool, String action)
    {
        String materialStatus = currentMaterialStatus(tool);
        if (STATUS_DRAFT.equals(materialStatus))
        {
            return;
        }
        if (STATUS_PROCESSING.equals(materialStatus))
        {
            throw new ServiceException("物料审签中，普通用户不能" + action + "物料");
        }
        if (STATUS_EFFECTIVE.equals(materialStatus))
        {
            throw new ServiceException("物料已生效，普通用户不能" + action + "物料");
        }
        throw new ServiceException("当前物料状态不允许" + action);
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

    private boolean isToolAuditor()
    {
        return SecurityUtils.isAdmin() || SecurityUtils.hasRole(ROLE_TOOL_AUDITOR);
    }

}
