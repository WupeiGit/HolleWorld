<!--#include virtual="/inc/action/flightMileageAction.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ʊ��Դ���ι���</title>
<link href="/style/common.css" type="text/css" rel="stylesheet" />
<link href="/style/admin.css" type="text/css" rel="stylesheet" />
<link href="/style/calendar.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/style/js/calendar.js"></script>
<script type="text/javascript" src="/style/js/calendar-setup.js"></script>
<script type="text/javascript" src="/style/js/calendar-zh.js"></script>
<script type="text/javascript" src="/style/js/prototype.js"></script>
<script type="text/javascript" src="/style/js/common.js"></script>
<script type="text/javascript" src="/style/js/ajax.js"></script>
<script type="text/javascript" src="/style/js/alt.js"></script>
<script type="text/javascript" src="/style/js/flightMileage.js"></script>
</head>

<%
Dim fId					:	fId					=	GetSafeStr(Request.QueryString("flightId"))
Dim sltDepartCode		:	sltDepartCode		=	GetSafeStr(Request.Form("departureCode"))
Dim sltDepartTerminal	:	sltDepartTerminal	=	GetSafeStr(Request.Form("departureTerminal"))
Dim sltArriveCode		:	sltArriveCode		=	GetSafeStr(Request.Form("arriveCode"))
%>
<body>
<form name="frmAdd" id="frmAdd" method="post" >
	<table border="0" cellpadding="0" cellspacing="1" class="tabStyle6" style="width:100%">
		<tr>
			<th colspan="10">��Ʊ��Դ���ι���-��Ӻ���</th>
		</tr>
		<tr>
			<td style="text-align:center;"><!--#include file="flightCommonInfo.asp" -->
				
				<table width="99%" border="0" cellpadding="3" cellspacing="1" class="tabStyle16">
					<tr>
						<th width="8%">��ӻ�Ʊ������Ϣ</th>
						<th><input name="btnAdd" type="button" class="btn_bg_style01_50" onClick="FltMlg.AddFltMlgTab(5);" value="������"/>
							<input name="btnSub" type="button" class="btn_bg_style01_50" onClick="FltMlg.CutFltMlgTab(5);" value="������" disabled="disabled" />
							<input type="hidden" name="copyNum" id="copyNum" value="0" />
						</th>
					</tr>
					<tr>
						<td colspan="2" style="padding:5px">
							<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabMsg" style="display:block;">
								<tr>
									<td height="80" style="text-align:center;"><img src="/images/pics/ico_question.gif" border="0" hspace="3" align="absmiddle" />
										<span class="font_gray">��ʾ���롾���ӡ���ǰ��Ʊ������Ϣ��</span>
									</td>
								</tr>
							</table>
							<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabOne" style="display:none;">
								<tbody id="tTabSignUpInfo">
									<tr id="divfirst" style="display:none;">
										<td>
											<table width="100%" border="0" cellpadding="2" cellspacing="1" class="tabStyle16" id="tabTwo">
												<tr>
													<td width="8%">&nbsp; * �ڼ��죺</td>
													<td width="12%"><input type="text" name="dayNum" id="dayNum" size="5" class="textStyleDefault"/>��
														<span class="font_gray">��</span></td>
													<td width="8%">&nbsp; * ����ţ�</td>
													<td width="20%"><input type="text" name="flightNo" id="flightNo" size="9" class="textStyleDefault"/>��
														<input type="text" name="airlineEn" id="airlineEn" style="border:0px" size="3" class="font_gray" readonly="readonly" />
														<input type="text" name="airlineCn" id="airlineCn" style="border:0px" class="font_gray" readonly="readonly" />
													</td>
													<td width="8%">&nbsp; * ��λ��</td>
													<td width="15%"><input type="text" name="airfares" id="airfares" size="9" class="textStyleDefault" /></td>
													<td width="8%">&nbsp; * �ɻ����ͣ�</td>
													<td><input type="text" name="planeTypes" id="planeTypes" size="20" class="textStyleDefault"/></td>
													<td>&nbsp; * ҹ����
														<select name="sltNight" id="sltNight">
															<option id="opIsNight" value="0">��</option>
															<option id="opIsNight" value="1">��</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>&nbsp; * �������У�</td>
													<td><input type="text" name="startPoint" id="startPoint" size="20" class="textStyleDefault" /></td>
													<td>&nbsp; * ����������</td>
													<td><%=CreateSltFltItemName("departureCode","-��ѡ��-",sltDepartCode,"","")%>��
														<input type="text" name="departureAirport" id="departureAirport" style="border:0px" class="font_gray" readonly="readonly" /></td>
													<td>&nbsp; * ������վ¥��</td>
													<td><%=CreateSltFltMileageByTerminal("departureTerminal",sltDepartTerminal,"","")%></td>
													<td>&nbsp; * ���ʱ�䣺</td>
													<td colspan="2"><input type="text" name="startTime" id="startTime" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="inputTextDateBg" /><label>&nbsp;</label>
														<label><%=CreateSltByTimeHour("leaveOnHour", "10", "", "", "")%> ʱ</label>
														<label><%=CreateSltByTimeMinute("leaveOnMinute", "00", "", "", "")%> ��</label>
														<label><%=CreateSltByTimeMinute("leaveOnSecond", "00", "", "", "")%> ��</label></td>
												</tr>
												<tr>
													<td>&nbsp; * �ִ���У�</td>
													<td><input type="text" name="endPoint" id="endPoint" size="20" class="textStyleDefault" /></td>
													<td>&nbsp; * �ִ������</td>
													<td><%=CreateSltFltItemName("arriveCode","-��ѡ��-",sltArriveCode,"","")%>��
														<input type="text" name="arriveAirport" id="arriveAirport" style="border:0px" class="font_gray" readonly="readonly" /></td>
													<td>&nbsp; * �ִﺽվ¥��</td>
													<td><%=CreateSltFltMileageByTerminal("arriveTerminal",sltArriveTerminal,"","")%></td>
													<td>&nbsp; * �ִ�ʱ�䣺</td>
													<td colspan="2"><input type="text" name="leaveTime" id="leaveTime" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="inputTextDateBg" /><label>&nbsp;</label>
														<label><%=CreateSltByTimeHour("returnOnHour", "10", "", "", "")%> ʱ</label>
														<label><%=CreateSltByTimeMinute("returnOnMinute", "00", "", "", "")%> ��</label>
														<label><%=CreateSltByTimeMinute("returnOnSecond", "00", "", "", "")%> ��</label></td>
												</tr>
											</table></td>
									</tr>
								</tbody>
							</table></td>
					</tr>
					<tr>
						<td><input type="hidden" name="flightId" id="flightId" value="<%=fId%>" /></td>
						<td><input type="button" name="btnSubmit" id="btnSubmit" class="btn_bg_style04_50" value="�ύ" onclick="FltMlg.toSubmitFltMlg()" />
							<input type="reset" class="btn_bg_style02_50" value="����" />
							<input type="button" name="btnCanl" id="btnCanl" class="btn_bg_style02_50" value="�ر�" onclick="window.close();"/></td>
					</tr>
				</table></td>
		</tr>
	</table>
</form>
</body>
</html>

<!--#include virtual="/conn/incConn.asp" -->