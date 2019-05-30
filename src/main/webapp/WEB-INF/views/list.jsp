 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
    <!--引入样式-->
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
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
				<button class="btn btn-success">新增</button>&nbsp&nbsp
				<button	class="btn btn-danger">删除</button>
			</div>
		</div>
		<div class="row">
		<br>
		</div>
		<!-- 表格 -->
		<div class="row">
			<table class="table table-hover">
				<tr>
                    <th>#</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
           <c:forEach items="${pageInfo.list}" var="emp">
           		<tr>
                    <th>${emp.empId}</th>
                    <th>${emp.empName}</th>
                    <th>${emp.gender=="M"?"男":"女"}</th>
                    <th>${emp.email}</th>
                    <th>${emp.department.deptName}</th>
                    <th>
                    	<button class="btn btn-success btn-sm">
                    		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                    	</button>
                    	<button class="btn btn-danger btn-sm">
                    		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                    	</button>
                    </th>
                </tr>
           </c:forEach>     
                
			</table>
		</div>
		<!-- 结尾 -->
		<div class="row">
        <div class="col-md-6 pageMessage">
        当前第${pageInfo.pageNum}页，总共${pageInfo.pages}页，共${pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="/emps?pn=1">首页</a>
                    </li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>


                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == pageInfo.pageNum}">
                          <li class="active"><a class="disabled">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}">
                            <li><a href="/emps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li>
                        <a href="/emps?pn=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
	
	</div>
</body>
</html>