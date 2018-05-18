<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车</title>

<link href="./css/common.css" rel="stylesheet" type="text/css">
<link href="./css/cart.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/index.js"></script>

<script type="text/javascript">
function deletcart(pid){
	var r=confirm("你确定要删除吗？");
	if(r==true){
		$.ajax({
			type:"post",
			url:"./deletCartByPid.do?pid="+pid,
			dataType:"text",
			data:"",
			success:function(data){
				if(data>0){
					window.location.href="./goCart.do";
				}
			},
			error:function(){}
		});
	}
	
}

$(document).ready(function(){
	if(localStorage.getItem('username')=="0"){
		window.location.href="./login.do" ;
		return false;
	}
	//显示购物车列表
	$.ajax({
		type:"post",
		url:"./lookCart.do",
		dataType:"json",
		data:"",
		success:function(data){
			var total=0;
			
			if(data[0].length==0){
				$("tbody").append("<tr><td style='color:gray;text-align:center;'>购物车空空如也哦！快去添加喜欢的商品吧=^_^=<br><a style='font-size:18px;color:#bf937d;' href='./index.do'>好的，去看看~~~</a></td></tr>").css("color","red");
				$("#submit").click(function(){
					alert("购物车还没有商品哦~");
					$("#submit").attr("href","javascript:;");
				})
				return;
			}
			for(var i=0;i<data[0].length;i++){
				$("tbody").append(
						'<tr><td width="60"><input type="hidden" name="id" value="22"><img src="'+data[0][i].image+'"></td>'
						+'<td><a target="_blank">'+data[0][i].pname+'</a></td>'
						+'<td>￥'+data[0][i].price+'</td>'
						+'<td class="quantity" width="60">'+data[0][i].count+'</td>'
						+'<td width="140"><span class="subtotal">￥'+(data[0][i].price*data[0][i].count)+'</span></td>'
						+'<td><a href="javascript:;" onclick="deletcart('+data[0][i].pid+');" class="delete">删除</a></td></tr>'
				);
				total=total+(data[0][i].price*data[0][i].count);
				
			}
			//删除某一条数据
			/* $("#delete").click(function(){
				alert(1111);
				var r=confirm("你确定要删除吗？");
			}); */
			
			
			$("#effectivePoint").html(total);
			$("#effectivePrice").html("￥"+total+"元");
			
		},
		error:function(){}
	});
	
	//清空购物车
	$("#clear").click(function(){
		var r=confirm("你确定要全部清空吗？");
		  if (r==true){
			  $.ajax({
					type:"post",
					url:"./removeCart.do",
					dataType:"text",
					data:"",
					success:function(data){
						if(data>0){
							window.location.href="./goCart.do";
						}
					},
					error:function(){}
				});
		    }

		  
		
	});
});
</script>

</head>
<body>
<div id="header" class="container header">

	
</div>	<div class="container cart">
		<div class="span24">
			<div class="step step1">
				
			</div>
				<table>
					<tbody>
					<tr>
						<th>图片</th>
						<th>商品</th>
						<th>价格</th>
						<th>数量</th>
						<th>小计</th>
						<th>操作</th>
					</tr>
						
						
				</tbody></table>
				<dl id="giftItems" class="hidden" style="display: none;">
				</dl>
				<div class="total">
					<em id="promotion"></em>
							<em>
								<!-- 登录后确认是否享有优惠 -->
							</em>
					赠送积分: <em id="effectivePoint">0</em>
					商品金额: <strong id="effectivePrice">￥0.00元</strong>
				</div>
				<div class="bottom">
					<a href="javascript:;" id="clear" class="clear">清空购物车</a>
					<a href="./goOrder.do" id="submit" class="submit" >提交订单</a>
				</div>
		</div>
	</div>
<div id="footer" class="container footer">

</div>
</body></html>