<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>工作日志-通用日志-展示页面-天</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/modules/personal/worklog/common_display_js.js" type="text/javascript"></script>
    <link  href="<%=rootPath%>/modules/personal/worklog/common_displayStyle.css" rel="stylesheet" type="text/css"/>
    <script src="<%=rootPath%>/modules/personal/worklog/worklog_common_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/modules/personal/worklog/worklog_common_display_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
    <style>html,body{height:100%;}</style>
</head>

<body class="MainFrameBox" id="logBoxBody">
    <s:form name="queryForm" id="queryForm" action="${ctx}/WorkLogAction!displayList.action" method="post" theme="simple">
        <s:hidden name="menuType" id="menuType" value="%{menuType}" />  
        <s:hidden name="displayType" value="day" />
    <!-- SEARCH PART START -->
    <%@ include file="/public/include/form_list.jsp"%>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
        <tr>
            <s:if test="#request.menuType=='underling'">
                <td class="whir_td_searchtitle"><s:text name="myworklog.selectemp"/>：</td>
                <td class="whir_td_searchinput">
                    <s:hidden id="queryUnderlingEmpPara" value="%{#request.queryUnderlingEmp}" />  
                    <select name="queryUnderlingEmp" id="queryUnderlingEmp" class="easyui-combobox" style="width:209px;" data-options="">
                        <option value="">--<s:text name="innercontact.select"/>--</option>
                        <s:iterator var="obj" value="#request.underlingEmpList" >
                            <option value="<s:property value='#obj[0]' />" ><s:property value='%{#obj[1]}' escape='false'/></option>
                        </s:iterator>
                    </select>
                </td>
            </s:if>
            <s:if test="#request.menuType=='query'">
                <td class="whir_td_searchtitle"><s:text name="myworklog.name"/>：</td>
                <td class="whir_td_searchinput">
                    <s:hidden id="queryWorkLogEmpId" name="queryWorkLogEmpId" value="%{#request.queryWorkLogEmpId}" />
                    <s:textfield name="queryWorkLogEmpName" id="queryWorkLogEmpName" value="%{#request.queryWorkLogEmpName}" cssClass="inputText" readonly="true" /><a href="JavaScript:void(0);" class="selectIco" onclick="openSelect({allowId:'queryWorkLogEmpId', allowName:'queryWorkLogEmpName', select:'user', single:'yes', show:'user', range:'<s:property value="%{#request.scopeRange}" />'});"></a>
                </td>
                <td class="whir_td_searchtitle"><s:text name="taskcenter.department"/>：</td>
                <td class="whir_td_searchinput">
                    <s:hidden id="queryWorkLogOrgId" name="queryWorkLogOrgId" value="%{#request.queryWorkLogOrgId}" />
                    <s:textfield name="queryWorkLogOrgName" id="queryWorkLogOrgName" value="%{#request.queryWorkLogOrgName}" cssClass="inputText" readonly="true" /><a href="JavaScript:void(0);" class="selectIco" onclick="openSelect({allowId:'queryWorkLogOrgId', allowName:'queryWorkLogOrgName', select:'org', single:'yes', show:'org', range:'<s:property value="%{#request.scopeRange}" />'});"></a>
                </td>
            </s:if>
            <td class="whir_td_searchtitle"><s:text name="myworklog.logdate"/>：</td>  
            <td class="whir_td_searchinput">
                <input type="text" class="Wdate whir_datebox" name="queryDate" id="queryDate" value='<s:property value="%{queryDate}" />' onclick="WdatePicker({el:'queryDate',isShowWeek:false, isShowClear:true, readOnly:true, dateFmt:'yyyy-MM-dd'})"/>
                <s:hidden name="queryPeriodReferDate" id="queryPeriodReferDate" />
                <s:hidden name="queryPeriodReferOffset" id="queryPeriodReferOffset" value="" />
            </td>
            <s:if test="#request.menuType=='query'">
                </tr>
                <tr>
                    <td colspan="6" class="SearchBar_toolbar">
            </s:if>
            <s:else>
                    <td class="SearchBar_toolbar">
            </s:else>
                <input type="button" class="btnButton4font"  onclick="if(checkBeforeRefreshListForm()){refreshListForm('queryForm');}" value='<s:text name="comm.searchnow"/>' />
                <!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
    <!-- SEARCH PART END -->
    
    <!-- MIDDLE BUTTONS START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
            <td align="left">
                <div class="Public_tag">
                    <ul>
                        <li class="tag_aon">
                            <span class="tag_center"><s:text name="calendar.day" /></span>
                            <span class="tag_right"></span>
                        </li>
                        <li>
                            <span class="tag_center" onclick="changeDisplayType('workweek');"><s:text name="calendar.workweek" /></span>
                            <span class="tag_right"></span>
                        </li>
                        <li>
                            <span class="tag_center" onclick="changeDisplayType('week');"><s:text name="calendar.week" /></span>
                            <span class="tag_right"></span>
                        </li>
                        <li>
                            <span class="tag_center" onclick="changeDisplayType('month');"><s:text name="calendar.month" /></span>
                            <span class="tag_right"></span>
                        </li>
                        <li>
                            <span class="tag_center" onclick="changeDisplayType('list');"><s:text name="calendar.list" /></span>
                            <span class="tag_right"></span>
                        </li>
                    </ul>
                    <span class="changePeriod">
                        <img src="<%=rootPath%>/<%=whir_skin%>/images/prev.gif" onclick="changeQueryByDateOffset('-1');" title='<s:text name="calendar.previous"/>' />
                        <img src="<%=rootPath%>/<%=whir_skin%>/images/next.gif" onclick="changeQueryByDateOffset('1');" title='<s:text name="calendar.next"/>' />
                        <input type="button" class="btnButton4font" onclick="changeQueryDate_toCur();" value='<s:text name="calendar.curDay" />' />
                        <span id="periodsShow"></span>
                    </span>
                </div>
            </td>
            <td align="right" class="bottomline" style="width:19%;">
            <s:if test="#request.menuType=='mine'">
                <input type="button" class="btnButton4font" onclick="importEventList();" value='<s:text name="calendar.Importschedule"/>' />
                <input type="button" class="btnButton4font" onclick="addWorkLog();" value='<s:text name="comm.add"/>' />
            </s:if>
            </td>
        </tr>
    </table>
    <!-- MIDDLE BUTTONS END -->

    <!-- LIST PART START -->    
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable" id="table_fullday">
        <thead id="headerContainer">
            <tr class="listTableHead">
                <td width="5%"><s:text name="calendar.dtime" /></td> 
                <td>
                    <div name="date" id="date_1_1" dayNum="1"></div>
                </td>
            </tr>
        </thead>
        <tbody >
            <tr id="tr_fullDay" height="60px" class="listTableLine2" style="display:none;" >
                <td width="5%"><s:text name="myworklog.daylog" /></td>
                <td id="td_fullDay_1" name="td_fullDay" dayNum="1" style="vertical-align:top;" ></td>
            </tr>
        </tbody>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr >
            <td valign="top" >
                <div id="dayLogDiv" class="dayLogDiv">
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" style="width:100%;border: 1px solid rgb(204, 204, 204);">
                        <tr>
                            <td width="5%" align="center" bgcolor="#E8EEF7">
                                <%
                                    java.text.DecimalFormat df = new java.text.DecimalFormat("00");
                                    df = new java.text.DecimalFormat("00");
                                    for(int i=0;i<24;i++){
                                        for(int j=0;j<2;j++){
                                %>
                                            <div class="<%=j==0?"time0":"time1"%>" onDblClick="" title="" onselectstart="return false;">
                                                <%=df.format(i)%>:<%=j==0?"00":"30"%>
                                            </div>
                                <%
                                        }
                                    }
                                %>
                            </td>
                            <td valign="top" dayNum="1" >
                                <div id="logBoxContainer_1" style="z-index: 599">
                                </div>
                                <div style="cursor: hand; height: 1488px; width: 100%; z-index: 500">
                                    <% 
                                        for(int i=0;i<24;i++){
                                            for(int j=0;j<2;j++){
                                    %>
                                            <s:if test="#request.menuType=='mine'">
                                                <div name="occupy" id="occupy_1_<%=i*2+j%>" occupyId="" class="<%=j==0?"time0":"time1"%>" onDblClick="addWorkLogByDateTime('0','1', '<%=i%>', '<%=j%>');" title="<s:text name='calendar.doubleclick'/>" onselectstart="return false;" onselectstart="return false;">
                                                    &nbsp;
                                                </div>
                                            </s:if>
                                            <s:else>
                                                <div name="occupy" id="occupy_1_<%=i*2+j%>" occupyId="" class="<%=j==0?"time0":"time1"%>" onDblClick="" title="" onselectstart="return false;" onselectstart="return false;">
                                                    &nbsp;
                                                </div>
                                            </s:else>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <!-- LIST PART END -->

    <!-- PAGER PART START -->
    <!-- PAGER PART END -->
    </s:form>
</body>

<script type="text/javascript">
$(document).ready(function(){
    //初始化列表页form表单,"queryForm"是表单id，可修改。
    //initListFormToAjax({formId:"queryForm"});  
    if(initDisplaySearchForm()){
		/* Added by Qian Min at 2013-08-29 for bug 7742 [BEGIN] */
		$("#dayLogDiv").animate({ scrollTop: 496 }, 120);
		/* Added by Qian Min at 2013-08-29 for bug 7742 [END] */
		
        initDisplayFormToAjax({"formId":'queryForm', "displayType":'day'});
    }
});
</script>

</html>

