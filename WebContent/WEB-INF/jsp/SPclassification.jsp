<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>lulu商城</title>
<link href="./css/product.css" rel="stylesheet" type="text/css"/>
<link href="./css/common.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/index.js"></script>

<script type="text/javascript">
	//分页
	function fenye(cid,current){
		$.ajax({
			type:"post",
			url:"./fenye.do?cid="+cid+"&current="+current,
			dataType:"json",
			//ata:"",
			success:function(data){
				console.log(data);
				$("#right").empty();
				$(".pagination").empty();
				
				//显示列表信息
				for(var i=0;i<data[0].length;i++){
					
					$("#right").append(
					'<li><a href="./deatil.do?pid='+data[0][i].pid+'">' +
					'<img src="'+data[0][i].image+'" width="170" height="170"  style="display:block;">' + 
					'<span style="color:green">'+data[0][i].pname+'</span>'	+ 
					'<span class="price">商城价： ￥'+data[0][i].shop_price+'/件</span></a></li>'
					)
				}
				
				if(data[1].cuurentPage==1){
					 $(".pagination").append(
							 '<a class="firstPage" href="#">&nbsp;</a>'+
							'<a class="previousPage" href="#">&nbsp;</a>'		 
					 );
				 }
				 if(data[1].cuurentPage!=1){
					 $(".pagination").append(
							 '<a class="firstPage" onclick="fenye('+cid+',1);">&nbsp;</a>'+
							'<a class="previousPage" onclick="fenye('+cid+','+(data[1].cuurentPage-1)+');">&nbsp;</a>'		 
					 );
				 }
	
				 for(var i=1;i<=data[1].totalPage;i++){//循环显示页码
					 if(i==data[1].cuurentPage){
						 $(".pagination").append(
									'<a class="currentPage" id="currentPage" href="#" onclick="fenye('+cid+','+i+');">'+i+'</a>' 
							 );
					 }
					 if(i!=data[1].cuurentPage){
						 $(".pagination").append(
									'<a  id="currentPage" href="#" onclick="fenye('+cid+','+i+');">'+i+'</a>' 
							 );
					 }
						 
						 
				 }
				 		 			
				 if(data[1].cuurentPage==data[1].totalPage){//若当前页数等于总页数
					 $(".pagination").append(
						'<a class="nextPage" href="#">&nbsp;</a>'+
	   					'<a class="lastPage" href="#">&nbsp;</a>'		 
					 );
				 }
				 if(data[1].cuurentPage!=data[1].totalPage){//若当前页数不等于总页数
					 $(".pagination").append(
								'<a class="nextPage" href="#" onclick="fenye('+cid+','+(data[1].cuurentPage+1)+');">&nbsp;</a>'+
			   					'<a class="lastPage" href="#" onclick="fenye('+cid+','+data[1].totalPage+');">&nbsp;</a>'		 
							 );
				 }
				
					
				
			},
			error:function(){
				
			}
		});
		
	}

	function GetQueryString(str){
		 var rs=new RegExp("(^|)"+str+"=([^&]*)(&|$)","gi").exec(String(window.document.location.href)),tmp;
		 if(tmp=rs)return tmp[2];
		 return "没有这个参数";
		 }

	$(document).ready(function(){
		var cname=decodeURI(GetQueryString('cname'));
		$("#cname").html(cname);
		/* var cid=window.location.search; */
		
		var cid=decodeURI(GetQueryString('cid'));
		sessionStorage.setItem('cid',cid);
		sessionStorage.setItem('cname',cname);
		//显示分类页面列表
		$.ajax({
			type:"post",
			url:"./goCategory.do?cid="+cid+"&current="+1,
			dataType:"json",
			data:"",
			success:function(data){
				
				if(data[1].length==0){
					 $("#right").append("<span id='ps'>该类商品没有库存咯，去看看其他商品吧！</span>");
					  $("#ps").css("color","#666666").css("font-size","20px").css("margin","10px auto"); 
				}
				 for(var i=0;i<data[0].length;i++){			
					$("#class").append(
						'<dd><a href="./class.do?csid='+data[0][i].csid+'&cid='+data[0][i].cid+'" >'+data[0][i].csname+'</a></dd>'
					);
				}
				 //点击二级菜单时执行
				 $("#class dd a").click(function(){
					 var csid=GetQueryString('csid');
					 
					  $.ajax({
						 type:"post",
						 url:"getProductByCsid.do?csid="+1,
						 dataType:"json",
						 data:"",
						 success:function(data){
							 console.log(data);
							 $("#right").empty();
							 for(var i=0;i<data[0].length;i++){
							 $("#right").append(
										'<li><a href="./deatil.do?pid='+data[0][i].pid+'">' +
										'<img src="'+data[0][i].image+'" width="170" height="170"  style="display:block;">' + 
										'<span style="color:green">'+data[0][i].pname+'</span>'	+ 
										'<span class="price">商城价： ￥'+data[0][i].shop_price+'/件</span></a></li>'	 
								 )}
						 },
						 error:function(){}
					 });
		 			});
				 //alert(data[1].length);
				 
				 for(var i=0;i<data[1].length;i++){//循坏显示商品信息
					 //alert(data[1][i].image);
					 $("#right").append(
							'<li><a href="./deatil.do?pid='+data[1][i].pid+'">' +
							'<img src="'+data[1][i].image+'" width="170" height="170"  style="display:block;">' + 
							'<span style="color:green">'+data[1][i].pname+'</span>'	+ 
							'<span class="price">商城价： ￥'+data[1][i].shop_price+'/件</span></a></li>'	 
					 )
				 }
				 
				 if(data[2].cuurentPage==1){
					 $(".pagination").append(
							 '<a class="firstPage" href="#">&nbsp;</a>'+
							'<a class="previousPage" href="#">&nbsp;</a>'		 
					 );
				 }
				 if(data[2].cuurentPage!=1){
					 $(".pagination").append(
							 '<a class="firstPage" onclick="fenye('+cid+',1);">&nbsp;</a>'+
							'<a class="previousPage" onclick="fenye('+cid+','+(data[2].cuurentPage-1)+');">&nbsp;</a>'		 
					 );
				 }
				 
				 for(var i=1;i<=data[2].totalPage;i++){
					 if(i==data[2].cuurentPage){
						 $(".pagination").append(
									'<a class="currentPage" id="currentPage" href="#" onclick="fenye('+cid+','+i+');">'+i+'</a>' 
							 );
					 }
					 if(i!=data[2].cuurentPage){
						 $(".pagination").append(
									'<a  id="currentPage" href="#" onclick="fenye('+cid+','+i+');">'+i+'</a>' 
							 );
					 }
						 
						 
				 }
				 		 			
				 if(data[2].cuurentPage==data[2].totalPage){//若当前页数等于总页数
					 $(".pagination").append(
						'<a class="nextPage" href="#">&nbsp;</a>'+
	   					'<a class="lastPage" href="#">&nbsp;</a>'		 
					 );
				 }
				 if(data[2].cuurentPage!=data[2].totalPage){//若当前页数不等于总页数
					 $(".pagination").append(
								'<a class="nextPage" href="#" onclick="fenye('+cid+','+(data[2].cuurentPage+1)+');">&nbsp;</a>'+
			   					'<a class="lastPage" href="#" onclick="fenye('+cid+','+data[2].totalPage+');">&nbsp;</a>'		 
							 );
				 }
	
			},
			error:function(){
				alert("网络错误！")
			}
		});
		
		
		
		
		
		
		
		
		

		
	});
</script>

</head>
<body>
<div id="header" class="container header">

</div>	
<div class="container productList">
		<div class="span6">
			<div class="hotProductCategory">
						<dl id="class">
							<dt><a id="cname" href="./image/蔬菜 - Powered By Mango Team.htm">女装男装</a></dt>					
						</dl>	
						<dl class="last">
							<dt>
								<a >商城卡</a>
							</dt>
									<dd>
										<a >商城卡</a>
									</dd>
						</dl>
						<dl class="last">
							<dt>
								<a href="./蔬菜分类.htm">定制套餐</a>
							</dt>
									<dd>
										<a >2-3人套餐</a>
									</dd>
									<dd>
										<a>4-6人套餐</a>
									</dd>
									<dd>
										<a >1-2人套餐</a>
									</dd>
									<dd>
										<a>标准套餐</a>
									</dd>
									<dd>
										<a >乳母套餐</a>
									</dd>
									<dd>
										<a >营养师1对1服务</a>
									</dd>
									<dd>
										<a >儿童套餐</a>
									</dd>
									<dd>
										<a>高考套餐</a>
									</dd>
									<dd>
										<a >学生套餐</a>
									</dd>
									<dd>
										<a >护眼套餐</a>
									</dd>
									<dd>
										<a >世杯套餐</a>
									</dd>
						</dl>
						<dl class="last">
							<dt>
								<a >健康生活附属品</a>
							</dt>
									<dd>
										<a >空气净化器</a>
									</dd>
									<dd>
										<a >薰衣草</a>
									</dd>
						</dl>
			</div>
		</div>
		<div class="span18 last">
			
			<form id="productForm" action="./image/蔬菜 - Powered By Mango Team.htm" method="get">
				<input type="hidden" id="brandId" name="brandId" value="">
				<input type="hidden" id="promotionId" name="promotionId" value="">
				<input type="hidden" id="orderType" name="orderType" value="">
				<input type="hidden" id="pageNumber" name="pageNumber" value="1">
				<input type="hidden" id="pageSize" name="pageSize" value="20">
					
				<div id="result" class="result table clearfix">
						<ul id="right">							
						</ul>
				</div>
	<div class="pagination">
		
	</div>
			</form>
		</div>
	</div>
<div id="footer" class="container footer">

</div>
</body></html>