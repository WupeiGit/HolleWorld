<%
'-----------------------------------------------------------
'
'	创建公共列表
'	Create Common SelectList
'
'-----------------------------------------------------------
'	获取系统列表
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
	CreateSysSltByName = CreateSelectPlus(conn, strSql, "", elementName, "选择项目", selectedItem, eventType, eventMethod)
End Function

'预算科目列表
Function GetBudgetDataList(ByVal tsType, ByVal tsItem, ByVal listID, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Call isNoValue(listID, "listDefault")
	Call isNoValue(selectedItem, "")
	Call isNoValue(exceptItem, 0)
	Call isNoValue(eventType, "")
	Call isNoValue(eventMethod, "")
	GetBudgetDataList = GetXMLSelectItem("ts_items with(nolock) where tmID =(select tmID from ts_typeManage with(nolock) where typeName ='"& tsType &"') And pID in (select iID from ts_items with(nolock) where itemName = '"& tsItem &"' and isEnable = 1)  and isEnable = 1 ","itemDesc","itemName",listID,selectedItem,exceptItem,eventType,eventMethod)
End Function


'付款方式
Function CreateSltPayType(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	CreateSltPayType = GetSysListByItemName(ts_TypeSys, ts_itemPayType, elementName, selectedValue, "预存转入", eventType, eventMethod)
End Function

Function CreateSltPayTypePlus(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct itemName, itemName from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = '"& ts_TypeSys &"') "&_
						  " and pID in (select iID from ts_items with(nolock) where itemName = '"& ts_itemPayType &"') "&_
						  " and isEnable = 1 "
	CreateSltPayTypePlus = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'团号列表
Function CreateSltByTeamCode(ByVal codeType, ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select iId, itemName = (itemName +': '+ itemDesc) "&_
			 " from ts_items with(nolock) "&_
			 " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
			 " 		and pid = (select iId from ts_items with(nolock) where itemName = '"& codeType &"') "
	CreateSltByTeamCode = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function

'团号列表
Function CreateSltByTeamCodeName(ByVal codeType, ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select itemName, itemName = (itemName +': '+ itemDesc) "&_
			 " from ts_items with(nolock) "&_
			 " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
			 " 		and pid = (select iId from ts_items with(nolock) where itemName = '"& codeType &"') "
	CreateSltByTeamCodeName = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function

'-----------------------------------------------------------
'	获取员工列表
'-----------------------------------------------------------
Function GetEmpList(ByVal selectID,ByVal selectedValue,ByVal dept,ByVal diqu)
	Dim strSql, data
	If (dept <> "") Then dept = "dept ='"& dept &"' and "
	If (diqu = "")  Then diqu = "本地区"
	strSql = "tabZLemp with(nolock) where "& dept &" diqu ='"& diqu &"' order by [name]"
	data = GetXMLSelectItem(strSql,"empid","[name]",selectID,selectedValue,-1,"","")
	If (data = -1) Then
		getEmpList = "无数据."
	Else
		getEmpList = data
	End If
End Function


'-----------------------------------------------------------
'	方法：CreateSltByDeptAndEmp()
'	说明：封装 CreateSelectListByCommonByGroup()
'	参数：
'		frmSelectName			表单
'		selectedItem			选中项
'		defaultOptionText		默认项
'		cssStyle				样式定义
'	返回：HTMLDocumentElement
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
' 方法CreateSltAboutCompStructure：创建关于公司组织结构 select 下拉列表框
' 参数：objCon				：数据库连接对象(引用类型)
'		sltId				：id
'		sltName				：name
'		strFirstItem		：首选项
'		strSelectedItem		：被选中项
'		isSltGrp			：分组后组名是否可选(True：可选；False：不可选)
'		eventType			：事件类型
'		eventHandle			：事件方法
' 返回值：select 下拉列表框
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

	'加入事件，eventType为事件类型(onClick,onChange);eventMehtod为调用的方法
	If (eventType <> "" And eventHandle <> "") Then objSelect.Attributes.SetNamedItem(objTag.CreateNode(2,eventType,"")).Text = eventHandle
	objSelect.Attributes.SetNamedItem(objTag.CreateNode(2,"name","")).Text = sltName
	objSelect.Attributes.SetNamedItem(objTag.CreateNode(2,"id","")).Text = sltId
	
	'创建 option 首选项
	If (strFirstItem <> "") Then
		Call CreateOption(objTag,objOption,"option",strSelectedItem,"",strFirstItem)
		objSelect.AppendChild(objOption)
	End If
	
	'填充
	On Error Resume Next
	strSql = "select di_id,di_name from ts_deptInfo with(nolock) where di_pid = 0 And isNull(di_isCancel,0) != 1 order by di_name asc"
	If GetRs(objRs,strSql) Then
		arr1 = objRs.GetRows(-1) : objRs.Close()
	End If
	
	'加入其他项
	For i = 0 To UBound(arr1,2)
		strSql = "select di_id,di_name,di_pid from ts_deptInfo with(nolock) where di_pid = "&arr1(0,i)&" order by di_name asc"
		If GetRs(objRs,strSql) Then
			arr2 = objRs.GetRows(-1) : objRs.Close()
		End If
		
		' 进行分组
		If IsArray(arr2) Then
			If isSltGrp = True Then		' 分组可以被选中
				Call CreateOption(objTag,objOption,"option",strSelectedItem,arr1(0,i),arr1(1,i))
				objSelect.AppendChild(objOption)
			Else						' 分组不能被选中
				Call CreateOption(objTag,objOptGup,"optgroup",strSelectedItem,arr1(1,i),"")
			End If
			
			strSign = "├"
			
			For j = 0 To UBound(arr2,2)
				If j = UBound(arr2,2) Then strSign = "└"
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
		CreateSltAboutCompStructure = -1	'未创建项
	End If
	
	If Err.Number <> 0 Then
		Err.Clear
		CreateSltAboutCompStructure = "加载失败"
		Exit Function
	End If
	
	Set objOptGup = Nothing
	Set objOption = Nothing
	Set objSelect = Nothing
	Set objTag = Nothing
	Set objRs = Nothing
End Function


'公司分支列表
'Function CreateSltStructure(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim strSql
'	strSql = " select s_id, s_name from ts_structure with(nolock) where isEnable = 1 order by s_name "
'	CreateSltStructure = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
'End Function

Function CreateSltStructure(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrValue : arrValue = Array("北京总部","成都分公司","上海分公司","上海众信","沈阳分公司","武汉分公司","西安分公司","哈尔滨分公司","福建分公司","杭州分公司","天津总部","天津荣业大街")
	Dim arrBody  : arrBody  = Array(1,5,3,14,9,7,10,11,12,16,13,17)
	CreateSltStructure = CreateSelectListByEasyByArrayPlus(arrValue,arrBody,elementName,selectedItem,"",firstItem,"",eventType,eventMethod)
End Function


'生成部门列表
Function CreateCBDepartmentList(ByVal elementName, ByVal selectedItems, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct di_id, "&_
	                      " deptName = (case when len(deptCode) = 3  then '' "&_
						  "                  when len(deptCode) = 6  then '　' "&_
						  "                  when len(deptCode) = 9  then '　　' "&_
						  "                  when len(deptCode) = 13 then '　　　' end) + di_name, "&_
						  " deptCode "&_
						  " from ts_deptInfo with(nolock) "&_
						  " where di_iscancel <> 1 "
	strSql = strSql & " order by deptCode "
	CreateCBDepartmentList = CreateCheckBoxList(conn,strSql,elementName,selectedItems,"",1,eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	创建年份与月份列表
'---------------------------------------------------------------------------
'创建年份下拉列表
Function CreateSltByYear(ByVal frmSelectName,ByVal selectedItem,ByVal cssStyle,ByVal style,ByVal styleValue)
	CreateSltByYear = CreateSltByYearPlus(frmSelectName,selectedItem,"",cssStyle,style,styleValue)
End Function


'创建年份下拉列表
Function CreateSltByMonth(ByVal frmSelectName,ByVal selectedItem,ByVal cssStyle,ByVal style,ByVal styleValue)
	CreateSltByMonth = CreateSltByMonthPlus(frmSelectName,selectedItem,"",cssStyle,style,styleValue)
End Function


'创建年份下拉列表
Function CreateSltByYearPlus(ByVal frmSelectName,ByVal selectedItem,ByVal defaultOption,ByVal cssStyle,ByVal style,ByVal styleValue)
	Dim arrValue : arrValue = Array("2008","2009","2010","2011","2012","2013","2014","2015")
	Dim arrBody  : arrBody  = Array("2008 年度","2009 年度","2010 年度","2011 年度","2012 年度","2013 年度","2014 年度","2015 年度")
	CreateSltByYearPlus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,frmSelectName,selectedItem,"",defaultOption,cssStyle,style,styleValue)
End Function


'创建年份下拉列表
Function CreateSltByMonthPlus(ByVal frmSelectName,ByVal selectedItem,ByVal defaultOption,ByVal cssStyle,ByVal style,ByVal styleValue)
	Dim arrBody  : arrBody  = Array("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月")
	Dim arrValue : arrValue = Array("1","2","3","4","5","6","7","8","9","10","11","12")
	CreateSltByMonthPlus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,frmSelectName,selectedItem,"",defaultOption,cssStyle,style,styleValue)
End Function


'创建月份复选列表
Function CreateCBLByMonth(ByVal elementName, ByVal selectedItems,ByVal exceptItems,ByVal isCreateList,ByVal eventType,ByVal eventMethod)
	Dim arrText  : arrText  = Array("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月")
	Dim arrValue : arrValue = Array("1","2","3","4","5","6","7","8","9","10","11","12")
	CreateCBLByMonth = CreateCheckBoxListByArray(elementName,arrValue,arrText,selectedItems,exceptItems,isCreateList,eventType,eventMethod)
End Function


'创建小时列表
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

'创建分钟列表
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
'	创建洲列表(公司分类)
'---------------------------------------------------------------------------
Function CreateSltContinentByUTS(ByVal elementName, ByVal selectedItem,ByVal exceptItem,ByVal cssStyle,ByVal eventType,ByVal eventMethod)
	Dim strSql : strSql = " select itemDesc, itemDesc from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
						  " And pid = (select iId from ts_items with(nolock) where itemName = '产品所属') order by itemName asc "
	CreateSltContinentByUTS = CreateSelect(conn,strSql,elementName,elementName,"选择产品归属",selectedItem,eventType,eventMethod)
End Function

'系统-目的地分类
Function CreateSltSysContinentByType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select distinct itemName, itemName from ts_items with(nolock) "&_
						  " where tmID in (select tmID from ts_typeManage with(nolock) where typeName = '"& TS_TYPE_CONTINENT &"') and pid = 0 order by itemName asc "
	CreateSltSysContinentByType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'系统-目的地地区
Function CreateSltSysContinentByItem(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal parentItemName, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select distinct itemName, itemName from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = '"& TS_TYPE_CONTINENT &"') "&_
						  " and pid = (select iId from ts_items with(nolock) where itemName = '"& parentItemName &"') order by itemName asc "
	CreateSltSysContinentByItem = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'系统-目的地分组显示
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
	Dim arrBody  : arrBody  = Array("全部目的地","欧洲(含俄联邦)","澳洲","美洲(北美+南美)","中东非(中东+非洲)","东南亚","东北亚(日韩)","邮轮","自由行","港澳台","国内")
	Dim arrValue : arrValue = Array("","欧洲|俄联邦","澳洲","美洲|拉美","中东|非洲","东南亚","日韩|日本|韩国","邮轮","自由行","港澳台","国内")
	CreateSltSysContinentByTeamList = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "-1", "", "", eventType, eventMethod)
End Function

'业务预算 目的地
Function CreateSltByTeamCodeDesc(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("请选择目的地","欧洲","亚洲","非洲","拉丁美洲","北美洲","大洋洲")
	Dim arrValue : arrValue = Array("","欧洲","亚洲","非洲","拉丁美洲","北美洲","大洋洲")
	CreateSltByTeamCodeDesc = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "-1", "", "", eventType, eventMethod)
End Function


'---------------------------------------------------------------------------
'	创建散拼组团部门列表  度假产品自由行部
'---------------------------------------------------------------------------
'96|161|163|164|165|166|167|168|169|170|171|172|173|174|175|176|177|178|179|180|181
Function CreateSltTeamCreateDeptBySummary(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("全体操作部","欧洲中心","澳洲中心","非洲中心","美洲中心","日韩中心","邮轮中心","度假产品海岛部","度假产品自由行部","度假产品东南亚部","度假产品外阜部","专项旅游部","台湾部","上海操作部","成都操作部","沈阳操作部","西安操作部","日本部","韩国部")
	Dim arrValue : arrValue = Array("","30","32","31","99|46","48|150","86","96|163|164|165|166|167|168|169|170|171","96|172|173|174|175|176|177|178","85|179","215|217|218","102","147","16","81","119","138","48","150")
	CreateSltTeamCreateDeptBySummary = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "-1", "", "", eventType, eventMethod)
End Function


'---------------------------------------------------------------------------
'	航空公司
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

'出票公司
'Function CreateSltAirCompanyByTicket(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim strSql : strSql = " select shortName, shortName from ts_air with(nolock) where 1=1 "&_
'						  " And aID in (select distinct airCompany from tabZTtd with(nolock) where airCompany is not Null) "&_
'						  " order by shortName "
'	CreateSltAirCompanyByTicket = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
'End Function

'---------------------------------------------------------------------------
'	产品分类
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
'	产品库分类
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
'	团队相关列表
'---------------------------------------------------------------------------

'业务类型
Function CreateSltTeamService(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("散拼","单团","单项")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateSltTeamService = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,elementName,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function

Function CreateCBTeamService(ByVal elementName, ByVal selectedItems,ByVal exceptItems, ByVal isCreateList, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("散拼","单团","单项")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateCBTeamService = CreateCheckBoxListByArray(elementName, arrValue, arrBody, selectedItems, exceptItems, isCreateList, eventType, eventMethod)
End Function

'目的地
Function CreateSltContinent(ByVal elementName, ByVal selectedItem,ByVal exceptItem,ByVal cssStyle,ByVal eventType,ByVal eventMethod)
	Dim arrContinent : arrContinent = Array("欧洲","非洲","大洋洲","亚洲","北美洲","南美洲")
	Call isNoValue(selectedItem,"")
	CreateSltContinent = CreateSelectListByEasyArray(arrContinent, elementName, selectedItem, exceptItem, "请选择洲", cssStyle, eventType, eventMethod)
End Function


'产品类型
'Function CreateSltTeamKind(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim strSql : strSql = " select distinct QianZhengKind, QianZhengKind "&_
'						  " from tabXJxianLu "&_
'						  " where isNull(QianZhengKind,'') <> '' "&_
'						  " order by QianZhengKind asc "
'	CreateSltTeamKind = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
'End Function

Function CreateSltTeamKind(ByVal elementName, ByVal firstItem, ByVal selectedItem,ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrText : arrText = "无|阿根廷|埃及|埃及+迪拜|埃及+土耳其|爱尔兰|爱沙尼亚|奥|奥地利|澳大利亚|澳大利亚+新西兰|爱沙尼亚|"&_
                            "巴西|巴西+阿根廷|巴西+阿根廷+秘鲁|巴西+阿根廷+智利|巴西+阿根廷+智利+秘鲁|巴西+秘鲁|巴西+智利|巴西+智利+秘鲁|"&_
                            "波兰|博茨瓦纳|冰岛|比利时|丹麦|德|德国|迪拜|迪拜+土耳其|俄罗斯|法|法国|菲律宾|芬|芬兰|古巴|古巴+墨西哥|"&_
                            "韩国|荷|荷兰|加拿大|柬埔寨|捷克|津巴布韦|克罗地亚|肯尼亚|卢森堡|马来西亚|美国|秘鲁|摩洛哥|墨西哥|纳米比亚|"&_
                            "南非|南非+埃及|南非+迪拜|南非+肯尼亚|南非+赞比亚|南非+津巴布韦|南非+赞比亚+津巴布韦|尼泊尔|挪|挪威|葡萄牙|日本|"&_
							"瑞|瑞典|瑞士|瑞士+土耳其|瑞士+迪拜|塞班|斯里兰卡|斯洛文尼亚|泰国|泰国+马来西亚|坦桑尼亚|"&_
                            "突尼斯|土耳其|土耳其+希腊|西|西班牙|西班牙+摩洛哥|希|希腊|希腊+迪拜|新加坡|新西兰|"&_
							"匈|匈牙利|匈牙利+塞尔维亚|匈牙利+克罗地亚|叙利亚|伊朗|以色列|以色列+约旦|"&_
                            "意|意+土|意大利|意+迪拜|印度|印度+尼泊尔|英|英国|英+爱|英+法|英+意|英国+迪拜|英国+爱尔兰|英国+法国|英国+意大利|"&_
							"约旦|越南|越南+柬埔寨|智利|缅甸|尼泊尔+不丹|意大利（广州）|法国（武汉）|英国（沈阳）"
	Dim arrBody : arrBody = SplitPlus(arrText,"|")
	CreateSltTeamKind = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,elementName,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'产品所属
Function CreateSltTeamContinent(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select itemDesc, itemDesc from ts_items with(nolock) "&_
						  " where tmID = (select tmID from ts_typeManage with(nolock) where typeName = 'teamNo') "&_
						  " And pid = (select iId from ts_items with(nolock) where itemName = '产品所属') order by itemName asc "
	CreateSltTeamContinent = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'出发返回地
Function CreateSltTeamPlace(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody
	arrBody = Array("北京","上海","成都","广州","香港","沈阳","南京","杭州","天津","深圳","大连","青岛","重庆","昆明","武汉","哈尔滨","宁波","西安","郑州","呼和浩特","包头","福州","厦门","银川","兰州","长春","乌鲁木齐","石家庄","其他","境外")
	CreateSltTeamPlace = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'签证
Function CreateSltTeamVisaSummary(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
'	Dim arrText, arrBody
'	
'	arrText     = "无,ADS,阿根廷,埃及,埃及+土耳其,埃及+迪拜,埃及+申根,"&_
'				  "埃及+申根+瑞士,奥+瑞,奥+匈+捷,奥+匈+瑞,奥+匈,奥地利商签,"&_
'				  "奥,澳+新,澳大利亚,巴西,德,德+瑞,德+匈+瑞,迪拜,迪拜落地,"&_
'				  "俄,法+瑞,法+匈+瑞,法+突尼斯,法签,菲律宾,芬签,芬签+瑞士,"&_
'				  "港澳通行证,个签,韩签,荷+瑞,加拿大,柬埔寨,肯尼亚,落地签,马签,"&_
'				  "美国,美国+加拿大,秘鲁,南非,南非+埃及,南非+迪拜,南非+肯落地,"&_
'				  "南非ADS,南非ADS+史瓦济兰落地,尼泊尔,挪+俄,挪威,日本,瑞签,瑞+意+匈,"&_
'				  "塞班,申根,申根+埃及,申根+瑞+匈,申根+瑞士,申根+匈+捷,申根多次,"&_
'				  "泰国,突尼斯,土耳其,土耳其+希腊,西班牙,希腊,新加坡,新加坡+泰国,"&_
'				  "新加坡+越南+马来西亚,意+瑞,意+瑞+匈,意+马耳他,意大利,意大利1次,意大利2次,意大利多次,"&_
'				  "印度,印度+尼泊尔,印尼,英+法,英+瑞,英国,英国商签+申根+瑞士,越南,智利"
'	
'	arrBody = SplitPlus(arrText,",")
'	CreateSltTeamVisaSummary = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
	CreateSltTeamVisaSummary = CreateSltTeamKind(elementName, firstItem, selectedItem, exceptItem, eventType, eventMethod)
End Function


'团队状态
Function CreateSltTeamReportType(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("真实团","虚开团","虚转实","作废团")
	Dim arrValue : arrValue = Array(1,2,3,0)
	CreateSltTeamReportType = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'新产品列表
Function CreateSltTeamRemind(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select trId, title from ts_teamRemind with(nolock) where isEnable = 1 order by title asc "
	CreateSltTeamRemind = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'收客状态
Function CreateSltTeamOpenStatus(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("正常","取消")
	Dim arrValue : arrValue = Array(1,0)
	CreateSltTeamOpenStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'取消状态
Function CreateSltTeamCancelStatus(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("正常","取消")
	Dim arrValue : arrValue = Array(0,1)
	CreateSltTeamCancelStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,exceptItem,firstItem,"",eventType,eventMethod)
End Function


'单项类型
Function CreateSltTeamSingleItemType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal keys, ByVal values)
	Dim strSql : strSql = "select itemName, itemName from ts_items with(nolock) where pId = (select iId from ts_items with(nolock) where itemName = '单项类型') order by itemName "
	CreateSltTeamSingleItemType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", keys, values)
End Function


'团队搜索关键字
Function CreateSltTeamSearchType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("团号","财务号","预定号","产品名称","产品类型","客户","出发地","签证","组团人","OP","团队编号","线路号")
	Dim arrValue : arrValue = Array("tuanNo","financeCode","scheduleNo","xlName","teamKind","agentName","cfdi","QianZhengKind","ztRen","accepter","tdid","lineKey")
	CreateSltTeamSearchType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'邮轮列表
Function CreateSltShipList(ByVal elementName, ByVal firstItem, ByVal selectedItem, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim strSql
	strSql = " select shipId, shipNames = ('[' + isNull(shipCompany,shipName) + '] ' + shipName) from ts_ship with(nolock) order by shipCompany, shipName "
	CreateSltShipList = CreateSelectPlusByXML(conn, strSql, elementName, firstItem, selectedItem, exceptItem, "", eventType, eventMethod)
End Function


'采购单分类
Function CreateSltTeamPurchasingOrderType(ByVal element, ByVal firstItem, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody : arrBody = Array("PO","合同","客户确认")
	CreateSltTeamPurchasingOrderType = CreateSelectListByEasyByArrayPlus(arrBody,arrBody,element,selectedItem,"",firstItem,"",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	部门列表
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


'只显示开过团列表
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
'	成本关账状态列表
'---------------------------------------------------------------------------
Function CreateSltTeamCloseStatus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("成本关账","未关账","已关账")
	Dim arrValue : arrValue = Array("",0,1)
	CreateSltTeamCloseStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	收入关账状态列表
'---------------------------------------------------------------------------
Function CreateSltTeamIncomeStatus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("收入锁定状态","未全部锁定","已全部锁定")
	Dim arrValue : arrValue = Array("",0,1)
	CreateSltTeamIncomeStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function

'---------------------------------------------------------------------------
'	结账状态列表
'---------------------------------------------------------------------------
Function CreateSltTeamStatStatus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("结账状态","未结账","已结账")
	Dim arrValue : arrValue = Array("",0,1)
	CreateSltTeamStatStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	决算状态列表
'---------------------------------------------------------------------------
Function CreateSltTeamBudgetStatus(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("未决算","已决算","结算代替")
	Dim arrValue : arrValue = Array("0","1","2")
	CreateSltTeamBudgetStatus = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	2012-11-27
'	账款日期状态
'---------------------------------------------------------------------------
Function CreateSltTeamBudgetAccountDate(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("账款日期","正常","有空项")
	Dim arrValue : arrValue = Array("","1","0")
	CreateSltTeamBudgetAccountDate = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	财务实收 - 客户类型
'---------------------------------------------------------------------------
Function CreateSltFinanceCustomerType(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("客户类型","公户","个人","其他社","其他商务")
	Dim arrValue : arrValue = Array("","公户","个人","其他社","其他商务")
	CreateSltFinanceCustomerType = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",eventType,eventMethod)
End Function


'---------------------------------------------------------------------------
'	销售收款单汇号
'---------------------------------------------------------------------------

'境内
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

'境外
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
'	旅行社类别列表
'---------------------------------------------------------------------------
Function CreateSltTravelTypeByStatic(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("客户类别","旅行社","企业客户","个人客户","加盟门市","直营门市","众信国旅","其它")
	Dim arrValue : arrValue = Array("","旅行社","企业客户","个人客户","加盟门市","直营门市","众信国旅","其它")
	CreateSltTravelTypeByStatic = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","",cssStyle,eventType,eventMethod)
End Function


Function CreateSltTravelType(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select distinct type, type from tabZLlxs with(nolock) where isArchive = 1 order by type "
	CreateSltTravelType = CreateSelectPlusByXML(conn, strSql, element, "客户类别", selectedItem, "", "", eventType, eventMethod)
End Function

'订单来源
Function CreateSltCustomerSummaryBySource(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("全部来源","ERP","分销","网站","手机","接口")
	Dim arrValue : arrValue = Array("","ERP","分销","网站","手机","接口")
	CreateSltCustomerSummaryBySource = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, "", "", "", eventType, eventMethod)
End Function

'客户来源列表
Function CreateSltCustomerBySource(ByVal elementName, ByVal selectedValue, ByVal exceptItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("选择来源","大客户-大公司","大客户-银行保险","会员","网络","广播","合作活动","户外","口碑","平媒","直投","展会")
	Dim arrValue : arrValue = Array("","大公司","银行保险","会员","网络","广播","合作活动","户外","口碑","平媒","直投","展会")
	CreateSltCustomerBySource = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, exceptItem, "", "", eventType, eventMethod)
End Function

'获取大客户列表
Function CreateSltCustomerVip(ByVal element, ByVal selectedItem, ByVal firstItem, ByVal vipSource, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select lxsId, [name] from tabZLlxs with(nolock) where isVip = 1 and vipSource = '"& vipSource &"' order by [name] "
	CreateSltCustomerVip = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedItem, "", "", eventType, eventMethod)
End Function


'报名界面 列表方式
Function CreateSltTeamByStepUp(ByVal element, ByVal selectedItem, ByVal keys, ByVal values)
	Dim arrBody  : arrBody  = Array("全部客户","以往合作客户","本团客户")
	Dim arrValue : arrValue = Array("all","team","used")
	CreateSltTeamByStepUp = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",keys,values)
End Function

'---------------------------------------------------------------------------
'	旅行社类别列表
'---------------------------------------------------------------------------
Function CreateSltAgentArchiveBaseList(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql, rs
	strSql = " select agentId, agentName from v_agentBaseList with(nolock) order by easyCode asc, fullName asc "
	CreateSltAgentArchiveBaseList = CreateSelectPlusByXML(conn, strSql, element, "选择客户总公司", selectedItem, "", "", eventType, eventMethod)
End Function

Function CreateSltAgentArchiveSubList(ByVal element, ByVal selectedItem, ByVal eventType, ByVal eventMethod)
	Dim strSql, rs
	strSql = " select agentId, agentName from v_agentSubList with(nolock) where isArchive = 1 order by easyCode asc, name asc "
	CreateSltAgentArchiveSubList = CreateSelectPlusByXML(conn, strSql, element, "选择客户", selectedItem, "", "", eventType, eventMethod)
End Function

Function CreateSltAccountType(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("账款交易类型","存入","取出","转入","转出")
	Dim arrValue : arrValue = Array("","存入","取出","转入","转出")
	CreateSltAccountType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, "", "", "", eventType, eventMethod)
End Function

Function CreateSltIsArchive(ByVal elementName, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("未归档","已归档")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltIsArchive = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, elementName, selectedValue, "", "", "", eventType, eventMethod)
End Function

'创建地区列表
Function CreateSltAreaList(ByVal elementName, ByVal selectedValue)
	Dim rs, strSql : strSql = "select distinct diQu, diQu from tabZLlxs with(nolock) where isNull(diQu,'')!='' And isNull(updateTime,'')!='' order by diQu asc"
	CreateSltAreaList = CreateSelectPlus(conn,strSql,elementName,elementName,"全部地区",selectedValue,"","")
End Function


'---------------------------------------------------------------------------
'	获取财务人员列表
'---------------------------------------------------------------------------
Function CreateSltFinanceManager(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select empId, empName from v_emplist with(nolock) "&_
			 " where 1=1 "&_
			 " 		and empId in (select empId from [dbo].[tabSetPurview] with(nolock) where isnull([budget_auditingByFinance],'') = '1') "&_
			 " 		and deptName not in ('ERP部','北京总部','收益控制部','证券事务部') "&_
			 " 		and isEnable = 1 "&_
			 " order by sId, empName "

'	strSql = " select emp.empId, emp.[name], d.s_id  "&_
'			 " from tabzlemp emp with(nolock) "&_
'			 " left join ts_deptInfo d with(nolock) on d.di_id = emp.di_id "&_
'			 " where (emp.deptCode = 'U01009' "&_
'			 " 		Or (emp.[name] in ('潘峰','缪莹','王一之','金萍','祝雷','金淑敏') And emp.deptCode = 'U02') "&_
'			 " 		Or (emp.[name] in ('王凌') And emp.deptCode = 'U010020060001') "&_
'			 "    	Or (emp.[name] in ('史明刚','罗平') And emp.deptCode = 'U03') "&_
'			 "    	Or (emp.[name] in ('张颖','许强','王林') And emp.deptCode = 'U06') "&_
'			 "    	Or (emp.[name] in ('王威赫') And emp.deptCode = 'U08') "&_
'			 " ) "&_
'			 " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(sp.user_Login,'') = '1' ) "&_
'			 " And emp.isEnable = 1 "&_
'			 " order by s_id, emp.[name] "
	CreateSltFinanceManager = CreateSelectPlusByXML(conn,strSql,element,"财务人员",selectedItem,"",cssStyle,keys,values)
End Function

Function CreateSltFinanceManagerPlus(ByVal element, ByVal selectedItem, ByVal cssStyle, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select emp.empId, emp.[name], d.s_id  "&_
			 " from tabzlemp emp with(nolock) "&_
			 " left join ts_deptInfo d with(nolock) on d.di_id = emp.di_id "&_
			 " where emp.empId in (select distinct financeManager from tabZTtd with(nolock) where isNull(financeManager,'') != '') "&_
			 " And emp.empid in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'') = '1') "&_
			 " order by s_id, emp.[name] "
	CreateSltFinanceManagerPlus = CreateSelectPlusByXML(conn,strSql,element,"财务人员",selectedItem,"",cssStyle,keys,values)
End Function


'借代标识列表
Function CreateSltFinanceByLoan(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("借","贷")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltFinanceByLoan = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'会计科目列表
Function CreateSltFinanceByAccount(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '　' "&_
			 " 		when levelValue = 3 then '　　' end) + itemName "&_
			 " from v_u8Items v with(nolock) "&_
			 " where 1=1 "&_
			 " And isEnable = 1 "&_
			 " order by codeValue "
	CreateSltFinanceByAccount = CreateSelectPlusByXML(conn,strSql,element,firstItem,selectedValue,exceptItem,"",keys,values)
End Function


'会计科目账号列表
Function CreateSltFinanceByAccountPlus(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)

	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '　' "&_
			 " 		when levelValue = 3 then '　　' end) + itemName "&_
			 " from v_u8Items v with(nolock) "&_
			 " where 1=1 "&_
			 " And struId = "& SESSION("sId") &_
			 " And isEnable = 1 "&_
			 " And (isNull(bankCode,'') <> '' Or isNull(cashClass,0) <> 0 Or levelValue <> 3) "&_
			 " order by codeValue "
	CreateSltFinanceByAccountPlus = CreateSelectPlusByXML(conn,strSql,element,firstItem,selectedValue,exceptItem,"",keys,values)
End Function


'2012-09-19
'根据付款方式，获取会计科目账号列表
Function CreateSltFinanceByAccountPlusByPay(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal payType, ByVal keys, ByVal values)

	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '　' "&_
			 " 		when levelValue = 3 then '　　' end) + itemName "&_
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
'根据付款方式，获取"人民币"会计科目账号列表
Function CreateSltFinanceByAccountPlusByPayAndCoin(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal payType, ByVal keys, ByVal values)

	Dim strSql
	strSql = " select codeValue, itemTitle = (case "&_
			 " 		when levelValue = 1 then '' "&_
			 " 		when levelValue = 2 then '　' "&_
			 " 		when levelValue = 3 then '　　' end) + itemName "&_
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
'	获取员工列表
'---------------------------------------------------------------------------
Function CreateSltEmpList(ByVal element, ByVal selectedItem, ByVal deptId, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select emp.[name], emp.[name] from tabzlemp emp with(nolock) "&_
						  " where 1=1 "&_
						  " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'0') = '1') "&_
						  " And isNull(yuancheng,'') != '1' "
						  
	If (deptId <> "") Then strSql = strSql & " And di_id = '"& deptId &"' "
	strSql = strSql & " order by name "
	CreateSltEmpList = CreateSelect(conn,strSql,element,element,"选择员工",selectedItem,eventType,eventMethod)
End Function


Function CreateSltEmpIdList(ByVal element, ByVal selectedItem, ByVal deptId, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select emp.empId, replace(emp.[name],' ','') name from tabzlemp emp with(nolock) "&_
						  " where 1=1 "&_
						  " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'0') = '1') "&_
						  " And isNull(yuancheng,'') != '1' "
	If (deptId <> "") Then strSql = strSql & " And di_id = '"& deptId &"' "
	strSql = strSql & " order by name "
	CreateSltEmpIdList = CreateSelect(conn,strSql,element,element,"选择员工",selectedItem,eventType,eventMethod)
End Function

Function CreateSltEmpIdInManyDeptList(ByVal element, ByVal selectedItem, ByVal deptId, ByVal cssStyle, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select emp.empId, replace(emp.[name],' ','') name from tabzlemp emp with(nolock) "&_
						  " where 1=1 "&_
						  " And emp.empId in (select sp.empId from tabSetPurview sp with(nolock) where isNull(user_Login,'0') = '1') "&_
						  " And isNull(yuancheng,'') != '1'  And isEnable = 1"
	If (deptId <> "") Then strSql = strSql & " And di_id in ("& deptId &") "
	strSql = strSql & " order by name "
	
	CreateSltEmpIdInManyDeptList = CreateSelect(conn,strSql,element,element,"选择员工",selectedItem,eventType,eventMethod)
End Function
'---------------------------------------------------------------------------
'	创建邮轮船舱列表
'---------------------------------------------------------------------------
Function CreateSltShip(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select shipId, shipName from ts_ship with(nolock) order by shipName "
	CreateSltShip = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", eventType, eventMethod)
End Function


Function CreateSltShipRoom(ByVal element, ByVal selectedValue, ByVal shipId, ByVal eventType, ByVal eventMethod)
	Dim strSql : strSql = " select code, roomDesc from v_shipRoomList with(nolock) where shipId = '"& shipId &"' order by roomDesc "
	CreateSltShipRoom = CreateSelectPlusByXML(conn, strSql, element, "选择船舱", selectedValue, "", "", eventType, eventMethod)
End Function


'第几人报名
Function CreateSltShipCustNumber(ByVal element, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arr : arr = Array(1,2,3,4,5,6,7,8,9,10) : Call isNoValue(selectedValue,1)
	CreateSltShipCustNumber = CreateSelectListByEasyArray(arr, element, selectedValue, "", "", "", eventType, eventMethod)
End Function

'船舱可用状态
Function CreateSltByShipEnable(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("收客","停售")
	Dim arrValue : arrValue = Array("1","0")
	CreateSltByShipEnable = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'---------------------------------------------------------------------------
'	产品主题与分类
'---------------------------------------------------------------------------

'主题
Function CreateSltTeamTheme(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select themeTitle, themeTitle from ts_teamTheme with(nolock) where isEnable = 1 order by themeTitle "
	CreateSltTeamTheme = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


'类别
Function CreateSltTeamType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select id, xlKind from tabXJxianLuKind with(nolock) where isEnable = 1 order by xlKind "
	CreateSltTeamType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

Function CreateSltTeamTypeName(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select xlKind = replace(xlKind,' ',''), xlKind from tabXJxianLuKind with(nolock) where isEnable = 1 order by xlKind "
	CreateSltTeamTypeName = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function

'---------------------------------------------------------------------------
'	API列表
'---------------------------------------------------------------------------

'API类型
Function CreateSltAPIType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select distinct fieldCode, fieldDesc from api_configField with(nolock) order by fieldDesc "
	CreateSltAPIType = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


'---------------------------------------------------------------------------
'	汇率
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

'正序与倒序
Function CreateSltOrderByType(ByVal element, ByVal selectedItem, ByVal keys, ByVal values)
	Dim arrBody  : arrBody  = Array("升序","降序")
	Dim arrValue : arrValue = Array("asc","desc")
	CreateSltOrderByType = CreateSelectListByEasyByArrayPlus(arrBody,arrValue,element,selectedItem,"","","",keys,values)
End Function


'可用选项
Function CreateSltByEnable(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("启用","禁用")
	Dim arrValue : arrValue = Array("1","0")
	CreateSltByEnable = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'是否列表
Function CreateSltByBoolean(ByVal element, ByVal selectedValue, ByVal firstItem, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("是","否")
	Dim arrValue : arrValue = Array("1","0")
	CreateSltByBoolean = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function

'---------------------------------------------------------------------------

'销售规则与策略,分组列表
Function CreateSltTacticsParent(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal exceptItem, ByVal keys, ByVal values)
	Dim strSql : strSql = " select tacticsId, tacticsTitle from ts_produceTactics with(nolock) where parentId = 0 "
	CreateSltTacticsParent = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, exceptItem, "", keys, values)
End Function


'2012-11-26
'IP类型列表
Function CreateSltByIPType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("动态","静态")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltByIPType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'2013-01-09
'财务团队类型
Function CreateSltFinanceTeamType(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("会议团","旅行团")
	Dim arrValue : arrValue = arrBody
	CreateSltFinanceTeamType = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'2013-01-09
'团队核算列表(开启后，该团将进行成本与收入抵消)
Function CreateSltFinanceAccountByIncomeAndCost(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("正常核算","代收代付")
	Dim arrValue : arrValue = Array("0","1")
	CreateSltFinanceAccountByIncomeAndCost = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function


'2013-01-24
'增值税税率 - 收入
Function CreateSltFinanceVatTaxRateListByIncome(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select itemName, itemName = (cast((cast(itemName as float) * 100) as varchar(20)) + '%') from ts_items with(nolock) where 1=1  "&_
			 " and tmId = 1  "&_
			 " and pId in (select iId from ts_items with(nolock) where tmId = 1 and itemName = '收入增值税税率' and pId = 0 and isEnable = 1) "&_
			 " order by itemName "
	CreateSltFinanceVatTaxRateListByIncome = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", keys, values)
End Function


'增值税税率 - 成本
Function CreateSltFinanceVatTaxRateListByCost(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal keys, ByVal values)
	Dim strSql
	strSql = " select itemName, itemName = (cast((cast(itemName as float) * 100) as varchar(20)) + '%') from ts_items with(nolock) where 1=1  "&_
			 " and tmId = 1  "&_
			 " and pId in (select iId from ts_items with(nolock) where tmId = 1 and itemName = '成本增值税税率' and pId = 0 and isEnable = 1) "&_
			 " order by itemName "
	CreateSltFinanceVatTaxRateListByCost = CreateSelectPlusByXML(conn, strSql, element, firstItem, selectedValue, "", "", keys, values)
End Function


'2013-07-02
'判断签证类型
Function CreateSltSignUpByVisaTypeInfo(ByVal element, ByVal firstItem, ByVal selectedValue, ByVal eventType, ByVal eventMethod)
	Dim arrBody  : arrBody  = Array("签证类型","团签","个签","自备","免签","商签","定居","居留","探亲")
	Dim arrValue : arrValue = Array("","团签","个签","自备","免签","商签","定居","居留","探亲")
	CreateSltSignUpByVisaTypeInfo = CreateSelectListByEasyByArrayPlus(arrBody, arrValue, element, selectedValue, "", firstItem, "", eventType, eventMethod)
End Function
%>