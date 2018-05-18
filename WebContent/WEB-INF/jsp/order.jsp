<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>订单页面</title>
<link href="./css/common.css" rel="stylesheet" type="text/css"/>
<link href="./css/cart.css" rel="stylesheet" type="text/css"/>
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
	//判断seesion是否为空
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
			$("#effectivePrice").html(total);
			
		},
		error:function(){}
	});
	
	
	//提交订单
	$("#submit").click(function(){
		var formdata=$("#orderForm").serialize();
		var total=$("#effectivePrice").html();
		$.ajax({
			type:"post",
			url:"./submitOrder.do?total="+total,
			dataType:"text",
			data:formdata,
			success:function(data){
				if(data>0){
					alert("订单提交成功！");
					window.location.href="./goCart.do";
				};
			},
			error:function(){}
		});
		$.ajax({
			type:"post",
			url:"./removeCart.do",
			dataType:"text",
			data:"",
			success:function(data){
				
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

<div class="container cart">

		<div class="span24">
		
			<div class="step step1">
				<ul>
					
					<li  class="current"></li>
					<li  >生成订单成功</li>
				</ul>
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
					
						
					
				</tbody>
			</table>
				<dl id="giftItems" class="hidden" style="display: none;">
				</dl>
				<div class="total">
					<em id="promotion"></em>
					商品金额: ￥<strong id="effectivePrice">100</strong>元
				</div>
			<form id="orderForm" action="" method="post">
				<!-- <input type="hidden" name="order.oid" value=""/> -->
				<div class="span24">
					<p>
							收货地址：<input name="addr" type="text" value="" style="width:350px" />
								<br />
							收货人&nbsp;&nbsp;&nbsp;：<input name="name" type="text" value="" style="width:150px" />
								<br /> 
							联系方式：<input name="phone" type="text"value="" style="width:150px" />

						</p>
						<hr />
						<p>
							选择银行：<br/>
							<input type="radio" name="payway" value="ICBC-NET-B2C-工商银行" checked="checked"/>工商银行
							<img src="./image/bank_img/icbc.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payway" value="BOC-NET-B2C-中国银行"/>中国银行
							<img src="./image/bank_img/bc.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payway" value="ABC-NET-B2C-农业银行"/>农业银行
							<img src="./image/bank_img/abc.bmp" align="middle"/>
							<br/>
							<input type="radio" name="payway" value="BOCO-NET-B2C-交通银行"/>交通银行
							<img src="./image/bank_img/bcc.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payway" value="PINGANBANK-NET-平安银行"/>平安银行
							<img src="./image/bank_img/pingan.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payway" value="CCB-NET-B2C-建设银行"/>建设银行
							<img src="./image/bank_img/ccb.bmp" align="middle"/>
							<br/>
							<input type="radio" name="payway" value="CEB-NET-B2C-光大银行"/>光大银行
							<img src="./image/bank_img/guangda.bmp" align="middle"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payway" value="CMBCHINA-NET-B2C-招商银行"/>招商银行
							<img src="./image/bank_img/cmb.bmp" align="middle"/>
						</p>
						<hr />
						<p style="text-align:right">
							<a id="submit" href="#">
								<img src="./image/images/finalbutton.gif" width="204" height="51" border="0" />
							</a>
						</p>
				</div>
			</form>
		</div>
		
	</div>
<div id="footer" class="container footer">

</div>
</body>
</html>