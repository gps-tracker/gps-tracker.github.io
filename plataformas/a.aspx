

<!DOCTYPE>
<html>
<head><title>
	Sistema de localización satelital GPS 
</title><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/component/resources/css/ext-all.css" /><link rel="stylesheet" type="text/css" href="css/chooser.css" /><link rel="stylesheet" type="text/css" href="css/btn.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/data-view.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/data-view1.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/Ext.ux.grid.CellActions.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/Ext.ux.grid.RowActions.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/Ext.ux.grid.RowAction.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/progresscolumn/ProgressColumn.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/Ext.ux.form.CheckboxCombo.min.css" /><link rel="stylesheet" type="text/css" href="http://gpstrackerrls.com/js/extends/css/RowEditor.css" /><link rel="stylesheet" type="text/css" href="css/main.css" /><link rel="stylesheet" type="text/css" href="css/coolBlues.css" /><link type="text/css" rel="Stylesheet" href="http://gpstrackerrls.com/js/extends/css/ColumnHeaderGroup.css" /><link type="text/css" href="http://gpstrackerrls.com/js/BaiduMap/css/baiducss.css" rel="stylesheet" />
    <style type="text/css">
        .x-grid3-td-progress-cell .x-grid3-cell-inner {
            font-weight: bold;
        }

        .x-grid3-td-progress-cell .high {
            background: transparent url(http://gpstrackerrls.com/js/extends/progresscolumn/images/progress-bg-red.gif) 0 -33px;
        }

        .x-grid3-td-progress-cell .medium {
            background: transparent url(http://gpstrackerrls.com/js/extends/progresscolumn/images/progress-bg-orange.gif) 0 -33px;
        } 
           
        .x-grid3-td-progress-cell .low {
            background: transparent url(http://gpstrackerrls.com/js/extends/progresscolumn/images/progress-bg-green.gif) 0 -33px;
        }
        
        .x-grid3-td-progress-cell .ux-progress-cell-foreground {
            color: #fff;
        }
    </style>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/component/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/component/ext-all.js"></script>	
    
    
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/jQueryRotate.2.2.js"></script>
	<script type="text/javascript" src="sound/soundmanager2-min.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.JSLoader.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/cookie.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/Dictionary.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/security.js"></script>
    <script src="http://gpstrackerrls.com/js/extends/extendjs.js" type="text/javascript"></script>
	<script type="text/javascript" >
	    var meimaptype = getCookie("meimaptype") == null ?0 : parseInt(getCookie("meimaptype"));

//	    window.onerror = function() {
//	        var lm = Ext.get('div_loading_content');
//	        lm.dom.innerHTML = _loadingError;
//	        Ext.get('loading').center();
//	    }
	</script>
    

</head>
<body>
    <form name="form1" method="post" action="trackermain.aspx" id="form1">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUJODY3MjIwNzY3ZGQS3mao4NIV1RaSoGVlrV3B1IsA4g==" />
</div>

<div>

	<input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="8C97FB4F" />
</div>
    <div id="loading-mask" style=""></div>    
      <div id="loading">
        <div class="loading-indicator">
              <img src="images/loading.gif" alt="" width="32" height="32" style="margin-right:8px;" align="absmiddle"/><div id="div_loading_content">Cargando...</div>
        </div>
      </div>
    <div id="header" style="visibility:hidden"> 
	    <div class="api-title" >Sistema de localización Satelital GPS </div> 
       
    </div>
    
    </form>
</body>
    
   
    <script src='http://maps.googleapis.com/maps/api/js?v=3.9&sensor=false&libraries=places&key=' type="text/javascript"></script>

    <script type="text/javascript">
        var clientlang = window.navigator.language;
        if (clientlang == null)
            clientlang = window.navigator.systemLanguage;
        var permission = 0;
        var grouplogin = 1;
        var turnoffalarmsound = getCookie("turnoffalarmsound") == 'false' ? false : true;
        var showmiles = getCookie("showmiles") == 'true' ? true : false;
        var showfahrenheit = getCookie("showfahrenheit") == 'true' ? true : false;
        var showgsmcircle = getCookie("showgsmcircle") == 'false' ? false : true;
        var gpsinvalidtype = getCookie("gpsinvalidtype")=='0'?0:1;
        var speedstr = "km/h"; //定义map中使用速度单位
        if (showmiles)
            speedstr = "mph";

        var isdemoaccount = 'False';

        var showStatuseInfoArray = [];

        var gmapurl = 'maps.google.com';
        var hasEmergency = false;
        var soundLoaded = false;
        var soundManager;
        var everythingloaded = false;
        
        function showStatusInfoClass(bitIndex, iconTrue, iconFalse, TrueExp, FalseExp) {
            this.bitIndex = bitIndex;
            this.iconTrue = iconTrue;
            this.iconFalse = iconFalse;
            this.TrueExp = TrueExp;
            this.FalseExp = FalseExp;
        }

//        window.onerror = function() {
//            if (!everythingloaded)
//                window.location.href = "trackermain.aspx";
//        }
        
    </script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/settings.js"></script>
    
    <script type="text/javascript">
        var rtimes = 0;
        
        if (typeof (google) == 'undefined' && meimaptype == 0) {
            var lang = getCookie("gpslang");
            if (clientlang == "zh-cn" || clientlang == "zh-CN") {//只有浏览器支持中文，就自动刷转
                if(rtimes >=3){
                  setCookie("meimaptype","2",0.1);
                }
                setTimeout(function() {
                    rtimes++;
                    if(rtimes<=3)
                        window.location.href = "trackermain.aspx?gr="+rtimes.toString(); 
                    else
                        window.location.href ="trackermain.aspx";
                }, 5000); //加载不到地图会5秒钟刷新一下，直到下载到地图
            }
            else{
                if(rtimes >=3){
                  setCookie("meimaptype","1",0.1);
                }
                setTimeout(function() {
                    rtimes++;
                    if(rtimes<=3)
                        window.location.href = "trackermain.aspx?gr="+rtimes.toString(); 
                    else
                        window.location.href ="trackermain.aspx";
                }, 5000); //加载不到地图会5秒钟刷新一下，直到下载到地图
            }
        }
       
    </script>

	<script type="text/javascript" src="http://gpstrackerrls.com/js/trackerinfo.js"></script>
	
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.ImageButton.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.MultiSelect.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.util.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.grid.CheckColumn.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.grid.CellActions.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.grid.PropertyGrid.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.grid.RowActions.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.grid.RowAction.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.form.ThemeCombo.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.Toast.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.state.HttpProvider.js"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.RouteCompareChartPanel.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.form.Myimg.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/progresscolumn/ProgressColumn.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.form.CheckboxCombo.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.ImageEditor.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/DataView-more.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/ColumnHeaderGroup.js"></script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/panelgbparams.js"></script>
    
	<script type="text/javascript" src="http://gpstrackerrls.com/js/resource/res_es_es.js?v=1.5.4.27"></script>
	<script type ="text/javascript">
	    /*jsload('http://gpstrackerrls.com/js/extends/Ext.ux.ImageButton.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.MultiSelect.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.util.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.grid.CheckColumn.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.grid.CellActions.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.grid.PropertyGrid.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.grid.RowActions.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.form.ThemeCombo.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.Toast.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.state.HttpProvider.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.form.Myimg.js');
	    jsload('http://gpstrackerrls.com/js/extends/progresscolumn/ProgressColumn.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.form.CheckboxCombo.min.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.ImageEditor.js');
	    jsload('http://gpstrackerrls.com/js/extends/DataView-more.js');*/
	    /*var meimaptype = getCookie("meimaptype") == null ? 0 : parseInt(getCookie("meimaptype")); //0 google map ,1 bing map
	    if (meimaptype == 0) {
	    /*jsload('http://gpstrackerrls.com/js/TLabelV2.js');
	    jsload('http://gpstrackerrls.com/js/simulator.js');
	    jsload('http://gpstrackerrls.com/js/extensions.pack.js');
	    jsload('http://gpstrackerrls.com/js/exmarker.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.gmaps.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.gmapwindow.js');
	    jsload('http://gpstrackerrls.com/js/gmapxz.js');
	    jsload('http://gpstrackerrls.com/js/ms_gearth.js');
	    jsload('http://gpstrackerrls.com/js/ms_gmap.js');
	    jsload('http://gpstrackerrls.com/js/gmapextentsearch.js');
	    }
	    else {
	    jsload("http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.3", function() {
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.bmaps.js');
	    jsload('http://gpstrackerrls.com/js/extends/Ext.ux.bmapwindow.js');
	    jsload('http://gpstrackerrls.com/js/BTLabel.js');
	    jsload('http://gpstrackerrls.com/js/bmapxz.js');
	    });
	    }*/
	    
	</script>
	<script type="text/javascript" src="http://gpstrackerrls.com/js/TLabel_V3.js"></script>
<script type="text/javascript" src="http://gpstrackerrls.com/js/extensions.pack.js" ></script>
<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.gmaps_V3.js"></script>
<script type="text/javascript" src="http://gpstrackerrls.com/js/extends/Ext.ux.gmapwindow_V3.js"></script>
<script type="text/javascript" src="http://gpstrackerrls.com/js/gmapxz_V3.js?v=1.3.3.12"></script>
<script type="text/javascript" src="http://gpstrackerrls.com/js/exmarker_v3.js"></script>
<script type="text/javascript" src="http://gpstrackerrls.com/js/ms_gmap_V3.js?v=1.4.12.31"></script>

	
    
    
    <script type="text/javascript" src="http://gpstrackerrls.com/js/program_module.js?v=1.4.10.22"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/messagereportwindow.js?v=1.3.11.20"></script>
     
    <script type="text/javascript" src="http://gpstrackerrls.com/js/RouteCompareChartWindow.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/tracker_geofence_relation_window.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/pgeofencewindow.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/inputstatusreport.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/VDRreport.js?v=1.3.11.20"></script>
   
    <script type="text/javascript" src="http://gpstrackerrls.com/js/extends/chooser.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/extends/RowEditor.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/parkingspeeddistanceWindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/AllLineChartWindow.js?v=1.4.5.16"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/customerconfig.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/odoreport.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/panelmenu.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/allCarsSensorReport.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/devicetreewindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/paneldevicelist.js?v=1.3.11.20" ></script>

    <script type="text/javascript" src="http://gpstrackerrls.com/js/panelcommandplus.js?v=1.5.2.28" ></script> 
    <script type="text/javascript" src="http://gpstrackerrls.com/js/panelstatus.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/mainwindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/readlastlocation.js?v=1.3.11.20"></script>
    
    <script type="text/javascript" src="http://gpstrackerrls.com/js/alarmwindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/historywindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/GroupUserTrackerWindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/ALLEvents.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/poiwindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/driverwindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/rfidwindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/authwindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/PhotoListWindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/RFIDAuthWindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/locationwindow.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/routewindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/timezonewindow.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/serviceDueWindow.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/sms_report_window.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/otawindow.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/trackerconfig.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/trackerextendsensorwin.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/trackerfuelsensorwin.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/addnewfuelsensorwin.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/gbtrans.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/ledcommand.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/ledallsettingswin.js?v=1.3.11.20" ></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/ledaddnewadvwin.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/sensoraveragereport.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/e01command.js?v=1.4.06.16"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/settingtools2.js?v=1.4.06.16"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/maintenancewindow.js?v=1.3.11.20"></script>
    <script type="text/javascript" src="http://gpstrackerrls.com/js/trackervertexwindow.js?v=1.3.11.20"></script>
   <script type="text/javascript" src="http://gpstrackerrls.com/js/customerreport1.js?v=1.3.11.20"></script>
   <script type="text/javascript" src="http://gpstrackerrls.com/js/aboutwindow.js?v=1.3.11.20"></script>
   
  
      	<!-- <script type="text/javascript" src="http://www.extjs.com/deploy/dev/examples/form/states.js"></script>EXAMPLES --> 
	<!--<script language="javascript" type="text/javascript">
	var SM2_DEFER=true;
	</script>
	<script type="text/javascript" src="js\soundManager\script\soundmanager2.js"></script>-->
</html>