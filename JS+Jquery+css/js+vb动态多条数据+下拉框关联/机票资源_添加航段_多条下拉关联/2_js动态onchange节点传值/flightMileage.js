var iCnt = 0;
var FltMlg = {
	AddFltMlgTab : function(num){
		$('tabMsg').style.display = "none";				//隐藏提示信息
		$('tabOne').style.display = "";
		
		var clonedivfirst		=	$('divfirst').cloneNode(true);
		var objTBody			=	document.createElement("tbody");
		
		var objInputAirLine		= 	null;
		var objSltDepartCode	=	null;
		var objSltArriveCode	=	null;
		clonedivfirst.style.display = "";
		
		$('copyNum').value	= ++iCnt;

		objTBody.appendChild(clonedivfirst);				
		$("tabOne").appendChild(objTBody);
		
		// 根据航班号触发航空公司全称事件
		objInputAirLine = objTBody.getElementsByTagName("td")[0].getElementsByTagName("input")[1];
		objInputAirLine.onblur = function(){
			var urlAirLine = 'flightMileageAdd.asp?action=toGetAirLineName&strAirCode='+this.value.substring(2,0);
			new Ajax.Request(urlAirLine,{
				onComplete: function(t){
					if(t.responseText == 0){
						objTBody.getElementsByTagName("td")[0].getElementsByTagName("input")[2].value = "";
						objTBody.getElementsByTagName("td")[0].getElementsByTagName("input")[3].value = "";
					}else{
						var arrAirName	= t.responseText.split(",");
						objTBody.getElementsByTagName("td")[0].getElementsByTagName("input")[2].value = arrAirName[0];
						objTBody.getElementsByTagName("td")[0].getElementsByTagName("input")[3].value = arrAirName[1];
					}
				}
			})
		}
		
		// 出发机场三字码事件
		objSltDepartCode = objTBody.getElementsByTagName("td")[0].getElementsByTagName("select")[1];
		objSltDepartCode.onchange = function(){
			var urlStart = "/inc/action/flightMileageAction.asp?action=toShowSltDepartAirport&departCode="+this.options[this.selectedIndex].value+"&strNum="+ $('copyNum').value;
			new Ajax.Request(urlStart,{
				onComplete: function(t){
					if(t.responseText != ''){
						objTBody.getElementsByTagName("td")[0].getElementsByTagName("select")[1].parentNode.childNodes[2].value = t.responseText;
					}
				}
			});			
		};
		
		// 抵达机场三字码事件
		objSltArriveCode = objTBody.getElementsByTagName("td")[0].getElementsByTagName("select")[6];
		objSltArriveCode.onchange = function(){
			var urlStart 		= "/inc/action/flightMileageAction.asp?action=toShowSltDepartAirport&departCode="+this.options[this.selectedIndex].value+"&strNum="+ $('copyNum').value;
			new Ajax.Request(urlStart,{
				onComplete: function(t){
					if(t.responseText != ''){
						objTBody.getElementsByTagName("td")[0].getElementsByTagName("select")[6].parentNode.childNodes[2].value = t.responseText;
					}
				}
			});			
		};
		
        $("btnSub").disabled = false;
		
		if(parseInt(iCnt) == 0){
			$("btnSub").disabled = true;													//禁用
		}else if(parseInt(iCnt)  < num && parseInt(iCnt)  > 0){
			$("btnAdd").disabled = false;													//启用
			$("btnSub").disabled = false;
		}else if(parseInt(iCnt)  == num){
			$("btnAdd").disabled = true;
		}
		
	},
	
	/*AddFltMlgTab2 : function(num){
		var clonedivfirst	= $('divfirst').cloneNode(true);
		var objTBody		= document.createElement("tbody");
    	var addTabInfo		= '';
		var addNum			= parseInt($('copyNum').value)+1;
		clonedivfirst.style.display = "";
		$('copyNum').value =	++iCnt;									
		//var urlStart 		= 'flightMileageAdd.asp?action=toSltDepartureCode&strNum='+ addNum;
		//var urlEnd			= 'flightMileageAdd.asp?action=toSltArriveCode&strNum='+ addNum;
		for(var i=1 ; i<= addNum; i++){
			addTabInfo = '<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabOne">'
						+'	<tbody id="tTabSignUpInfo">'
						+'		<tr id="divfirst" style="display:block;">'
						+'			<td>'
						+'				<table width="100%" border="0" cellpadding="2" cellspacing="1" class="tabStyle16" id="tabTwo">'
						+'					<tr>'
						+'						<td width="10%"><span class="font_red">*</span> 第几天：</td>'
						+'						<td width="20%"><input type="text" name="dayNum'+i+'" id="dayNum'+i+'" size="5" class="textStyleDefault" onkeyup=""/>&nbsp; <span class="font_gray">/ 天</span></td>'
						+'						<td width="10%"><span class="font_red">*</span> 航班号：</td>'
						+'						<td width="22%"><input type="text" name="flightNo'+i+'" id="flightNo'+i+'" size="20" class="textStyleDefault" /></td>'
						+'						<td width="10%"><span class="font_red">*</span> 舱位：</td>'
						+' 						<td><input type="text" name="airfares'+i+'" id="airfares'+i+'" size="20" class="textStyleDefault" /></td>'
						+'					</tr>'
						+'					<tr>'
						+'						<td><span class="font_red">*</span> 航站楼：</td>'
						+'						<td><input type="text" name="terminal'+i+'" id="terminal'+i+'" class="textStyleDefault"/></td>'
						+'						<td><span class="font_red">*</span>飞机机型：</td>'
						+'						<td><input type="text" name="planeTypes'+i+'" id="planeTypes'+i+'" size="20" class="textStyleDefault"/></td>'
						+'						<td><span class="font_red">*</span> 是否过夜：</td>'
						+'						<td><select name="sltNight'+i+'" id="sltNight'+i+'">'
						+'						 		<option id="opIsNight" value="0">否</option>'
						+'								<option id="opIsNight" value="1">是</option>'
						+'						</select>&nbsp; <span class="font_gray">默认项："否"</span></td>'
						+'					</tr>'
						+'					<tr>'
						+'						<td><span class="font_red">*</span> 出发城市：</td>'
						+'						<td><input type="text" name="startPoint'+i+'" id="startPoint'+i+'" size="20" class="textStyleDefault" /></td>'
						+'						<td><span class="font_red">*</span> 出发机场(三字码)：</td>'
						+'						<td><%=CreateSltFltItemName("departureCode'+i+'","-出发机场三字码-",sltDepartCode,"onchange","FltMlg.toShowDepartAirport(this[this.selectedIndex].value);")%>'
						+'							<label id="showDepartAirport'+i+'" class="font_gray">&nbsp;</label>'
						+'							<input type="hidden" name="departureAirport'+i+'" id="departureAirport'+i+'" size="20" />'									
						+'						</td>'
						+'						<td><span class="font_red">*</span> 起飞时间：</td>'
						+'						<td><input type="text" name="startTime'+i+'" id="startTime'+i+'" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="cur_hand;textStyleDefault" /><label>&nbsp;</label>'
						+'							<label><%=CreateSltByTimeHour("leaveOnHour", "10", "", "", "")%> 时</label>'
						+'							<label><%=CreateSltByTimeMinute("leaveOnMinute", "00", "", "", "")%> 分</label>'
						+'							<label><%=CreateSltByTimeMinute("leaveOnSecond", "00", "", "", "")%> 秒</label>'
						+'						</td>'
						+'					</tr>'
						+'					<tr>'
						+'						<td><span class="font_red">*</span> 抵达城市：</td>'
						+'						<td><input type="text" name="endPoint'+i+'" id="endPoint'+i+'" size="20" class="textStyleDefault" /></td>'
						+'						<td><span class="font_red">*</span> 抵达机场(三字码)：</td>'
						+'						<td><span id=""></span>'
						+'							<label id="showArriveCode'+i+'" class="font_gray">&nbsp;</label>'
						+'							<input type="hidden" name="arriveAirport'+i+'" id="arriveAirport'+i+'" size="20" />'
						+'						</td>'
						+'						<td><span class="font_red">*</span> 达到时间：</td>'
						+'						<td><input type="text" name="leaveTime'+i+'" id="leaveTime'+i+'" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="cur_hand;textStyleDefault" /><label>&nbsp;</label>'
						+'							<label><%=CreateSltByTimeHour("returnOnHour", "10", "", "", "")%> 时</label>'
						+'							<label><%=CreateSltByTimeMinute("returnOnMinute", "00", "", "", "")%> 分</label>'
						+'							<label><%=CreateSltByTimeMinute("returnOnSecond", "00", "", "", "")%> 秒</label>'
						+'						</td>'
						+'					</tr>'
						+'				</table>'
						+'			</td>'
						+'		</tr>'
						+'	</tbody>'
						+' </table>'
				$("copyFltInfo").innerHTML = addTabInfo;
			}
	
			objTBody.appendChild(clonedivfirst);						
			$("tabOne").appendChild(objTBody);
			
			$("btnSub").disabled = false;
			
			if(parseInt(iCnt) == 0){
				$("btnSub").disabled = true;													//禁用
			}else if(parseInt(iCnt)  < num-1 && parseInt(iCnt)  > 0){
				$("btnAdd").disabled = false;													//启用
				$("btnSub").disabled = false;
			}else if(parseInt(iCnt)  == num-1){
				$("btnAdd").disabled = true;
			}
		
	},*/
	
	//减少行
	CutFltMlgTab : function(num){
		var objTab = $("tabOne");
		//alert(iCnt);
		objTab.removeChild(objTab.childNodes[iCnt--]);
		$('copyNum').value	= iCnt;
		
		if(parseInt(iCnt) == 0){
			$('tabMsg').style.display = "";
			$('tabOne').style.display = "none";
			$("btnSub").disabled = true;												//禁用
		}else if(parseInt(iCnt)  < num && parseInt(iCnt)  > 0){
			$("btnAdd").disabled = false;												//启用
			$("btnSub").disabled = false;
		}else if(parseInt(iCnt)  == num ){
			$("btnAdd").disabled = true;
		}
		
	},
	
	//跳转到新增页
	toFlightMileageAdd : function(objFlightId){
		toUrl('flightMileageAdd.asp?flightId='+objFlightId, '_blank');
	},
	
	//跳转到删除操作的action
	toFlightMileageDelete : function(objFmId,objFlightId){
		if(window.confirm("您确定要删除此行吗？")){
			toUrl('flightMileageList.asp?action=fltMileageDelete&fmId='+objFmId+'&flightId='+objFlightId, '_blank');
		}
	},
	
	//跳转到修改页
	toFlightMileageUpdate : function(objFmId, objFlightId){
		toUrl('flightMileageUpdate.asp?fmId='+objFmId +'&flightId='+objFlightId, '_blank');
	},
	
	//提交验证
	toSubmitFltMlg	: function(){
		if(FltMlg.toCheckFltMlgAdd()){
			var addNum = parseInt($("copyNum").value);
			$("frmAdd").action = 'flightMileageAdd.asp?action=createFlgMlgAdd&addNum='+addNum;
			$("frmAdd").submit();
		}
	},
	
	toCheckFltMlgAdd : function(){
		var tdNum			=	parseInt($("copyNum").value);	
		var fltNo			=	document.getElementsByName("flightNo");
		var dayNum			=	document.getElementsByName("dayNum");
		var sPoint			=	document.getElementsByName("startPoint");
		var sTime			=	document.getElementsByName("startTime");
		var ePoint			=	document.getElementsByName("endPoint");
		var eTime			=	document.getElementsByName("leaveTime");
		var departCode		=	document.getElementsByName("departureCode");
		var arriveCode		=	document.getElementsByName("arriveCode");
		var airfares		=	document.getElementsByName("airfares");
		var planeTypes		=	document.getElementsByName("planeTypes");
		var departTerminal	=	document.getElementsByName("departureTerminal");
		var arriveTerminal	=	document.getElementsByName("arriveTerminal");

		for(var i = 1; i<= tdNum; i++){
			if(dayNum[i].value.blank()){
				alert("请检查【第几天】填写！"); 
				dayNum[i].focus();
				return false;
			}
			if(fltNo[i].value.blank()){
				alert("请检查【航班段号】填写！"); 
				fltNo[i].focus();
				return false;
			}
			if(airfares[i].value.blank()){
				alert("请填写【舱位】！");
				airfares[i].focus();
				return false;
			}
			if(planeTypes[i].value.blank()){
				alert("请选择【飞机机型】！");
				planeTypes[i].focus();
				return false;
			}
			if(sPoint[i].value.blank()){
				alert("请填写【出发城市】！");
				sPoint[i].focus();
				return false;
			}
			if(departCode[i].value.blank()){
				alert("请选择【出发机场】！");
				departCode[i].focus();
				return false;
			}
			if(departTerminal[i].value.blank()){
				alert("请选择【出发航站楼】！");
				departTerminal[i].focus();
				return false;
			}
			if(sTime[i].value.blank()){
				alert("请选择【起飞时间】！");
				sTime[i].focus();
				return false;
			}
			if(ePoint[i].value.blank()){
				alert("请填写【抵达城市】！");
				ePoint[i].focus();
				return false;
			}
			if(arriveCode[i].value.blank()){
				alert("请选择【抵达机场】！");
				arriveCode[i].focus();
				return false;
			}
			if(arriveTerminal[i].value.blank()){
				alert("请选择【抵达航站楼】！");
				arriveTerminal[i].focus();
				return false;
			}
			if(eTime[i].value.blank()){
				alert("请选择【到达时间】！");
				eTime[i].focus();
				return false;
			}
		}
		return true;
	},
	
	toCheckUpdate : function(){
		var fltNo		=	$("flightNo");
		var dayNum		=	$("dayNum");
		var sPoint		=	$("startPoint");
		var sTime		=	$("startTime");
		var ePoint		=	$("endPoint");
		var eTime		=	$("leaveTime");
		if(fltNo.value.blank()){
			alert("请检查【航班段号】填写！"); 
			fltNo.focus();
			return false;
		}
		if(dayNum.value.blank()){
			alert("请检查【第几天】填写！"); 
			dayNum.focus();
			return false;
		}
		if(sPoint.value.blank()){
			alert("请填写【起点】填写！");
			sPoint.focus();
			return false;
		}
		if(sTime.value.blank()){
			alert("请选择【起飞时间】！");
			sTime.focus();
			return false;
		}
		if(ePoint.value.blank()){
			alert("请检查【终点】填写！");
			ePoint.focus();
			return false;
		}
		if(eTime[i].value.blank()){
			alert("请选择【到达时间】！");
			eTime[i].focus();
			return false;
		}
	},
	
	//下拉出发机场三字码事件
	toShowDepartAirport : function(objDepartCode){
		var addTrNum	=	$('ckdTrNum').value;
		alert(addTrNum);
		var url = '?action=toShowSltDepartAirport&departCode='+objDepartCode;
		new Ajax.Request(url,{
			onComplete: function(t){
				if(t.responseText != ''){		
					$('showDepartAirport'+addTrNum).update(t.responseText);
					$('departureAirport'+addTrNum).value = t.responseText;
				}
			}
		})
	},
	
	//抵达机场三字码事件
	toShowArriveCode : function(objArriveCode){
		var addTrNum	=	$('ckdTrNum').value;
		alert(addTrNum);
		var url = '?action=toShowSltArriveAirport&arriveCode='+objArriveCode;
		new Ajax.Request(url,{
			onComplete: function(t){
				if(t.responseText != ''){	
					$('showArriveCode'+addTrNum).update(t.responseText);
					$('arriveAirport'+addTrNum).value = t.responseText;	
				}
			}
		})
	},
	//获取选中行
	getCheckedTrNum	: function(objTrNum){
		alert(objTrNum);
		$('ckdTrNum').value = objTrNum;
	},
	
	//验证天数是否包含数字
	checkDayNum : function(objDay){
		if($('dayNum').value != null){
			if(isNaN($('dayNum').value)){
				$('dayNum').value = '';
			}
		}
	}
	
	
}

