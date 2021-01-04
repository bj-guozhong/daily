<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
        }
        * {
            margin: 0px;
            padding: 0px;
        }
        .vlist {
            width: 100%;
        }
        #a1,.video {
            position: absolute;
            left: 0px;
            right: 0px;
            top: 0px;
            bottom: 0px;
            width: 100%;
            height: 100%;
        }
    </style>
    <title></title>
</head>
<body>
    <div class="video" id="mvideo"></div>
    <script type="text/javascript" src="/Content/js/ckplayer.js" charset="utf-8"></script>
    <script type="text/javascript">
         //使用ckplayer支持m3u8U直播
        var isiPad = navigator.userAgent.match(/iPhone|iPad|Linux|Android|iPod|ios|iOS|Windows Phone|Phone|WebOS/i) != null;
        var videoid = "4C4B74BF22FDBA35";
        var m3u8Url = "http://v.michaeljackson.cn/videos/mj_oni.mp4_DGR5lTix.m3u8";
        var picUrl = "";
        var player = null;
        if (isiPad) {
            document.getElementById('mvideo').innerHTML = '<video src="' + m3u8Url + '" poster="' + picUrl + '" controls="controls" webkit-playsinline="true" style="width: 100%; height: 100%; background-color: rgb(0, 0, 0);" width="100%" height="100%"></video>'
        } else {
            function SetCookie(name, value) {
                var Days = 30;
                var exp = new Date();
                exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
                document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
            }
            function getCookie(name) {
                var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
                if (arr != null) return unescape(arr[2]); return null;
            }
            function loadHandler() {
                player.addListener('time', timeHandler);
            }
            function timeHandler(t) {
                if (t > -1)
                    SetCookie(videoid + "_time", t);
            }
            var videoObject = {
                container: '.video',
                variable: 'player',
                loaded: 'loadHandler',
                poster: picUrl,
                html5m3u8: true,
                video: m3u8Url
            };
            var cookieTime = getCookie(videoid + "_time");
            if (!cookieTime || cookieTime == undefined) {
                cookieTime = 0;
            }
            if (cookieTime > 0) {
                videoObject['seek'] = cookieTime;
            }
            player = new ckplayer(videoObject);
        }
    </script>
</body>
</html>
