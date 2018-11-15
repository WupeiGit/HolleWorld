<%
'--------------添加航段
Function FlightMlgAdd(ByVal objItem)
	Dim strSql, i, objStrSTime, objStrETime
	Dim pg_fltNo, pg_dayNum, pg_sPoint, pg_sTime, pg_sHour, pg_sMin, pg_sSend, pg_ePoint, pg_eTime, pg_eHour, pg_eMin, pg_eSecd, pg_isNight
	Dim pg_departAirport, pg_arriveCode, pg_airfares, pg_planeTypes, pg_departTerminal, pg_arriveTerminal
		
		pg_fltNo			=	SplitPlus(objItem.item("fltNo"),",")
		pg_dayNum			=	SplitPlus(objItem.item("dayNum"),",")
		pg_sPoint			=	SplitPlus(objItem.item("sPoint"),",")
		pg_sTime			=	SplitPlus(objItem.item("sTime"),",")
		pg_sHour			=	SplitPlus(objItem.item("sHour"),",")
		pg_sMin				=	SplitPlus(objItem.item("sMin"),",")
		pg_sSend			=	SplitPlus(objItem.item("sSecd"),",")
		pg_ePoint			=	SplitPlus(objItem.item("ePoint"),",")
		pg_eTime			=	SplitPlus(objItem.item("eTime"),",")
		pg_eHour			=	SplitPlus(objItem.item("eHour"),",")
		pg_eMin				=	SplitPlus(objItem.item("eMin"),",")
		pg_eSecd			=	SplitPlus(objItem.item("eSecd"),",")
		pg_isNight			=	SplitPlus(objItem.item("isNight"),",")
		pg_airlineCn		=	SplitPlus(objItem.item("airlineCn"),",")
		pg_airlineEn		=	SplitPlus(objItem.item("airlineEn"),",")
		pg_departAirport	=	SplitPlus(objItem.item("departAirport"),",")
		pg_departCode		=	SplitPlus(objItem.item("departCode"),",")
		pg_arriveAirport	=	SplitPlus(objItem.item("arriveAirport"),",")
		pg_arriveCode		=	SplitPlus(objItem.item("arriveCode"),",")
		pg_airfares			=	SplitPlus(objItem.item("airfares"),",")
		pg_planeTypes		=	SplitPlus(objItem.item("planeTypes"),",")
		pg_departTerminal	=	SplitPlus(objItem.item("departTerminal"),",")
		pg_arriveTerminal	=	SplitPlus(objItem.item("arriveTerminal"),",")
		
	'循环添加到数据库
	For i=0 To UBound(pg_fltNo)
		objStrSTime = pg_sTime(i)&" "&pg_sHour(i)&":"&pg_sMin(i)&":"&pg_sSend(i)
		objStrETime = pg_eTime(i)&" "&pg_eHour(i)&":"&pg_eMin(i)&":"&pg_eSecd(i)
		
		strSql= " insert into ba_flightMileage "&_
				" ( flightId, dayNum, flightNo, airlineCn, airlineEn, airfares, planeTypes, 	"&_
				" 	startPoint, departureAirport, departureCode, departureTerminal, startTime, 	"&_
				" 	endPoint, arriveAirport, arriveCode, arriveTerminal, endTime, isNight )		"&_
				" values "&_
				" ("& objItem.item("fltId") &", '"& pg_dayNum(i) &"', '"& pg_fltNo(i) &"', '"& pg_airlineCn(i) &"', '"& pg_airlineEn(i) &"', '"& pg_airfares(i) &"', '"& pg_planeTypes(i) &"',"&_
				" '"& pg_sPoint(i) &"', '"&	pg_departAirport(i) &"', '"& pg_departCode(i) &"', '"& pg_departTerminal(i) &"', '"& objStrSTime &"', 								 "&_
				" '"& pg_ePoint(i) &"', '"& pg_arriveAirport(i) &"', '"& pg_arriveCode(i) &"', '"& pg_arriveTerminal(i) &"', '"& objStrETime &"', '"& pg_isNight(i) &"')"
		'break(strSql)
		conn.execute(strSql)
	Next
	
	If (Err.Number <> 0) Then
		Err.clear()
		FlightMlgAdd = False
	Else
		FlightMlgAdd = True
	End If    
End Function

'--------------修改航段
Function fltMileageUpdate(ByVal fmId, ByVal fltId, ByVal fltNo, ByVal dayNum, ByVal sPoint, ByVal sTime, ByVal sHour, ByVal sMin, ByVal sSecd, ByVal ePoint, ByVal eTime, ByVal eHour, ByVal eMin, ByVal eSecd, ByVal isNight)
	Dim strSql, objStrSTime, objStrETime 
		objStrSTime = sTime&" "& sHour &":"& sMin &":"&sSecd
		objStrETime = eTime&" "& eHour &":"& eMin &":"&eSecd
		
		strSql= " 	update ba_flightMileage"&_
				"	set "&_
				"	flightNo='"& fltNo &"', dayNum='"& dayNum &"',startPoint='"& sPoint &"',"&_
				"	startTime='"& objStrSTime &"',endPoint= '"& ePoint &"', endTime='"& objStrETime &"' , isNight='"& isNight &"'"&_
				"	where fmId="& fmId &" and flightId='"& fltId &"'"
		
	conn.execute(strSql)
	
	If (Err.Number <> 0) Then
		Err.clear()
		fltMileageUpdate = False
	Else
		fltMileageUpdate = True
	End If    
End Function

'--------------删除航段
Function fltMileageDel(ByVal fmId, ByVal fltId)
	Dim strSql
		strSql = "delete ba_flightMileage where flightId = "& fltId &" and fmId ="& fmId 
	
	conn.execute(strSql)
		
	If (Err.Number <> 0) Then
		fltMileageDel = False
	Else
		fltMileageDel = True
	End If
End Function

'------获取显示选中航空公司名称
Function ToShowSltFltTtemDesc(ByVal objCode)
	Dim strSql, rs, strValues
		strSql = " select itemDesc from ts_items with(nolock) where 1=1 and itemName = '"& objCode &"' order by asc"
	If GetRs(rs, strSql) Then
		strValues = rs("itemDesc")
	End If
	Call DestoryRs(rs)
	ToShowSltFltTtemDesc = strValues
End Function

'------------------------------------------
'	根据航班号获取当前航空公司名称02-25
'------------------------------------------
Function ToGetAirLineName(ByVal objAirCode)
	Dim strSql, rs
		strSql = " select cnName, shortName from ts_air where shortName = '"& objAirCode &"'"
	
	If GetRs(rs,strSql) Then
		Dim pg_airCnName	: pg_airCnName	= rs("cnName")
		Dim pg_airEnName	: pg_airEnName	= rs("shortName")	
	End If
	Call DestoryRs(rs)
	
	If (Err.Number <> 0) Then
		ToGetAirLineName = 0
	Else
		ToGetAirLineName = pg_airEnName&","&pg_airCnName
	End If	
End Function
%>