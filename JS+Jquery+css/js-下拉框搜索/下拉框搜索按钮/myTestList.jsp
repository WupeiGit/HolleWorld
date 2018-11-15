<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="/common/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML>
<html>
<head>
<s:include value="/common/basePath.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的测试页面</title>
<link href="css/common.css" rel="stylesheet" type="text/css" />
<link href="plugin/extjs/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="plugin/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="plugin/extjs/ext-all.js"></script>
<script type="text/javascript" src="plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>
<script type="text/javascript" src="js/common/search.js"></script>
<script type="text/javascript" src="js/common/extSelect.js"></script>
<script type="text/javascript" src="js/common/alt.js"></script>
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/common/popWin.js"></script>
<script type="text/javascript" src="js/common/popApp.js"></script>
</head>

<body>
<s:bean name="com.mx.travel.util.Util" id="myUtil"/>
<div class="frameBody">
	<!--1 鼠标浮动，随机抽奖 -->
	<div id="divOne">
		<div style="cursor: pointer;" id="div">
			<span class="test">☆</span>&nbsp;&nbsp;
			<span class="test">☆</span>&nbsp;&nbsp;
			<span class="test">☆</span>&nbsp;&nbsp;
			<span class="test">☆</span>&nbsp;&nbsp;
		</div>
		<span id="test2">*</span>
	</div>
	<!--2 隐藏和显示-->
	<div id="divTwo">
		<div id="id1"></div>
		<input type="button" id="bth1" value="点我" />
	</div>
	<!--3 菜单隐藏和显示-->
	<div id="divThree">
		<ul id="menu">
			<li class="miOne">
				<a href="javascript:">test1</a>
				<ul class="ulOne">
					<li>One</li>
					<li>two</li>
					<li>three</li>
				</ul>
			</li>
			<li class="miOne">
				<a href="javascript:">test2</a>
				<ul class="ulOne">
					<li>One111</li>
					<li>two333</li>
					<li>three44</li>
				</ul>
			</li>
			<li class="miOne">
				<a href="javascript:">test3</a>
				<ul class="ulOne">
					<li>One1</li>
					<li>two2</li>
					<li>three3</li>
				</ul>
			</li>
		</ul>
	</div>
</div>
</body>
<script type="text/javascript">
$(function(){
	$('.test').mouseover(function(){
		var left = $(this).offset().left+10;
		$('#test2').css('left',left);
	});
});

$(function(){
	$('.test').click(function(){
		var num = Math.floor(Math.random() * 4 + 1); //获取一到四之间的随机整数
		var i =  $(this).index()+1;
		if(num == i){
			alert("恭喜中奖"+num);
		}
	});
});
//2017-8-10
$(function(){
	$('#bth1').click(function(){
		//jquery中，并不是所有方法都有回调方法，但是一下的方法都具有
		//伸缩效果
		/* $('#id1').hide();//1直接隐藏
		$('#id1').hide(1000);//2时间隐藏
		$('#id1').hide(1000,function(){
			alert('test');
		});//隐藏且提示
		
		$('#id1').whow();//直接显示
		$('#id1').toggle(1000); //显示隐藏切换 */
		
		//上下隐藏
		/* $('#id1').slideUp(500,function(){
			alert('test');
		});
		$('#id1').slideDown(500,function(){
			alert('test');
		}); 
		$('#id1').slideToggle();*/
		
		//渐变的隐藏
		/* $('#id1').fadeOut(500);
		$('#id1').fadeIn(500);*/
		$('#id1').fadeToggle(500); 
		 
	});
});

//菜单隐藏显示
$(function(){
	$('.ulOne').hide(10);
	$('.miOne a').click(function(){
		$(this).next().slideDown(500); //展开下拉框菜单
		$(this).parent().siblings().find(".ulOne").slideUp(500); //收起其他下拉框菜单
	});
});

//animate
/* $(function(){
	$('#miOne').hide(1000);
	$('#miOne a').click(function(){
		$(this).next().slideDown(500);
		$(this).parent().siblings().find(".ulOne").slideUp(500);
	});
}); */
</script>
<style type="text/css">
	#divOne,#divTwo,#divThree {
		float:left;
		width:280px;
		height:260px;
		border: 1px solid red;
		margin: 2px;
		text-align: center;
		vertical-align: middle;
	}
	#divOne{
		left:5px;
	}
	#divTwo{
		left:5px;
	}
	/*----------鼠标浮动，随机中奖等----------------*/
	#div{
		width:auto;
		height:auto;
		position:absolute;
		left:50px;
		top:50px;
		border:1px;
		cursor: pointer;
	}
	#test2{
		position:absolute;
		left:59px;
		top:40px;
		color:red;
		font-size:20px;
	}
	.test{
		font-size:28px;
		color: blue;
	}
	/*========隐藏显示=========*/
	#id1{
	 	width:150px;
	 	height:150px;
	 	/* border: 2px solid red; */
	 	background-image:url("images/pics/accountRight.png");
	 	margin-left:50px;
	}
	/*-----------下拉框----------*/
	.ulOne{
		margin-left: 25px;
	}
</style>
</html>
