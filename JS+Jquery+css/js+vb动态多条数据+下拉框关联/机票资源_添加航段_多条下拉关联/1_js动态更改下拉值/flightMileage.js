var iCnt = 0;
var FltMlg = {
	AddFltMlgTab : function(num){
		var clonedivfirst = $('divfirst').cloneNode(true);
		//var cloneTab 	  = $('tabOne').cloneNode(true);
		//var cloneTr1	  = $('tabTr3').cloneNode(true);
		var objTBody = document.createElement("tbody");
    	
		var addNum		= parseInt($('copyNum').value)+2;
		clonedivfirst.style.display = "";
		$('copyNum').value =++iCnt;									
		var urlStart 		= 'flightMileageAdd.asp?action=toSltDepartureCode&strNum='+ addNum;
		var urlEnd			= 'flightMileageAdd.asp?action=toSltArriveCode&strNum='+ addNum;

			new Ajax.Request(urlStart,{
				onComplete: function(t){
					if(t.responseText != ''){
						var departCodeNode = $("tabOne").rows[0].cells[0].children[0].childNodes[0].rows[2].cells[3];
						var sltDepartCode = t.responseText+'<label id="showDepartAirport'+ addNum +'" class="font_gray"></label><input type="hidden" name="departureAirport'+ addNum +'" id="toGetEmpId'+ addNum +'" />';
						departCodeNode.innerHTML =  sltDepartCode;
					}
				}
			});
			
			new Ajax.Request(urlEnd,{
				onComplete: function(t){
					if(t.responseText != ''){
						var arriveCodeNode = $("tabOne").rows[0].cells[0].children[0].childNodes[0].rows[3].cells[3];
						var sltarriveCode = t.responseText+'<label id="showArriveCode'+ addNum +'" class="font_gray"></label><input type="hidden" name="arriveAirport'+ addNum +'" id="arriveAirport'+ addNum +'" />';
						arriveCodeNode.innerHTML =  sltarriveCode;
					}
				}
			});


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
	
	},
	
	AddFltMlgTab2 : function(num){
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
		
	},
	
	CutFltMlgTab : function(){
		var objTab = $("tabOne");
		objTab.removeChild(objTab.childNodes[iCnt]);
		$('copyNum').value = --iCnt;
		if(parseInt(iCnt) == 0){
			$("btnSub").disabled = true;												//����
		}else if(parseInt(iCnt)  < num-1 && parseInt(iCnt)  > 0){
			$("btnAdd").disabled = false;												//����
			$("btnSub").disabled = false;
		}else if(parseInt(iCnt)  == num-1){
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
			$("frmAdd").action = 'flightMileageAdd.asp?action=createFlgMlgAdd';				//����������ת·��
			$("frmAdd").submit();
		}
	},
	
	toCheckFltMlgAdd : function(){
		var tdNum			=	parseInt($("copyNum").value)+1;									//��ȡ��ӵ�����
		var fltNo			=	document.getElementsByName("flightNo");
		var dayNum			=	document.getElementsByName("dayNum");
		var sPoint			=	document.getElementsByName("startPoint");
		var sTime			=	document.getElementsByName("startTime");
		var ePoint			=	document.getElementsByName("endPoint");
		var eTime			=	document.getElementsByName("leaveTime");
		var departAirport	=	document.getElementsByName("departureAirport");
		var departCode		=	document.getElementsByName("departureCode");
		var arriveAirport	=	document.getElementsByName("arriveAirport");
		var arriveCode		=	document.getElementsByName("arriveCode");
		var airfares		=	document.getElementsByName("airfares");
		var planeTypes		=	document.getElementsByName("planeTypes");
		var terminal		=	document.getElementsByName("terminal");
		
		
		for(var i = 0; i< tdNum; i++){
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
			if(terminal[i].value.blank()){
				alert("����д����վ¥����");
				terminal[i].focus();
				return false;
			}
			if(planeTypes[i].value.blank()){
				alert("��ѡ�񡾷ɻ����͡���");
				planeTypes[i].focus();
				return false;
			}
			if(sPoint[i].value.blank()){
				alert("����д���������С���д��");
				sPoint[i].focus();
				return false;
			}
			if(departCode[i].value.blank()){
				alert("��ѡ�񡾳������������𡿣�");
				departCode[i].focus();
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
				alert("��ѡ�񡾵ִ���������롿��");
				arriveCode[i].focus();
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
		var url = '?action=toShowSltArriveAirport&arriveCode='+objArriveCode;
		new Ajax.Request(url,{
			onComplete: function(t){
				if(t.responseText != ''){	
				alert($('arriveAirport'+addTrNum).value);	
					$('showArriveCode'+addTrNum).update(t.responseText);
					$('arriveAirport'+addTrNum).value = t.responseText;
				alert($('arriveAirport'+addTrNum).value);	
				}
			}
		})
	},
	//��ȡѡ����
	getCheckedTrNum	: function(objTrNum){
		$('ckdTrNum').value = objTrNum;
	},
	
		//������õ��ܶ�
	checkDayNum : function(objDay){
		if($('dayNum').value != null){
			if(isNaN(dayNum.value)) el.value = '';
		}
	}
	
	
}

