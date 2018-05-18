$(document).ready(function(){
	//加载页面头部内容
	$.ajax({
		type:"get",
		dataType:"text",
		url:"./header.do",
		success:function(data){
			
			$("#header").html(data);
			
			$.ajax({
				type:"post",
				url:"user/nameShow.do",
				dataType:"text",
				//data:"",
				success:function(data){
					//加载登陆按钮的显示变化
					if(data=="0"){
						$("#headerLogin").find("a").html("登陆");
					}else{
						$("#headerLogin").find("a").html("欢迎您！ "+data).css("color","green");
						$(".headerLogout").css("display","block");
					}
					localStorage.setItem('username',data);
					//退出登录
					
					$("#headerLogout").find("a").click(function(){	
						$.ajax({
							type:"post",
							url:"./user/loginOut.do",
							dataType:"text",
							data:"",
							success:function(data){
								
								if(data=="1"){
									window.location.href="./login.do";
								}
							},
							error:function(){
								alert("网络错误！稍后再尝试哦~");
							}
						});
					});
				},
				error:function(){
					alert("网络错误！稍后再尝试哦~");
				}
			});
			
			
		}
		
	});
	
	//初始化首页的页面
	$.ajax({
		type:"post",
		url:"./indexInit.do",
		dataType:"json",
		//data:"",
		success:function(data){
			
			for(var i=0;i<data[0].length;i++){
				$(".mainNav").append(
						'<li><a href="./class.do?cid='+data[0][i].cid+'&cname='+data[0][i].cname+'">'+data[0][i].cname+'</a>|</li>'	
				);
			}
			
			for(var i=0;i<data[1].length;i++){
				$("#hot").append(
						'<li><a href="./deatil.do?pid='+data[1][i].pid+'" ><img src="'+data[1][i].image+'"  style="display: block;"></a></li>'	
				)
			}
			
			for(var i=0;i<data[2].length;i++){
				$("#new").append(
						'<li><a href="./deatil.do?pid='+data[2][i].pid+'"  ><img src="'+data[2][i].image+'"  style="display: block;"></a><li>'	
				)
			}
		},
		error:function(){}
	});
	
	
	
	
	

	
	
	//加载页面的脚部
	$.ajax({
		type:"get",
		dataType:"text",
		url:"./footer.do",
		success:function(data){
			
			$("#footer").html(data);
		}
		
	});
	
	
	
});