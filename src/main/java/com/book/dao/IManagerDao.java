package com.book.dao;

import java.util.List;

import com.book.entity.Manager;

/**
 * 数据访问层(Dao)
 * 
 * @author ZhouHang
 * @date 2019/05/14
 */
public interface IManagerDao {

	public boolean login(String id, String password);

	public Manager selectById(String id);

	public int insert(Manager manager);

	public int update(Manager manager, String id);

	public List<Manager> selectList();

	public int deleteById(String id);

}
