<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.drew.metadata.SampleUsage"%>
<%@ page import="com.drew.metadata.ImgInfoBean"%>
<%@ page import="com.edu.imnu.exifgps.dao.gpsDAO"%>
<%@ page import="com.edu.imnu.exifgps.dao.Position"%>
<%@ page import="com.edu.imnu.exifgps.util.DBUtil"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2&ak=8xQSmKfmrvww8c65tlUd0XjmhPqlLFOo"></script>

<title>地图</title>
</head>
<body>
<div id="allmap"></div>
<script type="text/javascript">

	var map = new BMap.Map("baidu_map");

	<%
	int i=0;
	int x1=44;
	int y1=111;
	int flag=0;
		for(i=0;i<3;i++){
			if(flag==1){
				%>
				var beforex="<%=x1%>";
				var beforey="<%=y1%>";
				var nowx="<%=x1+0.1%>";
				var nowy="<%=y1+0.2%>";
				var pointA =new BMap.Point(parseFloat(beforex),parseFloat(beforey));
				var pointB =new BMap.Point(parseFloat(nowx),parseFloat(nowy));
				var polyline =new BMap.Polyline([pointA,pointB],{strokeColor:"blue",strokeWeight:6,strokeOpacity:0.5});
				map.addOverlay(polyline);
				<%
			}else{
				%>
				var nowx="<%=x1%>";
				var nowy="<%=y1%>";
				var point =new BMap.Point(parseFloat(nowx),parseFloat(nowy));
				//初始化
				map.centerAndZoom(Point, 15);
				map.enableScrollWheelZoom();
				//添加一个跳跃的点
				var marker = new BMap.Map(point);//标注
				map.addOverlay(marker);
				marker.setAnimation(BMAP_ANIMATION_BOUNCE);
				
				<%
			}
			flag=1;
		}
	
	%>
	//控件
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});//左上角比例尺
	var top_left_navigation = new BMap.NavigationControl();//左上角默认缩放平移
	var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT,type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮
	map.addControl(top_left_navigation);
	map.addControl(top_right_navigation);
	
</script>
</body>
</html>