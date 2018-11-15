var iCnt =0;
var saveNode;	//ѡ��״̬
// btn event
var BtnEvent = {
	
	doSearchBusinessCost : function(obj){
		obj.disabled = true;
		if(!document.getElementById) return false;
		var coinId            = $F('coinId');
		var url = '?start='+ $F('txtCTStartDate') +'&end='+ $F('txtCTEndDate')+'&coinId='+coinId;
		$('frmBusinessCostList').action = url;
		
	},
	
	getItemNameList : function(obj){
		var categoryName = $(obj)[$(obj).selectedIndex].value;
		//var el = $(obj).parentNode.childNodes[1];
		var url = '?action=getBudgetDataList&categoryName='+categoryName;
		new Ajax.Request(url,{
			onComplete: function(t){
				//alert($(obj).parentNode.parentNode.childNodes[1].tagName);
				$(obj).parentNode.parentNode.childNodes[1].innerHTML=t.responseText;
			}
		});
	},
	
	getItemNames : function(obj){
		var categoryName = $(obj)[$(obj).selectedIndex].value;
		var url = '?action=getBudgetDataList&categoryName='+categoryName;
		new Ajax.Request(url,{
			onComplete: function(t){
				$('_itemNameList').innerHTML=t.responseText;
			}
		});		
	},
	
	getItemValue : function(obj){
		var itemCode = $(obj)[$(obj).selectedIndex].value;
		var budgetPrice = $(obj).parentNode.parentNode.childNodes[2];
		var budgetPrice_itemBalance = $(obj).parentNode.parentNode.childNodes[3];
		var itemBalance = $(obj).parentNode.parentNode.childNodes[4];
		var url = '?action=getItemValue&itemCode='+itemCode;
		new Ajax.Request(url,{
			onComplete: function(t){
				var context = t.responseText;
				//alert(context);
				budgetPrice.innerHTML=context.split(',')[0];
				budgetPrice_itemBalance.innerHTML=context.split(',')[1];
				itemBalance.innerHTML=context.split(',')[2];
			}
		});		
	},
	
	openEmps : function(empShareBcdId,closeEmpListBcdId,openEmpListBcdId){
		
		$(empShareBcdId).style.display = "block";
		$(openEmpListBcdId).style.display = "block";
		$(closeEmpListBcdId).style.display = "none";
	},
	
	closeEmps : function(empShareBcdId,closeEmpListBcdId,openEmpListBcdId){
		$(empShareBcdId).style.display = "none";
		$(openEmpListBcdId).style.display = "none";
		$(closeEmpListBcdId).style.display = "block";		
	},
	
	setBcId : function(n){
		$('_bcId').value = n.bcId;
	},
	getbcId : function(){
		return $F('_bcId');
	},
	checkBcId : function(){
		if(this.getbcId() == ''){
			alert('[��ʾ] ��ѡ��������뵥���ٽ��в�����');
			return false;
		}
		return true;
	},
	
	businessCostDetail : function(){
		if(this.checkBcId()){
			toUrl('/admin/finance/budget/businessCostDetail.asp?bcId='+ this.getbcId());
		}
	},
	
	//���ز���Ա���б�
	loadEmplist : function(){
		var deptIDs = getCheckBoxValues(document.getElementsByName('deptIDs'));
		new Ajax.Request('/inc/action/fiBusinessCostAction.asp?action=loadEmpList&deptIDs='+ deptIDs,{
			onComplete: function(t){
				if(t.responseText == '������Ϣ...'){
					$('_eIDs').update('<label class="font_gray">��ѡ���ź���в�����</label>');
				}else{
					$('_eIDs').update(t.responseText);
				}
			}
		})
	},
	
	//������õ��ܶ�
	countSumPrice : function(el){
		
		var sum = 0, sumPrice  = $('sumPrice');
		var costPrice = document.getElementsByName('costPrice');
		if(el != null){
			if(isNaN(el.value) && el.name == 'costPrice') el.value = '';
		}
		for(var i = 0; i < costPrice.length; i++){
			if(!costPrice[i].value.blank() && !isNaN(costPrice[i].value)){
				sum = sum + (parseFloat(costPrice[i].value));
			}
		}

		sumPrice.innerText = parseFloat(parseInt(sum * 10000)) / 10000;
	},
	
	checkAll : function(){
		var sltEmpId     = $F('sltEmpId');
		if (sltEmpId == '' || sltEmpId == null){
			alert('��ѡ�񾭰�����Ϣ���ٽ����ύ��');
			return false;
		}		
		var mayApplyValue      = document.getElementsByName('mayApplyValue');
		var categoryName       = document.getElementsByName('categoryName');
		var itemCode           = document.getElementsByName('itemCode');
		var costPrice          = document.getElementsByName('costPrice');
		var tableRow           = (Row.getRowTable()).rows.length - 1;
		
		for(var i = 0; i < tableRow; i++){
			if(categoryName[i].value.blank()){
				alert('��ѡ��[�������]���ٽ����ύ��');
				categoryName[i].focus();
				return false;
			}
			
			if(itemCode[i].value.blank()){
				alert('��ѡ��[���ÿ�Ŀ]���ٽ����ύ��');
				itemCode[i].focus();
				return false;
			}
			if(costPrice[i].value.blank()){
				alert('����д[������],�ٽ����ύ��');
				costPrice[i].focus();
				return false;
			}
			//if(parseFloat(mayApplyValue[i].value) < parseFloat(costPrice[i].value)){
			if(parseFloat(costPrice[i].value) >= 2000){
				alert('[������]���ܴ���[����Ԥ�����]��');
				costPrice[i].focus();
				return false;				
			}
			if(costPrice[i].value == 0){
				alert('[������]����Ϊ0��')
				costPrice[i].focus();
				return false;				
			}
		}
		
		try{ $('addBugdet').disabled = true; }catch(ex){}
		
		return true;
	},
	
	editCheckCost : function(){
		var categoryName       = $('categoryName');
		var itemCode           = $('itemCode');
		var costPrice          = $('costPrice');
		var costPriceOld       = $('costPriceOld');
		if(categoryName.value.blank()){
			alert('��ѡ��[�������]���ٽ����ύ��');
			categoryName.focus();
			return false;
		}
		if(itemCode.value.blank()){
			alert('��ѡ��[���ÿ�Ŀ]���ٽ����ύ��');
			itemCode.focus();
			return false;
		}
		if(costPrice.value.blank()){
			alert('����д[���������]���ٽ����ύ');
			costPrice.focus();
			return false;
		}

		if(costPriceOld.value < costPrice.value){
			alert('[���������]���ܳ���' + costPriceOld.value + '��');
			costPrice.focus();
			return false;
		}
		try{ $('_editCode').disabled = true;}catch(ex){}
		return true;
	},
	

	deleteBusinessCost : function(bcId){
		var frm = $('frmBusinessCostList');
		var url = '?action=deleteBusinessCost&bcId=' + bcId;
		if(confirm('�Ƿ�ȷ��ɾ���÷��ã�')){
			frm.action = url;
			frm.submit();
		}else{
			return false;	
		}			
	},
	
	delCost : function(bcId,bcdId){
		var frm = $('formBusinessCost');
		var url = '?action=delCost&bcId='+ bcId +'&bcdId=' + bcdId;
		if(confirm('�Ƿ�ȷ��ɾ���÷��ã�')){
			frm.action = url;
			frm.submit();
		}else{
			return false;	
		}			
	},
	
	delCustomer : function(bcdId,bcsId,costPrice){
		var frm = $('bcItem');
		var url = '?action=delCustomer&bcdId='+bcdId+'&bcsId='+bcsId+'&costPrice='+costPrice;
		if(confirm('�Ƿ�ȷ��ɾ���÷�̯��Ա��')){
			frm.action = url;
			frm.submit();
		}else{
			return false;
		}
		
	},
	
	
	submitCost : function(bcId){
		var frm = $('frmBusinessCostList');
		var url = '?action=submitCost&bcId='+ bcId;
		if(confirm('�Ƿ�ȷ���ύ�÷������룿')){
			frm.action = url;
			frm.submit();
		}else{
			return false;	
		}		
	},
	
	getOneDeptEmps : function(selectedValue){
		var url = '?action=getOneDeptEmps&deptId='+ selectedValue;
		var el = $('_sltEmpList');
		var n = new Nodes();
		new Ajax.Request(url,{
			onCreate: function(){
				el.update('���ڼ���...');
			},
			onComplete: function(t){
				if(t.responseText != ''){
					el.update(t.responseText);
				}
			}
		});
		
	},
	
	bcEditCustomer : function(){
		var frm = $('bcEditCustmoer');
		var bcdId = $F('bcdId');
		var eIdStr = getCheckBoxValues(document.getElementsByName('eId'));
		if(eIdStr == '' || eIdStr == null){
			alert('��ѡ���̯��Ա����');
			return false;
		}
		var url = '?action=setBcCustmoer&bcdId=' + bcdId + '&eIdStr=' + eIdStr
		frm.action = url;
		frm.submit();
		
	},
	
	// ��֤
	_checkNaN : function(obj){
		if(obj.value == '' || isNaN(obj.value)){
			obj.className = 'qs_inputWrong';
			return 0;
		}else{
			obj.className = '';
			return 1;
		}
	},


	// ȫѡ�뷴ѡ
	selectAllLine: function(elementName){
		BtnEvent.selectAll(elementName);
	},
	
	// ѡ��
	selectThisLine: function(tdNode, obj){
		BtnEvent.selectThis(tdNode, obj);
	},
	
	selectAll: function(elementName, cssStyle){
		var elements = document.getElementsByName(elementName);
		for(var i = 0; i < elements.length; i++){
			elements[i].checked = event.srcElement.checked;
			this.selectThis(elements[i].parentNode, elements[i], cssStyle);
		}
	},
	
	selectThis: function(tdNode, obj, cssStyle){
		var trNode = tdNode.parentNode;
		if(cssStyle == '' || cssStyle == null) cssStyle = 'listSelected';
		if(obj.checked) trNode.className = cssStyle;
		else trNode.className = '';
	},
	
	// ѡ����
	selectedLine : function(lineNode){
		if(saveNode!=null) saveNode.className = '';
		saveNode = lineNode;
		lineNode.className = 'listSelectedS6';
	}
	
}




var Row = {
	
	// ��ȡ���ݱ�
	getRowTable : function(){
		return $('rowTable');
	},
	
	// ��ȡ������
	getRowElements : function(){
		return $('rowElements');
	},
	
	// �������жϣ����Ϊ�ս��϶�Ϊ����
	getRowPrimaryElements : function(){
		return document.getElementsByName('costPrice');
	},
	
	// ����������
	resetRow : function(newRowNode) {
		var selects = newRowNode.getElementsByTagName('select');
		for ( var i = 0; i < selects.length; i++){
			Row.setSelectFirstOption(selects[i]);
		}
		
		var sltCreditNo = newRowNode.cells[1].childNodes[0];
		var sltLength = sltCreditNo.length;
		var optDefault = new Option('��ѡ��');
		for(var i = 0; i < sltLength; i++){
			sltCreditNo.removeChild(sltCreditNo[0]);
		}
		sltCreditNo.add(optDefault);
		
		newRowNode.cells[5].childNodes[0].value = '';
		newRowNode.cells[6].childNodes[0].value = '';
		newRowNode.className = '';
	},

	// ������Ŀ
	addRow : function(rows) {
		var rowElements = Row.getRowElements();
		var frameRowElement = rowElements.rows[1];
		if (rows == null) rows = 1;
		for ( var i = 0; i < rows; i++) {
			var newRow = frameRowElement.cloneNode(true);
			rowElements.appendChild(newRow);
			//Row.resetRow(newRow);
		}
	},
	
	// ɾ����Ŀ
	deleteLastRows : function(rows) {
		Row.deleteRows(rows, false)
	},

	// ɾ������Ŀ
	deleteBlankRows : function(rows) {
		Row.deleteRows(rows, true);
	},

	deleteRow : function(element) {
		if (element.rowIndex > 1) {
			Row.getRowElements().removeChild(element);
		} else {
			alert('[��ʾ] ���в���ɾ��!');
			return false;
		}
	},

	deleteRows : function(rows, isBlank) {
		var t = Row.getRowTable();
		var primaryElements = Row.getRowPrimaryElements();
		var tRows = t.rows.length;
		var cutRow = tRows - rows;
		
		if (cutRow <= 2) rows = 0;
		if (rows == 0) rows = tRows - 2;

		for ( var i = tRows - 1; i >= tRows - rows; i--) {
			if (!isBlank) {
				t.deleteRow(i);
			} else {
				if (primaryElements[i - 1].value.blank()) {
					t.deleteRow(i);
				}
			}
		}
	},
	
	// ѡ���б�����
	setSelectFirstOption : function(selectElement) {
		selectElement.options[0].selected = true;
	},
	
	//----------------------------------------------------------------------------
	
	// ȫѡ
	selectAll : function(){
		RowEvent.selectAll('factId','listSelectedS6');
	},
	
	// ѡ��
	selectThis : function(checkbox){
		RowEvent.selectThisLine(checkbox.parentNode,checkbox,'listSelectedS6');
	}
	
}

var CostShare ={
	// ���ӷ�̯��Ŀ
	addRowShare : function(rows){
		var strDeptId 	= $('seDeptId').value;
		var strEmpId	= $('seEmpId').value;
		var copyNum		= $('copyNum').value;	
		//var strTotalNum = parseInt(rows)+ parseInt(copyNum);
		
		if (rows == null) rows = 1;

		var objTBody 	= document.createElement("tbody");
		for ( var i= 0; i < parseInt(rows); i++){
			
			var cloneTrInfo	= $('trAddInfo').cloneNode(true);
			var copyNum		= $('copyNum').value;						
			var addNum		= parseInt(copyNum)+2;
			var url 		= 'businessCostShare.asp?action=toTestSelectEd&strNum='+ addNum;
			var urlEmp		= 'businessCostShare.asp?action=toTestSelectEmpEd&strNum='+ addNum;
			var strSelect 	= '';
			
			$('copyNum').value = ++iCnt;
			cloneTrInfo.style.display = "";
			
			cloneTrInfo.childNodes[0].innerHTML = '��&nbsp;<span class="font_red">'+addNum+'</span>&nbsp;��';
			
			new Ajax.Request(url,{
				onComplete: function(t){
					if(t.responseText != ''){
						cloneTrInfo.childNodes[1].innerHTML = t.responseText;
					}
				}
			});
			
			new Ajax.Request(urlEmp,{
				onComplete: function(t){
					if(t.responseText != ''){
						cloneTrInfo.childNodes[2].innerHTML =  '<span id="_sltEmpList'+addNum+'">'+ t.responseText +'</span>'+'<input type="hidden" name="toGetEmpId'+ addNum +'" id="toGetEmpId'+ addNum +'" />';
					}
				}
			});
			
			cloneTrInfo.childNodes[4].innerHTML = '<textarea name="shareNote'+addNum+'" id="shareNote'+addNum+'" rows="1" style="width:95%;" onfocus="this.rows=3;" onblur="this.rows=1;">���ޱ�ע</textarea>';
			//cloneTrInfo.childNodes[2].innerHTML =  '<span id="_sltEmpList'+addNum+'">'+'<%=CreateSltEmpIdInManyDeptList("sltEmpId'+addNum+'", Session("uId"), Session("deptId"), "", "onchange", "alert('+addNum+');CostShare.getSelectedEmpId('+addNum+');")%>' +'</span>'+'<input type="text" name="toGetEmpId'+ addNum +'" id="toGetEmpId'+ addNum +'" />';
			//cloneTrInfo.childNodes[2].innerValue = '<span id="_sltEmpList'+i+'"></span>';
			
			objTBody.appendChild(cloneTrInfo);
			$("rowTable").appendChild(objTBody);	
		}
		//url 		= '';
		//urlEmp		= '';
	},
	
	//��ȡѡ��Ա��ID
	getSelectedEmpId : function(objTrNum){
		//alert(objTrNum);
		//alert($('sltEmpId'+objTrNum)[$('sltEmpId'+objTrNum).selectedIndex].value);
		$('toGetEmpId'+objTrNum).value = $('sltEmpId'+objTrNum)[$('sltEmpId'+objTrNum).selectedIndex].value;
	},
	
	getCheckedTrNum	: function(objTrNum){
		$('ckdTrNum').value = objTrNum;		//��ȡ�����õ�ǰ�û�ѡ���ֵ�������ı�
	},
	
	//�������Ŷ�ӦԱ��
	getDeptEmpsShare : function(selectedValue){
		var strTrNum	= $('ckdTrNum').value;
		var url	= '?action=getOneDeptEmps&deptId='+ selectedValue+'&trNum='+strTrNum;
		var el	= $('_sltEmpList'+strTrNum);
		
		new Ajax.Request(url,{
			onCreate: function(){
				el.update('���ڼ���...');
			},
			onComplete: function(t){
				if(t.responseText != ''){
					el.update(t.responseText);
				}
			}
		});
		
	},
	
	//ɾ����̯��
	deleteRows : function(selectedValue){
			var objTab = $("rowTable");
			objTab.removeChild(objTab.childNodes[iCnt]);
			$('copyNum').value = --iCnt;								
			if(parseInt(iCnt) == 0){
				$("btnCutTb").disabled = true;
			}else{
				$("btnCutTb").disabled = false;
			}
	},
	
	
	//��֤��̯
	editCheckCostShare : function(){
		//var addNum          		= (Row.getRowTable()).rows.length - 1;
		var addNum					= parseInt($('copyNum').value)+1;
		var costOfOne         		= document.getElementsByName('costOfOne');
		var hidCostPrice			= $('costPrice').value;
		var hidSumPirce				= $('hidSumPrice').value;		//�����
		var currentPrice			= $('currentPrice').value;		//��ǰ���
		
		/*for(var i = 1; i <= addNum; i++){
			if($('sltCompDept'+i).value.blank()){
				alert('��ѡ��[��������]��');
				$('sltCompDept'+i).focus();
				return false;
			}
			if($('sltEmpId'+i).value.blank()){
				alert('��ѡ��[Ա��]��');
				$('sltEmpId'+i).focus();
				return false;
			}
			if($('shareNote'+i).value.blank()){
				alert('����д[��ע]��');
				$('shareNote'+i).focus();
				return false;
			}
		}*/
		for(var j = 0; j < addNum; j++){
			if($('sltCompDept'+parseInt(j+1)).value.blank()){
				alert('��ѡ��[��������]��');
				$('sltCompDept'+parseInt(j+1)).focus();
				return false;
			}
			if($('sltEmpId'+parseInt(j+1)).value.blank()){
				alert('��ѡ��[Ա��]��');
				$('sltEmpId'+parseInt(j+1)).focus();
				return false;
			}
			if(costOfOne[j].value.blank()){
				alert('����д[���ý��]��');
				costOfOne[j].focus();
				return false;
			}
			if(costOfOne[j].value == 0){
				alert('[���ý��]����Ϊ0��');
				costOfOne[j].focus();
				return false;
			}
			if(parseInt(hidCostPrice) < parseInt(costOfOne[j].value)){
				alert('[Ա�����������]���ܳ���' + hidCostPrice + 'Ԫ��');
				costOfOne[j].focus();
				return false;
			}
			if(parseInt(hidSumPirce) > parseInt(hidCostPrice)){
				alert('[���η�̯�ܽ��]���ܳ���' + hidCostPrice + 'Ԫ��');;
				return false;
			}
			if(parseInt(currentPrice) > parseInt(currentPrice)){
				alert('[���η�̯�ܽ��]���ܳ�������ǰ��' + currentPrice + 'Ԫ��');;
				return false;
			}
			if($('shareNote'+parseInt(j+1)).value.blank()){
				alert('����д[��ע]��');
				$('shareNote'+parseInt(j+1)).focus();
				return false;
			}
		}
		return true;
	},
	
	//�����ܽ���ֵ������
	countSumPrice : function(el){
		var sum = 0, sumPrice  = $('sumPrice');
		var costPrice = document.getElementsByName('costOfOne');
		if(el != null){
			if(isNaN(el.value) && el.name == 'costOfOne') el.value = '';
		}
		for(var i = 0; i < costPrice.length; i++){
			if(!costPrice[i].value.blank() && !isNaN(costPrice[i].value)){
				sum = sum + (parseFloat(costPrice[i].value));
			}
		}
		sumPrice.innerText = parseFloat(parseInt(sum * 10000)) / 10000;
		$('hidSumPrice').value = parseFloat(parseInt(sum * 10000)) / 10000;
	},	
	
	//��ӷ�̯
	addShare : function(bcdId){
		var frm = $('frmShareAdd');
		if(CostShare.editCheckCostShare()){
			frm.action = '?action=businessCostShareAdd&bcdId='+bcdId+'&addNum='+$F('copyNum');;
			frm.submit();
		}else{
			return false;
		}
		
	},
	
	//ɾ����̯
	delShare : function(bcdId,bcsId,costPrice){
		var frm = $('frmShareList');
		var url = '?action=delCostShare&bcdId='+bcdId+'&bcsId='+bcsId+'&costPrice='+costPrice;
		if(confirm('�Ƿ�ȷ��ɾ���÷�̯��Ա��')){
			frm.action = url;
			frm.submit();
		}else{
			return false;
		}
		
	},
	
	//��֤������
	toCheckPrice : function(currentPrice,txtPrice){
		if(txtPrice > currentPrice){
			alert("������Ľ�����");
			return false;
		}
	}
	
	
	/*֢״����ĳ��Ԫ�ص� innerHTML ����ֵʱ������ṩ�� HTML �����а���js�ű����ܶ�ʱ����Щ�ű���Ч��������ĳ�����������Ч�������������������Ч��
	
	ԭ�򣺲�ͬ������Բ��� innerHTML �еĽű��в�ͬ�Ĵ�����������ʵ�����������£� 
	
	����IE������, script ��ǩ����� defer ���ԣ����,�ڲ���ʱ�̣�innerHTML �������ڵ������ DOM ����. 
	���� Firefox ��Opera���ڲ���ʱ�̣�innerHTML �������ڵ㲻������ DOM ���С� 
	
	����������ۣ�����ͨ�õ����� innerHTML ����:*/ 

	/*
	* ������������������� innerHTML ����
	* �������� HTML �����а��� script �� style
	* ������
	*   el: DOM ���еĽڵ㣬�������� innerHTML
	*   htmlCode: ����� HTML ����
	* �����Ե��������ie5+, firefox1.5+, opera8.5+
	*/
	/*set_innerHTML : function(el, htmlCode){
			var ua = navigator.userAgent.toLowerCase();
			if (ua.indexOf('msie') >= 0 && ua.indexOf('opera') < 0) 
			{htmlCode = '<div style="display:none">for IE</div>' + htmlCode;
			htmlCode = htmlCode.replace(/<script([^>]*)>/gi,'<script$1 defer="true">');
			el.innerHTML = htmlCode;
			el.removeChild(el.firstChild);
			}
			else 
			{var el_next = el.nextSibling;
			var el_parent = el.parentNode;
			el_parent.removeChild(el);
			el.innerHTML = htmlCode;
			if (el_next)
			el_parent.insertBefore(el, el_next)
			else
			el_parent.appendChild(el);
			}
	}*/
	
	//����Ĵ��뻹��һ�����⣺�������� HTML �����а��� document.write ��䣬��ô�ͻ��ƻ�����ҳ�档�����������������ͨ�����¶��� document.write �����⡣�������£� 
	
	/*
	 �������ض��� document.write ����.
	 ������ʹ�� set_innerHTML ʱ������� HTML �����а��� document.write ��䣬����ԭҳ���ܵ��ƻ���
	*/
	/*document.write : function(){
		 var body = document.getElementsByTagName('body')[0];
		 for (var i = 0; i < arguments.length; i++) {
		  argument = arguments[i];
		  if (typeof argument == 'string') {
		   var el = body.appendChild(document.createElement('div'));
		   set_innerHTML(el, argument)
		  }
		 }
	}
	*/
}
