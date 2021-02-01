<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<title>视频详情</title>
<link href="${ctx}/files/style3.css" rel="stylesheet" type="text/css"></link>

<!-- jQuery  -->
<script type="text/javascript" src="${ctx}/files/water.js"></script>
<script type="text/javascript" src="${ctx}/files/water2.js"></script>
<script type="text/javascript" src="${ctx}/files/water3.js"></script>
<script type="text/javascript" src="${ctx}/files/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${ctx}/js/ckplayer/ckplayer/ckplayer.js" ></script>
<script>
$(document).ready(function() {
	var userid = '${uid}';
	var token = '${token}';
	//console.log(".................userid"+userid+"--------------token:"+token);
	//var username = '${username}';
    var watermark_txt=userid;//水印内容
    document.getElementById("watermarkId").value = watermark_txt;
    //默认进入首页设置页面水印
    watermark({"watermarl_element":"body", "watermark_txt":watermark_txt});//body为要添加的标签id
});

//js全屏模式下无法监听esc按键，解决办法：onresize 监听窗口改变
window.onresize = function() {
  if (!checkFull()) {
    //清空全屏模式下的水印内容，方法watermark3,参数clear
	 watermark3({"watermarl_element":"video", "watermark_txt":"clear"});
  }else{
	  //console.log("is onresize fullscreen ");
	 // watermark3({"watermarl_element":"video", "watermark_txt":"123456"});//body为要添加的标签id
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
<style>
        input{
            font-size:12px;
             /* 设置输入框中字体的大小 */
            height:35px; 
            /* 设置输入框的高度 */
            border-radius:4px; 
            /* 设置输入框的圆角的大小 */
            border:1px solid #c8cccf;
            /* 设置输入框边框的粗细和颜色 */
            color:#986655; 
            /* 设置输入框中文字的颜色 */
            outline:0; 
            /* 将输入框点击的时候出现的边框去掉 */
            text-align:left; 
            /* 设置输入框中文字的位置 */
            padding-left: 10px;
            display:block; 
            /* 将输入框设置为块级元素 */
            cursor: pointer;
             box-shadow: 2px 2px 5px 1px #ccc;  
            }
         input::-webkit-input-placeholder{
             color: #986655;
             font-size: 13px;
         }
</style>    
</head>
<body id="bid" oncontextmenu="return false"  oncopy = "return false">
	<div class="column_wrapper">
	<c:forEach items="${videos }" var="videos" varStatus="index">
		<div class="h3_ts1">${videos.title }</div><div class="md_hd"></div>
			<div class="video"> 
				<div class="nr_1">
				<div id="video" style="width:100%;height:500px;max-width:1000px;">
				</div>
				<script type="text/javascript">
					//定义一个变量：videoObject，用来做为视频初始化配置
					var videoObject = {
						container: '#video', 		//容器的ID或className
						variable: 'player', 		//播放函数名称
						loop: true, 				//播放结束是否循环播放
						autoplay: false,			//是否自动播放
						poster: '${videos.thumb}',	//封面图片
						preview: { 					//预览图片
							file: ['${ctx}/js/ckplayer/material/mydream_en1800_1010_01.png', '${ctx}/js/ckplayer/material/mydream_en1800_1010_02.png'],
							scale: 2
						},
						//flashplayer:true,
						//debug:true,
						video: [
							['${videos.videoSrc}?userId=${uid}&token=${token}', 'video/mp4', '', 0],	//视频地址
						]
					};
					var player = new ckplayer(videoObject);//初始化播放器
				    function loadedHandler(name){
						//调用到该函数后说明播放器已加载成功，可以进行部分控制了。此时视频还没有加载完成，所以不能控制视频的播放，暂停，获取元数据等事件
						player.addListener('loadedmetadata', loadedMetaDataHandler); //监听元数据
				    }
				    function loadedMetaDataHandler(name){
				    	//player.videoPlay();//控制视频播放
				    }
				    //1：使用控制动作时必需确保播放器已加载
				    //2：不能控制播放器的全屏和退出全屏动作，出于安全考虑，浏览器必需监听到用户点击动作才能进行全屏操作和退出全屏操作
				    //3：当使用player.videoClear()清空视频后请同时清空播放器容器的内容
				</script>
				</div>
				</div>
				<!-- DESC：假弹幕，没有写到数据库，只是页面上实现这一简单效果，如果有需求，则按播放时间节点和弹幕内容写入到数据库，在页面加载视频时读取所有弹幕，按时间节点遍历匹配弹幕进行显示 -->
				<!-- <input type="text" class="form_input" id="text" value="" size="25" onkeydown="getKey(event)" placeholder="写个弹幕回车试试看吧" /> -->
				<div class="column_wrapper_0428">
		            <div class="last_md_left">
		                <div class="lf1" id="videoDesc">${videos.desc}
		                </div>
		            </div>
		        </div>
		</c:forEach>
	</div>
<input type="hidden" name="" value="" id="watermarkId" />
</body>
<script>
var first = "";
var now;

//旋转视频角度
function turnRotate(){
	player.videoRotation(1);
}
//获取用户是否回车
function getKey(event) {
    if (event.keyCode == 13) {
    	var date = new Date();
	     	var time = date.getTime(); //毫秒时间
	     	if (first!="") {
	 	         var nowDate = new Date();
	 	         now = nowDate.getTime();
	 	         var num = now-first;
	 	         if(num>30000){//30秒内间隔不到刷弹幕
	 	        	this.newDanmu(document.getElementById('text').value);
		 	    	document.getElementById('text').value="";
		 	    	first = time;
	 	         }
	 	         else{
	 	        	 document.getElementById('text').value="";
	 	        	 alert("请不要频繁刷弹幕，30秒过后再试!");
	 	        	 return;
	 	         }
	     	}
	     	else{
	    		first = time;
	    		//console.log("22222222");
	 	    	this.newDanmu(document.getElementById('text').value);
	 	    	document.getElementById('text').value="";
	     	}
    }
}

/**
 * 以下是生成弹幕的方法,当前窗口可新创建弹幕，加载该页面时需要从数据库读取所有弹幕，按播放时间节点进行匹配然后进行显示
 */
 function loadedHandler() {}
	var y=0;
	var DArr=[];//弹幕数组
	var YArr=[];//元件数组
	function newDanmu(value) {
		//弹幕说明
		y+=20;
		if(y>300)y=0;
		var danmuObj = {
			list: [{
				type: 'text', //定义元素类型：只有二种类型，image=使用图片，text=文本
				file: '', //图片地址
				radius: 30, //图片圆角弧度
				width: 30, //定义图片宽，必需要定义
				height: 30, //定义图片高，必需要定义
				alpha: 0.9, //图片透明度(0-1)
				marginLeft: 10, //图片离左边的距离
				marginRight: 10, //图片离右边的距离
				marginTop: 10, //图片离上边的距离
				marginBottom: 10, //图片离下边的距离
				clickEvent: "link->http://"
			}, {
				type: 'text', //说明是文本
				text: value, //文本内容
				color: '0xFFDD00', //文本颜色
				size: 14, //文本字体大小，单位：px
				font: '"Microsoft YaHei", YaHei, "微软雅黑", SimHei,"\5FAE\8F6F\96C5\9ED1", "黑体",Arial', //文本字体
				leading: 30, //文字行距
				alpha: 1, //文本透明度(0-1)
				paddingLeft: 10, //文本内左边距离
				paddingRight: 10, //文本内右边距离
				paddingTop: 0, //文本内上边的距离
				paddingBottom: 0, //文本内下边的距离
				marginLeft: 0, //文本离左边的距离
				marginRight: 10, //文本离右边的距离
				marginTop: 10, //文本离上边的距离
				marginBottom: 0, //文本离下边的距离
				backgroundColor: '0xFF0000', //文本的背景颜色
				backAlpha: 0, //文本的背景透明度(0-1)
				backRadius: 30, //文本的背景圆角弧度
				clickEvent: "actionScript->videoPlay"
			}],
			x: '100%', //x轴坐标
			y: y, //y轴坐标
			//position:[2,1,0],//位置[x轴对齐方式（0=左，1=中，2=右），y轴对齐方式（0=上，1=中，2=下），x轴偏移量（不填写或null则自动判断，第一个值为0=紧贴左边，1=中间对齐，2=贴合右边），y轴偏移量（不填写或null则自动判断，0=紧贴上方，1=中间对齐，2=紧贴下方）]
			alpha: 1,
			//backgroundColor:'#FFFFFF',
			backAlpha: 0.8,
			backRadius: 30 //背景圆角弧度
		}
		var danmu = player.addElement(danmuObj);
		var danmuS = player.getElement(danmu);
		var obj = {
			element: danmu,
			parameter: 'x',
			static: true, //是否禁止其它属性，true=是，即当x(y)(alpha)变化时，y(x)(x,y)在播放器尺寸变化时不允许变化
			effect: 'None.easeOut',
			start: null,
			end: -danmuS['width']+300,
			speed: 10,
			overStop: true,
			pauseStop: true,
			callBack: 'deleteChild'
		};
		var danmuAnimate = player.animate(obj);
		DArr.push(danmuAnimate);
		console.log(danmu);
		YArr.push(danmu);
	}

	function deleteChild(ele) {
		if(player) {
			player.deleteElement(ele);
			if(YArr.indexOf(ele)>-1){//在YArr也就是保存弹幕的全局变量里搜索该弹幕，然后删除
				var n=YArr.indexOf(ele);
				console.log(n)
				YArr.splice(n,1);
			}
		}
	}
	function delDanmu(){
		for(var i=DArr.length-1;i>-1;i--){
			console.log(DArr[i],i)
			if(player) {
				try{
					player.deleteAnimate(DArr[i]);
					//player.deleteElement(YArr[i]);
				}
				catch(error){
					console.log(error);
				}
			}
		}
	}
	function getCoor(){
		for(var i=0;i<YArr.length;i++){
			console.log(player.getElement(YArr[i]));
			//这里可以直接输出所有的弹幕，不能获取到的会返回null
		}
	}
	
</script>
</html>


