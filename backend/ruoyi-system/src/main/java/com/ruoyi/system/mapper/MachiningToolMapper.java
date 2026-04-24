package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.MachiningToolVersion;

/**
 * 机加刀具信息 数据层
 *
 * @author lemon
 */
public interface MachiningToolMapper
{
    public List<MachiningTool> selectMachiningToolList(MachiningTool machiningTool);

    public MachiningTool selectMachiningToolById(Long toolId);

    public MachiningTool checkMaterialCodeUnique(String materialCode);

    public int updateEmptyMaterialVersion(String materialVersion);

    public List<MachiningToolVersion> selectMachiningToolVersions(Long toolId);

    public int insertMachiningTool(MachiningTool machiningTool);

    public int insertMachiningToolVersion(MachiningToolVersion machiningToolVersion);

    public int updateMachiningTool(MachiningTool machiningTool);

    public int resetMachiningToolApproval(MachiningTool machiningTool);

    public int updateMachiningToolWorkflow(MachiningTool machiningTool);

    public int deleteMachiningToolById(Long toolId);

    public int deleteMachiningToolByIds(Long[] toolIds);
}
