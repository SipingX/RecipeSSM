<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,pojo.User,pojo.Recipe"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	User user=new User();
	if(session.getAttribute("user")!=null){
		user=(User)session.getAttribute("user");
		if(!user.getRole().equals("admin")){
			response.sendRedirect("/RecipeSSM/visit/login");
		}
	}else{
		response.sendRedirect("/RecipeSSM/visit/login");
	}
	
	List<Recipe> recipeList = new ArrayList<Recipe>();
	if(request.getAttribute("recipeList") != null){
		recipeList = (List<Recipe>)request.getAttribute("recipeList");
	}
	Iterator<Recipe> recipes = recipeList.iterator();
	Recipe recipe = new Recipe();
	
	String msg = "";
	if(request.getAttribute("msg") != null){
		msg = (String)request.getAttribute("msg");
	}
%>
<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html lang="en">
<!--<![endif]-->

<head>

	<!-- Basic Page Needs
================================================== -->
	<meta charset="utf-8">
	<title>寻味环游记</title>
	
<style>
td {
	text-align: center;
}
</style>
	
<script type="text/javascript">
	function delete_confirm(recipeId){
	var tf=confirm("确认删除食谱(食谱ID：" + recipeId + "）？");
	if(tf==true){
		window.location.href='/RecipeSSM/recipe/deleteRecipe.action?recipeId=' + recipeId + "&page=" + ${page };
	}
} 
</script>

	<!-- Mobile Specific Metas
================================================== -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- CSS
================================================== -->
	<link rel="stylesheet" href="/RecipeSSM/css/style.css">
	<link rel="stylesheet" href="/RecipeSSM/css/colors/green.css" id="colors">

	<!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

</head>

<body>

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header
================================================== -->
		<header id="header">

			<!-- Container -->
			<div class="container">

				<!-- Logo / Mobile Menu -->
				<div class="three columns">
					<div id="logo">
						<h1>
							<a href="/RecipeSSM/visit/index">
								<img src="/RecipeSSM/images/logo.png" alt="寻味环游记" />
							</a>
						</h1>
					</div>
				</div>


				<!-- Navigation
================================================== -->
				<div class="thirteen columns navigation">

					<nav id="navigation" class="menu nav-collapse">
						<ul>
							<li>
								<a href="/RecipeSSM/visit/index">主页</a>
							</li>

							<li>
								<a href="/RecipeSSM/visit/recipe">食谱</a>
							</li>

							<li>
								<a href="material.jsp">食材</a>
							</li>

							<li>
								<a href="#">话题</a>
							</li>

							<li>
								<a href="shop.jsp">购物</a>
							</li>

							<li>
								<a href="/RecipeSSM/visit/recipe_upload">上传食谱</a>
								<ul>
									<li><a href="contact.jsp">联系我们</a></li>
								</ul>
							</li>
							
							<li>
								<%
									if(session.getAttribute("user") == null){
								%>	
										<a href="/RecipeSSM/visit/login">登录/注册</a>
								<% 
									}else{
								%>
										<a href="/RecipeSSM/visit/user" id="current"><%= user.getName() %></a>
										<ul>
											<li><a href="/RecipeSSM/user/logout.action">退出登录</a></li>
										</ul>
								<%	
									}
								%>
							</li>
						</ul>
					</nav>

				</div>

			</div>
			<!-- Container / End -->
		</header>

		<!-- Content
================================================== -->
		<div class="container">

			<!-- Masonry -->
			<div class="sixteen columns">

				<!-- Headline -->
				<h3 class="headline">食谱管理</h3>
				<span class="line rb margin-bottom-35"></span>
				<div class="clearfix"></div>

				<!-- Isotope -->
				<div class="isotope">
				
					<div class="sixteen columns">
						<table>
							<tr>
								<td>食谱ID</td>
								<td>作者ID</td>
								<td>食谱名称</td>
								<td>审核人员ID</td>
								<td>种类</td>
								<td>推荐星级</td>
								<td>浏览量</td>
								<td>难度</td>
								<td>用时（分钟）</td>
								<td>口味</td>
								<td>烹制方式</td>
								<td>描述</td>
								<td>地址</td>
								<td>删除</td>
							</tr>
							<%
								while (recipes.hasNext()) {
									recipe = recipes.next();
							%>
							<tr>
								<td><%= recipe.getId() %></td>
								<td><%= recipe.getAuthor() %></td>
								<td><a href="/RecipeSSM/visit/recipe_page?recipeId=<%= recipe.getId() %>"><%= recipe.getName() %></a></td>
								<td><%= recipe.getCensor() %></td>
								<td><%= recipe.getCategory() %></td>
								<td><%= recipe.getRating() %></td>
								<td><%= recipe.getBrowse() %></td>
								<td><%= recipe.getComplexity() %></td>
								<td><%= recipe.getMinute() %></td>
								<td><%= recipe.getTasty() %></td>
								<td><%= recipe.getMethod() %></td>
								<td><%= recipe.getDescription() %></td>
								<td><%= recipe.getAddress() %></td>
								<td><input type="button" value="删除食谱"  onClick="delete_confirm(<%= recipe.getId() %>)"></td>
							</tr>
							<%
								}
							%>
						</table>
						<font color="red"><%= msg %></font>
					</div>
				
				</div>
				<div class="clearfix"></div>
				
				<!-- Pagination -->
				<div class="pagination-container masonry">
 					<nav class="pagination">
						<ul>
							<li>
								<c:choose>
									<c:when test="${page-1==0 }"></c:when>
									<c:otherwise><a href="/RecipeSSM/visit/recipe_manage?page=${page-1 }">${page-1 }</a></c:otherwise>
								</c:choose>
							</li>
							<li>
								<a href="/RecipeSSM/visit/recipe_manage?page=${page }" class="current-page">${page }</a>						
							</li>
							<li>
								<c:choose>
									<c:when test="${page==pagecount }"></c:when>
									<c:otherwise><a href="/RecipeSSM/visit/recipe_manage?page=${page+1 }">${page+1 }</a></c:otherwise>
								</c:choose>
							</li>
						</ul>
					</nav>

					<nav class="pagination-next-prev">
						<ul>
							<li>
								<c:choose>
									<c:when test="${page==1 }"><a href="#" class="prev"></a></c:when>
									<c:otherwise><a href="/RecipeSSM/visit/recipe_manage?page=${page-1 }" class="prev"></a></c:otherwise>
								</c:choose>
							</li>
							<li>
								<c:choose>
									<c:when test="${page==pagecount }"><a href="#" class="next"></a></c:when>
									<c:otherwise><a href="/RecipeSSM/visit/recipe_manage?page=${page+1 }" class="next"></a></c:otherwise>
								</c:choose> 
							</li>
						</ul>
					</nav>
				</div>

			</div>
			
		</div>
		<!-- Container / End -->

		<div class="margin-top-5"></div>


	</div>
	<!-- Wrapper / End -->


	<!-- Footer
================================================== -->
	<div id="footer">

		<!-- Container -->
		<div class="container">

			<div class="five columns">
				<!-- Headline -->
				<h3 class="headline footer">关于网站</h3>
				<span class="line"></span>
				<div class="clearfix"></div>
				<p>网站以食谱为主题，给广大用户提供一个美食交流分享的平台，给予美食爱好者以便利，也可以很好的指导想要入门尝试以及初有兴趣的用户。</p>
			</div>

			<div class="three columns">

				<!-- Headline -->
				<h3 class="headline footer">食谱</h3>
				<span class="line"></span>
				<div class="clearfix"></div>

				<ul class="footer-links">
					<li>
						<a href="/RecipeSSM/visit/recipe">浏览食谱</a>
					</li>
					<li>
						<a href="/RecipeSSM/visit/recipe_upload">上传食谱</a>
					</li>
				</ul>

			</div>

			<div class="five columns">

				<!-- Headline -->
				<h3 class="headline footer">资讯</h3>
				<span class="line"></span>
				<div class="clearfix"></div>
				<p>注册接收电子邮件更新的新产品公告、礼品创意、销售等。</p>

				<form action="#" method="get">
					<input class="newsletter" type="text" placeholder="mail@example.com" value="" />
					<button class="newsletter-btn" type="submit">订阅</button>

				</form>
			</div>

		</div>
		<!-- Container / End -->

	</div>
	<!-- Footer / End -->

	<!-- Footer Bottom / Start -->
	<div id="footer-bottom">

		<!-- Container -->
		<div class="container">

			<div class="eight columns">© Copyright 2018 by
				<a href="#">Recipe</a>. All Rights Reserved.</div>

		</div>
		<!-- Container / End -->

	</div>
	<!-- Footer Bottom / End -->

	<!-- Back To Top Button -->
	<div id="backtotop">
		<a href="#">
		</a>
	</div>



	<!-- Java Script
================================================== -->
	<script src="/RecipeSSM/scripts/jquery-1.11.0.min.js"></script>
	<script src="/RecipeSSM/scripts/jquery-migrate-1.2.1.min.js"></script>
	<script src="/RecipeSSM/scripts/jquery.superfish.js"></script>
	<script src="/RecipeSSM/scripts/jquery.royalslider.min.js"></script>
	<script src="/RecipeSSM/scripts/responsive-nav.js"></script>
	<script src="/RecipeSSM/scripts/hoverIntent.js"></script>
	<script src="/RecipeSSM/scripts/isotope.pkgd.min.js"></script>
	<script src="/RecipeSSM/scripts/chosen.jquery.min.js"></script>
	<script src="/RecipeSSM/scripts/jquery.tooltips.min.js"></script>
	<script src="/RecipeSSM/scripts/jquery.magnific-popup.min.js"></script>
	<script src="/RecipeSSM/scripts/jquery.pricefilter.js"></script>
	<script src="/RecipeSSM/scripts/custom.js"></script>


	<!-- Style Switcher
================================================== -->
	<script src="/RecipeSSM/scripts/switcher.js"></script>

	<div id="style-switcher">
		<h2>切换风格
			<a href="#"></a>
		</h2>

		<div>
			<h3>预定义颜色</h3>
			<ul class="colors" id="color1">
				<li>
					<a href="#" class="green" title="Green"></a>
				</li>
				<li>
					<a href="#" class="blue" title="Blue"></a>
				</li>
				<li>
					<a href="#" class="orange" title="Orange"></a>
				</li>
				<li>
					<a href="#" class="navy" title="Navy"></a>
				</li>
				<li>
					<a href="#" class="yellow" title="Yellow"></a>
				</li>
				<li>
					<a href="#" class="peach" title="Peach"></a>
				</li>
				<li>
					<a href="#" class="beige" title="Beige"></a>
				</li>
				<li>
					<a href="#" class="purple" title="Purple"></a>
				</li>
				<li>
					<a href="#" class="celadon" title="Celadon"></a>
				</li>
				<li>
					<a href="#" class="pink" title="Pink"></a>
				</li>
				<li>
					<a href="#" class="red" title="Red"></a>
				</li>
				<li>
					<a href="#" class="brown" title="Brown"></a>
				</li>
				<li>
					<a href="#" class="cherry" title="Cherry"></a>
				</li>
				<li>
					<a href="#" class="cyan" title="Cyan"></a>
				</li>
				<li>
					<a href="#" class="gray" title="Gray"></a>
				</li>
				<li>
					<a href="#" class="darkcol" title="Dark"></a>
				</li>
			</ul>

		</div>

		<div id="reset">
			<a href="#" class="button color">重置</a>
		</div>

	</div>


</body>

</html>
