<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="info.modifycolumninfo"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
String sortChannelId = request.getAttribute("sortChannelId")!=null?request.getAttribute("sortChannelId").toString():"";
String allChannelList = request.getAttribute("allChannelList")!=null ? request.getAttribute("allChannelList").toString() :"[]";
%>
<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
			<s:form name="dataForm" id="dataForm" action="YiBoChannel!update.action" method="post" theme="simple" >
			<%@ include file="/public/include/form_detail.jsp"%>
			<%@ include file="channel_yibo_form.jsp"%>
			</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	var channelType = $("#channelType").val();
	var userDefine = $("#userDefine").val();
	
	//回填易播栏目id值（在校验重复名称时候会使用）
	
	//回填所属栏目值
	var channelId = '<s:property value="yiboChannel.channelId"/>';
	if(channelId!=''){
		$('#channelId').val(channelId);
	}
	//回填排序易播栏目的值
	var sortChannelId = '<%=sortChannelId%>';
	if(sortChannelId!=''){
		//$('#channelOrderId').combobox('setValue', sortChannelId);
		$('#channelOrderId').val(sortChannelId);
	}
	//回填易播播放条数的值
	var yiboPlayNum = '<s:property value="yiboChannel.yiboPlayNum"/>';
    yiboPlayNum = yiboPlayNum==''?'30':yiboPlayNum;
    $("#yiboPlayNum").combobox('setValue', yiboPlayNum);
});

initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<s:text name="info.newinfosave"/>'});
Ext.onReady(function() {
	var tp = Ext.create('Ext.XTemplate',
		'<tpl for=".">',
			'<tpl if="first == 1">',  
				'<div style="font-size:12px;font-weight:bold;">信息管理</div>',  
			'</tpl>',
			'<tpl if="first == 2">',  
				'<div style="font-size:12px;font-weight:bold;">单位主页</div>',  
			'</tpl>',
			'<tpl if="first == 3">',  
				'<div style="font-size:12px;font-weight:bold;">自定义信息频道</div>',  
			'</tpl>',
			'<div class="x-boundlist-item">{name}</div>',
		'</tpl>'
	);

	var states = Ext.create('Ext.data.Store', {
		fields: ['id', 'name', 'first'],
		data : <%=allChannelList%>
	});

	Ext.create('Ext.form.ComboBox', {
		store: states,
		queryMode: 'local',
		valueField: 'id',
		displayField: 'name',
		typeAhead: true,
		id: 'channelId',
		transform: 'channelId',
		hiddenName: 'selectedChannel',
		width:804,
		forceSelection: true,
		renderTo: Ext.getBody(),
		emptyText: '<s:text name="info.searchcolumn"/>',
		tpl: tp
	});
    
	whirExtCombobox.setValue('channelId',$("#channel").val());
});

function save(flag,obj){
	var result = "";
	var selectedChannel = whirExtCombobox.getValue('channelId');
	if(selectedChannel==null || selectedChannel=="" || selectedChannel=="0"){
		whir_alert('<s:text name="info.PleaseSelectColumn"/>');
		return;
	}
	var channelId =selectedChannel.substring(0,selectedChannel.indexOf(","));
	var yiboChannelId = '<s:property value="yiboChannel.yiboChannelId"/>';
	if(channelId==""||channelId=="-1"){
		whir_alert('<s:text name="info.PleaseSelectColumn"/>');
		return;
	}else{
		$.ajax({
			type: 'POST',
			url: whirRootPath+"/YiBoChannel!judgeName.action?searchChannelName="+encodeURIComponent($("#yiboChannelName").val())+"&yiboChannelId="+yiboChannelId+"&channelId="+channelId,
			async: false,
			dataType: 'text',
			cache:false,
			success: function(data){
				if(data!=null && data!=""){
					if(data=="2"){
						result = "2";
					}else if(data=="1"){
						result = "1";
					}
				}
			}
		});
		if(result=="2"){
			whir_alert("此栏目已被设置为易播栏目，请重新选择！");
			return;
		}else if(result=="1"){
			whir_alert('<s:text name="info.ColumnNameRepeat"/>');
			return;
		}
	}

	ok(flag,obj);
}
</script>
</html>

