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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2&ak=8xQSmKfmrvww8c65tlUd0XjmhPqlLFOo"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<title>地图</title>
</head>
<body>
<div id="allmap"></div>
<script type="text/javascript">

	var map = new BMap.Map("baidu_map");
	
	<%
	gpsDAO gsp=new gpsDAO();
	List <String>list=gsp.getGpsList();
	List <Position>points=new ArrayList<Position>();
	int flag=0;
	float x1=0;
	float y1=0;
	if(list!=null){
		for(String path:list){
			Position point=new Position();
			ImgInfoBean imgInfoBean = new SampleUsage().parseImgInfo(path);
			point.x=imgInfoBean.getLongitudeNumber();
			point.y=imgInfoBean.getLatitudeNumber();
			points.add(point);
		}
		for(Position nowpoi:points){
			if(flag==1){
				%>
				var beforex="<%=x1%>";
				var beforey="<%=y1%>";
				var nowx="<%=nowpoi.x%>";
				var nowy="<%=nowpoi.y%>";
				var pointA =new BMap.Point(parseFloat(beforex),parseFloat(beforey));
				var pointB =new BMap.Point(parseFloat(nowx),parseFloat(nowy));
				var polyline =new BMap.Polyline([pointA,pointB],{strokeColor:"blue",strokeWeight:6,});
				map.addOverlay(polyline);
				<%
			}else{
				%>
				var nowx="<%=nowpoi.x%>";
				var nowy="<%=nowpoi.y%>";
				var point =new BMap.Point(parseFloat(nowx),parseFloat(nowy));
				//地图初始化
				var bm = new BMap.Map("allmap");
				bm.centerAndZoom(gpsPoint, 15);
				bm.addControl(new BMap.NavigationControl());
				//添加一个跳跃的点
				var marker = new BMap.Map(point);//标注
				map.addOverlay(marker);
				marker.setAnimation(BMAP_ANIMATION_BOUNCE);
				<%
			}
			x1=nowpoi.x;
			y1=nowpoi.y;
			flag=1;
		}
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