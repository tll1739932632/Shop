	$(document).ready(function(){
		$("#captchaImage").click(function(){
			//修改src属性  实现刷新图片
			//如果两次路径一模一样，就不会调用后台方法
			//给路径拼参数不会影响方法的调用，因为后台并没有给这个路径做处理
			var time=new Date().getTime();
			$(this).attr("src","getYZM.do?time="+time);
		});
		
		//光标离开用户名输入框时的事件
		$("#username").blur(function(){
			checkname();
		});
		
		//光标离开密码框
		$("#password").blur(function(){
			checkpwd();
		});
		
		
		$("#rePassword").blur(function(){
			checkRepwd();
		});
		
		$("#email").blur(function(){
			checkemail();
		});
		
		$("#phone").blur(function(){
			checkphone();
		});
		
		
		//点击注册按钮的事件
		
			$("#btnSubmit").click(function(){
				checkname();
				checkpwd();
				checkRepwd();
				checkemail();
				checkphone();
				
				//获取表单数据
				var formData=$("#registerForm").serialize();
				
				$.ajax({
					type:"post",
					url:"user/register.do",
					dataType:"text",
					data:formData,
					success:function(data){
						if(data=="no"){
							//alert("验证码错误！");
							$("#captchaImage").next().html("验证码错误！清点击刷新！").css("color","red");
						}else if(data=="defeat"){
							alert("注册失败！");
						}else{
							alert("注册成功，邮件已发送至您的邮箱！");
							window.location.href="register.do";
							//$("#pop_message").fadeIn(1000).fadeOut(5000);
						}
					},
					error:function(){
						alert("网络错误！");
					}
				});
			});

		
		
	});
	
	//判断用户名
	function checkname(){
		if($("#username").val()==null|$("#username").val()==""){
			$("#username").next().html("用户名不能为空").css("color","red");
			
			return false;
		}
		var formData=$("#registerForm").serialize();//格式化表单中的数据
		//alert(formData);
		$.ajax({
			type:"post",//提交方式 get/post
			url:"user/checkUsername.do",//请求路径
			dataType:"text",//返回数据类型是text表示字符串，json可用返回对象 例如 list，map
			data:formData,
			success:function(data){
				if(data=="yes"){
					$("#username").next().html("用户名可用").css("color","green");
				
				}else{
					$("#username").next().html("用户名已存在").css("color","red");
					
					return false;
				}
			},
			error:function(){
				alert("网络错误！");
			}
		});
	}
	
	//判断密码
	function checkpwd(){
		var password=$("#password").val();
		if(password==null|password==""){
			$("#password").next().html("密码不能为空").css("color","red");
			
			return false;
		}
		if(password.length<6){
			$("#password").next().html("密码需要大于或等于6个字符").css("color","red");
			
			return false;
		}
		$("#password").next().html("可用").css("color","green");
	}
	
	//判断确认密码
	function checkRepwd(){
		var password=$("#password").val();
		var rePassword=$("#rePassword").val();
		if(rePassword==null|rePassword==""){
			$("#rePassword").next().html("密码不能为空").css("color","red");
			
			return false;
		}
		if(rePassword!=password){
			$("#rePassword").next().html("密码不一致").css("color","red");
			
			return false;
		}
		$("#rePassword").next().html("可用").css("color","green");
	}
	
	//检查email格式
	function checkemail(){
		var szReg=/^[0-9]|[a-z]{1,15}@[a-z]|[0-9]{2,5}.com$/;
		var email=$("#email").val();
		if(email==null|email==""){
			$("#email").next().html("邮箱不能为空").css("color","red");
			return false;
		}
		if(!szReg.test(email)){
			$("#email").next().html("邮箱格式不正确！").css("color","red");
			return false;
		}
		$("#email").next().html("可用").css("color","green");
	}
	
	//检查电话号码
	function checkphone(){
		var Reg = /^1[3|4|5|7|8]\d{9}$/;
		var phone=$("#phone").val();
		if(phone==null|phone==""){
			$("#phone").next().html("电话不能为空").css("color","red");
			return false;
		}
		if(!Reg.test(phone)){
			$("#phone").next().html("电话格式不正确！").css("color","red");
			return false;
		}
		$("#phone").next().html("可用").css("color","green");
	}