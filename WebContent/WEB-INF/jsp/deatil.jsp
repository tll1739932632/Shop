<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>网上商城</title>
<link href="./css/common.css" rel="stylesheet" type="text/css">
<link href="./css/product.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/index.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		
		var cid=sessionStorage.getItem('cid');
		var pid=window.location.search;
		
		var cname=sessionStorage.getItem('cname');
		$("#cname").html(cname);
		$.ajax({
			type:"post",
			url:"./goCategory.do?cid="+cid,
			dataType:"json",
			data:"",
			success:function(data){
				for(var i=0;i<data[0].length;i++){			
					$("#class").append(
						'<dd><a >'+data[0][i].csname+'</a></dd>'
					);
				}
			},
			error:function(){}
		});
		
		$.ajax({
			type:"post",
			url:"./deatilInfo.do"+pid,
			dataType:"json",
			data:"",
			success:function(data){
				
				$(".medium").attr("src",data[0][0].image);
				$(".name").html(data[0][0].pname);
				var price="￥："+data[0][0].shop_price+"元/件";
				$("#shop_price").html(data[0][0].shop_price);
				var price1='￥'+data[0][0].market_price+'元/件';
				$("del").html(data[0][0].market_price);
				$("#img_des").attr("src",data[0][0].image);
				$("#des").html(data[0][0].pdesc);
				$(".sn div span").html(data[0][0].pid);
				
			},
			error:function(){}
		});
		
		var count=1;
		var quantity=$("#quantity").val();
		$("#increase").click(function(){
			count++;
			$("#quantity").val(count);
		});
		$("#decrease").click(function(){
			count--;
			if(count>0){
				$("#quantity").val(count);
			}else{
				count=1;
			}
		});
		
		$("#addCart").click(function(){
			if(sessionStorage.getItem('username')=="0"){
				window.location.href="./login.do";
				return;
			}
			var pid=$(".sn div span").html();
			var image=$(".medium")[0].src;
			var pname=$(".name").html();
			var price=$("#shop_price").html();
			var count=$("#quantity").val();
			$.ajax({
				type:"post",
				url:"./insertCart.do",
				dataType:"json",
				data:{
					"pid":pid,
					"image":image,
					"pname":pname,
					"price":price,
					"count":count
				},
				success:function(data){
					if(data>0){
						window.location.href="./goCart.do";
					}
				},
				error:function(){}
			});
			
		});
		
		
	});
	

</script>

</head>
<body>

<div id="header" class="container header">

</div>
<div class="container productContent">
		<div class="span6">
			<div class="hotProductCategory">

						<dl id="class">
							<dt><a id="cname" href="./image/蔬菜 - Powered By Mango Team.htm">女装男装</a></dt>					
						</dl>
						<dl class="last">
							<dt>
								<a>亿家卡</a>
							</dt>
									<dd>
										<a >亿家卡</a>
									</dd>
									<dd>
										<a>    </a>
									</dd>
						</dl>
			</div>
			

		</div>
		<div class="span18 last">
			
			<div class="productImage">
					<a title="" style="outline-style: none; text-decoration: none;" id="zoom" href="http://image/r___________renleipic_01/bigPic1ea8f1c9-8b8e-4262-8ca9-690912434692.jpg" rel="gallery">
						<div class="zoomPad"><img style="opacity: 1;" title="" class="medium" src="image/r___________renleipic_01/bigPic5f3622b8-028a-4e62-a77f-f41a16d715ed.jpg"><div style="display: block; top: 0px; left: 162px; width: 0px; height: 0px; position: absolute; border-width: 1px;" class="zoomPup"></div><div style="position: absolute; z-index: 5001; left: 312px; top: 0px; display: block;" class="zoomWindow"><div style="width: 368px;" class="zoomWrapper"><div style="width: 100%; position: absolute; display: none;" class="zoomWrapperTitle"></div><div style="width: 0%; height: 0px;" class="zoomWrapperImage"><img src="%E5%B0%9A%E9%83%BD%E6%AF%94%E6%8B%89%E5%A5%B3%E8%A3%852013%E5%A4%8F%E8%A3%85%E6%96%B0%E6%AC%BE%E8%95%BE%E4%B8%9D%E8%BF%9E%E8%A1%A3%E8%A3%99%20%E9%9F%A9%E7%89%88%E4%BF%AE%E8%BA%AB%E9%9B%AA%E7%BA%BA%E6%89%93%E5%BA%95%E8%A3%99%E5%AD%90%20%E6%98%A5%E6%AC%BE%20-%20Powered%20By%20Mango%20Team_files/6d53c211-2325-41ed-8696-d8fbceb1c199-large.jpg" style="position: absolute; border: 0px none; display: block; left: -432px; top: 0px;"></div></div></div><div style="visibility: hidden; top: 129.5px; left: 106px; position: absolute;" class="zoomPreload">Loading zoom</div></div>
					</a>
				
			</div>
			<div class="name">大冬瓜</div>
			<div class="sn">
				<div>编号：<span>751</span>####</div>
			</div>
			<div class="info">
				<dl>
					<dt>亿家价:</dt>
					<dd>
						<strong >￥：<span id="shop_price">4.78</span>元/件</strong>
							参 考 价：
							<del>￥6.00元/件</del>
					</dd>
				</dl>
					<dl>
						<dt>促销:</dt>
						<dd>
								<a target="_blank" title="限时抢购 (2014-07-30 ~ 2015-01-01)">限时抢购</a>
						</dd>
					</dl>
					<dl>
						<dt>    </dt>
						<dd>
							<span>    </span>
						</dd>
					</dl>
			</div>
				<div class="action">
					
						<dl class="quantity">
							<dt>购买数量:</dt>
							<dd>
								<input id="quantity" name="quantity" value="1" maxlength="4" onpaste="return false;" type="text">
								<div>
									<button  id="increase" class="increase">&nbsp;</button>
									<button  id="decrease" class="decrease">&nbsp;</button>
								</div>
							</dd>
							<dd>
								件
							</dd>
						</dl>
					<div class="buy">
							<input id="addCart" class="addCart" value="加入购物车" type="button">
				
					</div>
				</div>
			<div id="bar" class="bar">
				<ul>
						<li id="introductionTab">
							<a href="#introduction">商品介绍</a>
						</li>
						
				</ul>
			</div>
				
				<div id="introduction" name="introduction" class="introduction">
					<div class="title">
						<strong id="des">商品介绍</strong>
					</div>
					<div>
						<img id="img_des" src="image/r___________renleipic_01/bigPic139f030b-d68b-41dd-be6d-b94cc568d3c5.jpg">
					</div>
				</div>
				
				
				
		</div>
	</div>
<div id="footer" class="container footer">

</div>
</body>
</html>