package com.cfr.service;

import com.cfr.bean.Department;
import com.cfr.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        //查出的所有的部门信息
        List<Department> list= departmentMapper.selectByExample(null);
        return  list;
    }
}
