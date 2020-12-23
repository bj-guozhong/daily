1.全屏模式下无法监听esc按键，键盘ESC代码27不生效，被win10自带的ESC覆盖也可用此方法：onresize 监听窗口改变.
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
