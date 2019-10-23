package com.neusoft.dao;

import com.neusoft.bean.ManagerRoleRf;

import java.util.List;

public interface ManagerRoleRfMapper {
    int deleteByPrimaryKey(Integer rfId);

    int insert(ManagerRoleRf record);

    int insertSelective(ManagerRoleRf record);

    ManagerRoleRf selectByPrimaryKey(Integer rfId);

    int updateByPrimaryKeySelective(ManagerRoleRf record);

    int updateByPrimaryKey(ManagerRoleRf record);

    int deletebyManagerid(Integer managerid);
    int insertAll(List<ManagerRoleRf> list);
}