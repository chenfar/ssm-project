# ssm-project

[**我的博客**](https://www.ccgofa.top)

[![Build Status](https://travis-ci.org/ZHENFENG13/My-Blog.svg?branch=master)](https://www.ccgofa.top)
![Version 1.0.0](https://img.shields.io/badge/version-1.0.0-yellow.svg)
[![License](https://img.shields.io/badge/license-apache-blue.svg)](https://www.ccgofa.top)

这是一个基于SpingMVC+Spring+Mybatis的员工信息管理项目。数据库是MySQL8.0.15。

**这里主要是介绍一下如何让一个GitHub上面的开源项目跑起来**



## 基于Maven和idea，运行一个开源项目

### 首先你需要下载源码

```shell
mkdir projects
cd projects/
git clone https://github.com/cfr321/ssm-project.git
```

这样你就就将源码下载过来了

### 在idea中打开它

- 启动idea，选择import Project。让后选择下载的项目，然后idea就会自动识别是一个Maven项目。
- 然后配置好JDK，选择好maven 项目自动导入

- 如果是个maven web 项目的话，进入之后直接用maven install，这个项目。然后就可以配置tomacat了。
- 在运行环境里面添加tomcat，并配置好war包给它。
- 最后将数据库连接信息改成自己的。这个项目的配置的话是在**dbconfig.properties**，文件里面。
- 然后要准备好数据库。我这里只准备了建表sql。自己可以在test里面写个循环调mapper层插入数据。

### 然后就愉快的运行起来了

页面展示

![](readme_Images\\QQ截图20190530141903.png)

新增修改

![](readme_Images\\QQ截图20190530141927.png)



## 简单介绍

- 使用 jQuery+bootstrap，主要的操作都是通过发Ajax请求完成。并对员工信息进行了前端和后端的JSP303校验，页面展示是用过JSP。
- SpringMVC作为控制层，接受页面的Ajax请求。使用 [ **pagehelper**](<https://github.com/pagehelper/Mybatis-PageHelper>) 实现分页功能。持久层使用Mybatis框架，并使用了它的逆向工程自动生成mapper.xml文件。



## 联系我

Blog: [www.ccgofa.top](www.ccgofa.top)

QQ: **825655513**

Email:  wellshake@qq.com
