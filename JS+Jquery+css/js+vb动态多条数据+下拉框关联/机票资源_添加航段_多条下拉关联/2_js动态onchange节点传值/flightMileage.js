var iCnt = 0;
var FltMlg = {
	AddFltMlgTab : function(num){
		$('tabMsg').style.display = "none";				//������ʾ��Ϣ
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
		
		// ���ݺ���Ŵ������չ�˾ȫ���¼�
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
		
		// ���������������¼�
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
		
		// �ִ�����������¼�
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
			$("btnSub").disabled = true;													//����
		}else if(parseInt(iCnt)  < num && parseInt(iCnt)  > 0){
			$("btnAdd").disabled = false;													//����
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
						+'						<td width="10%"><span class="font_red">*</span> �ڼ��죺</td>'
						+'						<td width="20%"><input type="text" name="dayNum'+i+'" id="dayNum'+i+'" size="5" class="textStyleDefault" onkeyup=""/>&nbsp; <span class="font_gray">/ ��</span></td>'
						+'						<td width="10%"><span class="font_red">*</span> ����ţ�</td>'
						+'						<td width="22%"><input type="text" name="flightNo'+i+'" id="flightNo'+i+'" size="20" class="textStyleDefault" /></td>'
						+'						<td width="10%"><span class="font_red">*</span> ��λ��</td>'
						+' 						<td><input type="text" name="airfares'+i+'" id="airfares'+i+'" size="20" class="textStyleDefault" /></td>'
						+'					</tr>'
						+'					<tr>'
						+'						<td><span class="font_red">*</span> ��վ¥��</td>'
						+'						<td><input type="text" name="terminal'+i+'" id="terminal'+i+'" class="textStyleDefault"/></td>'
						+'						<td><span class="font_red">*</span>�ɻ����ͣ�</td>'
						+'						<td><input type="text" name="planeTypes'+i+'" id="planeTypes'+i+'" size="20" class="textStyleDefault"/></td>'
						+'						<td><span class="font_red">*</span> �Ƿ��ҹ��</td>'
						+'						<td><select name="sltNight'+i+'" id="sltNight'+i+'">'
						+'						 		<option id="opIsNight" value="0">��</option>'
						+'								<option id="opIsNight" value="1">��</option>'
						+'						</select>&nbsp; <span class="font_gray">Ĭ���"��"</span></td>'
						+'					</tr>'
						+'					<tr>'
						+'						<td><span class="font_red">*</span> �������У�</td>'
						+'						<td><input type="text" name="startPoint'+i+'" id="startPoint'+i+'" size="20" class="textStyleDefault" /></td>'
						+'						<td><span class="font_red">*</span> ��������(������)��</td>'
						+'						<td><%=CreateSltFltItemName("departureCode'+i+'","-��������������-",sltDepartCode,"onchange","FltMlg.toShowDepartAirport(this[this.selectedIndex].value);")%>'
						+'							<label id="showDepartAirport'+i+'" class="font_gray">&nbsp;</label>'
						+'							<input type="hidden" name="departureAirport'+i+'" id="departureAirport'+i+'" size="20" />'									
						+'						</td>'
						+'						<td><span class="font_red">*</span> ���ʱ�䣺</td>'
						+'						<td><input type="text" name="startTime'+i+'" id="startTime'+i+'" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="cur_hand;textStyleDefault" /><label>&nbsp;</label>'
						+'							<label><%=CreateSltByTimeHour("leaveOnHour", "10", "", "", "")%> ʱ</label>'
						+'							<label><%=CreateSltByTimeMinute("leaveOnMinute", "00", "", "", "")%> ��</label>'
						+'							<label><%=CreateSltByTimeMinute("leaveOnSecond", "00", "", "", "")%> ��</label>'
						+'						</td>'
						+'					</tr>'
						+'					<tr>'
						+'						<td><span class="font_red">*</span> �ִ���У�</td>'
						+'						<td><input type="text" name="endPoint'+i+'" id="endPoint'+i+'" size="20" class="textStyleDefault" /></td>'
						+'						<td><span class="font_red">*</span> �ִ����(������)��</td>'
						+'						<td><span id=""></span>'
						+'							<label id="showArriveCode'+i+'" class="font_gray">&nbsp;</label>'
						+'							<input type="hidden" name="arriveAirport'+i+'" id="arriveAirport'+i+'" size="20" />'
						+'						</td>'
						+'						<td><span class="font_red">*</span> �ﵽʱ�䣺</td>'
						+'						<td><input type="text" name="leaveTime'+i+'" id="leaveTime'+i+'" onclick="return showCalendarByEl(this);" size="12" maxlength="12" readonly="readonly" class="cur_hand;textStyleDefault" /><label>&nbsp;</label>'
						+'							<label><%=CreateSltByTimeHour("returnOnHour", "10", "", "", "")%> ʱ</label>'
						+'							<label><%=CreateSltByTimeMinute("returnOnMinute", "00", "", "", "")%> ��</label>'
						+'							<label><%=CreateSltByTimeMinute("returnOnSecond", "00", "", "", "")%> ��</label>'
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
				$("btnSub").disabled = true;													//����
			}else if(parseInt(iCnt)  < num-1 && parseInt(iCnt)  > 0){
				$("btnAdd").disabled = false;													//����
				$("btnSub").disabled = false;
			}else if(parseInt(iCnt)  == num-1){
				$("btnAdd").disabled = true;
			}
		
	},*/
	
	//������
	CutFltMlgTab : function(num){
		var objTab = $("tabOne");
		//alert(iCnt);
		objTab.removeChild(objTab.childNodes[iCnt--]);
		$('copyNum').value	= iCnt;
		
		if(parseInt(iCnt) == 0){
			$('tabMsg').style.display = "";
			$('tabOne').style.display = "none";
			$("btnSub").disabled = true;												//����
		}else if(parseInt(iCnt)  < num && parseInt(iCnt)  > 0){
			$("btnAdd").disabled = false;												//����
			$("btnSub").disabled = false;
		}else if(parseInt(iCnt)  == num ){
			$("btnAdd").disabled = true;
		}
		
	},
	
	//��ת������ҳ
	toFlightMileageAdd : function(objFlightId){
		toUrl('flightMileageAdd.asp?flightId='+objFlightId, '_blank');
	},
	
	//��ת��ɾ��������action
	toFlightMileageDelete : function(objFmId,objFlightId){
		if(window.confirm("��ȷ��Ҫɾ��������")){
			toUrl('flightMileageList.asp?action=fltMileageDelete&fmId='+objFmId+'&flightId='+objFlightId, '_blank');
		}
	},
	
	//��ת���޸�ҳ
	toFlightMileageUpdate : function(objFmId, objFlightId){
		toUrl('flightMileageUpdate.asp?fmId='+objFmId +'&flightId='+objFlightId, '_blank');
	},
	
	//�ύ��֤
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
				alert("���顾�ڼ��졿��д��"); 
				dayNum[i].focus();
				return false;
			}
			if(fltNo[i].value.blank()){
				alert("���顾����κš���д��"); 
				fltNo[i].focus();
				return false;
			}
			if(airfares[i].value.blank()){
				alert("����д����λ����");
				airfares[i].focus();
				return false;
			}
			if(planeTypes[i].value.blank()){
				alert("��ѡ�񡾷ɻ����͡���");
				planeTypes[i].focus();
				return false;
			}
			if(sPoint[i].value.blank()){
				alert("����д���������С���");
				sPoint[i].focus();
				return false;
			}
			if(departCode[i].value.blank()){
				alert("��ѡ�񡾳�����������");
				departCode[i].focus();
				return false;
			}
			if(departTerminal[i].value.blank()){
				alert("��ѡ�񡾳�����վ¥����");
				departTerminal[i].focus();
				return false;
			}
			if(sTime[i].value.blank()){
				alert("��ѡ�����ʱ�䡿��");
				sTime[i].focus();
				return false;
			}
			if(ePoint[i].value.blank()){
				alert("����д���ִ���С���");
				ePoint[i].focus();
				return false;
			}
			if(arriveCode[i].value.blank()){
				alert("��ѡ�񡾵ִ��������");
				arriveCode[i].focus();
				return false;
			}
			if(arriveTerminal[i].value.blank()){
				alert("��ѡ�񡾵ִﺽվ¥����");
				arriveTerminal[i].focus();
				return false;
			}
			if(eTime[i].value.blank()){
				alert("��ѡ�񡾵���ʱ�䡿��");
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
			alert("���顾����κš���д��"); 
			fltNo.focus();
			return false;
		}
		if(dayNum.value.blank()){
			alert("���顾�ڼ��졿��д��"); 
			dayNum.focus();
			return false;
		}
		if(sPoint.value.blank()){
			alert("����д����㡿��д��");
			sPoint.focus();
			return false;
		}
		if(sTime.value.blank()){
			alert("��ѡ�����ʱ�䡿��");
			sTime.focus();
			return false;
		}
		if(ePoint.value.blank()){
			alert("���顾�յ㡿��д��");
			ePoint.focus();
			return false;
		}
		if(eTime[i].value.blank()){
			alert("��ѡ�񡾵���ʱ�䡿��");
			eTime[i].focus();
			return false;
		}
	},
	
	//�������������������¼�
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
	
	//�ִ�����������¼�
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
	//��ȡѡ����
	getCheckedTrNum	: function(objTrNum){
		alert(objTrNum);
		$('ckdTrNum').value = objTrNum;
	},
	
	//��֤�����Ƿ��������
	checkDayNum : function(objDay){
		if($('dayNum').value != null){
			if(isNaN($('dayNum').value)){
				$('dayNum').value = '';
			}
		}
	}
	
	
}

