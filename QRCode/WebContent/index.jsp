<%@ page contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>二维码 科帮网 关注我们 http://www.52itstyle.com</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.8.3.js" ></script>
<script type="text/javascript" src="js/jquery.form.js" ></script>
<style type="text/css">
 #preview, .img, img
 {
 width:200px;
 height:200px;
 }
 #preview
 {
border:1px solid #000;
}
</style>
</head>
<body>
<div id="preview"></div>
    <form name="fileUpload" enctype="multipart/form-data" method="post">
		<div>
			 <h3>请上传你的二维码</h3><input type="file" id="image" name="image" onchange="preview(this)" />
	    </div>
    </form>
<div> <input type="button" value="点击解析二维码" onclick="decoderQRCode()" ></br>
<span id="showCode">
</span>
</br>
</br>
</br>
</br>
<a href="http://www.52itstyle.com/forum-54-1.html" >更多源码点击这里</a>
</div>
<div> 
=========================================================================
</div>
<div>
  输入你要生成的文字说明 ：<textarea rows="5" cols="30" id="content" ></textarea></br>
<input type="button" value="点击生成二维码" onclick="encoderQRCode(this)" ></br>
<img id="imageShow" src="">
</div>
<script type="text/javascript">
var basePath = '<%=basePath%>';
//生成二维码
function encoderQRCode(thisObj){
	var content = $.trim($("#content").html())
	if(""===content){
		alert("小逗比请书写内容");
		return;
	}
	$.ajax({
		url:"qRCodeAction_encoderQRCode.action",
      	async:false,
      	type:'post',
      	dataType:'text',
      	data: {'time':(new Date()).toString(),content:content},
		success:function(result){
			var imgName = eval("("+result+")");
			var imgPath = basePath+"file/"+imgName;
			$("#imageShow").attr("src",imgPath);
			$(thisObj).hide();
		}
	});
}
//解析二维码
function decoderQRCode(){
	document.forms[0].action="qRCodeAction_decoderQRCode.action";
   	$("form[name='fileUpload']").ajaxSubmit({
   	    async:false,
         	type:'post',
         	async:true,
         	data:{'time':(new Date()).toString()},
            success: function(result) {
            	var message  = result==null?"逗比不要乱传图片":result
        	 	$("#showCode").html("解析结果："+message)
	   		},error:function(){
	   			alert("网络异常");
	     }
	   	});
}
</script>
 <script type="text/javascript">  
 function preview(file) {
 var prevDiv = document.getElementById('preview');
 if (file.files && file.files[0]) {
 var reader = new FileReader();
 reader.onload = function(evt){
 prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
}  
 reader.readAsDataURL(file.files[0]);
} else  {
 prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>'; 
 }
 }
 </script>

 </body>
 </html>
