<%
'-----------------------------------------------------------
'
'	���������б�
'	Create Common SelectList
'
'-----------------------------------------------------------
'	��ȡϵͳ�б�
'-----------------------------------------------------------
Function GetSysList(ByVal tsType, ByVal tsItem, ByVal listID, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Call isNoValue(listID, "listDefault")
	Call isNoValue(selectedItem, "")
	Call isNoValue(exceptItem, 0)
	Call isNoValue(eventType, "")
	Call isNoValue(eventMethod, "")
	GetSysList = GetXMLSelectItem("ts_items with(nolock) where tmID =(select tmID from ts_typeManage with(nolock) where typeName ='"& tsType &"') And pID in (select iID from ts_items with(nolock) where itemName = '"& tsItem &"' and isEnable = 1)  and isEnable = 1 ","iID","itemName",listID,selectedItem,exceptItem,eventType,eventMethod)
End Function


Function GetSysListByItemName(ByVal tsType, ByVal tsItem, ByVal listID, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Call isNoValue(listID, "listDefault")
	Call isNoValue(selectedItem, "")
	Call isNoValue(exceptItem, 0)
	Call isNoValue(eventType, "")
	Call isNoValue(eventMethod, "")
	GetSysListByItemName = GetXMLSelectItem("ts_items with(nolock) where tmID = (select tmID from ts_typeManage with(nolock) where typeName ='"& tsType &"') And pID in (select iID from ts_items with(nolock) where itemName ='"& tsItem &"' and isEnable = 1)  and isEnable = 1 ","itemName","itemName",listID,selectedItem,exceptItem,eventType,eventMethod)
End Function


Function GetSysListByItemNameByNotGuide(ByVal tsType, ByVal tsItem, ByVal listID, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Call isNoValue(listID, "listDefault")
	Call isNoValue(selectedItem, "")
	Call isNoValue(exceptItem, 0)
	Call isNoValue(eventType, "")
	Call isNoValue(eventMethod, "")
	GetSysListByItemNameByNotGuide = GetXMLSelectItem("ts_items with(nolock) where tmID = (select tmID from ts_typeManage with(nolock) where typeName ='"& tsType &"') And pID in (select iID from ts_items with(nolock) where itemName ='"& tsItem &"' and isEnable = 1)  and isEnable = 1 and itemName not in (select tableValue from dbo.getAirString(1)) ","itemName","itemName",listID,selectedItem,exceptItem,eventType,eventMethod)
End Function

Function GetSysListComboBox(ByVal tsType, ByVal tsItem, ByVal strDefault, ByVal strTextBoxId, ByVal strTextBoxName, ByVal iEventHandle)
	Dim strSql : strSql = " select itemName,itemName from ts_items with(nolock) where tmID = (select tmID from ts_typeManage with(nolock) where typeName ='"& tsType &"') And pID in (select iID from ts_items with(nolock) where itemName = '"& tsItem &"' and isEnable = 1) "
	GetSysListComboBox = CreateComboBoxTag(strDefault,strTextBoxId,strTextBoxName,strSql,20,120,iEventHandle)
End Function


Function CreateSysSltByName(ByVal tsType, ByVal tsItem, ByVal elementName, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select itemName, itemName from ts_items with(nolock) "&_
			 " where tmID =(select tmID from ts_typeManage with(nolock) where typeName = '"& tsType &"') "&_
			 " And pID in (select iID from ts_items with(nolock) where itemName = '"& tsItem &"') "&_
			 " and isEnable = 1 "
	CreateSysSltByName = CreateSelectPlus(conn, strSql, "", elementName, "ѡ����Ŀ", selectedItem, eventType, eventMethod)
End Function

'Ԥ���Ŀ�б�
Function GetBudgetDataList(ByVal tsType, ByVal tsItem, ByVal listID, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Call isNoValue(listID, "listDefault")
	Call isNoValue(selectedItem, "")
	Call isNoValue(exceptItem, 0)
	Call isNoValue(eventType, "")
	Call isNoValue(eventMethod, "")
	GetBudgetDataList = GetXMLSelectItem("ts_items with(nolock) where tmID =(select tmID from ts_typeManage with(nolock) where typeName ='"& tsType &"') And pID in (select iID from ts_items with(nolock) where itemName = '"& tsItem &"' and isEnable = 1)  and isEnable = 1 ","itemDesc","itemName",listID,selectedItem,exceptItem,eventType,eventMethod)
End Function


'���ʽ
Function CreateSltPayType(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	CreateSltPayType = GetSysListByItemName(ts_TypeSys, ts_itemPayType, elementName, selectedValue, "Ԥ��ת��", eventType, eventMethod)
End Function

Function CreateSltPayTypePlus(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct itemName, itemName from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = '"& ts_TypeSys &"') "&_
						  " and pID in (select iID from ts_items with(nolock) where itemName = '"& ts_itemPayType &"') "&_
						  " and isEnable = 1 "
	CreateSltPayTypePlus = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'�ź��б�
Function CreateSltByTeamCode(ByVal codeType, ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select iId, itemName = (itemName +': '+ itemDesc) "&_
			 " from ts_items with(nolock) "&_
			 " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
			 " 		and pid = (select iId from ts_items with(nolock) where itemName = '"& codeType &"') "
	CreateSltByTeamCode = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function

'�ź��б�
Function CreateSltByTeamCodeName(ByVal codeType, ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select itemName, itemName = (itemName +': '+ itemDesc) "&_
			 " from ts_items with(nolock) "&_
			 " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
			 " 		and pid = (select iId from ts_items with(nolock) where itemName = '"& codeType &"') "
	CreateSltByTeamCodeName = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function

'-----------------------------------------------------------
'	��ȡԱ���б�
'-----------------------------------------------------------
Function GetEmpList(ByVal selectID,ByVal selectedValue,ByVal dept,ByVal diqu)
	Dim strSql, data
	If (dept <> "") Then dept = "dept ='"& dept &"' and "
	If (diqu = "")  Then diqu = "������"
	strSql = "tabZLemp with(nolock) where "& dept &" diqu ='"& diqu &"' order by [name]"
	data = GetXMLSelectItem(strSql,"empid","[name]",selectID,selectedValue,-1,"","")
	If (data = -1) Then
		getEmpList = "������."
	Else
		getEmpList = data
	End If
End Function


'-----------------------------------------------------------
'	������CreateSltByDeptAndEmp()
'	˵������װ CreateSelectListByCommonByGroup()
'	������
'		frmSelectName			��
'		selectedItem			ѡ����
'		defaultOptionText		Ĭ����
'		cssStyle				��ʽ����
'	���أ�HTMLDocumentElement
'-----------------------------------------------------------
Function CreateSltByDeptAndEmp(ByVal frmSelectName, ByVal selectedItem, ByVal defaultOptionText, ByVal cssStyle)
	Dim relationFieldIndex
	Dim groupSql   : groupSql   = " select di_id, di_name from ts_deptInfo with(nolock) order by di_name"
	Dim subItemSql : subItemSql = " select di_id, emp.empid, emp.name from tabZLemp emp with(nolock) "&_
								  " inner join tabSetPurview sp with(nolock) on emp.empid = sp.empid "&_
								  " where emp.isEnable != '0' And isNull(yuancheng,'0') != '1' And isNull(user_Login,'0') != '0' "&_
								  " order by emp.name "
	Call isNoValue(frmSelectName, "frmEmplist")
	Call isNoValue(cssStyle, "select_style01")
	Call isNoValue(selectedItem, "")
	CreateSltByDeptAndEmp = CreateSelectListByCommonByGroup(groupSql, subItemSql, relationFieldIndex, frmSelectName, selectedItem, defaultOptionText, cssStyle)
End Function

Function CreateSltByDeptByItmeID(ByVal frmSelectName, ByVal selectedItem, ByVal defaultOptionText, ByVal cssStyle)
	Dim relationFieldIndex
	Dim groupSql   : groupSql   = " select s_id, s_name from ts_structure with(nolock) order by s_id "
	Dim subItemSql : subItemSql = " select s_id, di_id, di_name from ts_deptInfo with(nolock) order by di_name "
	Call isNoValue(frmSelectName, "frmEmplist")
	Call isNoValue(cssStyle, "select_style01")
	Call isNoValue(selectedItem, "")
	CreateSltByDeptByItmeID = CreateSelectListByCommonByGroup(groupSql, subItemSql, relationFieldIndex, frmSelectName, selectedItem, defaultOptionText, cssStyle)
End Function

Function CreateSltByDeptByItmeName(ByVal frmSelectName, ByVal selectedItem, ByVal defaultOptionText, ByVal cssStyle)
	Dim relationFieldIndex
	Dim groupSql   : groupSql   = " select s_id, s_name from ts_structure with(nolock) order by s_id "
	Dim subItemSql : subItemSql = " select distinct s_id, di_name, di_name from ts_deptInfo with(nolock) order by di_name "
	Call isNoValue(frmSelectName, "frmEmplist")
	Call isNoValue(cssStyle, "select_style01")
	Call isNoValue(selectedItem, "")
	CreateSltByDeptByItmeName = CreateSelectListByCommonByGroup(groupSql, subItemSql, relationFieldIndex, frmSelectName, selectedItem, defaultOptionText, cssStyle)
End Function


'-----------------------------------------------------------
' ����CreateSltAboutCompStructure���������ڹ�˾��֯�ṹ select �����б��
' ������objCon				�����ݿ����Ӷ���(��������)
'		sltId				��id
'		sltName				��name
'		strFirstItem		����ѡ��
'		strSelectedItem		����ѡ����
'		isSltGrp			������������Ƿ��ѡ(True����ѡ��False������ѡ)
'		eventType			���¼�����
'		eventHandle			���¼�����
' ����ֵ��select �����б��
'-----------------------------------------------------------
Function CreateSltAboutCompStructure(ByRef objCon,ByVal sltId,ByVal sltName,ByVal strFirstItem,ByVal strSelectedItem,ByVal isSltGrp,ByVal eventType,ByVal eventHandle)
	Dim objTag,objSelect,objOption,objOptGup
	Dim strSql,strSign
	Dim objRs
	Dim arr1,arr2,arr3
	Dim i,j
	Dim strSelectedText : strSelectedText = "selected"
	
	Set objTag = Server.CreateObject("MSXML2.DOMDocument")
	Set objSelect = objTag.CreateElement("select")
	If IsNull(strSelectedItem) Then strSelectedItem = ""

	'�����¼���eventTypeΪ�¼�����(onClick,onChange);eventMehtodΪ���õķ���
	If (eventType <> "" And eventHandle <> "") Then objSelect.Attributes.SetNamedItem(objTag.CreateNode(2,eventType,"")).Text = eventHandle
	objSelect.Attributes.SetNamedItem(objTag.CreateNode(2,"name","")).Text = sltName
	objSelect.Attributes.SetNamedItem(objTag.CreateNode(2,"id","")).Text = sltId
	
	'���� option ��ѡ��
	If (strFirstItem <> "") Then
		Call CreateOption(objTag,objOption,"option",strSelectedItem,"",strFirstItem)
		objSelect.AppendChild(objOption)
	End If
	
	'���
	On Error Resume Next
	strSql = "select di_id,di_name from ts_deptInfo with(nolock) where di_pid = 0 And isNull(di_isCancel,0) != 1 order by di_name asc"
	If GetRs(objRs,strSql) Then
		arr1 = objRs.GetRows(-1) : objRs.Close()
	End If
	
	'����������
	For i = 0 To UBound(arr1,2)
		strSql = "select di_id,di_name,di_pid from ts_deptInfo with(nolock) where di_pid = "&arr1(0,i)&" order by di_name asc"
		If GetRs(objRs,strSql) Then
			arr2 = objRs.GetRows(-1) : objRs.Close()
		End If
		
		' ���з���
		If IsArray(arr2) Then
			If isSltGrp = True Then		' ������Ա�ѡ��
				Call CreateOption(objTag,objOption,"option",strSelectedItem,arr1(0,i),arr1(1,i))
				objSelect.AppendChild(objOption)
			Else						' ���鲻�ܱ�ѡ��
				Call CreateOption(objTag,objOptGup,"optgroup",strSelectedItem,arr1(1,i),"")
			End If
			
			strSign = "��"
			
			For j = 0 To UBound(arr2,2)
				If j = UBound(arr2,2) Then strSign = "��"
				Call CreateOption(objTag,objOption,"option",strSelectedItem,arr2(0,j),strSign&arr2(1,j))
				If isSltGrp = True Then
					objSelect.AppendChild(objOption)
				Else
					objOptGup.AppendChild(objOption)
					objSelect.AppendChild(objOptGup)
				End If
			Next
		Else
			Call CreateOption(objTag,objOption,"option",strSelectedItem,arr1(0,i),arr1(1,i))
			objSelect.AppendChild(objOption)
			
		End If
		Set arr2 = Nothing
	Next
	
	objTag.AppendChild(objSelect)
	
	If (objSelect.ChildNodes.Length > 0) Then
		CreateSltAboutCompStructure = objTag.DocumentElement.XML
	Else
		CreateSltAboutCompStructure = -1	'δ������
	End If
	
	If Err.Number <> 0 Then
		Err.Clear
		CreateSltAboutCompStructure = "����ʧ��"
		Exit Function
	End If
	
	Set objOptGup = Nothing
	Set objOption = Nothing
	Set objSelect = Nothing
	Set objTag = Nothing
	Set objRs = Nothing
End Function


'��˾��֧�б�
'Function CreateSltStructure(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim strSql
'	strSql = " select s_id, s_name from ts_structure with(nolock) where isEnable = 1 order by s_name "
'	CreateSltStructure = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
'End Function

Function CreateSltStructure(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrValue : arrValue = Array("�����ܲ�","�ɶ��ֹ�˾","�Ϻ��ֹ�˾","�Ϻ�����","�����ֹ�˾","�人�ֹ�˾","�����ֹ�˾","�������ֹ�˾","�����ֹ�˾","���ݷֹ�˾","����ܲ�","�����ҵ���")
	Dim arrBody  : arrBody  = Array(1,5,3,14,9,7,10,11,12,16,13,17)
	CreateSltStructure = CreateSelectListByEasyByArrayPlus(arrValue,arrBody,elementName,selectedItem,"",firstItem,"",eventType,eventMethod)
End Function


'���ɲ����б�
Function CreateCBDepartmentList(ByVal elementName, ByVal selectedItems, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct di_id, "&_
	                      " deptName = (case when len(deptCode) = 3  then '' "&_
						  "                  when len(deptCode) = 6  then '��' "&_
						  "                  when len(deptCode) = 9  then '����' "&_
						  "                  when len(deptCode) = 13 then '������' end) + di_name, "&_
						  " deptCode "&_
						  " from ts_deptInfo with(nolock) "&_
						  " where di_iscancel <> 1 "
	strSql = strSql & " order by deptCode "
	CreateCBDepartmentList = CreateCheckBoxList(conn,strSql,elementName,selectedItems,"",1,eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	����������·��б�
'---------------------------------------------------------------------------
'������������б�
Function CreateSltByYear(ByVal frmSelectName,ByVal selectedItem,ByVal cssStyle,ByVal style,ByVal styleValue)
	CreateSltByYear = CreateSltByYearPlus(frmSelectName,selectedItem,"",cssStyle,style,styleValue)
End Function


'������������б�
Function CreateSltByMonth(ByVal frmSelectName,ByVal selectedItem,ByVal cssStyle,ByVal style,ByVal styleValue)
	CreateSltByMonth = CreateSltByMonthPlus(frmSelectName,selectedItem,"",cssStyle,style,styleValue)
End Function


'������������б�
Function CreateSltByYearPlus(ByVal frmSelectName,ByVal selectedItem,ByVal defaultOption,ByVal cssStyle,ByVal style,ByVal styleValue)
	Dim arrValue : arrValue = Array("2008","2009","2010","2011","2012","2013","2014","2015")
	Dim arrBody  : arrBody  = Array("2008 ���","2009 ���","2010 ���","2011 ���","2012 ���","2013 ���","2014 ���","2015 ���")
	CreateSltByYearPlus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,frmSelectName,selectedItem,"",defaultOption,cssStyle,style,styleValue)
End Function


'������������б�
Function CreateSltByMonthPlus(ByVal frmSelectName,ByVal selectedItem,ByVal defaultOption,ByVal cssStyle,ByVal style,ByVal styleValue)
	Dim arrBody  : arrBody  = Array("1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��")
	Dim arrValue : arrValue = Array("1","2","3","4","5","6","7","8","9","10","11","12")
	CreateSltByMonthPlus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,frmSelectName,selectedItem,"",defaultOption,cssStyle,style,styleValue)
End Function


'�����·ݸ�ѡ�б�
Function CreateCBLByMonth(ByVal elementName, ByVal selectedItems,ByVal exceptItems,ByVal isCreateList,ByVal eventType,ByVal eventMethod)
	Dim arrText  : arrText  = Array("1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��")
	Dim arrValue : arrValue = Array("1","2","3","4","5","6","7","8","9","10","11","12")
	CreateCBLByMonth = CreateCheckBoxListByArray(elementName,arrValue,arrText,selectedItems,exceptItems,isCreateList,eventType,eventMethod)
End Function


'����Сʱ�б�
Function CreateSltByTimeHour(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim row, arrValue, arrBody
	Dim str : str = ""
	For row = 0 To 23
		If len(row) = 1 Then
			str = str & "0" & row & ","
		Else
			str = str & row & ","
		End If
	Next
	str = left(str, len(str) - 1)
	arrValue = SplitPlus(str, ",")
	arrBody  = arrValue
	CreateSltByTimeHour = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'���������б�
Function CreateSltByTimeMinute(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim row, arrValue, arrBody
	Dim str : str = ""
	For row = 0 To 59
		If len(row) = 1 Then
			str = str & "0" & row & ","
		Else
			str = str & row & ","
		End If
	Next
	str = left(str, len(str) - 1)
	arrValue = SplitPlus(str, ",")
	arrBody  = arrValue
	CreateSltByTimeMinute = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'---------------------------------------------------------------------------
'	�������б�(��˾����)
'---------------------------------------------------------------------------
Function CreateSltContinentByUTS(ByVal elementName, ByVal selectedItem,ByVal exceptItem,ByVal cssStyle,ByVal eventType,ByVal eventMethod)
	Dim strSql : strSql = " select itemDesc, itemDesc from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
						  " And pid = (select iId from ts_items with(nolock) where itemName = '��Ʒ����') order by itemName asc "
	CreateSltContinentByUTS = CreateSelect(conn,strSql,elementName,elementName,"ѡ���Ʒ����",selectedItem,eventType,eventMethod)
End Function

'ϵͳ-Ŀ�ĵط���
Function CreateSltSysContinentByType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select distinct itemName, itemName from ts_items with(nolock) "&_
						  " where tmID in (select tmID from ts_typeManage with(nolock) where typeName = '"& TS_TYPE_CONTINENT &"') and pid = 0 order by itemName asc "
	CreateSltSysContinentByType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'ϵͳ-Ŀ�ĵص���
Function CreateSltSysContinentByItem(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal parentItemName, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select distinct itemName, itemName from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = '"& TS_TYPE_CONTINENT &"') "&_
						  " and pid = (select iId from ts_items with(nolock) where itemName = '"& parentItemName &"') order by itemName asc "
	CreateSltSysContinentByItem = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'ϵͳ-Ŀ�ĵط�����ʾ
Function CreateSltSysContinentByGroup(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal cssStyle)
	Dim relationFieldIndex
	Dim groupSql   : groupSql   = " select distinct iId, itemName from ts_items with(nolock) "&_
								  " where tmID in (select tmID from ts_typeManage with(nolock) where typeName = '"& TS_TYPE_CONTINENT &"') and pid = 0 order by iId asc "
	Dim subItemSql : subItemSql = " select distinct pId, itemName, itemName from ts_items with(nolock) "&_
								  " where tmID in (select tmID from ts_typeManage with(nolock) where typeName = '"& TS_TYPE_CONTINENT &"') and pid <> 0 "&_
								  " order by pId asc, itemName asc "
	Call isNoValue(cssStyle, "select_style01")
	CreateSltSysContinentByGroup = CreateSelectListByCommonByGroup(groupSql, subItemSql, relationFieldIndex, element, selectedValue, firstItem, cssStyle)
End Function


Function CreateSltSysContinentByTeamList(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ȫ��Ŀ�ĵ�","ŷ��(��������)","����","����(����+����)","�ж���(�ж�+����)","������","������(�պ�)","����","������","�۰�̨","����")
	Dim arrValue : arrValue = Array("","ŷ��|������","����","����|����","�ж�|����","������","�պ�|�ձ�|����","����","������","�۰�̨","����")
	CreateSltSysContinentByTeamList = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "-1", "", "", eventType, eventMethod)
End Function

'ҵ��Ԥ�� Ŀ�ĵ�
Function CreateSltByTeamCodeDesc(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��ѡ��Ŀ�ĵ�","ŷ��","����","����","��������","������","������")
	Dim arrValue : arrValue = Array("","ŷ��","����","����","��������","������","������")
	CreateSltByTeamCodeDesc = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "-1", "", "", eventType, eventMethod)
End Function


'---------------------------------------------------------------------------
'	����ɢƴ���Ų����б�  �ȼٲ�Ʒ�����в�
'---------------------------------------------------------------------------
'96|161|163|164|165|166|167|168|169|170|171|172|173|174|175|176|177|178|179|180|181
Function CreateSltTeamCreateDeptBySummary(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ȫ�������","ŷ������","��������","��������","��������","�պ�����","��������","�ȼٲ�Ʒ������","�ȼٲ�Ʒ�����в�","�ȼٲ�Ʒ�����ǲ�","�ȼٲ�Ʒ�⸷��","ר�����β�","̨�岿","�Ϻ�������","�ɶ�������","����������","����������","�ձ���","������")
	Dim arrValue : arrValue = Array("","30","32","31","99|46","48|150","86","96|163|164|165|166|167|168|169|170|171","96|172|173|174|175|176|177|178","85|179","215|217|218","102","147","16","81","119","138","48","150")
	CreateSltTeamCreateDeptBySummary = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "-1", "", "", eventType, eventMethod)
End Function


'---------------------------------------------------------------------------
'	���չ�˾
'---------------------------------------------------------------------------
Function CreateSltAirCompany(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select aID, shortName from ts_air with(nolock) where 1=1 "&_
						  " order by shortName "
	CreateSltAirCompany = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function

Function CreateSltAirCompanyShortName(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select shortName, shortName from ts_air with(nolock) where 1=1 "&_
						  " And aID in (select distinct airCompany from tabZTtd with(nolock) where airCompany is not Null) "&_
						  " order by shortName "
	CreateSltAirCompanyShortName = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function

'��Ʊ��˾
'Function CreateSltAirCompanyByTicket(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim strSql : strSql = " select shortName, shortName from ts_air with(nolock) where 1=1 "&_
'						  " And aID in (select distinct airCompany from tabZTtd with(nolock) where airCompany is not Null) "&_
'						  " order by shortName "
'	CreateSltAirCompanyByTicket = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
'End Function

'---------------------------------------------------------------------------
'	��Ʒ����
'---------------------------------------------------------------------------
Function CreateSltProduceType(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select id, xlKind from tabXJxianLuKind with(nolock) where 1=1 And isEnable = 1 "&_
						  " order by orderNum desc, xlKind asc "
	CreateSltProduceType = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function

Function CreateSltProduceTypeDesc(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct xlKind, xlKind, orderNum from tabXJxianLuKind with(nolock) where 1=1 And isEnable = 1 "&_
						  " order by orderNum desc, xlKind asc "
	CreateSltProduceTypeDesc = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function

'---------------------------------------------------------------------------
'	��Ʒ�����
'---------------------------------------------------------------------------
Function CreateSltPlanLib(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select id, ('['+ teamCode + ']	' + product_name) product_name from v_teamPlanList with(nolock) where teamCode != '' And isEnable = 1 "&_
						  " order by teamCode, product_name "
	CreateSltPlanLib = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function

Function CreateSltPlanLibPlus(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal keys, ByVal values)
	Dim strSql : strSql = " select id, ('['+ teamCode + ']	' + product_name) product_name from v_teamPlanList with(nolock) where teamCode != '' And isEnable = 1 "&_
						  " order by teamCode, product_name "
	CreateSltPlanLibPlus = CreateSelectPlus(conn,strSql,"",elementName,firstItem,selectedItem,keys,values)
End Function

Function CreateSltPlanLibCode(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal keys, ByVal values)
	Dim strSql : strSql = " select teamCode, ('['+ teamCode + ']	' + product_name) product_name from v_teamPlanList with(nolock) where teamCode != '' And isEnable = 1 "&_
						  " order by teamCode, product_name "
	CreateSltPlanLibCode = CreateSelectPlus(conn,strSql,"",elementName,firstItem,selectedItem,keys,values)
End Function




'---------------------------------------------------------------------------
'	�Ŷ�����б�
'---------------------------------------------------------------------------

'ҵ������
Function CreateSltTeamService(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ɢƴ","����","����")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateSltTeamService = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,elementName,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function

Function CreateCBTeamService(ByVal elementName, ByVal selectedItems,ByVal exceptItems, ByVal isCreateList, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ɢƴ","����","����")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateCBTeamService = CreateCheckBoxListByArray(elementName, arrValue, arrBody, selectedItems, exceptItems, isCreateList, eventType, eventMethod)
End Function

'Ŀ�ĵ�
Function CreateSltContinent(ByVal elementName, ByVal selectedItem,ByVal exceptItem,ByVal cssStyle,ByVal eventType,ByVal eventMethod)
	Dim arrContinent : arrContinent = Array("ŷ��","����","������","����","������","������")
	Call isNoValue(selectedItem,"")
	CreateSltContinent = CreateSelectListByEasyArray(arrContinent, elementName, selectedItem, exceptItem, "��ѡ����", cssStyle, eventType, eventMethod)
End Function


'��Ʒ����
'Function CreateSltTeamKind(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim strSql : strSql = " select distinct QianZhengKind, QianZhengKind "&_
'						  " from tabXJxianLu "&_
'						  " where isNull(QianZhengKind,'') <> '' "&_
'						  " order by QianZhengKind asc "
'	CreateSltTeamKind = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
'End Function

Function CreateSltTeamKind(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrText : arrText = "��|����͢|����|����+�ϰ�|����+������|������|��ɳ����|��|�µ���|�Ĵ�����|�Ĵ�����+������|��ɳ����|"&_
                            "����|����+����͢|����+����͢+��³|����+����͢+����|����+����͢+����+��³|����+��³|����+����|����+����+��³|"&_
                            "����|��������|����|����ʱ|����|��|�¹�|�ϰ�|�ϰ�+������|����˹|��|����|���ɱ�|��|����|�Ű�|�Ű�+ī����|"&_
                            "����|��|����|���ô�|����կ|�ݿ�|��Ͳ�Τ|���޵���|������|¬ɭ��|��������|����|��³|Ħ���|ī����|���ױ���|"&_
                            "�Ϸ�|�Ϸ�+����|�Ϸ�+�ϰ�|�Ϸ�+������|�Ϸ�+�ޱ���|�Ϸ�+��Ͳ�Τ|�Ϸ�+�ޱ���+��Ͳ�Τ|�Ჴ��|Ų|Ų��|������|�ձ�|"&_
							"��|���|��ʿ|��ʿ+������|��ʿ+�ϰ�|����|˹������|˹��������|̩��|̩��+��������|̹ɣ����|"&_
                            "ͻ��˹|������|������+ϣ��|��|������|������+Ħ���|ϣ|ϣ��|ϣ��+�ϰ�|�¼���|������|"&_
							"��|������|������+����ά��|������+���޵���|������|����|��ɫ��|��ɫ��+Լ��|"&_
                            "��|��+��|�����|��+�ϰ�|ӡ��|ӡ��+�Ჴ��|Ӣ|Ӣ��|Ӣ+��|Ӣ+��|Ӣ+��|Ӣ��+�ϰ�|Ӣ��+������|Ӣ��+����|Ӣ��+�����|"&_
							"Լ��|Խ��|Խ��+����կ|����|���|�Ჴ��+����|����������ݣ�|�������人��|Ӣ����������"
	Dim arrBody : arrBody = SplitPlus(arrText,"|")
	CreateSltTeamKind = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,elementName,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'��Ʒ����
Function CreateSltTeamContinent(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select itemDesc, itemDesc from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
						  " And pid = (select iId from ts_items with(nolock) where itemName = '��Ʒ����') order by itemName asc "
	CreateSltTeamContinent = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'�������ص�
Function CreateSltTeamPlace(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody
	arrBody = Array("����","�Ϻ�","�ɶ�","����","���","����","�Ͼ�","����","���","����","����","�ൺ","����","����","�人","������","����","����","֣��","���ͺ���","��ͷ","����","����","����","����","����","��³ľ��","ʯ��ׯ","����","����")
	CreateSltTeamPlace = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'ǩ֤
Function CreateSltTeamVisaSummary(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim arrText, arrBody
'	
'	arrText     = "��,ADS,����͢,����,����+������,����+�ϰ�,����+���,"&_
'				  "����+���+��ʿ,��+��,��+��+��,��+��+��,��+��,�µ�����ǩ,"&_
'				  "��,��+��,�Ĵ�����,����,��,��+��,��+��+��,�ϰ�,�ϰ����,"&_
'				  "��,��+��,��+��+��,��+ͻ��˹,��ǩ,���ɱ�,��ǩ,��ǩ+��ʿ,"&_
'				  "�۰�ͨ��֤,��ǩ,��ǩ,��+��,���ô�,����կ,������,���ǩ,��ǩ,"&_
'				  "����,����+���ô�,��³,�Ϸ�,�Ϸ�+����,�Ϸ�+�ϰ�,�Ϸ�+�����,"&_
'				  "�Ϸ�ADS,�Ϸ�ADS+ʷ�߼������,�Ჴ��,Ų+��,Ų��,�ձ�,��ǩ,��+��+��,"&_
'				  "����,���,���+����,���+��+��,���+��ʿ,���+��+��,������,"&_
'				  "̩��,ͻ��˹,������,������+ϣ��,������,ϣ��,�¼���,�¼���+̩��,"&_
'				  "�¼���+Խ��+��������,��+��,��+��+��,��+�����,�����,�����1��,�����2��,��������,"&_
'				  "ӡ��,ӡ��+�Ჴ��,ӡ��,Ӣ+��,Ӣ+��,Ӣ��,Ӣ����ǩ+���+��ʿ,Խ��,����"
'	
'	arrBody = SplitPlus(arrText,",")
'	CreateSltTeamVisaSummary = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
	CreateSltTeamVisaSummary = CreateSltTeamKind(elementName, firstItem, selectedItem, exceptItem, eventType, eventMethod)
End Function


'�Ŷ�״̬
Function CreateSltTeamReportType(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��ʵ��","�鿪��","��תʵ","������")
	Dim arrValue : arrValue = Array(1,2,3,0)
	CreateSltTeamReportType = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'�²�Ʒ�б�
Function CreateSltTeamRemind(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select trId, title from ts_teamRemind with(nolock) where isEnable = 1 order by title asc "
	CreateSltTeamRemind = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'�տ�״̬
Function CreateSltTeamOpenStatus(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("����","ȡ��")
	Dim arrValue : arrValue = Array(1,0)
	CreateSltTeamOpenStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'ȡ��״̬
Function CreateSltTeamCancelStatus(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("����","ȡ��")
	Dim arrValue : arrValue = Array(0,1)
	CreateSltTeamCancelStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'��������
Function CreateSltTeamSingleItemType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal keys, ByVal values)
	Dim strSql : strSql = "select itemName, itemName from ts_items with(nolock) where pId = (select iId from ts_items with(nolock) where itemName = '��������') order by itemName "
	CreateSltTeamSingleItemType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", keys, values)
End Function


'�Ŷ������ؼ���
Function CreateSltTeamSearchType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�ź�","�����","Ԥ����","��Ʒ����","��Ʒ����","�ͻ�","������","ǩ֤","������","OP","�Ŷӱ��","��·��")
	Dim arrValue : arrValue = Array("tuanNo","financeCode","scheduleNo","xlName","teamKind","agentName","cfdi","QianZhengKind","ztRen","accepter","tdid","lineKey")
	CreateSltTeamSearchType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'�����б�
Function CreateSltShipList(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select shipId, shipNames = ('[' + isNull(shipCompany,shipName) + '] ' + shipName) from ts_ship with(nolock) order by shipCompany, shipName "
	CreateSltShipList = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'�ɹ�������
Function CreateSltTeamPurchasingOrderType(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody : arrBody = Array("PO","��ͬ","�ͻ�ȷ��")
	CreateSltTeamPurchasingOrderType = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,element,selectedItem,"",firstItem,"",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	�����б�
'---------------------------------------------------------------------------
'Function CreateSltInfinityByDeptUnInclude(ByRef con,ByVal element,ByVal parentValue,ByVal firstItem,ByVal selectedItem,ByVal exceptItem,ByVal itemSign,ByVal keys,ByVal values)
'	Dim listSign, isIncludeSubItem : isIncludeSubItem = 0
'	Dim strSqlBase : strSqlBase = " select di_id, di_name, di_pid from v_deptInfo with(nolock) where 1=1 "&_
'								  " And di_pid = ? "&_
'								  " And di_isCancel = 0 "&_
'								  " order by deptCode "
'	CreateSltInfinityByDeptUnInclude = CreateSelectInfinity(con, strSqlBase, parentValue, element, firstItem, selectedItem, exceptItem, itemSign, listSign, isIncludeSubItem, keys, values)
'End Function
'
'Function CreateSltInfinityByDept(ByRef con,ByVal element,ByVal parentValue,ByVal firstItem,ByVal selectedItem,ByVal exceptItem,ByVal itemSign,ByVal keys,ByVal values)
'	Dim listSign, isIncludeSubItem : isIncludeSubItem = 1
'	Dim strSqlBase : strSqlBase = " select di_id, di_name, di_pid from v_deptInfo with(nolock) where 1=1 "&_
'								  " And di_pid = ? "&_
'								  " And di_isCancel = 0 "&_
'								  " order by deptCode "
'	CreateSltInfinityByDept = CreateSelectInfinity(con, strSqlBase, parentValue, element, firstItem, selectedItem, exceptItem, itemSign, listSign, isIncludeSubItem, keys, values)
'End Function

Function CreateSltInfinityByDeptUnInclude(ByRef con,ByVal element,ByVal parentValue,ByVal firstItem,ByVal selectedItem,ByVal exceptItem,ByVal itemSign,ByVal keys,ByVal values)
	Dim listSign, isIncludeSubItem : isIncludeSubItem = 0
	Dim strSqlBase : strSqlBase = " select di_id, di_name, di_pid, subCount from v_deptInfo with(nolock) where 1=1 "&_
								  " And di_pid = ? "&_
								  " And di_isCancel = 0 "&_
								  " order by deptCode "
	CreateSltInfinityByDeptUnInclude = CreateSelectInfinityBySub(con, strSqlBase, parentValue, element, firstItem, selectedItem, exceptItem, itemSign, listSign, isIncludeSubItem, keys, values)
End Function

Function CreateSltInfinityByDept(ByRef con,ByVal element,ByVal parentValue,ByVal firstItem,ByVal selectedItem,ByVal exceptItem,ByVal itemSign,ByVal keys,ByVal values)
	Dim listSign, isIncludeSubItem : isIncludeSubItem = 1
	Dim strSqlBase : strSqlBase = " select di_id, di_name, di_pid, subCount from v_deptInfo with(nolock) where 1=1 "&_
								  " And di_pid = ? "&_
								  " And di_isCancel = 0 "&_
								  " order by deptCode "
	CreateSltInfinityByDept = CreateSelectInfinityBySub(con, strSqlBase, parentValue, element, firstItem, selectedItem, exceptItem, itemSign, listSign, isIncludeSubItem, keys, values)
End Function


'ֻ��ʾ�������б�
'Function CreateSltInfinityByDeptByTeam(ByRef con,ByVal element,ByVal parentValue,ByVal firstItem,ByVal selectedItem,ByVal exceptItem,ByVal itemSign,ByVal keys,ByVal values)
'	Dim strSqlBase
'	strSqlBase = " select di_id, di_name, di_pid from ts_deptInfo di where di_pid = ? "&_
'				 " 	And exists(select empID from tabZLemp emp "&_
'						" where emp.di_id = di.di_id "&_
'						" And isNull(yuancheng,'') != '1' "&_
'						" And (select isNull(user_Login,'0') isLogin from tabSetPurview sp where sp.empid = emp.empid) != '0') "&_
'				 " 	And exists(select di_id from tabZTtd td where td.di_id = di.di_id And isNull(isCancel,'') != '1') "&_
'				 " order by s_id, di_pid, di_name"
'	CreateSltInfinityByDeptByTeam = CreateSelectInfinity(con, strSqlBase, parentValue, element, firstItem, selectedItem, exceptItem, itemSign, keys, values)
'End Function


'---------------------------------------------------------------------------
'	�ɱ�����״̬�б�
'---------------------------------------------------------------------------
Function CreateSltTeamCloseStatus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�ɱ�����","δ����","�ѹ���")
	Dim arrValue : arrValue = Array("",0,1)
	CreateSltTeamCloseStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	�������״̬�б�
'---------------------------------------------------------------------------
Function CreateSltTeamIncomeStatus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��������״̬","δȫ������","��ȫ������")
	Dim arrValue : arrValue = Array("",0,1)
	CreateSltTeamIncomeStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function

'---------------------------------------------------------------------------
'	����״̬�б�
'---------------------------------------------------------------------------
Function CreateSltTeamStatStatus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("����״̬","δ����","�ѽ���")
	Dim arrValue : arrValue = Array("",0,1)
	CreateSltTeamStatStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	����״̬�б�
'---------------------------------------------------------------------------
Function CreateSltTeamBudgetStatus(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("δ����","�Ѿ���","�������")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateSltTeamBudgetStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	2012-11-27
'	�˿�����״̬
'---------------------------------------------------------------------------
Function CreateSltTeamBudgetAccountDate(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�˿�����","����","�п���")
	Dim arrValue : arrValue = Array("","1","0")
	CreateSltTeamBudgetAccountDate = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	����ʵ�� - �ͻ�����
'---------------------------------------------------------------------------
Function CreateSltFinanceCustomerType(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�ͻ�����","����","����","������","��������")
	Dim arrValue : arrValue = Array("","����","����","������","��������")
	CreateSltFinanceCustomerType = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	�����տ���
'---------------------------------------------------------------------------

'����
Function CreateSltSalerRequisitionInList(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal firstBankAccount, ByVal eventType, ByVal eventMethod)
	Dim strSql, rs
	strSql = " select biId, bankCnName from ts_bankInfo with(nolock) "&_
			 " where 1=1 "&_
			 " and requisition like 'in%' "&_
			 " and sId = "& SESSION("sId") &_
			 " and isEnable = 1 "
	If (firstBankAccount <> "" and selectedValue = "") Then
		If GetRs(rs, "select biId from ts_bankInfo b with(nolock) where replace(account,' ','') = '"& replace(firstBankAccount," ","") &"' ") Then
			selectedValue = rs("biId")
		End If
		Call DestoryRs(rs)
	End If
	strSql = strSql & " order by bankCnName "
	CreateSltSalerRequisitionInList = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", eventType, eventMethod)
End Function

'����
Function CreateSltSalerRequisitionOutList(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal firstBankAccount, ByVal eventType, ByVal eventMethod)
	Dim strSql, rs
	strSql = " select biId, bankCnName from ts_bankInfo with(nolock) "&_
			 " where 1=1 "&_
			 " and requisition like 'out%' "&_
			 " and sId = "& SESSION("sId") &_
			 " and isEnable = 1 "
	If (firstBankAccount <> "" and selectedValue = "") Then
		If GetRs(rs, "select biId from ts_bankInfo b with(nolock) where replace(account,' ','') = '"& replace(firstBankAccount," ","") &"' ") Then
			selectedValue = rs("biId")
		End If
		Call DestoryRs(rs)
	End If
	strSql = strSql & " order by bankCnName "
	CreateSltSalerRequisitionOutList = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", eventType, eventMethod)
End Function


'---------------------------------------------------------------------------
'	����������б�
'---------------------------------------------------------------------------
Function CreateSltTravelTypeByStatic(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�ͻ����","������","��ҵ�ͻ�","���˿ͻ�","��������","ֱӪ����","���Ź���","����")
	Dim arrValue : arrValue = Array("","������","��ҵ�ͻ�","���˿ͻ�","��������","ֱӪ����","���Ź���","����")
	CreateSltTravelTypeByStatic = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function


Function CreateSltTravelType(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct type, type from tabZLlxs with(nolock) where isArchive = 1 order by type "
	CreateSltTravelType = CreateSelectPlusByXML(conn, strSql, element, "�ͻ����", selectedItem, "", "", eventType, eventMethod)
End Function

'������Դ
Function CreateSltCustomerSummaryBySource(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ȫ����Դ","ERP","����","��վ","�ֻ�","�ӿ�")
	Dim arrValue : arrValue = Array("","ERP","����","��վ","�ֻ�","�ӿ�")
	CreateSltCustomerSummaryBySource = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, "", "", "", eventType, eventMethod)
End Function

'�ͻ���Դ�б�
Function CreateSltCustomerBySource(ByVal elementName, ByVal selectedValue, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ѡ����Դ","��ͻ�-��˾","��ͻ�-���б���","��Ա","����","�㲥","�����","����","�ڱ�","ƽý","ֱͶ","չ��")
	Dim arrValue : arrValue = Array("","��˾","���б���","��Ա","����","�㲥","�����","����","�ڱ�","ƽý","ֱͶ","չ��")
	CreateSltCustomerBySource = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, exceptItem, "", "", eventType, eventMethod)
End Function

'��ȡ��ͻ��б�
Function CreateSltCustomerVip(ByVal element, ByVal selectedItem, ByVal firstItem, ByVal vipSource, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select lxsId, [name] from tabZLlxs with(nolock) where isVip = 1 and vipSource = '"& vipSource &"' order by [name] "
	CreateSltCustomerVip = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function


'�������� �б�ʽ
Function CreateSltTeamByStepUp(ByVal element, ByVal selectedItem, ByVal keys, ByVal values)
	Dim arrBody  : arrBody  = Array("ȫ���ͻ�","���������ͻ�","���ſͻ�")
	Dim arrValue : arrValue = Array("all","team","used")
	CreateSltTeamByStepUp = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",keys,values)
End Function

'---------------------------------------------------------------------------
'	����������б�
'---------------------------------------------------------------------------
Function CreateSltAgentArchiveBaseList(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql, rs
	strSql = " select agentId, agentName from v_agentBaseList with(nolock) order by easyCode asc, fullName asc "
	CreateSltAgentArchiveBaseList = CreateSelectPlusByXML(conn, strSql, element, "ѡ��ͻ��ܹ�˾", selectedItem, "", "", eventType, eventMethod)
End Function

Function CreateSltAgentArchiveSubList(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql, rs
	strSql = " select agentId, agentName from v_agentSubList with(nolock) where isArchive = 1 order by easyCode asc, name asc "
	CreateSltAgentArchiveSubList = CreateSelectPlusByXML(conn, strSql, element, "ѡ��ͻ�", selectedItem, "", "", eventType, eventMethod)
End Function

Function CreateSltAccountType(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�˿������","����","ȡ��","ת��","ת��")
	Dim arrValue : arrValue = Array("","����","ȡ��","ת��","ת��")
	CreateSltAccountType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, "", "", "", eventType, eventMethod)
End Function

Function CreateSltIsArchive(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("δ�鵵","�ѹ鵵")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltIsArchive = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, "", "", "", eventType, eventMethod)
End Function

'���������б�
Function CreateSltAreaList(ByVal elementName, ByVal selectedValue)
	Dim rs, strSql : strSql = "select distinct diQu, diQu from tabZLlxs with(nolock) where isNull(diQu,'')!='' And isNull(updateTime,'')!='' order by diQu asc"
	CreateSltAreaList = CreateSelectPlus(conn,strSql,elementName,elementName,"ȫ������",selectedValue,"","")
End Function


'---------------------------------------------------------------------------
'	��ȡ������Ա�б�
'---------------------------------------------------------------------------
Function CreateSltFinanceManager(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select empId, empName from v_emplist with(nolock) "&_
			 " where 1=1 "&_
			 " 		and empId in (select empId from [dbo].[tabSetPurview] with(nolock) where isnull([budget_auditingByFinance],'') = '1') "&_
			 " 		and deptName not in ('ERP��','�����ܲ�','������Ʋ�','֤ȯ����') "&_
			 " 		and isEnable = 1 "&_
			 " order by sId, empName "

'	strSql = " select emp.empId, emp.[name], d.s_id  "&_
'			 " from tabzlemp emp with(nolock) "&_
'			 " left join ts_deptInfo d with(nolock) on d.di_id = emp.di_id "&_
'			 " where (emp.deptCode = 'U01009' "&_
'			 " 		Or (emp.[name] in ('�˷�','��Ө','��һ֮','��Ƽ','ף��','������') And emp.deptCode = 'U02') "&_
'			 " 		Or (emp.[name] in ('����') And emp.deptCode = 'U010020060001') "&_
'			 "    	Or (emp.[name] in ('ʷ����','��ƽ') And emp.deptCode = 'U03') "&_
'			 "    	Or (emp.[name] in ('��ӱ','��ǿ','����') And emp.deptCode = 'U06') "&_
'			 "    	Or (emp.[name] in ('������') And emp.deptCode = 'U08') "&_
'			 " ) "&_
'			 " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(sp.user_Login,'') = '1' ) "&_
'			 " And emp.isEnable = 1 "&_
'			 " order by s_id, emp.[name] "
	CreateSltFinanceManager = CreateSelectPlusByXML(conn,strSql,element,"������Ա",selectedItem,"",cssStyle,keys,values)
End Function

Function CreateSltFinanceManagerPlus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select emp.empId, emp.[name], d.s_id  "&_
			 " from tabzlemp emp with(nolock) "&_
			 " left join ts_deptInfo d with(nolock) on d.di_id = emp.di_id "&_
			 " where emp.empId in (select distinct financeManager from tabZTtd with(nolock) where isNull(financeManager,'') != '') "&_
			 " And emp.empid in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'') = '1') "&_
			 " order by s_id, emp.[name] "
	CreateSltFinanceManagerPlus = CreateSelectPlusByXML(conn,strSql,element,"������Ա",selectedItem,"",cssStyle,keys,values)
End Function


'�����ʶ�б�
Function CreateSltFinanceByLoan(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��","��")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltFinanceByLoan = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'��ƿ�Ŀ�б�
Function CreateSltFinanceByAccount(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '��' "&_
			 " 		when levelValue = 3 then '����' end) + itemName "&_
			 " from v_u8Items v with(nolock) "&_
			 " where 1=1 "&_
			 " And isEnable = 1 "&_
			 " order by codeValue "
	CreateSltFinanceByAccount = CreateSelectPlusByXML(conn,strSql,element,firstItem,selectedValue,exceptItem,"",keys,values)
End Function


'��ƿ�Ŀ�˺��б�
Function CreateSltFinanceByAccountPlus(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)

	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '��' "&_
			 " 		when levelValue = 3 then '����' end) + itemName "&_
			 " from v_u8Items v with(nolock) "&_
			 " where 1=1 "&_
			 " And struId = "& SESSION("sId") &_
			 " And isEnable = 1 "&_
			 " And (isNull(bankCode,'') <> '' Or isNull(cashClass,0) <> 0 Or levelValue <> 3) "&_
			 " order by codeValue "
	CreateSltFinanceByAccountPlus = CreateSelectPlusByXML(conn,strSql,element,firstItem,selectedValue,exceptItem,"",keys,values)
End Function


'2012-09-19
'���ݸ��ʽ����ȡ��ƿ�Ŀ�˺��б�
Function CreateSltFinanceByAccountPlusByPay(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal payType, ByVal keys, ByVal values)

	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '��' "&_
			 " 		when levelValue = 3 then '����' end) + itemName "&_
			 " from v_u8Items v with(nolock) "&_
			 " where 1=1 "&_
			 " And payType = '"& payType &"' "&_
			 " And struId = "& SESSION("sId") &_
			 " And isEnable = 1 "&_
			 " And (isNull(bankCode,'') <> '' Or isNull(cashClass,0) <> 0 Or levelValue <> 3) "&_
			 " order by codeValue "
	CreateSltFinanceByAccountPlusByPay = CreateSelectPlusByXML(conn,strSql,element,firstItem,selectedValue,"","",keys,values)
End Function

'2013-08-21
'���ݸ��ʽ����ȡ"�����"��ƿ�Ŀ�˺��б�
Function CreateSltFinanceByAccountPlusByPayAndCoin(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal payType, ByVal keys, ByVal values)

	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '��' "&_
			 " 		when levelValue = 3 then '����' end) + itemName "&_
			 " from v_u8Items v with(nolock) "&_
			 " where 1=1 "&_
			 " And payType = '"& payType &"' "&_
			 " And struId = "& SESSION("sId") &_
			 " And isEnable = 1 "&_
			 " And (isNull(bankCode,'') <> '' Or isNull(cashClass,0) <> 0 Or levelValue <> 3) "&_
			 " And isNull(code2,'') <> '02'"&_
			 " order by codeValue "
	CreateSltFinanceByAccountPlusByPayAndCoin = CreateSelectPlusByXML(conn,strSql,element,firstItem,selectedValue,"","",keys,values)
End Function


'---------------------------------------------------------------------------
'	��ȡԱ���б�
'---------------------------------------------------------------------------
Function CreateSltEmpList(ByVal element, ByVal selectedItem, ByVal deptId, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select emp.[name], emp.[name] from tabzlemp emp with(nolock) "&_
						  " where 1=1 "&_
						  " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'0') = '1') "&_
						  " And isNull(yuancheng,'') != '1' "
						  
	If (deptId <> "") Then strSql = strSql & " And di_id = '"& deptId &"' "
	strSql = strSql & " order by name "
	CreateSltEmpList = CreateSelect(conn,strSql,element,element,"ѡ��Ա��",selectedItem,eventType,eventMethod)
End Function


Function CreateSltEmpIdList(ByVal element, ByVal selectedItem, ByVal deptId, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select emp.empId, replace(emp.[name],' ','') name from tabzlemp emp with(nolock) "&_
						  " where 1=1 "&_
						  " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'0') = '1') "&_
						  " And isNull(yuancheng,'') != '1' "
	If (deptId <> "") Then strSql = strSql & " And di_id = '"& deptId &"' "
	strSql = strSql & " order by name "
	CreateSltEmpIdList = CreateSelect(conn,strSql,element,element,"ѡ��Ա��",selectedItem,eventType,eventMethod)
End Function

Function CreateSltEmpIdInManyDeptList(ByVal element, ByVal selectedItem, ByVal deptId, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select emp.empId, replace(emp.[name],' ','') name from tabzlemp emp with(nolock) "&_
						  " where 1=1 "&_
						  " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'0') = '1') "&_
						  " And isNull(yuancheng,'') != '1'  And isEnable = 1"
	If (deptId <> "") Then strSql = strSql & " And di_id in ("& deptId &") "
	strSql = strSql & " order by name "
	
	CreateSltEmpIdInManyDeptList = CreateSelect(conn,strSql,element,element,"ѡ��Ա��",selectedItem,eventType,eventMethod)
End Function
'---------------------------------------------------------------------------
'	�������ִ����б�
'---------------------------------------------------------------------------
Function CreateSltShip(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select shipId, shipName from ts_ship with(nolock) order by shipName "
	CreateSltShip = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", eventType, eventMethod)
End Function


Function CreateSltShipRoom(ByVal element, ByVal selectedValue, ByVal shipId, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select code, roomDesc from v_shipRoomList with(nolock) where shipId = '"& shipId &"' order by roomDesc "
	CreateSltShipRoom = CreateSelectPlusByXML(conn, strSql, element, "ѡ�񴬲�", selectedValue, "", "", eventType, eventMethod)
End Function


'�ڼ��˱���
Function CreateSltShipCustNumber(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arr : arr = Array(1,2,3,4,5,6,7,8,9,10) : Call isNoValue(selectedValue,1)
	CreateSltShipCustNumber = CreateSelectListByEasyArray(arr, element, selectedValue, "", "", "", eventType, eventMethod)
End Function

'���տ���״̬
Function CreateSltByShipEnable(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("�տ�","ͣ��")
	Dim arrValue : arrValue = Array("1","0")
	CreateSltByShipEnable = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'---------------------------------------------------------------------------
'	��Ʒ���������
'---------------------------------------------------------------------------

'����
Function CreateSltTeamTheme(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select themeTitle, themeTitle from ts_teamTheme with(nolock) where isEnable = 1 order by themeTitle "
	CreateSltTeamTheme = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


'���
Function CreateSltTeamType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select id, xlKind from tabXJxianLuKind with(nolock) where isEnable = 1 order by xlKind "
	CreateSltTeamType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

Function CreateSltTeamTypeName(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select xlKind = replace(xlKind,' ',''), xlKind from tabXJxianLuKind with(nolock) where isEnable = 1 order by xlKind "
	CreateSltTeamTypeName = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'---------------------------------------------------------------------------
'	API�б�
'---------------------------------------------------------------------------

'API����
Function CreateSltAPIType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select distinct fieldCode, fieldDesc from api_configField with(nolock) order by fieldDesc "
	CreateSltAPIType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


'---------------------------------------------------------------------------
'	����
'---------------------------------------------------------------------------

Function CreateSltCoinByCnName(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select cId, coinName from ts_coinTypes with(nolock) "
	CreateSltCoinByCnName = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


Function CreateSltCoinByShortName(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select cId, shortName from ts_coinTypes with(nolock) "
	CreateSltCoinByShortName = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'---------------------------------------------------------------------------

'�����뵹��
Function CreateSltOrderByType(ByVal element, ByVal selectedItem, ByVal keys, ByVal values)
	Dim arrBody  : arrBody  = Array("����","����")
	Dim arrValue : arrValue = Array("asc","desc")
	CreateSltOrderByType = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",keys,values)
End Function


'����ѡ��
Function CreateSltByEnable(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("����","����")
	Dim arrValue : arrValue = Array("1","0")
	CreateSltByEnable = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'�Ƿ��б�
Function CreateSltByBoolean(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��","��")
	Dim arrValue : arrValue = Array("1","0")
	CreateSltByBoolean = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'---------------------------------------------------------------------------

'���۹��������,�����б�
Function CreateSltTacticsParent(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select tacticsId, tacticsTitle from ts_produceTactics with(nolock) where parentId = 0 "
	CreateSltTacticsParent = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


'2012-11-26
'IP�����б�
Function CreateSltByIPType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��̬","��̬")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltByIPType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'2013-01-09
'�����Ŷ�����
Function CreateSltFinanceTeamType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("������","������")
	Dim arrValue : arrValue = arrBody
	CreateSltFinanceTeamType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'2013-01-09
'�ŶӺ����б�(�����󣬸��Ž����гɱ����������)
Function CreateSltFinanceAccountByIncomeAndCost(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("��������","���մ���")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltFinanceAccountByIncomeAndCost = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'2013-01-24
'��ֵ˰˰�� - ����
Function CreateSltFinanceVatTaxRateListByIncome(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select itemName, itemName = (cast((cast(itemName as float) * 100) as varchar(20)) + '%') from ts_items with(nolock) where 1=1  "&_
			 " and tmId = 1  "&_
			 " and pId in (select iId from ts_items with(nolock) where tmId = 1 and itemName = '������ֵ˰˰��' and pId = 0 and isEnable = 1) "&_
			 " order by itemName "
	CreateSltFinanceVatTaxRateListByIncome = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", keys, values)
End Function


'��ֵ˰˰�� - �ɱ�
Function CreateSltFinanceVatTaxRateListByCost(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select itemName, itemName = (cast((cast(itemName as float) * 100) as varchar(20)) + '%') from ts_items with(nolock) where 1=1  "&_
			 " and tmId = 1  "&_
			 " and pId in (select iId from ts_items with(nolock) where tmId = 1 and itemName = '�ɱ���ֵ˰˰��' and pId = 0 and isEnable = 1) "&_
			 " order by itemName "
	CreateSltFinanceVatTaxRateListByCost = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", keys, values)
End Function


'2013-07-02
'�ж�ǩ֤����
Function CreateSltSignUpByVisaTypeInfo(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("ǩ֤����","��ǩ","��ǩ","�Ա�","��ǩ","��ǩ","����","����","̽��")
	Dim arrValue : arrValue = Array("","��ǩ","��ǩ","�Ա�","��ǩ","��ǩ","����","����","̽��")
	CreateSltSignUpByVisaTypeInfo = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function
%>