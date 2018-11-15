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
Dim fmId, fltId, fltNo, dayNum,sPoint, sTime, sHour, sMin, sSecd, ePoint, eTime, eHour, eMin,  eSecd, isNight
Dim departureAirport, departureCode, arriveAirport, arriveCode, airfares, planeTypes, terminal
Dim fltMlgAdd	:	fltMlgAdd	=	"/admin/flight/flightMelieageAdd.asp"
Dim flightList	:	flightList	=	"/admin/flight/flightList.asp"
Dim fltMlgList	:	fltMlgList	=	"/admin/flight/flightMileageList.asp"

Select Case GetSafeStr(Request.QueryString("action"))

	'���ӻ�Ʊ����
	Case "createFlgMlgAdd"
		'��ȡflightMileageAddҳ����������ֵ��flightMileageList.asp�д��Ĳ���
		Set objItem = CreateObject("Scripting.Dictionary")
		With objItem
			.add "fltId"				=	GetSafeStr(Request("flightId"))		
			.add "fltNo"				=	GetSafeStr(Request("flightNo"))
			.add "dayNum"				=	GetSafeStr(Request("dayNum"))
			.add "sPoint"				=	GetSafeStr(Request("startPoint"))
			.add "sTime"				=	GetSafeStr(Request("startTime"))
			.add "sHour"				=	GetSafeStr(Request("leaveOnHour"))
			.add "sMin"					=	GetSafeStr(Request("leaveOnMinute"))
			.add "sSecd"				=	GetSafeStr(Request("leaveOnSecond"))
			.add "ePoint"				=	GetSafeStr(Request("endPoint"))
			.add "eTime"				=	GetSafeStr(Request("leaveTime"))
			.add "eHour"				=	GetSafeStr(Request("returnOnHour"))
			.add "eMin"					=	GetSafeStr(Request("returnOnMinute"))
			.add "eSecd"				=	GetSafeStr(Request("returnOnSecond"))
			.add "isNight"				=	GetSafeStr(Request("sltNight"))
			.add "departAirport"		=	GetSafeStr(Request("departureAirport"))
			.add "departCode"			=	GetSafeStr(Request("departureCode"))
			.add "arriveAirport"		=	GetSafeStr(Request("arriveAirport"))
			.add "arriveCode"			=	GetSafeStr(Request("arriveCode"))
			.add "airfares"				=	GetSafeStr(Request("airfares"))
			.add "planeTypes"			=	GetSafeStr(Request("planeTypes"))
			.add "terminal"				=	GetSafeStr(Request("terminal"))
		End With
		
		If FlightMlgAdd(objItem) Then
			Call WinSuccess("��ӳɹ���", fltMlgList&"?flightId="& fltId &"",	3)
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
%>
