<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=自己申请的密钥"></script>
    <title>批量转换</title>
</head>
<body>
    <div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
 
    var points = [new BMap.Point(117.187,39.0998),//这里给出要gps定位的经纬度信息
                  new BMap.Point(117.185,39.0996),//可以是一个定位点也可以是多个定位点
                  new BMap.Point(117.184,39.0996),
                  new BMap.Point(117.184,39.0996),
                  new BMap.Point(117.183,39.0997)
    ];
 
    //地图初始化
    var bm = new BMap.Map("allmap");
    bm.centerAndZoom(new BMap.Point(116.378688937,39.9076296510), 15);
 
    //坐标转换完之后的回调函数
    translateCallback = function (data){
      if(data.status === 0) {
        for (var i = 0; i < data.points.length; i++) {
            bm.addOverlay(new BMap.Marker(data.points[i]));
            bm.setCenter(data.points[i]);
        }
      }
    }
    setTimeout(function(){
        var convertor = new BMap.Convertor();
        convertor.translate(points, 1, 5, translateCallback)
    }, 1000);
</script>