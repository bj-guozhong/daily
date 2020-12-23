常用的一些JS脚本

1.报名成功返回时返回到完全相同的滚动位置 add by:gz  20201127
$(window).scroll(function () {
    //set scroll position in session storage
    sessionStorage.scrollPos = $(window).scrollTop();
});
var init = function () {
    //get scroll position in session storage
    $(window).scrollTop(sessionStorage.scrollPos || 0)
};
window.onload = init;

2.在页面整体BODY中加入水印，水印内容为当前登陆人账号，watermark()方法来源water.js,可以在仓库videoWaterMarkByJsDemo中找到。
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

3.全屏模式下无法监听esc按键，解决办法：onresize 监听窗口改变
window.onresize = function() {
  if (!checkFull()) {
    //清空全屏模式下的水印内容，方法watermark3
	 watermark3({"watermarl_element":"player_a", "watermark_txt":"clear"});
  }
}
function checkFull() {
  var isFull =
    document.fullscreenElement ||
    document.mozFullScreenElement ||
    document.webkitFullscreenElement
  if (isFull === undefined) isFull = false
  return isFull
}
</script>

4.页面禁止右键，这个算不上JS方法：
<body id="bid" oncontextmenu="return false" onselectstart="return false" oncopy = "return false">


