<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2&ak=8xQSmKfmrvww8c65tlUd0XjmhPqlLFOo"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<title>百度地图</title>
</head>
<body>
<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">

var xx = 111.73;
var yy = 40.83;
var gpsPoint = new BMap.Point(xx,yy);

//初始化
var bm = new BMap.Map("allmap");
bm.centerAndZoom(gpsPoint, 15);
bm.addControl(new BMap.NavigationControl());


translateCallback = function (point){
    var marker = new BMap.Marker(point);
    bm.addOverlay(marker);
    var label = new BMap.Label("Hello",{offset:new BMap.Size(20,-10)});
    marker.setLabel(label); //添加百度label
    bm.setCenter(point);
    alert(point.lng + "," + point.lat);
}

setTimeout(function(){
    BMap.Convertor.translate(gpsPoint,0,translateCallback);     
}, 2000);
</script>
