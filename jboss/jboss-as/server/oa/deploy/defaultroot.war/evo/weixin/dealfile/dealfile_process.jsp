<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../common/taglibs.jsp" %>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
request.setAttribute("now",new java.util.Date());
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>文件办理</title>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>
</head>
<body>
<c:if test="${not empty docXml3}">
	<x:parse xml="${docXml3}" var="doc"/>
	<c:set var="EmpLivingPhoto"><x:out select="$doc//EmpLivingPhoto/text()" /></c:set>
</c:if>
<c:if test="${not empty EmpLivingPhoto}"><c:set var="EmpLivingPhoto">/defaultroot/upload/peopleinfo/${EmpLivingPhoto}</c:set></c:if>
<%if(empLivingPhoto !=null && !"".equals(empLivingPhoto) ){%>
<c:set var="EmpLivingPhoto"><%=empLivingPhoto%></c:set>
<%}%>
<c:if test="${not empty docXml}">
<x:parse xml="${docXml}" var="doc"/>
<c:set var="hasbackbutton"><x:out select="$doc//workInfo/havebackbutton/text()"/></c:set>
<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
<section class="wh-section wh-section-bottomfixed" id="mainContent">
    <article class="wh-edit wh-edit-document">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul>
                    <li>
                    	<strong class="document-icon">
                    		<img src="${EmpLivingPhoto eq '' || EmpLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : EmpLivingPhoto}">
                    	</strong>
                    	<p>
	                    	<a href="javascript:void(0);"><!-- <em class="not-over">未完成</em> -->${worktitle} 当前环节为：${workcurstep}</a>
	                    	<span>（${fn:substring(worksubmittime,0,16)}）</span>
                    	</p>
                    </li>
                </ul>
            </div>
            <form id="sendForm" class="dialog" action="/defaultroot/workflow/sendnew.controller" method="post">
            	<c:if test="${not empty docXml2}">
            		<x:parse xml="${docXml2}" var="doc2"/>
            		<table class="wh-table-edit" id="table_form">
            			<x:forEach select="$doc2//fieldList/field" var="fd" >
						<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
						<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
						<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
						<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
							<tr>
			                    <th>
				                    <x:out select="$fd/name/text()"/>
				                    <c:if test="${mustfilled == '1' && readwrite == '1'}">
				                    	<i class="fa fa-asterisk"></i>
				                    </c:if>：
			                    </th>
							<td style="text-align:right">
							<c:choose>
								<%--单行文本 101--%>
								<c:when test="${showtype =='101' && readwrite =='1'}">
									<c:if test="${fieldtype == '1000000' }">
										<input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="9" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
									<c:if test="${fieldtype == '1000001' }">
										<input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="18" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
									<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
										<input placeholder="请输入" class="edit-ipt-r" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
								</c:when>
								<%--密码输入 102--%>
								<c:when test="${showtype =='102' && readwrite =='1'}">
									<input placeholder="请输入" class="edit-ipt-r" type="password" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
								</c:when>
								<%--单选 103--%>
								<c:when test="${showtype =='103' && readwrite =='1'}">
									<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
									<div class="examine">
										<a class="edit-select edit-ipt-r">
											<div class="edit-sel-show">
												<span>请选择</span>
											</div>    
											<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
												<option value="">请选择</option>
												<x:forEach select="$fd//dataList/val" var="selectvalue" >
													<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
													<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
												</x:forEach>
											</select>
										</a>
									</div>
								</c:when>
								<%--多选 104--%>
								<c:when test="${showtype =='104' && readwrite =='1'}">
									<c:set var="selectedvalue">,<x:out select="$fd/hiddenval/text()"/></c:set>
									<x:forEach select="$fd//dataList/val" var="selectvalue" >
										<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
										<input type="checkbox" align="left" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> style="width:10%;"><x:out select="$selectvalue/showval/text()"/>
									</x:forEach>
								</c:when>
								<%--下拉框 105--%>
								<c:when test="${showtype =='105' && readwrite =='1'}">
									<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
									<div class="examine">
										<a class="edit-select edit-ipt-r">
											<div class="edit-sel-show">
												<span>请选择</span>
											</div>    
											<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
												<option value="">请选择</option>
												<x:forEach select="$fd//dataList/val" var="selectvalue" >
													<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
													<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
												</x:forEach>
											</select>
										</a>
									</div>
								</c:when>
								<%--日期 107--%>
								<c:when test="${showtype =='107' && readwrite =='1'}">
									<div class="edit-ipt-a-arrow">
										<input placeholder="选择日期" data-dateType="date" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										<label class="edit-ipt-label" for="scroller"></label>
									</div>
								</c:when>
								<%--时间 108--%>
								<c:when test="${showtype =='108' && readwrite =='1'}">
									<div class="edit-ipt-a-arrow">
										<input placeholder="选择时间 " data-dateType="time" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										<label class="edit-ipt-label" for="scroller"></label>
									</div>
								</c:when>
								<%--日期 时间 109--%>
								<c:when test="${showtype =='109' && readwrite =='1'}">
									<div class="edit-ipt-a-arrow">
										<input placeholder="选择日期 时间" data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										<label class="edit-ipt-label" for="scroller"></label>
									</div>								
								</c:when>
								<%--多行文本 110--%>
								<c:when test="${showtype =='110' && readwrite =='1'}">
									<textarea name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
									<span class="edit-txta-num"><script>document.write(300-"<x:out select="$fd/value/text()"/>".length);</script></span>
								</c:when>
								<%--自动编号 111--%>
								<c:when test="${showtype =='111' && readwrite =='1'}">
									<x:out select="$fd/value/text()"/>
								</c:when>
								<%--html编辑 113--%>
								<c:when test="${showtype =='113' && readwrite =='1'}">
									<textarea name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
									<span class="edit-txta-num"><script>document.write(300-"<x:out select="$fd/value/text()"/>".length);</script></span>
								</c:when>
								<%--附件上传 115--%>
								<c:when test="${showtype =='115'}">
									<c:if test="${readwrite =='1'}">
										<ul class="edit-upload">
				                            <li class="edit-upload-in" onclick="addImg('<x:out select="$fd/sysname/text()"/>');"><span><i class="fa fa-plus"></i></span></li>
				                        </ul>
									</c:if>
									<c:set var="values"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty values}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="customform";
										String aValues =(String)pageContext.getAttribute("values");
										String[] aval  = aValues.split(";");
										String[] aval0=new String[0];
										String[] aval1=new String[0];
										if(aval[0] != null && aval[0].endsWith(",")) {
											saveFileNames =aval[0].substring(0, aval[0].length() -1);
											saveFileNames =saveFileNames.replaceAll(",","|");
										}
										if(aval[1] != null && aval[1].endsWith(",")) {
											realFileNames =aval[1].substring(0, aval[1].length() -1);
											realFileNames =realFileNames.replaceAll(",","|");
										}
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
										<input name="fileNames<x:out select="$fd/sysname/text()"/>" value="${values}" type="hidden"/>
									</c:if>
								</c:when>
								<%--Word编辑 116--%>
								<c:when test="${showtype =='116'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".doc";
										saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${empty filename && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:if>
								</c:when>
								<%--Excel编辑 117--%>
								<c:when test="${showtype =='117'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".xls";
										saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${empty filename && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:if>
								</c:when>
								<%--WPS编辑 118--%>
								<c:when test="${showtype =='118'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".wps";
										saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
									<c:if test="${empty filename && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:if>
								</c:when>
								<%--登录人信息 --%>
								<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
									<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
								</c:when>
								<%--单选人 全部 210--%>
								<c:when test="${showtype =='210' && readwrite =='1'}">
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user")' placeholder="请选择"/>
								</c:when>

								<%--多选人 全部 211--%>
								<c:when test="${showtype =='211' && readwrite =='1'}">
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user");' placeholder="请选择"/>
								</c:when>

								<%--单选组织 212--%>
								<c:when test="${showtype =='212' && readwrite =='1'}">
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/> 
								</c:when>

								<%--多选组织 214--%>
								<c:when test="${showtype =='214' && readwrite =='1'}">
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
		           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
								</c:when>
								<%--金额 301--%>
								<c:when test="${showtype =='301' && readwrite =='1'}">
									<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
										<input class="edit-ipt-r" id='<x:out select="$fd/sysname/text()"/>' type="number" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
									<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
										<input class="edit-ipt-r" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:if>
								</c:when>
								<%--金额大写 302--%>
								<c:when test="${showtype =='302' && readwrite =='1'}">
									<input class="edit-ipt-r" type="text" readonly maxlength="18" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
								</c:when>
								<%--批示意见 401--%>
								<c:when test="${showtype =='401' }">
									<c:if test="${readwrite =='1' }">
										<textarea class="edit-txta edit-txta-l" placeholder="请输入" name="comment_input" id="comment_input" maxlength="50"></textarea>
										<div class="examine" style="text-align:right;">
											<a class="edit-select edit-ipt-r">
												<div class="edit-sel-show">
													<span>常用审批语</span>
												</div>    
												<select class="btn-bottom-pop" onchange="selectComment(this);">
													<option value="">常用审批语</option> 
													<option value="同意">同意</option>
													<option value="已阅">已阅</option>
												</select>
											</a>
										</div>
									</c:if>
									<c:if test="${readwrite =='0' }">
										<x:forEach select="$fd//dataList/comment" var="ct" >
											<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
										</x:forEach>
									</c:if>
								</c:when>
								<%--单选人 本组织 704--%>
								<c:when test="${showtype =='704' && readwrite =='1'}">
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
									<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
								</c:when>
								
								<%--多选人 本组织 705--%>
								<c:when test="${showtype =='705' && readwrite =='1'}">
									<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
									<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
								</c:when>
								<%--流程发起人 708--%>
								<c:when test="${showtype =='708' && readwrite =='1'}">
									<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
								</c:when>
								<%--日期时间计算 808--%>
								<c:when test="${showtype =='808' && readwrite =='1'}">
									该字段暂不支持手机办理，请于电脑端操作。
								</c:when>
								<c:otherwise>
									<x:out select="$fd/value/text()"/>
								</c:otherwise>
							</c:choose>
							</td>
			                </tr>
						</x:forEach>
						<!--子表信息begin-->
						<c:set var="subTable" ></c:set>
						<x:forEach select="$doc2//subTableList/subTable/subFieldList" var="ct" varStatus="xh">
							<c:set var="subTable" >${xh.index+1}</c:set>
						</x:forEach>
						<c:if test="${ not empty subTable}">
						<tr>
							<th>子表填写<i class="fa fa-asterisk"></i>：</th>
							<td><input type="text" readonly="readonly" class="edit-ipt-r" value="${subTable}条子表数据" onclick="addSubTable(${param.workId});"/></td>
						</tr>
						</c:if>
						<!--子表信息end-->
						<!--批示意见begin-->
						<c:set var="commentField" ><x:out select="$doc//workInfo/commentField/text()"/></c:set>
						<c:set var="actiCommFieldType" ><x:out select="$doc//workInfo/actiCommFieldType/text()"/></c:set>
						<c:if test="${actiCommFieldType != '-1' && (commentField == '-1' || commentField == 'nullCommentField' || commentField == 'autoCommentField' || commentField == 'null') }">
						<tr>
							<th>审批意见：</th>
							<td>
	                            <textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="comment_input" id="comment_input" maxlength="50"></textarea>
								<%--<a href="#" class="edit-slt-r">常用语审批</a>--%>
								<div class="examine" style="text-align:right;">
									<a class="edit-select edit-ipt-r">
										<div class="edit-sel-show">
											<span>常用审批语</span>
										</div>    
										<select class="btn-bottom-pop" onchange="selectComment(this);">
											<option value="">常用审批语</option> 
											<option value="同意">同意</option>
											<option value="已阅">已阅</option>
										</select>
									</a>
								</div>
		                    </td>
						</tr>
						</c:if>
						<x:forEach select="$doc2//commentList/comment" var="ct" >
							<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
							<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
							<tr>
								<th><x:out select="$ct//step/text()"/>：</th>
								<td><x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)</td>
							</tr>
						</x:forEach>
						<!--批示意见end-->
						<!--退回意见begin-->
						<c:set var="backcomment" ><x:out select="$doc2//backComment/text()"/></c:set>
						<c:if test="${not empty backcomment}">
							<tr>
								<th>退回意见：</th>
								<td>${backcomment}</td>
							</tr>
						</c:if>
						<!--退回意见end-->
            		</table>
					<input type="hidden" name="pass_title"  value="" />
					<input type="hidden" name="pass_time"   value="" />
					<input type="hidden" name="pass_person" value="" />
					<input type="hidden" name="__sys_operateType" value="2" />
					<input type="hidden" name="__sys_infoId"      value='<x:out select="$doc2//paramList/workrecord_id/text()"/>' />
					<input type="hidden" name="__sys_pageId"      value='<x:out select="$doc2//paramList/worktable_id/text()"/>' />
					<input type="hidden" name="__sys_formType"    value='<x:out select="$doc2//paramList/formType/text()"/>' />	
					<input type="hidden" name="__main_tableName"  value='<x:out select="$doc2//fieldList/tableName/text()"/>' />	
					<input type="hidden" name="tableId"           value='<x:out select="$doc//workInfo/worktable_id/text()"/>' />
					<input type="hidden" name="recordId"          value='<x:out select="$doc//workInfo/workrecord_id/text()"/>' />
					<input type="hidden" name="activityId"        value='<x:out select="$doc//workInfo/initactivity/text()"/>' />      
					<input type="hidden" name="workId"            value='<x:out select="$doc//workInfo/wf_work_id/text()"/>' />
					<input type="hidden" name="stepCount"         value='<x:out select="$doc//workInfo/workstepcount/text()"/>' />
					<input type="hidden" name="actiCommFieldType" value='<x:out select="$doc//workInfo/actiCommFieldType/text()"/>' />
					<%--新添加参数 2012/4/5 --%>
					<input type="hidden" name="isForkTask"    value='<x:out select="$doc//workInfo/isForkTask/text()"/>' />
					<input type="hidden" name="forkStepCount" value='<x:out select="$doc//workInfo/forkStepCount/text()"/>' />
					<input type="hidden" name="forkId"        value='<x:out select="$doc//workInfo/forkId/text()"/>' />
					<c:if test="${not empty docXml2}">
						<input type="hidden" name="activityclass" value='<x:out select="$doc2//paramList/activityclass/text()"/>' /> 
					</c:if>
					<input type="hidden" name="curCommField"  value='<x:out select="$doc//workInfo/commentField/text()"/>' />
					<input type="hidden" name="trantype"      value='<x:out select="$doc//workInfo/trantype/text()"/>' />
					<x:if select="$doc//workInfo/commentmustnonull" var="commentmustnonull">
						<input type="hidden" name="commentmustnonull" value='<x:out select="$doc//workInfo/commentmustnonull/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/backnocomment" var="backnocomment">
						<input type="hidden" name="backnocomment"     value='<x:out select="$doc//workInfo/backnocomment/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/backMailRange" var="backMailRange">
						<input type="hidden" name="backMailRange"     value='<x:out select="$doc//workInfo/backMailRange/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/smsRight" var="smsRight">
						<input type="hidden" name="smsRight"          value='<x:out select="$doc//workInfo/smsRight/text()"/>' />
					</x:if>
					<input type="hidden" name="commentType"  value="0" />
					<input type="file" style="display:none;" value="" name="comment_input_shouxie" id="comment_input_shouxie"/>
					<input type="file" style="display:none;" value="" name="comment_input_yuyin" id="comment_input_yuyin"/>
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="0">
            	</c:if>
            </form>
			<!----------退回开始---------->
			<form id="backForm" class="dialog" action="/defaultroot/workflow/back.controller" method="post">
				<input type="hidden" name="workId" value="<%=workId%>">
				<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
				<input type="hidden" name="worktitle" value="${worktitle}">
				<input type="hidden" name="workcurstep" value="${workcurstep}">
				<input type="hidden" name="worksubmittime" value="${worksubmittime}">
				<input type="hidden" name="workStatus" value="0">
				<input type="hidden" name="tableId" value='<x:out select="$doc//workInfo/worktable_id/text()"/>'>
				<input type="hidden" name="recordId" value='<x:out select="$doc//workInfo/workrecord_id/text()"/>'>
				<input type="hidden" name="stepCount" value='<x:out select="$doc//workInfo/workstepcount/text()"/>'>
				<input type="hidden" name="forkId" value='<x:out select="$doc//workInfo/forkId/text()"/>'>
				<input type="hidden" name="forkStepCount" value='<x:out select="$doc//workInfo/forkStepCount/text()"/>'>
				<input type="hidden" name="isForkTask" value='<x:out select="$doc//workInfo/isForkTask/text()"/>'>
				<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
			</form>
			<!----------退回结束---------->
			<!----------转办开始---------->
			<form id="tranInfoForm" class="dialog" action="/defaultroot/dealfile/tranInfo.controller?workId=${wfworkId}" method="post">
				<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
				<input type="hidden" name="worktitle" value="${worktitle}">
				<input type="hidden" name="workcurstep" value="${workcurstep}">
				<input type="hidden" name="worksubmittime" value="${worksubmittime}">
				<input type="hidden" name="workStatus" value="0">
			</form>
			<!----------转办结束---------->
			<!----------加签开始---------->
			<form id="addSignForm" class="dialog" action="/defaultroot/dealfile/addSign.controller?workId=${wfworkId}" method="post">
				<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
				<input type="hidden" name="worktitle" value="${worktitle}">
				<input type="hidden" name="workcurstep" value="${workcurstep}">
				<input type="hidden" name="worksubmittime" value="${worksubmittime}">
				<input type="hidden" name="workStatus" value="0">
			</form>
			<!----------加签结束---------->
        </div>
    </article>
</section>
<footer class="wh-footer wh-footer-forum" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <div class="fbtn-more-nav">
                    <div class="fbtn-more-nav-inner">
                    	<c:if test="${fn:indexOf(modibutton,'Tran') >0}">
                        	<a href="javascript:$('#tranInfoForm').submit();" class="fbtn-matter col-xs-12"><i class="fa fa-share"></i>转办</a>
                        </c:if>
                        <c:if test="${fn:indexOf(modibutton,'AddSign') >0}">
                        	<a href="javascript:$('#addSignForm').submit();" class="fbtn-matter col-xs-12"><i class="fa fa-plus"></i>加签</a>
                        </c:if>
                    </div>
                    <div class="fbtn-more-nav-arrow"></div>
                </div>
                <c:choose>
	                <c:when test="${ hasbackbutton == 'true' }">
		               	<a href="javascript:$('#backForm').submit();" class="fbtn-cancel col-xs-5"><i class="fa fa-arrow-left"></i>退回</a>
		                <a href="javascript:if(formCheck()){$('#sendForm').submit();}" class="fbtn-matter col-xs-5"><i class="fa fa-check-square"></i>发送</a>
	                </c:when>
	                <c:otherwise>
		                <a href="javascript:$('#sendForm').submit();" class="fbtn-matter col-xs-10"><i class="fa fa-check-square"></i>发送</a>
	                </c:otherwise>
                </c:choose>
                <span id="fbtnMore" class="fbtn-matter col-xs-2"><i class="fa fa-bars"></i></span>
            </div>
        </div>
    </div>
</footer>
<section id="selectContent" style="display:none">
</section>
<section id="subtableContent" style="display:none">
</section>
</c:if>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/modules/comm/microblog/script/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.core.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.datetime.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.select.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<%--<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.ios7.js"></script>--%>
<script type="text/javascript">
    var dialog = null;
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    function pageLoaded(){
        if (document.readyState == "complete") {
            setTimeout(function(){
                dialog.close();
            },500);
        }
    }

	$(function(){
		var sw = $(window).width();
		var sh = $(window).height();
		$('body').append("<div id='subBg' style='position:fixed; left:0; top:0; background:rgba(0,0,0,0.8);z-index:9999; cursor:default;width:100%;height:100%;display:none;'><p style='text-align:center; color:#fff;font-size:16px;font-family:microsoft yahei; display:block;line-height:2em;padding-top:70px;background:url(/defaultroot/evo/weixin/images/subDot.png) no-repeat right center;'>非常抱歉，由于微信不支持直接打开该类型文件，请点击此处，并选择在浏览器中打开</p></div>");
		$('#subBg').width(sw);
		$('#subBg').height(sh); 
		
		$("textarea").each(function(){
			$(this).change(function(){ 
				$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );
			});
		});


		$('.active').mousedown(function(){
			$(this).css('background','#f5f5f5');
		})
		$('.active').mouseup(function(){
			$(this).css('background','');
		})

	})

    $(function(){
    	//设置单选、下拉框等初始化时的内容
    	setDefaultSpanHtml();
        //单选
        var radioList = $(".edit-radio li");
        radioList.click(function(){
            radioList.eq($(this).index()).addClass('radio-active').siblings().removeClass('radio-active')
        })
        //更多菜单展开
        var fbtnMore = $("#fbtnMore");
        var fbtnMoreCon = $(".fbtn-more-nav");
        if(fbtnMoreCon.is(':visible')){
            fbtnMoreCon.hide();
            $(".wh-section").click(function(){
                fbtnMoreCon.hide();
            })
        }
        fbtnMoreCon.hide();
        fbtnMore.click(function(){
            fbtnMoreCon.toggle();
        });
        //选择日期时间
        selectDateTime();
    });
    
    //表单必填项验证
    function formCheck(){
		return confirmForm();
    	var tipsName = '';
    	var checkOk = true;
    	$('#table_form tr th i').each(function(){
    		var value = $(this).parent().next('td').children().val();
    		if(value == '' && value != undefined){
	    		tipsName = $(this).parent().text().replace('：','');
    			alert(tipsName.trim()+'不能为空！');
    			checkOk = false;
    			return false;
    		}
    	});
    	return checkOk;
    }
    
    //选择批示意见
    function selectComment(obj){
    	var $selectObj = $(obj);
    	var selectVal = $selectObj.val();
    	var $textarea = $selectObj.parent().parent().siblings();
    	setSpanHtml(obj,selectVal);
    	$textarea.val($textarea.val() + selectVal);
    }
    
    //设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	}    
    
    //设置页面初始时的选项内容显示
    function setDefaultSpanHtml(){
    	var selectText = '';
    	var $currSelect;
    	$('select').each(function(){
    		$currSelect = $(this);
    		selectText = $currSelect.find("option:selected").text();
    		$currSelect.parent().find('div>span').html(selectText);
    	});
    }
    
    //日期空间初始化参数
    var opt = {
		'date': {
			preset: 'date', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            showNow: false,
            endYear:2099
		},
		'datetime': {
	  	 	preset: 'datetime', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            timeFormat: 'HH:ii',
            timeWheels:'HHii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            hourText:'时',
            minuteText:'分',
            showNow: false,
            endYear:2099
		},
		'time': {
	  	 	preset: 'time', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            timeFormat: 'HH:ii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            hourText:'时',
            minuteText:'分',
            amText:'上午',
            pmText:'下午',
            showNow: false,
            endYear:2099
		}
	}
    
    //选择日期时间
    function selectDateTime(){
    	var dateType = '';
    	var firstParam;
    	$('input').each(function(){
    		dateType = $(this).data('datetype');
    		if(dateType){
				$(this).mobiscroll(opt[dateType]);
    		}
    	});
    }
    
    //打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){ 
		pageLoading();
		var selectIdVal = $('input[name="'+selectId+'"]').val();
		if( selectIdVal.indexOf(";") > 0 ){
			var selectIdArray = selectIdVal.split(';');
			selectIdVal = selectIdArray[1];
		}
		if(selectIdVal.indexOf('$') != -1){
			var selectIdArray = selectIdVal.split('$');
			if(selectIdArray){
				selectIdVal = '';
				for(var i=0,length=selectIdArray.length;i<length;i++){
					if(selectIdArray[i]){
						selectIdVal += selectIdArray[i] + ',';
					}
				}
			}
		}
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/person/searchOrg.controller?flag=org';
		}else if(listType=='user'){
			postUrl = '/defaultroot/person/newsearch.controller?flag=user';
		}
		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[name="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
				if(dialog){
					dialog.close();
				}
			}
		});
	}
    	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#selectContent").css("display","block");
		}else if(flag==1){
			$("#selectContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#selectContent").empty();
		}else if(flag==2){//显示子表 
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#subtableContent").css("display","block");
		}else if(flag==3){
			$("#subtableContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#subtableContent").empty();
		}
	}
    
    //图片数标记
    var index = 0;
   
    //添加图片
    function addImg(name){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="_mainfile_'+name+'"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   
	//删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		var loadingDialog = openTipsDialog('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_name_"+(index-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				alert("文件上传失败！");
			}
		});
	}
    
    
    
    function selectCallBack(obj1,obj2){
		obj2.val( obj1.val() + ";" + obj2.val());
	}

    //打开子表 
    function addSubTable(workId){
		pageLoading();
		var postUrl = '/defaultroot/dealfile/subprocess.controller?workId='+workId;
		$.ajax({
			url : postUrl,
			type : "post",
			data : {},
			success : function(data){
				$("#subtableContent").append(data);
				hiddenContent(2);
				if(dialog){
					dialog.close();
				}
			}
		});
		//window.open('/defaultroot/dealfile/subprocess.controller?workId='+workId);
	}
</script>