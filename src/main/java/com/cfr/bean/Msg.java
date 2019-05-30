package com.cfr.bean;
/*
 * 定义通用的返回数据的类型
 */

import java.util.HashMap;
import java.util.Map;

public class Msg {
	//状态码
	private int code;
	//提示信息
	private String msg;
	//用户要返回的信息  我们用一个map来储存
	private Map<String, Object> extend =new HashMap<String, Object>();
	
	public static Msg success() {
		Msg result =new Msg();
		result.setCode(100);
		result.setMsg("处理成功");
		return result;
	}
	
	public Msg() {
		super();
	}

	public Msg(int code, String msg, Map<String, Object> extend) {
		super();
		this.code = code;
		this.msg = msg;
		this.extend = extend;
	}

	public static Msg fail() {
		Msg result =new Msg();
		result.setCode(200);
		result.setMsg("处理失败");
		return result;
	}
	//将返回信息存储到Msg
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
}
