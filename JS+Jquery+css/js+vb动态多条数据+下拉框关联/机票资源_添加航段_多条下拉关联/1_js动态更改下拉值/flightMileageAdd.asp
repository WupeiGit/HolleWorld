<!--#include virtual="/inc/action/flightMileageAction.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ʊ��Դ���ι���</title>
<link href="/style/common.css" type="text/css" rel="stylesheet" />
<link href="/style/admin.css" type="text/css" rel="stylesheet" />
<link href="/style/calendar.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/style/js/prototype.js"></script>
<script type="text/javascript" src="/style/js/common.js"></script>
<script type="text/javascript" src="/style/js/ajax.js"></script>
<script type="text/javascript" src="/style/js/alt.js"></script>
<script type="text/javascript" src="/style/js/calendar.js"></script>
<script type="text/javascript" src="/style/js/calendar-setup.js"></script>
<script type="text/javascript" src="/style/js/calendar-zh.js"></script>
<script type="text/javascript" src="/style/js/flightMileage.js"></script>

</head>
<%
Dim sql, rs
Dim fId					:	fId				=	GetSafeStr(Request.QueryString("flightId"))
Dim sltDepartCode		:	sltDepartCode	=	GetSafeStr(Request("departureCode"))
Dim sltArriveCode		:	sltArriveCode	=	GetSafeStr(Request("arriveCode"))
sql = "select * from ts_items with(nolock) where 1=1 and pid=639 and tmid =11"
%>
<body>
<form name="frmAdd" id="frmAdd" method="post" >
<table border="0" cellpadding="0" cellspacing="1" class="tabStyle6" style="width:100%">
    <tr>
        <th colspan="10">��Ʊ��Դ���ι���-��Ӻ���</th>
    </tr>
    <tr>
        <td style="text-align:center;">
			<!--#include file="flightCommonInfo.asp" -->
            <table width="99%" border="0" cellpadding="3" cellspacing="1" class="tabStyle16">
                <tr>
                    <th width="8%">��ӻ�Ʊ������Ϣ</th>
					<th><input name="btnAdd" type="button" class="btn_bg_style01_50" onClick="FltMlg.AddFltMlgTab(1);" value="������"/>
						<input name="btnSub" type="button" class="btn_bg_style01_50" onClick="FltMlg.CutFltMlgTab(1);" value="������" disabled="disabled" />
                        <input type="hidden" name="copyNum" id="copyNum" value="0" /></th>
                </tr>
                <tr>
                    <td colspan="2" style="padding:5px">
                    	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabOne">
                        	 <tbody id="tTabSignUpInfo">
                                <tr id="divfirst" style="display:block;">
                                    <td>
                                        <table width="100%" border="0" cellpadding="2" cellspacing="1" class="tabStyle16" id="tabTwo">
                                            <tr>
												<td width="10%"><span class="font_red">*</span> �ڼ��죺</td>
                                                <td width="20%"><input type="text" name="dayNum" id="dayNum" size="5" class="textStyleDefault" onkeyup="FltMlg.checkDayNum(this.value);"/>&nbsp; <span class="font_gray">/ ��</span></td>
      											<td width="10%"><span class="font_red">*</span> ����ţ�</td>
                                                <td width="22%"><input type="text" name="flightNo" id="flightNo" size="20" class="textStyleDefault" /></td>
												<td width="10%"><span class="font_red">*</span> ��λ��</td>
                                                <td><input type="text" name="airfares" id="airfares" size="20" class="textStyleDefault" /></td>
											</tr>
											<tr>
												<td><span class="font_red">*</span> ��վ¥��</td>
                                                <td><input type="text" name="terminal" id="terminal" class="textStyleDefault"/></td>
												<td><span class="font_red">*</span>�ɻ����ͣ�</td>
                                                <td><input type="text" name="planeTypes" id="planeTypes" size="20" class="textStyleDefault"/></td>
												<td><span class="font_red">*</span> �Ƿ��ҹ��</td>
												<td>
                                                	<select name="sltNight" id="sltNight">
                                                        <option id="opIsNight" value="0">��</option>
                                                        <option id="opIsNight" value="1">��</option>
                                                    </select>
                                                    &nbsp; <span class="font_gray">Ĭ���"��"</span>
												</td>
                                            </tr>
											<tr>
												<td><span class="font_red">*</span> �������У�</td>
                                                <td><input type="text" name="startPoint" id="startPoint" size="20" class="textStyleDefault" /></td>
                                                <td><span class="font_red">*</span> ��������(������)��</td>
                                                <td><%=CreateSltFltItemName("departureCode1","-��������������-",sltDepartCode,"onchange","FltMlg.getCheckedTrNum(1);FltMlg.toShowDepartAirport(this[this.selectedIndex].value);")%>														
																<label id="showDepartAirport1" class="font_gray">&nbsp;</label>
																<input type="hidden" name="departureAirport1" id="departureAirport1" size="20" />	
												</td>
												<td><span class="font_red">*</span> ���ʱ�䣺</td>
                                                <td><input type="text" name="startTime" id="startTime" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="cur_hand;textStyleDefault" /><label>&nbsp;</label>
                                                    <label><%=CreateSltByTimeHour("leaveOnHour", "10", "", "", "")%> ʱ</lasbel>
                                                    <label><%=CreateSltByTimeMinute("leaveOnMinute", "00", "", "", "")%> ��</label>
                                                    <label><%=CreateSltByTimeMinute("leaveOnSecond", "00", "", "", "")%> ��</label>
                                                </td>
											</tr>
											<tr>
												<td><span class="font_red">*</span> �ִ���У�</td>
                                                <td><input type="text" name="endPoint" id="endPoint" size="20" class="textStyleDefault" /></td>
											    <td><span class="font_red">*</span> �ִ����(������)��</td>
                                                <td><%=CreateSltFltItemName("arriveCode1","-�ִ����������-",sltArriveCode,"onchange","FltMlg.getCheckedTrNum(1);FltMlg.toShowArriveCode(this[this.selectedIndex].value);")%>
													<label id="showArriveCode1" class="font_gray">&nbsp;</label>
													<input type="hidden" name="arriveAirport1" id="arriveAirport1" size="20" />
												</td>
												<td><span class="font_red">*</span> �ﵽʱ�䣺</td>
                                                <td><input type="text" name="leaveTime" id="leaveTime" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="cur_hand;textStyleDefault" /><label>&nbsp;</label>
                                                	<label><%=CreateSltByTimeHour("returnOnHour", "10", "", "", "")%> ʱ</label>
                                                    <label><%=CreateSltByTimeMinute("returnOnMinute", "00", "", "", "")%> ��</label>
                                                    <label><%=CreateSltByTimeMinute("returnOnSecond", "00", "", "", "")%> ��</label>
												</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
								<tr>
								 	<td>
										<div id="copyFltInfo"></div>
									</td>
								</tr>
                        	</tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                	<td><input type="hidden" name="flightId" id="flightId" value="<%=fId%>" /><input type="text" name="ckdTrNum" id="ckdTrNum" value="0"/></td>
               		<td><input type="button" name="btnSubmit" id="btnSubmit" class="btn_bg_style04_50" value="�ύ" onclick="FltMlg.toSubmitFltMlg()" />
                    	<input type="reset" class="btn_bg_style02_50" value="����" />
                    	<input type="button" name="btnCanl" id="btnCanl" class="btn_bg_style02_50" value="�ر�" onclick="window.close();"/>
                    </td>
                </tr>
            </table>          
       </td>
    </tr>
</table>
</form>
</body>
</html>

<!--#include virtual="/conn/incConn.asp" -->