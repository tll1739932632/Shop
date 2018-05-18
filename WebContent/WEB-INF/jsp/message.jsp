<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>激活页面</title>


<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	var i=5;
	var t=0;
$(document).ready(function(){
	t=setInterval("countdown()", 1000);
	
});
function countdown(){
	$(".box").find("span").html(i);
	i--;
	if(i==0){
		clearInterval(t);
		location.href="../login.do";
	}
}
</script>
</head>
<body>

	<div class="box">
		<p style="color:green;">恭喜你，激活成功！<span>5</span>秒钟之后跳转到登陆界面！</p>
		<a href="../login.do">没有跳转？点此直接访问登陆页面！</a>
	</div>
</body>
</html>