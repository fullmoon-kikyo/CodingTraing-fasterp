package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.MachiningToolVersion;

/**
 * 机加刀具信息 服务层
 *
 * @author lemon
 */
public interface IMachiningToolService
{
    public List<MachiningTool> selectMachiningToolList(MachiningTool machiningTool);

    public MachiningTool selectMachiningToolById(Long toolId);

    public List<MachiningToolVersion> selectMachiningToolVersions(Long toolId);

    public boolean checkMaterialCodeUnique(MachiningTool machiningTool);

    public int insertMachiningTool(MachiningTool machiningTool);

    public int updateMachiningTool(MachiningTool machiningTool);

    public void assertCanApplyChange(Long toolId);

    public int deleteMachiningToolById(Long toolId);

    public int deleteMachiningToolByIds(Long[] toolIds);

    public int forceDeleteMachiningToolByIds(Long[] toolIds);

}
