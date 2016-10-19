<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
	<title>文件办理</title>
	<link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
</head>
<body>
<c:if test="${not empty docXml}"><!--1-->
	<x:parse xml="${docXml}" var="doc"/>
	<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
	<c:set var="wfsmsRight"><x:out select="$doc//smsRight/text()"/></c:set>
	<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
	<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
	<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
	<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
	<c:set var="empLivingPhoto"><%=empLivingPhoto%></c:set>
	<section class="wh-section wh-section-bottomfixed">
	    <article class="wh-edit wh-edit-document">
	        <div class="wh-container">
	            <div class="wh-article-lists">
	           		<ul>
	                    <li>
	                    	<strong class="document-icon">
	                    		<img src="${param.empLivingPhoto eq '' || param.empLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : param.empLivingPhoto}">
	                    	</strong>
	                    	<p>
		                    	<a><c:if test="${fn:indexOf(workcurstep,'办理完毕') == -1}"><em class="not-over">未完成</em></c:if>${worktitle} 当前环节为：${workcurstep}</a>
		                    	<span>（${fn:substring(worksubmittime,0,16)}）</span>
	                    	</p>
	                    </li>
	                </ul>
	            </div>
	            <c:if test="${not empty docXml2}"><!--2-->
					<x:parse xml="${docXml2}" var="doc2"/>
					<table class="wh-table-edit">
						<!--主表信息begin-->
						<x:forEach select="$doc2//fieldList/field" var="fd" >
							<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
							<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
							<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
							<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
							<tr>
								<th><x:out select="$fd/name/text()"/><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>：</th>
								<td>
									<c:choose>
										<%--附件上传 115--%>
										<c:when test="${showtype =='115'}">
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
										</c:when>
		
										<%--批示意见 401--%>
										<c:when test="${showtype =='401' }">
											<x:forEach select="$fd//dataList/comment" var="ct" >
												<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
											</x:forEach>
										</c:when>
		
										<c:otherwise>
											<x:out select="$fd/value/text()"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:forEach>
						<!--主表信息end-->
						<!--子表信息begin-->
						<c:set var="subTable" ></c:set>
						<x:forEach select="$doc2//subTableList/subTable/subFieldList" var="ct" varStatus="xh">
							<c:set var="subTable" >${xh.index+1}</c:set>
						</x:forEach>
						<c:if test="${not empty subTable}">
						<tr>
							<th>子表填写：</th>
							<td>
								<input type="text" class="edit-ipt-r" value="${subTable}条子表数据" onclick="addSubTable(${param.workId});"/>
							</td>
						</tr>
						</c:if>
						<!--子表信息end-->
	
						<!--批示意见begin-->
						<x:forEach select="$doc2//commentList/comment" var="ct" >
							<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
							<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
							<tr>
								<th><x:out select="$ct//step/text()"/>：</th>
								<td>
									<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
								</td>
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
				</c:if>
            </div>
		</article>
	</section>
</c:if><!--1-->
</body>
</html>
	<%--
	<nav class="Step1">
		<c:if test="${empLivingPhoto ==''}"><img src="/defaultroot/evo/weixin/images/p2.jpg" /></c:if><c:if test="${empLivingPhoto !=''}"><img src="/defaultroot/upload/peopleinfo/${empLivingPhoto}"/></c:if>
		<a>${worktitle}当前环节为${workcurstep}<span>（${worksubmittime}）</span></a>
	</nav>
	
	<c:if test="${not empty docXml2}"><!--2-->
		<x:parse xml="${docXml2}" var="doc2"/>
		<section class="Contain">
			<div class="DyForm">
				<dl>
					<!--主表信息begin-->
					<x:forEach select="$doc2//fieldList/field" var="fd" >
						<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
						<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
						<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
						<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>

						<dt>
							<c:if test="${mustfilled == 1}"><span class="erro"></span></c:if><em class="tt"><x:out select="$fd/name/text()"/>：</em>
							<c:choose>
								附件上传 115
								<c:when test="${showtype =='115'}">
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
									</c:if>
								</c:when>

								Word编辑 116
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
								</c:when>

								Excel编辑 117
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
								</c:when>

								WPS编辑 118
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
								</c:when>

								批示意见 401
								<c:when test="${showtype =='401' }">
									<x:forEach select="$fd//dataList/comment" var="ct" >
										<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
									</x:forEach>
								</c:when>

								<c:otherwise>
									<x:out select="$fd/value/text()"/>
								</c:otherwise>
							</c:choose>
						</dt>
					</x:forEach>
					<!--主表信息end-->

					<!--子表信息begin-->
					<c:set var="subTable" ></c:set>
					<x:forEach select="$doc2//subTableList/subTable/subFieldList" var="ct" varStatus="xh">
						<c:set var="subTable" >${xh.index+1}</c:set>
					</x:forEach>
					<c:if test="${ not empty subTable}">
					<dt>
						<span class="erro"></span><em class="tt">子表填写：</em><input type="text" class="txt txt1" value="${subTable}条子表数据" onclick="addSubTable(${param.workId});"/>
					</dt>
					</c:if>
					<!--子表信息end-->

					<!--批示意见begin-->
					<x:forEach select="$doc2//commentList/comment" var="ct" >
						<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
						<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
						<dt>
							<em class="tt"><x:out select="$ct//step/text()"/>：</em><x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
						</dt>
					</x:forEach>
					<!--批示意见end-->

					<!--退回意见begin-->
					<c:set var="backcomment" ><x:out select="$doc2//backComment/text()"/></c:set>
					<c:if test="${not empty backcomment}">
						<dt>
							<em class="tt">退回意见：</em>${backcomment}
						</dt>
					</c:if>
					<!--退回意见end-->
					<dt><br/><br/><br/></dt>
				</dl>
			</div>
		</section>
	</c:if><!--2-->
	--%>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
	function addSubTable(workId){
		window.open('/defaultroot/dealfile/subprocess.controller?workId='+workId);
	}
</script>