<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,pojo.User,pojo.Recipe,pojo.Include,pojo.Step,pojo.RPicture,pojo.Material"
%>

<%
	User user=new User();
	if(session.getAttribute("user")!=null){
		user=(User)session.getAttribute("user");
	}
	
	Recipe recipe = new Recipe();
	if(request.getAttribute("recipe") != null){
		recipe = (Recipe)request.getAttribute("recipe");
	}
	
	Include include = new Include();
	Iterator<Include> includeList = (new ArrayList<Include>()).iterator();
	if(request.getAttribute("include") != null){
		includeList = (Iterator<Include>)request.getAttribute("include");
	}
	
	Iterator<Material> materialList = (new ArrayList<Material>()).iterator();
	if(request.getAttribute("material") != null){
		materialList = (Iterator<Material>)request.getAttribute("material");
	}
	
	Step step = new Step();
	Iterator<Step> stepList = (new ArrayList<Step>()).iterator();
	if(request.getAttribute("step") != null){
		stepList = (Iterator<Step>)request.getAttribute("step");
	}
	
	RPicture picture = new RPicture();
	int c = 0;
	Iterator<RPicture> picList = (new ArrayList<RPicture>()).iterator();
	if(request.getAttribute("picture") != null){
		picList = (Iterator<RPicture>)request.getAttribute("picture");
	}
%>
    
<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>

<!-- Basic Page Needs
================================================== -->
<meta charset="utf-8">
<title>寻味环游记</title>

<script type="text/javascript">
	function jumpToRecipe() {
		window.location.href = "/RecipeSSM/visit/recipe";
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
			<h1><a href="../visit/index"><img src="/RecipeSSM/images/logo.png" alt="Chow" /></a></h1>
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
				<a href="/RecipeSSM/visit/index" id="current">食谱</a>
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
				<%
					if(session.getAttribute("user") == null){
				%>	
						<a href="/RecipeSSM/visit/login">登录/注册</a>
				<% 
					}else{
				%>
						<a href="/RecipeSSM/visit/user"><%= user.getName() %></a>
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


<!-- Recipe Background -->
<div class="recipeBackground">
<%-- <%
	while (picList.hasNext()) {
		picture = picList.next();
		System.out.println("图片从数据库获取地址："+picture.getUrl());
		c = 1;
%>
	<img src="<%= picture.getUrl() %>" alt="" />
<%
		break;
	}
%> --%>
	<img src="/RecipeSSM/images/recipeBackground.jpg" alt="" />
</div>

<!-- Content
================================================== -->
<div class="container" itemscope itemtype="http://schema.org/Recipe">

	<!-- Recipe -->
	<div class="twelve columns">
	<div class="alignment">

		<!-- Header -->
		<section class="recipe-header">
			<div class="title-alignment">
				<h2><%= recipe.getName() %></h2>
				<div class="<%= recipe.getRating() %>">
					<div class="star-rating"></div>
					<div class="star-bg"></div>
				</div>
				<span><a href="#reviews">(<%= recipe.getBrowse() %> 浏览)</a></span>
			</div>
		</section>
		

		<!-- Slider -->
		<div class="recipeSlider rsDefault">
		<%
			while (picList.hasNext()) {
				picture = picList.next();
				if(c < 3){
					c++;
					continue;
				}
		%>
 		    <img itemprop="image" class="rsImg" src="<%= picture.getUrl() %>" alt="" /> 
	    <%
			}
		%>
		</div>


		<!-- Details -->
		<section class="recipe-details" itemprop="nutrition">
			<ul>
				<li>难度: <strong itemprop="recipeYield"><%= recipe.getComplexity() %></strong></li>
				<li>时间（分钟）: <strong itemprop="prepTime"><%= recipe.getMinute() %></strong></li>
				<li>口味: <strong itemprop="cookTime"><%= recipe.getTasty() %></strong></li>
				<li>工艺: <strong itemprop="calories"><%= recipe.getMethod() %></strong></li>
			</ul>
			<a href="#" class="print"><i class="fa fa-print"></i> 打印</a>
			<div class="clearfix"></div>
		</section>


		<!-- Text -->
		<p itemprop="description"><%= recipe.getDescription() %></p>


		<!-- Ingredients -->
		<h3>材料：</h3>
		<ul class="ingredients">
		<%
			int i = 1;
			while (includeList.hasNext() && materialList.hasNext()) {
		%>
			<li>
				<input id="check-<%= i %>" type="checkbox" name="check" value="check-<%= i %>">
				<label itemprop="ingredients" for="check-<%= i %>"><%= materialList.next().getName() %>---用量：<%= includeList.next().getQuantity() %></label>
			</li>
		<%
				i++;
			}
		%>								
		</ul>


		<!-- Directions -->
		<h3>步骤</h3>
		<ol class="directions" itemprop="recipeInstructions">
		<%
			while (stepList.hasNext()) {
				step = stepList.next();
//				System.out.println(step.getDescription());
		%>
			<li><%= step.getDescription() %></li>
		<%
			}
		%>	
		</ol>


		<!-- Share Post -->
		<ul class="share-post">
			<li><a href="/RecipeSSM/visit/navigation?address=<%=recipe.getAddress() %>" class="pinterest-share">推荐店铺地址导航</a></li>

			<!-- <li><a href="#add-review" class="rate-recipe">Add Review</a></li> -->
		</ul>
		<div class="clearfix"></div>

		
		<!-- Meta -->
<!--  		<div class="post-meta">
			By <a href="#" itemprop="author">Sandra Fortin</a>, on
			<meta itemprop="datePublished" content="2014-30-10">30th November, 2014</meta>
		</div>  -->


		<div class="margin-bottom-40"></div>


		<!-- Headline -->
 		<h3 class="headline">猜你喜欢</h3>
		<span class="line margin-bottom-35"></span>
		<div class="clearfix"></div>

		<div class="related-posts">
		<!-- Recipe #1 -->
			<div class="four recipe-box columns">

				<!-- Thumbnail -->
				<div class="thumbnail-holder">
					<a href="getRecipePageAct?recipeId=2">
						<img src="/RecipeSSM/images/recipeThumb-01a.jpg" alt=""/>
						<div class="hover-cover"></div>
						<div class="hover-icon">查看食谱</div>
					</a>
				</div>

				<!-- Content -->
				<div class="recipe-box-content">
					<h3><a href="getRecipePageAct?recipeId=2">墨西哥烤玉米</a></h3>
					
					<div class="rating five-stars">
						<div class="star-rating"></div>
						<div class="star-bg"></div>
					</div>

					<div class="recipe-meta"><i class="fa fa-clock-o"></i> 30 分钟</div>

					<div class="clearfix"></div>
				</div>
			</div>

			<!-- Recipe #2 -->
			<div class="four recipe-box columns">

				<!-- Thumbnail -->
				<div class="thumbnail-holder">
					<a href="../visit/recipe_page?recipeId=3">
						<img src="/RecipeSSM/images/recipeThumb-07a.jpg" alt=""/>
						<div class="hover-cover"></div>
						<div class="hover-icon">查看食谱</div>
					</a>
				</div>
				
				<!-- Content -->
				<div class="recipe-box-content">
					<h3><a href="../visit/recipe_page?recipeId=3">柠檬咖喱鸡</a></h3>
					
					<div class="rating five-stars">
						<div class="star-rating"></div>
						<div class="star-bg"></div>
					</div>

					<div class="recipe-meta"><i class="fa fa-clock-o"></i> 1 小时 20 分钟</div>

					<div class="clearfix"></div>
				</div>
			</div>

			<!-- Recipe #3 -->
			<div class="four recipe-box columns">

				<!-- Thumbnail -->
				<div class="thumbnail-holder">
					<a href="../visit/recipe_page?recipeId=7">
						<img src="/RecipeSSM/images/recipeThumb-03a.jpg" alt=""/>
						<div class="hover-cover"></div>
						<div class="hover-icon">查看食谱</div>
					</a>
				</div>
				
				<!-- Content -->
				<div class="recipe-box-content">
					<h3><a href="getRecipePageAct?recipeId=7">咖喱鸡块</a></h3>
					
					<div class="rating five-stars">
						<div class="star-rating"></div>
						<div class="star-bg"></div>
					</div>

					<div class="recipe-meta"><i class="fa fa-clock-o"></i> 45 分钟</div>

					<div class="clearfix"></div>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>


		<div class="margin-top-15"></div>


		<!-- Comments
		================================================== -->
		<h3 class="headline">访问 <span class="comments-amount">(4)</span></h3><span class="line"></span><div class="clearfix"></div>
		
			<!-- Reviews -->
			<section class="comments" id="reviews">

				<ul>
					<li>
						<div class="avatar"><img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" alt="" /></div>
						<div class="comment-content"><div class="arrow-comment"></div>
							<div class="comment-by"><strong>John Doe</strong><span class="date">7th, October 2014</span>
								<a href="#" class="reply"><i class="fa fa-reply"></i> 回复</a>
							</div>
							<p>非常好！</p>
							<div class="rating five-stars">
								<div class="star-rating"></div>
								<div class="star-bg"></div>
							</div>
						</div>

						<!-- Second Level -->
						<ul>
							<li>
								<div class="avatar"><img src="images/author-photo.png" alt="" /></div>
								<div class="comment-content"><div class="arrow-comment"></div>
								<div class="comment-by"><strong>Sandra Fortin</strong><span class="date">7th, October 2014</span>
								<a href="#" class="reply"><i class="fa fa-reply"></i> 回复</a>
								</div>
								<p>是的！并不难操作</p>
								</div>
							</li>
						</ul>

					</li>

					<li>
						<div class="avatar"><img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" alt="" /></div>
						<div class="comment-content"><div class="arrow-comment"></div>
							<div class="comment-by"><strong>Kathy Brown</strong><span class="date">12th, October 2014</span>
								<a href="#" class="reply"><i class="fa fa-reply"></i> 回复</a>
							</div>
							<p>准备今天就做做看！</p>
							<div class="rating ive-stars">
									<div class="star-rating"></div>
									<div class="star-bg"></div>
							</div>
						</div>
					</li>

					<li>
						<div class="avatar"><img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" alt="" /> </div>
						<div class="comment-content"><div class="arrow-comment"></div>
							<div class="comment-by"><strong>John Doe</strong><span class="date">15th, October 2014</span>
								<a href="#" class="reply"><i class="fa fa-reply"></i> 回复</a>
							</div>
							<p>喜欢牛肉！</p>
							<div class="rating four-stars">
								<div class="star-rating"></div>
								<div class="star-bg"></div>
							</div>
						</div>

					</li>
				 </ul>

			</section>
			<div class="clearfix"></div>
			<br>


		<!-- Add Comment
		================================================== -->

		<h3 class="headline">写评论</h3><span class="line margin-bottom-35"></span><div class="clearfix"></div>
		
		<!-- Add Comment Form -->
		<form id="add-review" class="add-comment">
			<fieldset>

				<div>
					<label>名字:</label>
					<input type="text" value=""/>
				</div>
					
				<div>
					<label>Email: <span>*</span></label>
					<input type="text" value=""/>
				</div>

				<div>
					<label>等级:</label>
					<span class="rate">
						<span class="star"></span>
						<span class="star"></span>
						<span class="star"></span>
						<span class="star"></span>
						<span class="star"></span>
					</span>
				</div>
				<div class="clearfix"></div>

				<div>
					<label>评论: <span>*</span></label>
					<textarea cols="40" rows="3"></textarea>
				</div>

			</fieldset>

			<a href="#" class="button medium color">发表评论</a>
			<div class="clearfix"></div>

		</form>

	</div>
	</div>


<!-- Sidebar
================================================== -->
<div class="four columns">

	<!-- Search Form -->
	<div class="widget search-form">
		<nav class="search">
			<form action="recipe.jsp" method="get">
				<button><i class="fa fa-search"></i></button>
				<input onfocus="jumpToRecipe()" class="search-field" type="text" placeholder="Search for Recipe" value=""/>
			</form>
		</nav>
		<div class="clearfix"></div>
	</div>


	<!-- Author Box -->
	<div class="widget">
		<div class="author-box">
			<span class="title">推荐人</span>
			<span class="name"><%= recipe.getAuthor() %></span>
			<span class="contact"><a href="mailto:sandra@chow.com">mailto:sandra@chow.com</a></span>
			<img src="/RecipeSSM/images/author-photo.png" alt="">
			<p>心情美食家</p>
		</div>
	</div>


	<!-- Popular Recipes -->
	<div class="widget">
		<h4 class="headline">热门推荐：</h4>
		<span class="line margin-bottom-30"></span>
		<div class="clearfix"></div>
		
		<!-- Recipe #1 -->
		<a href="../visit/recipe_page?recipeId=6" class="featured-recipe">
			<img src="/RecipeSSM/images/featuredRecipe-01.jpg" alt="">

			<div class="featured-recipe-content">
				<h4>巧克力冰淇淋蛋糕</h4>
			
				<div class="rating five-stars">
					<div class="star-rating"></div>
					<div class="star-bg"></div>
				</div>
			</div>
			<div class="post-icon"></div>
		</a>

		<!-- Recipe #2 -->
		<a href="../visit/recipe_page?recipeId=2" class="featured-recipe">
			<img src="/RecipeSSM/images/featuredRecipe-02.jpg" alt="">

			<div class="featured-recipe-content">
				<h4>墨西哥烤玉米</h4>
			
				<div class="rating five-stars">
					<div class="star-rating"></div>
					<div class="star-bg"></div>
				</div>
			</div>
			<div class="post-icon"></div>
		</a>

		<!-- Recipe #3 -->
		<a href="../visit/recipe_page?recipeId=8" class="featured-recipe">
			<img src="/RecipeSSM/images/featuredRecipe-03.jpg" alt="">

			<div class="featured-recipe-content">
				<h4>玉米鸡肉卷</h4>
			
				<div class="rating five-stars">
					<div class="star-rating"></div>
					<div class="star-bg"></div>
				</div>
			</div>
			<div class="post-icon"></div>
		</a>

		<div class="clearfix"></div>
	</div>


	<!-- Popular Recipes -->
	<div class="widget">
		<h4 class="headline">分享</h4>
		<span class="line margin-bottom-30"></span>
		<div class="clearfix"></div>
		
		<ul class="share-buttons">
			<li class="facebook-share">
				<a href="#">
					<span class="counter">1,234</span>
					<span class="counted">粉丝</span>
					<span class="action-button">喜欢</span>
				</a>
			</li>

			<li class="twitter-share">
				<a href="#">
					<span class="counter">863</span>
					<span class="counted">粉丝</span>
					<span class="action-button">关注</span>
				</a>
			</li>

			<li class="google-plus-share">
				<a href="#">
					<span class="counter">902</span>
					<span class="counted">粉丝</span>
					<span class="action-button">关注</span>
				</a>
			</li>
		</ul>
		<div class="clearfix"></div>
	</div>

</div>


</div>
<!-- Container / End -->


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
						<a href="recipe.jsp">浏览食谱</a>
					</li>
					<li>
						<a href="recipe_submit.jsp">上传食谱</a>
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
