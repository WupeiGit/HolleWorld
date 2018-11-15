<!--#include virtual="/api/nc/NCHelper.asp"-->
<%
function businessCostApply(ByVal objItem)

Dim comm, stateId

	If CreateStoredProcCmd(comm,"pf_businessCostAdd") Then
		With comm.Parameters
			.Append comm.CreateParameter("@stateId",			adInteger,adParamOutput,4)
			.Append comm.CreateParameter("@transactorName",		adVarChar,adParamInput,100,	    objItem.Item("transactorName"))
			.Append comm.CreateParameter("@transactorCode",		adVarChar,adParamInput,100,	    objItem.Item("transactorCode"))
			.Append comm.CreateParameter("@transactorDeptName",	adVarChar,adParamInput,100,	    objItem.Item("transactorDeptName"))
			.Append comm.CreateParameter("@transactorDeptCode",	adVarChar,adParamInput,100,	    objItem.Item("transactorDeptCode"))			
			.Append comm.CreateParameter("@categoryNames",      adVarChar,adParamInput,8000,    objItem.Item("categoryNames"))
			.Append comm.CreateParameter("@itemCodes",			adVarChar,adParamInput,8000,	objItem.Item("itemCodes"))
			.Append comm.CreateParameter("@costPrices",		    adVarChar,adParamInput,8000,	objItem.Item("costPrices"))
			.Append comm.CreateParameter("@isBillOrNos",        adVarChar,adParamInput,8000,    objItem.Item("isBillOrNos"))
			.Append comm.CreateParameter("@billDates",          adVarChar,adParamInput,8000,    objItem.Item("billDates"))
			.Append comm.CreateParameter("@costNotes",          adVarChar,adParamInput,8000,    objItem.Item("costNotes"))
			
			.Append comm.CreateParameter("@creatorID",          adVarChar,adParamInput,50,    Session("uid"))
			.Append comm.CreateParameter("@creatorName",        adVarChar,adParamInput,50,    Session("userName"))
			.Append comm.CreateParameter("@deptCode",           adVarChar,adParamInput,50,    Session("deptCode"))
			.Append comm.CreateParameter("@deptName",           adVarChar,adParamInput,50,    Session("deptName"))
				
		End With
		comm.Execute()

		stateId = comm.parameters("@stateId").value 

	End If
	Call TerminateStoredProcCmd(comm)
	
	If ((Err.Number <> 0) Or (stateId = 0)) Then
        businessCostApply = False
	Else
		businessCostApply = True
	End If
End Function

Function editCost(ByVal objItem)
	On Error Resume Next
	Dim strSql
	Dim itemCode  : itemCode  = objItem.item("itemCode")
	Dim bcdId     : bcdId     = objItem.item("bcdId")
	Dim costPrice : costPrice = objItem.item("costPrice")
	Dim isBillOrNo: isBillOrNo= objItem.item("isBillOrNo")
	Dim billDate  : billDate  = objItem.item("billDate")
	Dim costNote  : costNote  = objItem.item("costNote")
	strSql = "select itemName from ts_items where itemDesc = '" & itemCode & "'"
	Dim itemName  : itemName  = GetRsToString(strSql,"") 
	
	strSql = " update fi_businessCostDetail set itemCode = '" & itemCode & "',itemName = '" & itemName & "',costPrice=" & costPrice & ",isBillOrNo=" & isBillOrNo & ",billDate='"& billDate & "',costNote='" & costNote & "' where bcdId = " & bcdId
	
	conn.execute(strSql)
	If (Err.Number <> 0) Then
		editCost = False
	Else
		editCost = True
	End If	
End Function

Function deleteBusinessCost(ByVal objItem)
 	On Error Resume Next
	Dim strSql
	Dim bcId      :  bcId  = 	objItem.item("bcId")
	Dim bcdIdStr
	
	strSql = "delete from fi_businessCostShare where bcdId in (select bcdId from fi_businessCostDetail  where bcId =" & bcId & ")"
	conn.execute(strSql)
	
	strSql = "delete from fi_businessCostDetail where bcId = " & bcId
	conn.execute(strSql)
	
	strSql = "delete from fi_businessCost where bcId = " & bcId
	conn.execute(strSql)

	If (Err.Number <> 0) Then
		deleteBusinessCost = False
	Else
		deleteBusinessCost = True
	End If			
End Function

Function  submitCost(ByVal objItem)
	On Error Resume Next
	Dim strSql
	Dim bcId     :  bcId   =   objItem.item("bcId")
	
	strSql = "update fi_businessCost set submitStatus = 2,submitTime = getDate() where bcId = " & bcId
	conn.execute(strSql)
	
	If (Err.Number <> 0) Then
		submitCost = False
	Else
		submitCost = True
	End If		
End Function

Function delCost(ByVal objItem)
	On Error Resume Next
	Dim strSql
	Dim bcId       :  bcId   =  objItem.item("bcId")
	Dim bcdId      :  bcdId  = 	objItem.item("bcdId")
	strSql = "delete from fi_businessCostShare where bcdId = " & bcdId
	conn.execute(strSql)
	
	strSql = "delete from fi_businessCostDetail where bcdId = " & bcdId
	conn.execute(strSql)
	
	strSql = "update fi_businessCost set sumCost = (select isNull(sum(costPrice),0) from fi_businessCostDetail where bcId = " & bcId & "), sumCostRmb = (select isNull(sum(costPrice),0) from fi_businessCostDetail where bcId = " & bcId & ") where bcId = " & bcId
	conn.execute(strSql)
	
	If (Err.Number <> 0) Then
		delCost = False
	Else
		delCost = True
	End If	
End Function

Function delCustomer(ByVal objItem)
	On Error Resume Next
	Dim strSql,rs,shareNum,costOfOne
	Dim bcdId      :  bcdId    =  objItem.item("bcdId")
	Dim bcsId      :  bcsId    =  objItem.item("bcsId")
	Dim costPrice  :  costPrice=  objItem.item("costPrice")
	
	'shareNum = GetRsToString("select shareNum from fi_businessCostShare where bcsId =" & bcsId,"")
	'costOfOne = costPrice/(CINT(shareNum)-1)

	strSql = "delete from fi_businessCostShare where bcsId =" & bcsId
	break(strSql)
	conn.execute(strSql)
	
	shareNum = GetRsToString("select count(*) from fi_businessCostShare where bcdId = " & bcdId,"")
	costOfOne = costPrice/CINT(shareNum)

	strSql = "update fi_businessCostShare set shareNum = " & shareNum & ",costOfOne=" & costOfOne & " where bcdId = " & bcdId
	
	conn.execute(strSql)
	
	If (Err.Number <> 0) Then
		delCustomer = False
	Else
		delCustomer = True
	End If		
End Function

'É¾³ý·ÖÌ¯
Function delCostShare(ByVal objItem)
	On Error Resume Next
	Dim strSql,rs,costOfOne
	Dim bcdId      :  bcdId    =  objItem.item("bcdId")
	Dim bcsId      :  bcsId    =  objItem.item("bcsId")
	Dim costPrice  :  costPrice=  objItem.item("costPrice")

	strSql = "delete from fi_businessCostShare where bcsId =" & bcsId
	conn.execute(strSql)
	
	'shareNum = GetRsToString("select count(*) from fi_businessCostShare where bcdId = " & bcdId,"")
	'costOfOne = costPrice/CINT(shareNum)

	'strSql = "update fi_businessCostShare set costOfOne=" & costOfOne & " where bcdId = " & bcdId &" and bcsId ="&bcsId
	
	'conn.execute(strSql)
	
	If (Err.Number <> 0) Then
		delCostShare = False
	Else
		delCostShare = True
	End If		
End Function


Function setBcCustmoer(ByVal objItem)
	On Error Resume Next
	Dim strSql,rs,i,deptName,empId,costOfOne,shareNum
	Dim bcdId     : bcdId    = objItem.item("bcdId")
	Dim costPrice : costPrice= objItem.item("costPrice")
	Dim eIdStr    : eIdStr = objItem.item("eIdStr")
	Dim eIdArr    : eIdArr = split(eIdStr,",")
	
	'strSql = "delete from fi_businessCostShare where bcdId = " & bcdId
	'conn.execute(strSql)
	
	'costOfOne = costPrice/(ubound(eIdArr)+1)
	For i = 0 To ubound(eIdArr)
		empId     = GetRsToString("select empId from fi_empList where eId = " & eIdArr(i),"")
		deptName  = GetRsToString("select deptName from fi_empList where eId = " & eIdArr(i),"")
		strSql = "insert into fi_businessCostShare values(" & bcdId & ",'" & deptName & "'," & empId & ","& ubound(eIdArr)+1 &",0)"
		conn.execute(strSql)
	Next
	
	shareNum = GetRsToString("select count(*) from fi_businessCostShare where bcdId = " & bcdId,"")
	costOfOne = costPrice/CINT(shareNum)

	strSql = "update fi_businessCostShare set shareNum = " & shareNum & ",costOfOne=" & costOfOne & " where bcdId = " & bcdId
	conn.execute(strSql)	
	
	If (Err.Number <> 0) Then
		setBcCustmoer = False
	Else
		setBcCustmoer = True
	End If	
End Function

Function auditingpassByCost(ByVal objItem)
	On Error Resume Next
	Dim strSql
	Dim bcdIds       :  bcdIds      = objItem.item("bcdIds")
	Dim approvalRole : approvalRole = objItem.item("approvalRole")
	If approvalRole =  1 Then 
		strSql = "update fi_businessCostDetail set maAudiStatus = 2, maAudiTime = getDate(), maAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)
	End If
	If approvalRole = 2 Then 
		strSql = "update fi_businessCostDetail set diAudiStatus = 2, diAudiTime = getDate(), diAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)
	End If 
	If approvalRole = 3 Then 
		strSql = "update fi_businessCostDetail set fiAudiStatus = 2, fiAudiTime = getDate(), fiAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)
	End If
	If approvalRole = 4 Then 
		strSql = "update fi_businessCostDetail set prAudiStatus = 2, prAudiTime = getDate(), prAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)	
	End If 
	If (Err.Number <> 0) Then
		auditingpassByCost = False
	Else
		auditingpassByCost = True
	End If		
	
End Function

Function auditingunpassByCost(ByVal objItem)
	On Error Resume Next
	Dim strSql
	Dim bcdIds       :  bcdIds      = objItem.item("bcdIds")
	Dim approvalRole : approvalRole = objItem.item("approvalRole")
	If approvalRole =  1 Then 
		strSql = "update fi_businessCostDetail set maAudiStatus = 3, maAudiTime = getDate(), maAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)
	End If
	If approvalRole = 2 Then 
		strSql = "update fi_businessCostDetail set diAudiStatus = 3, diAudiTime = getDate(), diAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)
	End If 
	If approvalRole = 3 Then 
		strSql = "update fi_businessCostDetail set fiAudiStatus = 3, fiAudiTime = getDate(), fiAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)
	End If
	If approvalRole = 4 Then 
		strSql = "update fi_businessCostDetail set prAudiStatus = 3, prAudiTime = getDate(), prAudiNote = '"& Session("userName") &"' where bcdId in (" & bcdIds & ")"
		conn.execute(strSql)	
	End If 
	If (Err.Number <> 0) Then
		auditingunpassByCost = False
	Else
		auditingunpassByCost = True
	End If		
End Function

'Ìí¼Ó·ÖÌ¯
Function BusinessCostShareAdd(ByVal objItem)
	Dim i,j, rs, strSql, strSqlDept, strSqlEmp, strEmpDept
	Dim strDeptName, strDeptCode, strEmpName, strEmpCode, strDept
	Dim bcdId			: bcdId    			= GetSafeStr(objItem.item("bcdId"))
	Dim empIds 			: empIds 			= GetSafeStr(objItem.item("strSltEmpId"))
	Dim deptIds			: deptIds			= GetSafeStr(objItem.item("sltDeptId"))
	Dim costOfOnes		: costOfOnes		= GetSafeStr(objItem.item("costOfOne"))
	Dim shareNotes		: shareNotes		= GetSafeStr(objItem.item("shareNote"))

	'strSqlDept = "select * from ts_deptInfo where di_id in ("& deptIds &")"
	'If GetRs(rs, strSqlDept) Then
'		For i = 0 To rs.RecordCount
'			strDeptName = strDeptName&rs("di_name")&","
'			strDeptCode = strDeptCode&rs("deptCode")&","
'			
'			rs.MoveNext
'			If (rs.Bof Or rs.Eof) Then Exit For
'		Next	
'	End If

	strSqlEmp  = "select name,empCode,dept,deptCode from tabZLemp where empId in("& empIds &")"
	If GetRs(rs, strSqlEmp) Then
		For j = 0 To rs.RecordCount
			strEmpName 	= strEmpName&rs("name")&","
			strEmpCode 	= strEmpCode&rs("empCode")&","
			strDept   	= strDept&rs("dept")&","
			strDeptCode= strDeptCode&rs("deptCode")&","
			
			rs.MoveNext
			If (rs.Bof Or rs.Eof) Then Exit For
		Next	
	End If
	Call DestoryRs(rs)	
'outln(strEmpName)
	strDept				= left(strDept,len(strDept)-1)
	strDeptCode			= left(strDeptCode,len(strDeptCode)-1)
	strEmpName			= left(strEmpName,len(strEmpName)-1)
	strEmpCode			= left(strEmpCode,len(strEmpCode)-1)
	
	'If (len(shareNotes)>0) Then
'		shareNotes		= left(shareNotes,len(shareNotes)-1)
'	Else
'		For i = 0 To Ubound(SplitPlus(deptIds,","))
'			shareNotes	=  shareNotes&" "&","
'		Next
'		shareNotes		= left(shareNotes,len(shareNotes)-1)
'	End If

'outln(empIds)
'outln(deptIds)
'outln(costOfOnes)
'outln(shareNotes)
'outln(strDept)
'outln(strDeptCode)
'outln(strEmpName)
'outln(strEmpCode)
'break(arrShareNote)
	
	Dim arrDeptId 		: arrDeptId 		= SplitPlus(deptIds,",")
	Dim arrDeptCode 	: arrDeptCode 		= SplitPlus(strDeptCode,",")
	Dim arrDeptName 	: arrDeptName 		= SplitPlus(strDept,",")
	Dim arrSltEmpId 	: arrSltEmpId 		= SplitPlus(empIds,",")
	Dim arrEmpCode 		: arrEmpCode 		= SplitPlus(strEmpCode,",")
	Dim arrEmpName 		: arrEmpName 		= SplitPlus(strEmpName,",")
	Dim arrCostOfOne 	: arrCostOfOne 		= SplitPlus(costOfOnes,",")
	Dim arrShareNote 	: arrShareNote 		= SplitPlus(shareNotes,",")
	
'outln(ubound(arrDeptId))
'outln(ubound(arrDeptCode))
'outln(ubound(arrDeptName))
'outln(ubound(arrSltEmpId))
'outln(ubound(arrEmpCode))
'outln(ubound(arrEmpName))
'outln(ubound(arrCostOfOne))
'outln(ubound(arrShareNote))
'break(arrShareNote)

	Dim currentPrice : currentPrice = GetRsToString("select isNull(sum(costOfOne),0) from fi_businessCostShare where bcdId = "&bcdId,"0")
	Dim sumPrice	 : sumPrice		= GetRsToString("select isNull(costPrice,0) from fi_businessCostDetail where bcdId = "&bcdId,"0")

	If (CDBL(sumPrice - currentPrice) >= 0) Then
		For i = 0 To ubound(arrCostOfOne)
		strSql = " insert into fi_businessCostShare(bcdId, deptId, deptCode, deptName, empId, empCode, empName, costOfOne, shareNote) "&_
					 " values ("& bcdId &","& arrDeptId(i) &",'"& arrDeptCode(i) &"','"& arrDeptName(i) &"',"& arrSltEmpId(i) &","&_
					 " '"& arrEmpCode(i) &"','"& arrEmpName(i) &"',"& arrCostOfOne(i) &",'"& arrShareNote(i) &"')"
					'break(strSql)
			conn.execute(strSql)
		Next
	End If
	
	If (Err.Number <> 0) Then
		BusinessCostShareAdd = False
	Else
		BusinessCostShareAdd = True
	End If	
End Function
%>





