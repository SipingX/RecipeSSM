<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,pojo.User"
%>
<%
	User user=new User();
	if(session.getAttribute("user")!=null){
		user=(User)session.getAttribute("user");
	}else{
		response.sendRedirect("/RecipeSSM/visit/login");
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
								<a href="/RecipeSSM/visit/material">食材</a>
							</li>

							<li>
								<a href="#">话题</a>
							</li>

							<li>
								<a href="/RecipeSSM/visit/shop">购物</a>
							</li>

							<li>
								<a href="/RecipeSSM/visit/recipe_upload">上传食谱</a>
								<ul>
									<li><a href="/RecipeSSM/visit/contact">联系我们</a></li>
								</ul>
							</li>
							
							<li>
								<a href="/RecipeSSM/visit/user" id="current"><%= user.getName() %></a>
								<ul>
									<li><a href="../user/logout.action">退出登录</a></li>
								</ul>
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
			<div class="twelve columns">

				<!-- Headline -->
				<h3 class="headline">我的主页</h3>
				<span class="line rb margin-bottom-35"></span>
				<div class="clearfix"></div>

				<!-- Isotope -->
				<div class="isotope">

					<!-- Recipe #1 -->
					<div class="10 recipe-box columns">

						<!-- Thumbnail -->
						<div class="thumbnail-holder">
							<table>
								<tr>
									<td><img src="<%= user.getPortrait() %>" alt="" /></td>
								</tr>
								<tr>
									<td>账号：</td>
									<td><%= user.getId() %></td>
								</tr>
								<tr>
									<td>昵称：</td>
									<td><%= user.getName() %></td>
								</tr>
								<tr>
									<td>性别：</td>
									<td><%= user.getGender() %></td>
								</tr>
								<tr>
									<td>年龄：</td>
									<td><%= user.getAge() %></td>
								</tr>
								<tr>
									<td>地址：</td>
									<td><%= user.getAddress() %></td>
								</tr>
							</table>
							<%
								if(user.getRole().equals("admin")){
							%>
								<a href="/RecipeSSM/user/manageUser.action">管理用户</a><br>
								<a href="/RecipeSSM/visit/recipe_manage">管理食谱</a>
							<%
								}
							%>
						</div>
					</div>
					
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
