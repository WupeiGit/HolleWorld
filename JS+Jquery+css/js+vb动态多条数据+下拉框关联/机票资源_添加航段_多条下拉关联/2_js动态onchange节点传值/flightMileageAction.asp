<!--#include virtual="/conn/conn.asp" -->
<!--#include virtual="/inc/base.asp" -->
<!--#include virtual="/inc/function.asp" -->
<!--#include virtual="/inc/pages.asp" -->
<!--#include virtual="/inc/winMessage.asp" -->
<!--#include virtual="/inc/fso.asp" -->
<!--#include virtual="/inc/class/Tags.asp" -->
<!--#include virtual="/inc/object/ADOObjects.asp" -->
<!--#include virtual="/inc/dao/flightMileageDAO.asp" -->

<%
Dim fmId, fltId, fltNo, dayNum, sPoint, sTime, sHour, sMin, sSecd, ePoint, eTime, eHour, eMin,  eSecd, isNight
Dim departureAirport, departureCode, arriveAirport, arriveCode, airfares, planeTypes, terminal
Dim fltMlgAdd	:	fltMlgAdd	=	"/admin/flight/flightMelieageAdd.asp"
Dim flightList	:	flightList	=	"/admin/flight/flightList.asp"
Dim fltMlgList	:	fltMlgList	=	"/admin/flight/flightMileageList.asp"

Select Case GetSafeStr(Request.QueryString("action"))

	'���ӻ�Ʊ����
	Case "createFlgMlgAdd"
		Dim strFltNo, strDayNum, strSPoint, strSTime, strSHour, strSMin, strSSecd, strEPoint, strETime, strEHour, strEMin, strESecd, strIsNight, strAirlineEn
		Dim strAirlineCn, strDepartAirport, strDepartCode, strArriveAirport, strArriveCode, strAirfares, strPlaneTypes, strDepartTerminal, strArriveTerminal
		Dim addNum : addNum	= GetSafeStr(Request("addNum"))
		
		fltId				= GetSafeStr(Request("flightId"))
		strFltNo			= GetSafeStr(Request("flightNo"))
		strDayNum			= GetSafeStr(Request("dayNum"))
		strSPoint			= GetSafeStr(Request("startPoint"))
		strSTime			= GetSafeStr(Request("startTime"))
		strSHour			= GetSafeStr(Request("leaveOnHour"))
		strSMin				= GetSafeStr(Request("leaveOnMinute"))
		strSSecd			= GetSafeStr(Request("leaveOnSecond"))
		strEPoint			= GetSafeStr(Request("endPoint"))
		strETime			= GetSafeStr(Request("leaveTime"))
		strEHour			= GetSafeStr(Request("returnOnHour"))
		strEMin				= GetSafeStr(Request("returnOnMinute"))
		strESecd			= GetSafeStr(Request("returnOnSecond"))
		strIsNight			= GetSafeStr(Request("sltNight"))
		strAirlineEn		= GetSafeStr(Request("airlineEn"))
		strAirlineCn		= GetSafeStr(Request("airlineCn"))
		strDepartAirport	= GetSafeStr(Request("departureAirport"))
		strDepartCode		= GetSafeStr(Request("departureCode"))
		strArriveAirport	= GetSafeStr(Request("arriveAirport"))	
		strArriveCode		= GetSafeStr(Request("arriveCode"))	
		strAirfares			= GetSafeStr(Request("airfares"))
		strPlaneTypes		= GetSafeStr(Request("planeTypes"))	
		strDepartTerminal	= GetSafeStr(Request("departureTerminal"))	
		strArriveTerminal	= GetSafeStr(Request("arriveTerminal"))

		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "fltId",				fltId
			.add "fltNo",				right(strFltNo,len(strFltNo)-1)
			.add "dayNum",				right(strDayNum,len(strDayNum)-1)
			.add "sPoint",				right(strSPoint,len(strSPoint)-1)
			.add "sTime",				right(strSTime,len(strSTime)-1)
			.add "sHour",				right(strSHour,len(strSHour)-1)
			.add "sMin",				right(strSMin,len(strSMin)-1)
			.add "sSecd",				right(strSSecd,len(strSSecd)-1)
			.add "ePoint",				right(strEPoint,len(strEPoint)-1)
			.add "eTime",				right(strETime,len(strETime)-1)
			.add "eHour",				right(strEHour,len(strEHour)-1)
			.add "eMin",				right(strEMin,len(strEMin)-1)
			.add "eSecd",				right(strESecd,len(strESecd)-1)
			.add "isNight",				right(strIsNight,len(strIsNight)-2)
			.add "airlineEn",			right(strAirlineEn,len(strAirlineEn)-1)
			.add "airlineCn",			right(strAirlineCn,len(strAirlineCn)-1)
			.add "departCode",			right(strDepartCode,len(strDepartCode)-1)
			.add "arriveCode",			right(strArriveCode,len(strArriveCode)-1)
			.add "departAirport",		right(strDepartAirport,len(strDepartAirport)-1)
			.add "arriveAirport",		right(strArriveAirport,len(strArriveAirport)-1)
			.add "airfares",			right(strAirfares,len(strAirfares)-1)
			.add "planeTypes",			right(strPlaneTypes,len(strPlaneTypes)-1)
			.add "departTerminal",		right(strDepartTerminal,len(strDepartTerminal)-1)
			.add "arriveTerminal",		right(strArriveTerminal,len(strArriveTerminal)-1)
		End With
		
		If FlightMlgAdd(objItem) Then
			Call WinSuccess("��ӳɹ���", fltMlgList&"?flightId="& GetSafeStr(Request("flightId")) &"",	3)
		Else
			Call WinError("���ʧ�ܣ�", fltMlgAdd,	3)
		End If
		
	'�޸Ļ�Ʊ����
	Case "fltMileageUpdate"
		fmId	=	GetSafeStr(Request("hidFmId"))	
	    fltId	=	GetSafeStr(Request("hidFltId"))
	    fltNo	=	GetSafeStr(Request("flightNo"))
		dayNum	=	GetSafeStr(Request("dayNum"))
		sPoint	=	GetSafeStr(Request("startPoint"))
		sTime   = 	GetSafeStr(Request("startTime"))
		sHour	=	GetSafeStr(Request("leaveOnHour"))
		sMin	=	GetSafeStr(Request("leaveOnMinute"))
		sSecd	=	GetSafeStr(Request("leaveOnSecond"))
		ePoint	=	GetSafeStr(Request("endPoint"))
		eTime	=	GetSafeStr(Request("leaveTime"))
		eHour	=	GetSafeStr(Request("returnOnHour"))
		eMin	=	GetSafeStr(Request("returnOnMinute"))
		eSecd	=	GetSafeStr(Request("returnOnSecond"))
		isNight	=	GetSafeStr(Request("sltNight"))

        If (fmId<>"" and fltId<>"" and fltNo<>"") Then
			If fltMileageUpdate(fmId, fltId, fltNo, dayNum, sPoint, sTime, sHour, sMin, sSecd, ePoint, eTime, eHour, eMin, eSecd, isNight) Then
				 Call WindowMessage("success","�޸ĳɹ�", fltMlgList&"?flightId="& fltId &"",3,"","","")
			Else
				 Call WindowMessage("error","�޸Ĳ���ʧ�ܣ�", fltMlgList&"?flightId="& fltId,3,"","","")
			End If
	    Else
		         Call WindowMessage("error","��ȡ���ʧ�ܣ���ʱ�����޸ģ�", fltMlgList&"?flightId="& fltId,3,"","","")
		End If
	
	'ɾ����Ʊ����
	Case "fltMileageDelete"
		If fltMileageDel(GetSafeStr(Request("fmId")), GetSafeStr(Request("flightId"))) Then
			Call WindowMessage("success","ɾ���ɹ���", fltMlgList&"?flightId="& GetSafeStr(Request("flightId")),3,"","","")
		Else
			Call WindowMessage("error","ɾ��ʧ�ܣ�", fltMlgList&"?flightId="& GetSafeStr(Request("flightId")),3,"","","")
		End If
			
	'��ѯ������������
	Case "toShowSltDepartAirport"
		Break(ToShowSltFltTtemDesc(GetSafeStr(Request("departCode"))))
		
	'��ѯ������������
	Case "toShowSltArriveAirport"
		Break(ToShowSltFltTtemDesc(GetSafeStr(Request("arriveCode"))))
		
	'���ݺ���Ż�ȡ��ǰ���չ�˾����/Ӣ������
	Case "toGetAirLineName"
		Break(ToGetAirLineName(GetSafeStr(Request("strAirCode"))))	
	
		
	Case "toSltDepartureCode"
		Break(ToSltDepartureCode(GetSafeStr(Request("strNum"))))
		
	Case "toSltArriveCode"
		Break(ToSltArriveCode(GetSafeStr(Request("strNum"))))
		
End Select

Function TimeDiff(ByVal sTime, ByVal eTime)
	Dim countTimeSecd, countDay, countHour, countMinut, countSecond
		countTimeSecd 	= DateDiff("s",sTime,eTime)
	
		countDay	 	= Int(countTimeSecd/86400)
		countHour		= Int((countTimeSecd - countDay * 86400)/3600)
		
	If countHour < 10 Then
		countHour = 0&countHour
	End If
	
		countMinut		= Int(countTimeSecd/60)	Mod 60 
	If countMinut < 10 Then
		countMinut = 0&countMinut
	End If
		countSecond		= countTimeSecd Mod 60 
	
	If countDay >0 Then
		TimeDiff = countDay&" �� "&countHour&" ʱ "&countMinut&" �� "
	Else
		TimeDiff = countHour&" ʱ "&countMinut&" �� "
	End If
End Function 

'��ѯ����������
Function CreateSltFltItemName(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
		strSql = " select itemName, itemName from ts_items item with(nolock) where 1=1 and item.tmID = 11 and item.pID = 639 and item.isEnable = 1 order by iID "
	CreateSltFltItemName = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function

'����
Function ToSltDepartureCode(ByVal objStrNum)
	ToSltDepartureCode = CreateSltFltItemName("departureCode"&objStrNum,"-��������������-",sltDepartCode,"onchange","FltMlg.getCheckedTrNum("& objStrNum &");FltMlg.toShowDepartAirport(this[this.selectedIndex].value);")
End Function

'����
Function ToSltArriveCode(ByVal objStrNum)
	ToSltArriveCode = CreateSltFltItemName("arriveCode"&objStrNum,"-�������������-",sltArriveCode,"onchange","FltMlg.getCheckedTrNum("& objStrNum &");FltMlg.toShowArriveCode(this[this.selectedIndex].value);")
End Function

'--------------------------------------
'	��Ʊ���κ�վ¥ѡ��2014-02-25
'--------------------------------------
Function CreateSltFltMileageByTerminal(ByVal element,ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("-��ѡ��-","T1","T2","T3","T4","T5")
	Dim arrValue : arrValue = Array("","T1","T2","T3","T4","T5")
	CreateSltFltMileageByTerminal = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function
%>
