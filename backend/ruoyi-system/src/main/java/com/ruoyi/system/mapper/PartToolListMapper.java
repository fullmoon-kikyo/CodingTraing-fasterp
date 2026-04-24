package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.PartToolList;

/**
 * 零件刀具清单 数据层
 *
 * @author lemon
 */
public interface PartToolListMapper
{
    public List<PartToolList> selectPartToolListList(PartToolList partToolList);

    public PartToolList selectPartToolListById(Long listId);

    public int insertPartToolList(PartToolList partToolList);

    public int updatePartToolList(PartToolList partToolList);

    public int updatePartToolListWorkflow(PartToolList partToolList);

    public int resetPartToolListApproval(PartToolList partToolList);

    public int deletePartToolListById(Long listId);

    public int deletePartToolListByIds(Long[] listIds);
}
