<!--#include virtual="/inc/action/fiBusinessCostAction.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���÷�̯����</title>
<link href="/style/common.css" rel="stylesheet" type="text/css" />
<link href="/style/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/style/js/prototype.js"></script>
<script type="text/javascript" src="/style/js/common.js"></script>
<script type="text/javascript" src="/style/js/ajax.js"></script>
<script type="text/javascript" src="/style/js/businessCost.js"></script>
</head>
<%
Dim rs, strSql, row, rsEmp, sumSharePrice
Dim itemName,costPrice,isBillOrNo,billDate,createTime,costNote,iPage, iPageSize, pCount, itemCount, otherKeys, pageStyle
Dim bcdId 		: bcdId 		= GetSafeStr(Request.QueryString("bcdId"))

strSql = " select * from fi_businessCostDetail with(nolock) where bcdId = " & bcdId
If GetRs(rs,strSql) Then 
	itemName = rs("itemName")
	costPrice = rs("costPrice")
	isBillOrNo = rs("isBillOrNo")
	billDate = rs("billDate") 
	createTime = rs("createTime") 
	costNote = rs("costNote") 
End If
Call DestoryRs(rs)

'strSql = " select * from fi_empList with(nolock) "&_
'		 " where programmeId = (select programmeId from bc_programme where currentEnable = 1)" 

strSql = " select bcsId,deptName,costOfOne, shareNote, empName, empCode, "&_
         " empName2 = (select empName from fi_empList where programmeId in (select programmeId from bc_programme where currentEnable = 1) and empId = bcs.empId),"&_ 
         " categoryName = (select categoryName from fi_empList where programmeId in (select programmeId from bc_programme where currentEnable = 1) and empId = bcs.empId) ,"&_
		 " empCode2 = (select empCode from fi_empList where programmeId in (select programmeId from bc_programme where currentEnable = 1) and empId = bcs.empId)"&_
         " from fi_businessCostShare bcs with(nolock) where bcdId = " & bcdId

otherKeys = otherKeys &"&bcdId="   & bcdId
%>
<body>
	<table width="99%" border="0" align="center" cellpadding="3" cellspacing="1" class="tabStyle16" style="margin-bottom:8px;">
		<tr>
			<th colspan="30">������Ϣ</th>
		</tr>
		<tr>
			<td width="7%" align="right" nowrap="nowrap"><strong>���ÿ�Ŀ</strong></td>
			<td width="10%" align="left" nowrap="nowrap"><%=itemName%></td>
			<td width="7%" align="right" nowrap="nowrap"><strong>�Ƿ��з�Ʊ</strong></td>
			<td width="10%" align="left" nowrap="nowrap"><strong><% If isBillOrNo = true Then %> �� <% Else %> �� <% End If%></strong></td>
			<td width="7%" align="right" nowrap="nowrap"><strong>����ʱ��</strong></td>
			<td width="59%" align="left" nowrap="nowrap"><%=createTime%></td>
		</tr>
		<tr>
			<td width="7%" align="right" nowrap="nowrap"><strong>���ý��</strong></td>
			<td width="10%" align="left" nowrap="nowrap"><%=GetMoney(costPrice)%></td>
			<td width="7%" align="right" nowrap="nowrap"><strong>��Ʊ����</strong></td>
			<td width="10%" align="left" nowrap="nowrap"><%=billDate%></td>
			<td width="7%" align="right" nowrap="nowrap"><strong>��ע</strong></td>
			<td width="59%" align="left" nowrap="nowrap"><%=costNote%></td>			
		</tr> 
	</table>
		
	<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="tabStyle6">
		<tr>
			<th>���÷�̯��Ϣ</th>
		</tr>
		<tr>
			<td><div class="clearAll" id="listLayer">
					<div class="paddingAll8px">
						<form name="frmShareList" id="frmShareList" action="" method="post"/>
						<table border="0" cellpadding="0" cellspacing="1" class="tabStyle16" align="center" style="margin-bottom:8px;width:100%;">
						<tr>
							<th width="3%">���</th>
							<th width="10%">Ա�����</th>
							<th width="14%">���������룩</th>
							<th width="8%">���ý��</th>
							<th width="8%">����</th>
							<th>��ע</th>
							<th width="8%">����</th>
						</tr>
						<%
						If GetRs(rs, strSql) Then
							Call SetPageInfo(rs, iPage, iPageSize, pCount, itemCount)
							For row = 1 To iPageSize
							sumSharePrice = sumSharePrice+rs("costOfOne")
						%>
						<tr onclick="BtnEvent.selectedLine(this);" class="cur_hand">
							<td><%=row%></td>
							<td><%=rs("categoryName")%></td>
							<td><%=rs("empName")%>(<%=rs("empCode")%>)</td>
							<td><%=GetMoney(rs("costOfOne"))%></td>
							<td><%=rs("deptName")%></td>
							<td><%=rs("shareNote")%></tr>
							<td><input type="button" onclick="CostShare.delShare(<%=bcdId%>,<%=rs("bcsId")%>,<%=costPrice%>)" value="ɾ��" class="btn_bg_style02_50"/></td>
						</tr>
						<%
								rs.MoveNext
								If (rs.Bof Or rs.Eof) Then Exit For
							Next	
						End If
						Call DestoryRs(rs)
						%>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>				
							<td colspan="4">�ϼƣ�<strong><%=sumSharePrice%></strong> Ԫ</td>

						</tr>	
						<tr>
							<td colspan="30" class="mdListBtn" style="text-align:right"><%=CreatePageInfo(iPage, iPageSize, pCount, itemCount, otherKeys, pageStyle)%></td>
						</tr>	
					</table>
					</form>
					<!--<table border="0" cellpadding="0" cellspacing="0" class="tabStyle16"  style="margin-bottom:8px;width:100%;">
						<tr>
							<td colspan="30">
							<input type="button" class="btn_bg_style04" onclick="BtnEvent.bcEditCustomer();" value="���" />
							<input type="button" class="btn_bg_style02_50" onclick="window.close();" value="�ر�" /></td>
						</tr>			
					</table>-->
					</div>
					
					<div class="paddingAll8px">
						<input type="button" class="btn_bg_style01_50" onclick="CostShare.addRowShare(1);" value="��1��" />
						<!--<input type="button" class="btn_bg_style01_50" onclick="CostShare.addRowShare(5);" value="��5��" />-->
						<input type="button" class="btn_bg_style02_50" id="btnCutTb" onClick="CostShare.deleteRows(1);" value="ɾ1��" />
						<input type="hidden" name="copyNum" id="copyNum" value="0" />
					</div>
					<div class="paddingAll8px">
						<form name="frmShareAdd" id="frmShareAdd" method="post" action="">
						<table width="99%" border="0" cellpadding="3" cellspacing="1" class="tabStyle16"  id="rowTable">
							<tbody id="rowElementShare">
								<tr>
									<th width="5%">�������</th>
									<th width="10%">��������</th>
									<th width="10%">Ա��</th>
									<th width="15%">���ý��</th>
									<th colspan="2">��ע</th>
								</tr>
								<tr id="trAddInfo" style="display:block;">
									<td>�� 1 ��</td>
									<td><%=CreateSltInfinityByDept(conn,"sltCompDept1",0,"", Session("deptId"),"","","onchange","CostShare.getCheckedTrNum(1);CostShare.getDeptEmpsShare(this[this.selectedIndex].value);")%></td>
									<td><span id="_sltEmpList1"><%=CreateSltEmpIdInManyDeptList("sltEmpId1", Session("uId"), Session("deptId"), "", "onchange", "CostShare.getSelectedEmpId(1);")%></span>
										<input type="hidden" name="toGetEmpId1" id="toGetEmpId1" value="<%=Session("uId")%>"/>
									</td>
									<td><input type="text" name="costOfOne" id="costOfOne"  onkeydown="CostShare.countSumPrice(this);" onkeyup="CostShare.countSumPrice(this);CostShare.toCheckPrice(<%=costPrice-sumSharePrice%>,this.value);" autocomplete="off"></td>
									<td><textarea name="shareNote1" id="shareNote1" rows="1" style="width:95%;" onfocus="this.rows=3;" onblur="this.rows=1;">���ޱ�ע</textarea></td>
								</tr>
							</tbody>
						</table>
						</form>
					</div>
			</div></td>
		</tr>
		<tr>
			<td><div class="clearAll" id="listLayer">
				<div class="paddingAll8px">	
				���κϼƣ�<label type="text" id="sumPrice" class="font_bold font_bigTitle_orange">0</label>Ԫ&nbsp;&nbsp;
				������<label type="text" id="currentPrice" class="font_bold font_bigTitle_orange"><%=costPrice-sumSharePrice%></label>Ԫ
				<input type="hidden" name="bcdId" id="bcdId" value="<%=bcdId%>" />
				<input type="hidden" name="costPrice" id="costPrice" value="<%=costPrice%>" />
				<input type="hidden" name="hidSumPrice" id="hidSumPrice" value=""/>
				<input type="hidden" name="seDeptId" id="seDeptId" value="<%=Session("deptId")%>" />
				<input type="hidden" name="seEmpId" id="seEmpId" value="<%=Session("uid")%>" />
				<input type="hidden" name="ckdTrNum" id="ckdTrNum" />
				<input type="button" name="btnSubShare" id="btnSubShare" value="�ύ" class="btn_bg_style01_50" onclick="CostShare.addShare(<%=bcdId%>);"/>
				<input type="button" name="btnClo" id="btnClo" value="�ر�" onclick="window.close();"/>	
				</div></div>
			</td>
		</tr>
	</table>
</body>
</html>

<!--#include virtual="/conn/incConn.asp" -->