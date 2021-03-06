<%@page import="factory.TouBiaoFactory"%>
<%@page import="vo.TouBiao"%>
<%@page import="factory.ZhaoBiaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ZhaoBiao"%>
<%@page import="factory.CodeFactory"%>
<%@page import="vo.Code"%>
<%@page import="factory.CompanyFactory"%>
<%@page import="vo.Company"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的投标信息</title>
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" type="text/css" href="css/title.css">
<link rel="stylesheet" type="text/css" href="css/showBuyOrder.css">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<link rel="stylesheet" type="text/css" href="css/table.css">
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="nav">
		<span class="span"><a href="shouye.html">首页</a></span><span class="span"><a href="geRenZhongXin.html">个人中心</a></span><span>查看我的订单</span>
</div>

<div class="management">
	<div class="managementInclude">
		<jsp:include page="left.jsp"></jsp:include>
		<div class="managementRight">
				<span><b>查看我的招标信息</b></span><hr>
				<table id="search">
						<tr class="firstTr">
						<th class="title1">投标公司</th>
						<th class="title2">工时</th>
						<th class="title3">项目报价</th>
						<th class="title4">投标日期</th>
						<th class="title5">操作</th>
						</tr>
					<% 
						HttpSession sess =request.getSession();
						String name = "";
						if(sess.getAttribute("User")!=null){
						name = 	(String)sess.getAttribute("User");
						}
						int index=1;
						if(request.getParameter("index")!=null){
							index = new Integer(request.getParameter("index"));
						}
						List<Company> list = null;
						list = CompanyFactory.get().getCompanyByOwnofAll(name);
						List<TouBiao> TouBiaoList = new ArrayList<TouBiao>();
						for(Company company:list){
							List<TouBiao> temp = TouBiaoFactory.get().getTouBiaoByOwn(company.getId()+"");
							for(TouBiao touBiao:temp){
								touBiao.setCompanyName(company.getCompanyName());
							}
							TouBiaoList.addAll(temp);
						}
						for(TouBiao touBiao:TouBiaoList){
					%>						
									<tr>
										<th>
											<%=touBiao.getCompanyName()%></a>
										</th>
										<th class="unit"><%=touBiao.getWorkTime()%>(天)</th>
										<th class="count"><%=touBiao.getMoney()%>(万元)</th>
										<th class="status"><%=touBiao.getUpdateDate()%></th>
										<th>
											<a href="touBiao.jsp?id=<%=touBiao.getId()%>">查看投标信息</a>
										</th>
									</tr>
					<%
						}
					%>
					</table>
					<div class="index">
					<%
						if(index==1){
					%>
						无上页
					<%	
						}else{
					%>
						<a href="showSellOrder.jsp?index=<%=index-1 %>">上一页</a>
					<%
						}
						int count =CompanyFactory.get().countOfOwn(name);
						count =count/6+1;
						int i =0;
						if((index-5)<0){
							i=0;
						}else{
							i=index-5;
						}
						for(int x=i;x<Math.min(Math.max(10, index+5), count);x++){
							if(x!=index-1){
					%>
						<a href="showSellOrder.jsp?index=<%=x+1 %>"><%=x+1 %></a>	
					<% 		
							}else{
					%>
							<%=x+1 %>
					<% 			
							}
						}
					%>
					<%
						if(index==count){
					%>
						无下页
					<%	
						}else{
					%>
						<a href="showSellOrder.jsp?index=<%=index+1 %>">下一页</a>
					<%
						}
					%>
				</div>
		</div>
	</div>
</div>

<div class="footer">
	<div class ="footerInclude">
		<ul>
			<li>
				<span>新手入门</span><br>
				<a href="#">免费注册</a><br>
				<a href="#">如何购买商品</a><br>
				<a href="#">如何发布商品</a>
			</li>
			<li>
				<span>诚信服务</span><br>
				<a href="#">用户协议</a><br>
				<a href="#">免责声明</a><br>
				<a href="#">7*24小时服务</a>
			</li>
			<li>
				<span>交易保障</span><br>
				<a href="#">寄售交易</a><br>
				<a href="#">支付宝交易</a><br>
				<a href="#">建议与投诉</a>
			</li>
			<li>
				<span>售后服务</span><br>
				<a href="#">联系客服</a>
			</li>
			<li>
				<span>友情链接</span><br>
				<a href="#">九游游戏</a>
			</li>
		</ul>
		<span class="span1">Copyright © 2013 jiaoyimao.com    版权所有    ICP证：粤ICP备13009613号-2 </span>
	</div>
</div>
</body>
</html>