<!--#include virtual="/conn/conn.asp" -->
<!--#include virtual="/inc/base.asp" -->
<!--#include virtual="/inc/function.asp" -->
<!--#include virtual="/inc/class/upfile_class.asp" -->
<!--#include virtual="/inc/uploadFile.asp" -->
<!--#include virtual="/inc/pages.asp" -->
<!--#include virtual="/inc/winMessage.asp" -->
<!--#include virtual="/inc/class/Tags.asp" -->
<!--#include virtual="/inc/object/ADOObjects.asp" -->
<!--#include virtual="/inc/dao/fiBusinessCostDao.asp" -->
<%
Dim budgetPrice,itemBalance,objItem,sqlStrByEmp,rsByEmp,transactorNameStr,transactorCodeStr,deptNameStr,deptCodeStr
Dim toUrlBusinessCostList         : toUrlBusinessCostList         = "/admin/finance/budget/businessCostList.asp" 
Dim toUrlBusinessCostDetailList   : toUrlBusinessCostDetailList   = "/admin/finance/budget/businessCostDetail.asp?bcId=" & Request("bcId")
Dim toUrlBusinessCostCustomer     : toUrlBusinessCostCustomer     = "/admin/finance/budget/businessCostCustomer.asp?bcdId=" & Request("bcdId")
Dim toUrlBusinessCostApprovalDesc : toUrlBusinessCostApprovalDesc = "/admin/finance/budget/businessCostApprovalDesc.asp?bcId=" & Request("bcId") & "&approvalRole=" & Request("approvalRole") & "&schAudiStat=" & Request("schAudiStat")
Dim toUrlBusinessCostShare		  : toUrlBusinessCostShare 		  = "/admin/finance/budget/businessCostShare.asp?bcdId=" & Request("bcdId")
Select Case Request.QueryString("action")

	Case "getBudgetDataList"
		strSql = "select distinct itemCode,itemName from v_fiBudgetOrderYearApplyList v with(nolock) where categoryName = '" & CheckStr(Request.QueryString("categoryName")) & "' and deptId = (select deptId from fi_empList where empId = " & Session("uid") &  " and programmeId = v.programmeId)" 
		Break(CreateSelectPlus(conn,strSql,"","itemCode","请选择","","onchange","BtnEvent.getItemValue(this)"))	
'		strSql = "select itemDesc,itemName from ts_items where pId =(select iId from ts_items where tmId = 8 and itemName = '"& CheckStr(Request.QueryString("categoryName")) &"' and isEnable = 1)  and isAutoCalc = 0"
'		Break(CreateSelectPlus(conn,strSql,"","itemCode","请选择","","",""))
		
	Case "getOneDeptEmps"
		Dim trNum : trNum  =  CheckStr(Request("trNum"))
		Break(CreateSltEmpIdInManyDeptList("sltEmpId"&trNum, "", Request.QueryString("deptId"), "", "onchange", "CostShare.getSelectedEmpId("& trNum &");"))
		

	Case "getItemValue"

		strSql = "select costPriceSum = isNUll(sum(costPrice),0) from fi_businessCostDetail  bcd with(nolock) "&_
		 " left join fi_businessCost bc with(nolock) on bcd.bcId = bc.bcId "&_
         " where itemCode in (select itemCode from v_fiBudgetOrderYearApplyList where itemCode = '" & CheckStr(Request.QueryString("itemCode")) & "' and deptId = " & Session("userBudgetDept") & ") "&_ 
		 " and Month(bcd.createTime) <= Month(getDate())"&_ 
		 " and bc.deptId = " & Session("userBudgetDept")
		If GetRs(rs, strSql) Then
			itemBalance = rs("costPriceSum") 'GetRsToString(strSql,"")本部门累计已申请
		End If 
		Call DestoryRs(rs)
		
'		strSql = "select thisMonthValue = "&_
'		"  isNull((case when Month(GETDATE()) = 1 Then sum(jan) "&_
'		"	  when Month(GETDATE()) = 2 Then sum(jan) + sum(feb) "&_
'		"	  when Month(GETDATE()) = 3 Then sum(jan) + sum(feb) + sum(mar) "&_
'		"	  when Month(GETDATE()) = 4 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) "&_
'		"	  when Month(GETDATE()) = 5 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) "&_
'		"	  when Month(GETDATE()) = 6 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) "&_
'		"	  when Month(GETDATE()) = 7 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) + sum(jul) "&_
'		"	  when Month(GETDATE()) = 8 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) + sum(jul) + sum(aug) "&_
'		"	  when Month(GETDATE()) = 9 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) + sum(jul) + sum(aug) + sum(sep) "&_
'		"	  when Month(GETDATE()) = 10 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) + sum(jul) + sum(aug) + sum(sep) + sum(oct) "&_
'		"	  when Month(GETDATE()) = 11 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) + sum(jul) + sum(aug) + sum(sep) + sum(oct) + sum(nov) "&_
'		"     when Month(GETDATE()) = 12 Then sum(jan) + sum(feb) + sum(mar) + sum(apr) + sum(may) + sum(jun) + sum(jul) + sum(aug) + sum(sep) + sum(oct) + sum(nov) + sum(dec) end ),0) "&_
'		" from fi_monthDetail where bodId in (select bodId from v_fiBudgetOrderYearApplyList where itemCode = '" & CheckStr(Request.QueryString("itemCode")) & "' and deptId = " & Session("userBudgetDept") & ")"
'		If GetRs(rs, strSql) Then
'			budgetPrice = rs("thisMonthValue") 'GetRsToString(strSql,"")本部门截止本月预算总额
'		End If 
'		Call DestoryRs(rs)		
		strSql = "select thisMonthValue = isNull(sum(budgetPrice),0) from fi_budgetOrderDetail where bodId in (25464)"
		If GetRs(rs, strSql) Then
			budgetPrice = rs("thisMonthValue") 
		End If 
		Call DestoryRs(rs)	
		Break(budgetPrice & "," & itemBalance & "," & budgetPrice-itemBalance & "<input type='hidden' name='mayApplyValue' id = 'mayApplyValue' value='" & budgetPrice-itemBalance & "' />")
		
		
	Case "businessCostApply"
		sqlStrByEmp = "select empCode,empName,deptName,deptCode from v_empList where empId =" & Request("sltEmpId")
		If GetRs(rsByEmp,sqlStrByEmp) Then 
			transactorNameStr = rsByEmp("empName")
			transactorCodeStr = rsByEmp("empCode")
			deptNameStr       = rsByEmp("deptName")
			deptCodeStr       = rsByEmp("deptCode")
		End If

		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "transactorName",             transactorNameStr
			.add "transactorCode",             transactorCodeStr
			.add "transactorDeptCode",         deptCodeStr
			.add "transactorDeptName",         deptNameStr
			.add "categoryNames",              Request("categoryName")
			.add "itemCodes",                  Request("itemCode")
			.add "costPrices",                 Request("costPrice")
			.add "isBillOrNos",                Request("isBillOrNo")
			.add "billDates",                  Request("billDate")
			.add "costNotes",                  Request("costNote")
		End With
	
		If businessCostApply(objItem) Then
			Call WinSuccess("提交成功！", toUrlBusinessCostList, 3)
		Else
			Call WinError("提交失败！", toUrlBusinessCostList, 3)
		End If	
		
	Case "editCost"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdId",         Request("bcdId")
			.add "categoryName",  Request("categoryName")
			.add "itemCode",      Request("itemCode")
			.add "costPrice",     Request("costPrice")
			.add "isBillOrNo",    Request("isBillOrNo")
			.add "billDate",      Request("billDate")
			.add "costNote",      Request("costNote")
		End With
		If editCost(objItem) Then
			Call WinSuccess("提交成功！", toUrlBusinessCostDetailList, 3)
		Else
			Call WinError("提交失败！", toUrlBusinessCostDetailList, 3)
		End If			
	
		
	Case "deleteBusinessCost"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcId",             Request("bcId")
		End With

		If deleteBusinessCost(objItem) Then
			Call WinSuccess("删除成功！", toUrlBusinessCostList, 3)
		Else
			Call WinError("删除失败！", toUrlBusinessCostList, 3)
		End If		
		
		
		
	Case "delCost"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcId",            Request("bcId")
			.add "bcdId",           Request("bcdId")
		End With
		If delCost(objItem) Then
			Call WinSuccess("删除成功！", toUrlBusinessCostDetailList, 3)
		Else
			Call WinError("删除失败！", toUrlBusinessCostDetailList, 3)
		End If		
		
	Case "delCustomer"	
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdId",            Request("bcdId")
			.add "bcsId",            Request("bcsId")
			.add "costPrice",        Request("costPrice")
		End With
		If delCustomer(objItem) Then
			Call WinSuccess("删除成功！", toUrlBusinessCostCustomer, 3)
		Else
			Call WinError("删除失败！", toUrlBusinessCostCustomer, 3)
		End If	
		
	Case "delCostShare"	
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdId",            Request("bcdId")
			.add "bcsId",            Request("bcsId")
			.add "costPrice",        Request("costPrice")
		End With
		
		If Request("bcdId") <> "" Then
			If delCostShare(objItem) Then
				Call WinSuccess("删除成功！", toUrlBusinessCostShare, 3)
			Else
				Call WinError("删除失败！", toUrlBusinessCostShare, 3)
			End If
		Else
			Call WinError("操作失败，请重试！", toUrlBusinessCostShare, 3)
		End If
		
	Case "submitCost"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcId",             Request("bcId")
		End With
		If submitCost(objItem) Then
			Call WinSuccess("提交成功！", toUrlBusinessCostList, 3)
		Else
			Call WinError("提交失败！", toUrlBusinessCostList, 3)
		End If 
	
	Case "setBcCustmoer"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdId",             Request("bcdId")
			.add "costPrice",         Request("costPrice")
			.add "eIdStr",            Request("eIdStr")
		End With

		If setBcCustmoer(objItem) Then
			Call WinSuccess("保存成功！", toUrlBusinessCostCustomer, 3)
		Else
			Call WinError("保存失败！", toUrlBusinessCostCustomer, 3)
		End If		
		
	Case "auditingpassByCost"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdIds",             Request("bcdIds")
			.add "approvalRole",       Request("approvalRole")
		End With
		
		If auditingpassByCost(objItem) Then
			Call WinSuccess("审核成功！", toUrlBusinessCostApprovalDesc ,3)
		Else
			Call WinError("审核失败，请重新审核！", toUrlBusinessCostApprovalDesc,3)
		End If
		
	Case "auditingunpassByCost"
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdIds",             Request("bcdIds")
			.add "approvalRole",       Request("approvalRole")
		End With
		
		If auditingunpassByCost(objItem) Then 
			Call WinSuccess("审核成功！", toUrlBusinessCostApprovalDesc ,3)
		Else
			Call WinError("审核失败，请重新审核！", toUrlBusinessCostApprovalDesc,3)
		End If				
			
	'获取员工列表
	Case "loadEmpList"
		Break(CreateSltByEmpListByDeptIDs("eId","",Request.QueryString("deptIDs"),"","")) : Call CloseConn()	

	'添加分摊
	Case "businessCostShareAdd" 
		Dim num, strSltDeptId, strSltEmpId, strShareNote
		Dim addNum : addNum	=	GetSafeStr(Request("addNum"))
		
		For num = 1 To CINT(addNum+1)
			strSltDeptId	= strSltDeptId&GetSafeStr(Request("sltCompDept"&num))&","
			strSltEmpId		= strSltEmpId&GetSafeStr(Request("sltEmpId"&num))&","
			strShareNote	= strShareNote&GetSafeStr(Request("shareNote"&num))&","
		Next

		strSltDeptId	= left(strSltDeptId,len(strSltDeptId)-1)
		strSltEmpId		= left(strSltEmpId,len(strSltEmpId)-1)
		strShareNote	= left(strShareNote,len(strShareNote)-1)

		'break(strSltDeptId&"<strong>====</strong>"&strSltEmpId)
		
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "bcdId",					  GetSafeStr(Request("bcdId"))
			.add "addNum",					  addNum
			.add "sltDeptId",				  strSltDeptId
			.add "strSltEmpId",				  strSltEmpId		
			.add "costOfOne",                 GetSafeStr(Request("costOfOne"))
			.add "shareNote",                 strShareNote
		End With

		If BusinessCostShareAdd(objItem) Then
			Call WinSuccess("提交成功！", toUrlBusinessCostShare, 3)
		Else
			Call WinError("提交失败！", toUrlBusinessCostShare, 3)
		End If

	Case "toTestSelectEd"
		Break(ToTestSelectEd(GetSafeStr(Request("strNum"))))
		
	Case "toTestSelectEmpEd"
		Break(ToTestSelectEmpEd(GetSafeStr(Request("strNum"))))
		
End Select
'生成部门列表
Function CreateSltByDept(ByVal elementName, ByVal selectedItems, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct di_id, "&_
	                      " deptName = (case when len(deptCode) = 3  then '' "&_
						  "                  when len(deptCode) = 6  then '　' "&_
						  "                  when len(deptCode) = 9  then '　　' "&_
						  "                  when len(deptCode) = 13 then '　　　' end) + di_name, "&_
						  " deptCode "&_
						  " from ts_deptInfo with(nolock) "&_
						  " where di_iscancel <> 1 "
	strSql = strSql & " order by deptCode "
	CreateSltByDept = CreateCheckBoxList(conn,strSql,elementName,selectedItems,"",1,eventType,eventMethod)
End Function

Function CreateSltByEmpListByDeptIDs(ByVal elementName, ByVal selectedItems, ByVal deptIDs, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select eId, empName "&_
						  " from fi_empList emp with(nolock) "&_
						  " where deptId in ("& deptIDs &") and programmeId = (select programmeId from bc_programme where currentEnable = 1) "	
	strSql = strSql & " order by empName "
	Dim eIdStr : eIdStr = GetRsToString(strSql,",")
	If (deptIDs <> "") Then CreateSltByEmpListByDeptIDs = CreateCheckBoxList(conn,strSql,elementName,eIdStr,"",1,eventType,eventMethod)
End Function

'审核状态
Function GetAudiResult(ByVal audiStatus)
	Dim result
	Select Case CLng(audiStatus)
		Case 1
			result = "<img src=""/images/icons/03/exclamation.gif"" border=""0"" align=""absmiddle"" hspace=""3"" />"
		Case 2
			result = "<img src=""/images/icons/01/tick.png"" border=""0"" align=""absmiddle"" hspace=""3"" />"
		Case 3
			result = "<img src=""/images/icons/02/cross.gif"" border=""0"" align=""absmiddle"" hspace=""3"" />"
	End Select
	GetAudiResult = result
End Function

'审核状态
Function CreateSltAudiStat(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("全部状态","未审核","已审核")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateSltAudiStat = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", "", "", eventType, eventMethod)
End Function

Function ToTestSelectEd(ByVal objStrNum)
	ToTestSelectEd = CreateSltInfinityByDept(conn,"sltCompDept"&objStrNum,0,"", Session("deptId"),"","","onchange","CostShare.getCheckedTrNum("& objStrNum &");CostShare.getDeptEmpsShare(this[this.selectedIndex].value);")
End Function

Function ToTestSelectEmpEd(ByVal objStrNum)
	ToTestSelectEmpEd = CreateSltEmpIdInManyDeptList("sltEmpId"&objStrNum, Session("uid"), Session("deptId"), "选择", "onchange", "CostShare.getSelectedEmpId("& objStrNum &");")
End Function
%>