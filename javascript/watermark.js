1.在页面整体BODY中加入水印，水印内容为当前登陆人账号，watermark()方法来源water.js,可以在仓库videoWaterMarkByJsDemo中找到。
<script>
$(document).ready(function() {
	var userid = '${uid}';
	//var username = '${username}';
    var watermark_txt=userid;//水印内容
    document.getElementById("watermarkId").value = watermark_txt;
    //默认进入首页设置页面水印
    watermark({"watermarl_element":"body", "watermark_txt":watermark_txt});//body为要添加的标签id
});
</script>
