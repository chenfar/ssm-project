package com.cfr.controller;

import com.cfr.bean.Employee;
import com.cfr.bean.Msg;
import com.cfr.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeController {
	@Autowired
	EmployeeService employService;
	/*
	 * 要导入jackson包
	 * 用json数据来做交互
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value="pn",defaultValue="1") Integer pn) {
		PageHelper.startPage(pn,5);		
		List<Employee> emps=employService.getAll();
		//使用pageinfo包装 查询结果 
		PageInfo page= new PageInfo(emps,5);
		return Msg.success().add("pageInfo",page);	
	}
	//更新员工
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		employService.updateEmp(employee);
		return  Msg.success();
	}
	/*
	校验员工名是否可用
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg chevkkuse(String empName){
		//先判断用户名时候是合法的表达式
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg","用户名必须6到16的数字英文或者2到5的汉字");
		}
		//数据库重复校验
		boolean b=employService.checkUser(empName);
		if(b){
			return Msg.success();
		}
		return Msg.fail().add("va_msg","用户名不可用");
	}
	/*
	单个批量删除二合一
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empIds}",method = RequestMethod.DELETE)
	public Msg deleEmpById(@PathVariable("empIds") String empIds) {
        //批量删除
        if (empIds.contains("-")) {
            //把数据切割成 string的数组，然后转成list
            List<Integer> list = new ArrayList<>();
            String[] str_ids = empIds.split("-");
            for (String s : str_ids) {
                list.add(Integer.parseInt(s));
            }
            employService.deleteBatch(list);
        } else {
            //单个删除
            Integer id = Integer.parseInt(empIds);
            employService.deleEmpById(id);
        }
        return Msg.success();
    }
	/**
     * 添加员工
     *1. 支持JSR303校验
     *2. 导入hibernate-validator
     *3. bean加入patten注解
     *4. BindingResult来获得错误信息
     * @param employee
	 * @return
	 * 校验：@Valid   BindingResult bindingResult   还要再类里面配置要求
	 */
	@RequestMapping("/emp")
	@ResponseBody
	public Msg addEmp(@Valid Employee employee, BindingResult bindingResult){
		if(bindingResult.hasErrors()) {
			//校验失败返回错误信息
			Map<String ,Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = bindingResult.getFieldErrors();
			for(FieldError error : fieldErrors){
				System.out.println("错误的字段名"+error.getField());
				System.out.println("错误的信息"+error.getDefaultMessage());
				map.put(error.getField(),error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields",map);
		}else {
			int result = employService.addEmp(employee);
			if(result != 0){
				return this.getEmpsWithJson(1);
			}else{
				return Msg.fail().add("errMsg","新增信息失败");
			}
		}
	}
	//员工信息获取
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee=employService.getEmp(id);
		return  Msg.success().add("emp",employee);
	}
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn, Model model) {
		//这不是一个分页查询
		//引入分页插件  使用:传入页码  和 每一页的大小，它后面的查询就是分页查询
		PageHelper.startPage(pn,5);		
		List<Employee> emps=employService.getAll();
		//使用pageinfo包装 查询结果 
		PageInfo page= new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}
