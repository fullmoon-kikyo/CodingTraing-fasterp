package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.MachiningTool;
import com.ruoyi.system.domain.PartToolList;
import com.ruoyi.system.mapper.MachiningToolMapper;
import com.ruoyi.system.mapper.PartToolListMapper;
import com.ruoyi.system.service.IPartToolListService;

/**
 * 零件刀具清单 服务层处理
 *
 * @author lemon
 */
@Service
public class PartToolListServiceImpl implements IPartToolListService
{
    private static final String STATUS_DRAFT = "draft";
    private static final String STATUS_PROCESSING = "processing";
    private static final String STATUS_EFFECTIVE = "effective";
    private static final String STATUS_REJECTED = "rejected";
    @Autowired
    private PartToolListMapper partToolListMapper;

    @Autowired
    private MachiningToolMapper machiningToolMapper;

    @Override
    public List<PartToolList> selectPartToolListList(PartToolList partToolList)
    {
        return partToolListMapper.selectPartToolListList(partToolList);
    }

    @Override
    public PartToolList selectPartToolListById(Long listId)
    {
        return partToolListMapper.selectPartToolListById(listId);
    }

    @Override
    public int insertPartToolList(PartToolList partToolList)
    {
        fillToolSnapshot(partToolList);
        partToolList.setApprovalStatus(STATUS_DRAFT);
        return partToolListMapper.insertPartToolList(partToolList);
    }

    @Override
    public int updatePartToolList(PartToolList partToolList)
    {
        PartToolList old = requirePartToolList(partToolList.getListId());
        if (STATUS_PROCESSING.equals(old.getApprovalStatus()))
        {
            throw new ServiceException("审签中的零件刀具清单不能修改，请先驳回或退回");
        }
        fillToolSnapshot(partToolList);
        partToolList.setApprovalStatus(STATUS_DRAFT);
        int rows = partToolListMapper.updatePartToolList(partToolList);
        if (STATUS_EFFECTIVE.equals(old.getApprovalStatus()) || STATUS_REJECTED.equals(old.getApprovalStatus()))
        {
            PartToolList reset = new PartToolList();
            reset.setListId(partToolList.getListId());
            reset.setApprovalStatus(STATUS_DRAFT);
            reset.setUpdateBy(partToolList.getUpdateBy());
            partToolListMapper.resetPartToolListApproval(reset);
        }
        return rows;
    }

    @Override
    public int deletePartToolListById(Long listId)
    {
        return partToolListMapper.deletePartToolListById(listId);
    }

    @Override
    public int deletePartToolListByIds(Long[] listIds)
    {
        for (Long listId : listIds)
        {
            PartToolList partToolList = requirePartToolList(listId);
            if (!STATUS_DRAFT.equals(partToolList.getApprovalStatus()) && !STATUS_REJECTED.equals(partToolList.getApprovalStatus()))
            {
                throw new ServiceException("仅草稿或已驳回状态的零件刀具清单允许删除");
            }
        }
        return partToolListMapper.deletePartToolListByIds(listIds);
    }

    private PartToolList requirePartToolList(Long listId)
    {
        if (listId == null)
        {
            throw new ServiceException("清单ID不能为空");
        }
        PartToolList partToolList = partToolListMapper.selectPartToolListById(listId);
        if (partToolList == null)
        {
            throw new ServiceException("零件刀具清单不存在或已删除");
        }
        return partToolList;
    }

    /**
     * 刀具字段由刀具数据库引用生成，不接受前端手工传入的快照值。
     */
    private void fillToolSnapshot(PartToolList partToolList)
    {
        if (partToolList.getToolId() == null)
        {
            throw new ServiceException("请选择引用刀具");
        }
        MachiningTool tool = machiningToolMapper.selectMachiningToolById(partToolList.getToolId());
        if (tool == null)
        {
            throw new ServiceException("引用刀具不存在或已删除");
        }
        if (!"0".equals(tool.getStatus()) || !"effective".equals(tool.getApprovalStatus()))
        {
            throw new ServiceException("仅允许引用已生效且启用的刀具");
        }
        partToolList.setMaterialCode(tool.getMaterialCode());
        partToolList.setToolName(tool.getToolName());
        partToolList.setToolBrand(tool.getToolBrand());
        partToolList.setToolSpec(tool.getToolSpec());
        partToolList.setToolModel(tool.getToolModel());
        partToolList.setToolCategory(tool.getToolCategory());
        partToolList.setManufacturer(tool.getManufacturer());
    }
}
