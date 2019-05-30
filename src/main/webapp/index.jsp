 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    pageContext.setAttribute("path", path);
    pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<base href="basePath">

<meta charset="UTF-8">
<title>员工列表</title>
<!-- 引入js -->
  	<!--<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>  
    <script src="//cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>  -->
    
    
    <script type="text/javascript" src="static/js/jquery/jquery.min.js"></script>
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 员工添加模态框  Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
						<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
						<span class="help-block"></span>
					</div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
				      <label class="radio-inline">
							<input type="radio" name="gender" id="gender1_add_input" value="M">男
						</label>
						<label class="radio-inline">
							<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
						</label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				    <!-- 部门选择 -->
				      	<select class="form-control" name="dId" id="dept_add_select">
							
						</select>
				    </div>
				  </div>
				  
				 
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 员工修改模态框  Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" >员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label  class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label  class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender1_update_input" value="M">男
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label  class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门选择 -->
								<select class="form-control" name="dId" id="dept_update_select">
								</select>
							</div>
						</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 搭建页面 -->
	<div class="container">
		<!--标题  -->
		<div class="row">
			<div class="col-sm-12">
				<h1>SSM_CURD</h1>
			</div>
		</div>
		<!-- 按钮 --> 
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-success" id="emp_add_modal_btn">新增</button>&nbsp&nbsp
				<button	class="btn btn-danger" id="emp_delete_btn">删除</button>
			</div>
		</div>
		<div class="row">
		</div>
		<!-- 表格 -->
		<div class="row">
			<table class="table table-hover" id="emp_table">
				<thead>
				<tr>
					<th>
						<input type="checkbox" id="check_all"/>
					</th>
                    <th>#</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操 作</th>
                </tr>
				</thead>
				<tbody>
				</tbody>    
			</table>
		</div>
		<!-- 结尾 -->
		<div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">   
        </div>
    </div>	
	</div>
	<script type="text/javascript">
		var totaRecord,currentPage;
		//1、页面加载完成以后，直接ajax发送请求，要到分页数据
		$(function(pn){
        	to_page(1);
   		 });
		function to_page(pn){
	        $.ajax({
	            url:"emps",
	            data:"pn="+pn,
	            type:"GET",
	            success:function(result){
	                //1.解析显示员工信息
	                build_emps_table(result);
	                //2. 解析显示分页信息
	                build_page_info(result);
	                //3. 解析显示分页条
	                build_page_nav(result);
	              
	            }
	        });
	    }
		//1、解析并显示员工具体信息
		function build_emps_table(result){
			//清空table
			$("#emp_table tbody").empty();
			var emps=result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-xs edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//位按钮添加自定义属性
				editBtn.attr("edit-id",item.empId);
			   var delBtn  = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn")
			   .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
			   delBtn.attr("del-id",item.empId);
			   var btnTd   = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emp_table tbody");
			});
		}
		//2、解释左边的分页信息的分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
	        $("#page_info_area").append("当前第"+
	                result.extend.pageInfo.pageNum+"页,总共"+
	                result.extend.pageInfo.pages+"页，总共"+
	                result.extend.pageInfo.total+"条记录");
			totaRecord=result.extend.pageInfo.total;
			currentPage=result.extend.pageInfo.pageNum;
	}
		//3、显示分页信息条,点击跳转
		function build_page_nav(result){
			$("#page_nav_area").empty();
			$("#check_all").prop("checked",'');
			var ul = $("<ul></ul>").addClass("pagination");
			//实现首页 前一页点击  什么时候不能点的设置
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页"));
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			//后一页末页  点击 不能点的设置
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页"));
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
			}
			//添加到
			ul.append(firstPageLi).append(prePageLi);
			//变量每个li
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
			if(result.extend.pageInfo.pageNum==item){
				numLi.addClass("active");
			}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle=$("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//4、查出员工的部门信息
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"depts",
				type:"get",
				success:function(result) {
					$.each(result.extend.depts,function(){
						var optionEle =$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		//员工添加模态框设置
		$("#emp_add_modal_btn").click(function(){
			//重置模态框,表单完全重置
			$("#myModal form")[0].reset();
			$("#empName_add_input").parent().removeClass("has-success has-error");
			$("#empName_add_input").next("span").text("");
			$("#email_add_input").parent().removeClass("has-success has-error");
			$("#email_add_input").next("span").text("");
			//查出所有的部门信息放在部门下拉栏
			getDepts("#dept_add_select");
			//弹出模态框
			$('#myModal').modal({
				backdrop:"static"
			});
		});
		//检验表单数据
		function validate_add_form(){
			//1、拿到表单数据,校验名字
			var empNanme=$("#empName_add_input").val();
			var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/; //jquery正则表达式
			if (!regName.test(empNanme)) {
				show_validata_masg("#empName_add_input","error","请输入2-5中文或者6-16的英文");
				return false;
			}else{
				show_validata_masg("#empName_add_input","success","");
			}
			//校验邮箱
			var email=$("#email_add_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validata_masg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validata_masg("#email_add_input","success","");
			}
			return true;
	}
		//框改变函数
		function show_validata_masg(ele,statu,msg){
			//清除元素当前状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==statu){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else{
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		//校验名字是否可用,只要框内信息发生改边就擦欧总
		$("#empName_add_input").change(function () {
				var empName=this.value;
				$.ajax({
					url:"checkuser",
					data:"empName="+empName,
					type:"POST",
					success:function (result) {
						if(result.code==100){
							show_validata_masg("#empName_add_input","success","用户名可用");
							$("#emp_save_btn").attr("ajax-va","success");
						}else{
							show_validata_masg("#empName_add_input","error",result.extend.va_msg);
							$("#emp_save_btn").attr("ajax-va","error");
						}
					}
				})
		});
		//点击保存员工按钮
		$("#emp_save_btn").click(function(){
			//1. 模态框表单数据提交给服务器进行保存
			//2. 数据格式正确性
			if(!validate_add_form()){
				return false;
			}
			//3. 用户存在,ajax-va
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//4. ajax请求保存
			$.ajax({
				url:"emp",
				type:"POST",
				data:$("#myModal form").serialize(),
				success: function (result) {
					if(result.code == 100){
						//保存成功
						//1. 关闭模态框
						$("#myModal").modal('hide');
						//2.来最后一页
						to_page(result.extend.pageInfo.pages);
					}else {
						//undefined是未定义的意思
						if(undefined!= result.extend.errorFields.email){
							//演示用户邮箱错误信息
							show_validata_masg("#email_add_input","error",result.extend.errorFields.email);

						}
						if(undefined!= result.extend.errorFields.empName){
							//演示用户名字的错误信息
							show_validata_masg("#empName_add_input","error",result.extend.errorFields.empName);
						}
						return false;
					}
				}
			});
			to_page(totalRecord);
		});
		//给员工修改的按钮绑定点击事件，因为按钮是如果直接用click是在按钮创建之前完成的
		//应该用这种方法
		$(document).on("click",".edit_btn",function () {
			//1、查出员工信息 显示
			getEmp($(this).attr("edit-id"));
			//2、查出部门信息，显示
			getDepts("#dept_update_select");
			//3、弹出模态框
			//把员工id传给跟新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$('#empUpdateModal').modal({
				backdrop:"static"
			});
		});
		//获取员工信息
		function getEmp(id) {
			$.ajax({
				url:"emp/"+id,
				type:"GET",
				success:function (result) {
					//
					var emp=result.extend.emp;
					$("#empName_update_static").text(emp.empName);
					$("#email_update_input").val(emp.email);
					$("#empUpdateModal input[name=gender]").val([emp.gender]);
					$("#empUpdateModal select").val([emp.dId]);
				}
			});
		}
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function () {
			//校验邮箱信息
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validata_masg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validata_masg("#email_update_input","success","");
			}
			//发送ajax请求，更新数据
			$.ajax({
				url:"emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success: function (result) {
					//1. 关闭模态框
					$("#empUpdateModal").modal('hide');
					to_page(currentPage);
				}
			})
		});

		//单个删除按钮
		$(document).on("click",".delete_btn",function () {
			//1、弹出是否确认删除
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			// alert($(this).parent("tr").find("td:eq(1)").text()); //td:eq(1)是选择tr下面的第二个td
			if(confirm("确认删除【"+empName+"】吗？")){
				//确认删除
				$.ajax({
					url:"emp/"+empId,
					type:"DELETE",
					success:function (result) {
						//回到本页
						to_page(currentPage);
					}
				})
			}
		});
		//全选全部选的check功能
		$("#check_all").click(function () {
			//prop来获取this是否被选中
			$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//check_item
		$(document).on("click",".check_item",function () {
			//判断当前的是否被选满了  .check_item:checked   表示被选中的
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		})
		//给全选按钮绑定事件
		$("#emp_delete_btn").click(function () {
			// $(".check_item:checked")
			var empName="";
			var del_idstr="";
			$.each($(".check_item:checked"),function () {
				//this就是当前遍历的值
				empName +=$(this).parents("tr").find("td:eq(2)").text()+",";
				del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			empName.substring(0,empName.length-1);
			del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empName+"】吗？")){
				//发送ajax请求
				$.ajax({
					url:"emp/"+del_idstr,
					type:"DELETE",
					success:function (result) {
						alert(result.msg);
						to_page(currentPage);
					}
				})
			}
		});
	</script>
</body>
</html>