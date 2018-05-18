<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>luul商城——找回密码</title>
<link href="./css/common.css" rel="stylesheet" type="text/css"/>
<link href="./css/login.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/index.js"></script>
<style type="text/css">

.login{
	
	width:500px;
	height:300px;
	margin:25px auto;
}
#loginForm table th{
	width: 120px;
}
input.text{
	width: 150px;
}

</style>

<script type="text/javascript">

function cc(eemail,username){//判断字符串
	var email=$("#email").val();
	alert(email);
	if(email==eemail){
		$("table").empty();
		$("table").append(
				'<tr><th>重置密码:</th>'+
				'<td><input type="password" id="newpwd"  class="text" maxlength="20"><span></span></td>'+
				'</tr>'+
				'<tr><th>确认密码:</th>'+
				'<td><input type="password" id="surepwd"  class="text" maxlength="20"><span></span></td>'+
				'</tr>'+
				'<tr><th>&nbsp;'+
				'</th><td><input id="checkPwd" type="button" class="submit" value="提交"></td></tr>'	
		);
		
		$("#checkPwd").click(function(){//点击确定
			var newpwd=$("#newpwd").val();
			var surepwd=$("#surepwd").val();
			if(newpwd==null|newpwd==""){
				$("#newpwd").next().html("重置密码不能为空！").css("color","red");
				return;
			}
			if(surepwd==null|surepwd==""){
				$("#surepwd").next().html("确认不能为空！").css("color","red");
				return;
			}
			if(newpwd!=surepwd){
				$("#surepwd").next().html("密码不相等！").css("color","red");
				return;
			}
			
			$.ajax({//更新密码
				type:"post",
				url:"./user/forgetPwd.do?username="+username+"&password="+surepwd,
				dataType:"text",
				data:"",
				success:function(data){
					if(data>0){
						$("table").empty();
						$("table").append(
								'<tr><th>密码更新成功！</th>'+
								'<td><a style="color:#bf937d;font-size:20px;" href="./login.do">&nbsp;→点我去登陆<a></td>'+
								'</tr>'
						);
					}
				},
				error:function(){}
			});
		});
		
	}else{
		alert("邮箱不正确!");
	}
	
}

	$(document).ready(function(){
		
		$("#btnSubmit").click(function(){
					var username=$("#username").val();
					if(username==null|username==""){
						$("#username").next().html("用户名不能为空").css("color","red");
						return false;}
			$.ajax({
				type:"post",
				url:"./user/check.do?username="+username,
				dataType:"json",
				data:"",
				success:function(data){
					if(data.length>0){
						
						$("table").empty();
						$("table").append(
							'<tr><th>你的邮箱:</th>'+
							'<td><input type="text" id="email" name="username" class="text" maxlength="20"><span></span></td>'+
							'</tr><tr><th>&nbsp;'+
							'</th><td><input id="checkE" onclick="cc(\''+data[0].email+'\',\''+data[0].username+'\');" type="button" class="submit" value="下一步"></td></tr>'
						);
						var str=data[0].email+"";
						var s="";
						s=str.substring(2, str.length-2);
						var replacement="";
						for(var i=0;i<s.length;i++){
							replacement+='*';
						}
						s=str.replace(s, replacement);
						$("#email").next().html("("+s+")").css("color","gray");
					}else{
						$("#username").next().html("用户名不存在").css("color","red");
					}
				},
				error:function(){
					alert("123");
				}
			});
		});
		
		
		
	});
</script>
</head>
<body>
<div id="header" class="container header">
</div>	


<div class="login" >
		
			
					<div class="title">
						<strong>找回密码</strong>look for your password
					</div>
					<form id="loginForm"  method="post" novalidate="novalidate">
						<table>
						
							<tr >
								<th>
										
										你的用户名:
								</th>
								<td>
									<input type="text" id="username" name="username" class="text" maxlength="20">
									<span></span>
								</td>
							</tr>
							
							<tr>
								<th>&nbsp;
									
								</th>
								<td>
									<input id="btnSubmit" type="button" class="submit" value="下一步">
									<span></span>
								</td>
							</tr>
							
						</table>
					</form>
</div>


<div id="footer" class="container footer">

</div>
</body>
</html>