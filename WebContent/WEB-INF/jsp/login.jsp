<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>会员登录</title>

<link href="./css/common.css" rel="stylesheet" type="text/css"/>
<link href="./css/login.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/index.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#captchaImage").click(function(){
			//修改src属性  实现刷新图片
			//如果两次路径一模一样，就不会调用后台方法
			//给路径拼参数不会影响方法的调用，因为后台并没有给这个路径做处理
			var time=new Date().getTime();
			$(this).attr("src","getYZM.do?time="+time);
		});
		
		$("#btnSubmit").click(function(){
			var formData=$("#loginForm").serialize();
			var isRe=$("#isRememberUsername").val();
			$.ajax({
				type:"post",
				url:"user/login.do",
				dataType:"text",
				data:formData,
				success:function(data){
					
					switch(data){
					case "0":$("#btnSubmit").next().html("用户名不存在，请查证后重试").css("color","red");break;
					case "1":$("#btnSubmit").next().html("用户名没有激活，请激活后重试").css("color","red");break;
					case "2":$("#btnSubmit").next().html("密码错误，请重新输入").css("color","red");break;
					case "3":$("#btnSubmit").next().html("验证码错误，请重新输入").css("color","red");break;
					case "4":window.location.href="./index.do";break;
					default:sessionStorage.setItem('name',data);
							window.location.href="./index.do";
							break;
					}
					
				},
				error:function(){
					alert("网络错误！稍后再尝试哦！");
				}
			})
		});
		
		 $("#username").val(sessionStorage.getItem('name')); 
		
		
	})
</script>

</head>
<body>

<div id="header" class="container header">
</div>	
<div class="container login">
		<div class="span12">
<div class="ad">
					<img src="./image/login.jpg" width="500" height="330" alt="会员登录" title="会员登录">
</div>		</div>
		<div class="span12 last">
			<div class="wrap">
				<div class="main">
					<div class="title">
						<strong>会员登录</strong>USER LOGIN 
					</div>
					<form id="loginForm"  method="post" novalidate="novalidate">
						<table>
							<tbody><tr>
								<th>
										用户名:
								</th>
								<td>
									<input type="text" id="username" name="username" class="text" maxlength="20">
									
								</td>
							</tr>
							<tr>
								<th>
									密&nbsp;&nbsp;码:
								</th>
								<td>
									<input type="password" id="password" name="password" class="text" maxlength="20" autocomplete="off">
								</td>
							</tr>
								<tr>
									<th>
										验证码:
									</th>
									<td>
										<span class="fieldSet">
											<input type="text" id="captcha" name="captcha" class="text captcha" maxlength="4" autocomplete="off"><img id="captchaImage" class="captchaImage" src="getYZM.do" title="点击更换验证码">
										</span>
									</td>
								</tr>
							<tr>
								<th>&nbsp;
									
								</th>
								<td>
									<label>
										<input type="checkbox" id="isRememberUsername" name="isRe" value="1" >记住用户名
									</label>
									<label>
										&nbsp;&nbsp;<a href="./find.do" >找回密码</a>
									</label>
								</td>
							</tr>
							<tr>
								<th>&nbsp;
									
								</th>
								<td>
									<input id="btnSubmit" type="button" class="submit" value="登 录">
									<span></span>
								</td>
							</tr>
							<tr class="register">
								<th>&nbsp;
									
								</th>
								<td>
									<dl>
										<dt>还没有注册账号？</dt>
										<dd>
											立即注册即可体验在线购物！
											<a href="./register.do">立即注册</a>
										</dd>
									</dl>
								</td>
							</tr>
						</tbody></table>
					</form>
				</div>
			</div>
		</div>
	</div>
<div id="footer" class="container footer">

</div>
</body></html>