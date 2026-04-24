package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.PartToolList;

/**
 * 零件刀具清单 服务层
 *
 * @author lemon
 */
public interface IPartToolListService
{
    public List<PartToolList> selectPartToolListList(PartToolList partToolList);

    public PartToolList selectPartToolListById(Long listId);

    public int insertPartToolList(PartToolList partToolList);

    public int updatePartToolList(PartToolList partToolList);

    public int deletePartToolListById(Long listId);

    public int deletePartToolListByIds(Long[] listIds);
}
