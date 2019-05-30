package com.cfr.service;

import com.cfr.bean.Employee;
import com.cfr.bean.EmployeeExample;
import com.cfr.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	//	查询所有的员工信息
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	//	跟新员工信息
    public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	//检验当前姓名是否可用
	public int addEmp(Employee employee) {
		return employeeMapper.insertSelective(employee);
	}
	//查看员工姓名是否可用
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
	//按照员工Id查询员工信息
    public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
    }
	//员工删除
	public void deleEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

    public void deleteBatch(List<Integer> empIds) {
	    EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //删除所有的例子中的id 的员工
        criteria.andEmpIdIn(empIds);
	    employeeMapper.deleteByExample(example);
    }
}
