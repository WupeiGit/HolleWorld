var iCnt =0;
var saveNode;	//选中状态
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
			alert('[提示] 请选择费用申请单，再进行操作！');
			return false;
		}
		return true;
	},
	
	businessCostDetail : function(){
		if(this.checkBcId()){
			toUrl('/admin/finance/budget/businessCostDetail.asp?bcId='+ this.getbcId());
		}
	},
	
	//加载部门员工列表
	loadEmplist : function(){
		var deptIDs = getCheckBoxValues(document.getElementsByName('deptIDs'));
		new Ajax.Request('/inc/action/fiBusinessCostAction.asp?action=loadEmpList&deptIDs='+ deptIDs,{
			onComplete: function(t){
				if(t.responseText == '暂无信息...'){
					$('_eIDs').update('<label class="font_gray">请选择部门后进行操作。</label>');
				}else{
					$('_eIDs').update(t.responseText);
				}
			}
		})
	},
	
	//申请费用的总额
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
			alert('请选择经办人信息，再进行提交！');
			return false;
		}		
		var mayApplyValue      = document.getElementsByName('mayApplyValue');
		var categoryName       = document.getElementsByName('categoryName');
		var itemCode           = document.getElementsByName('itemCode');
		var costPrice          = document.getElementsByName('costPrice');
		var tableRow           = (Row.getRowTable()).rows.length - 1;
		
		for(var i = 0; i < tableRow; i++){
			if(categoryName[i].value.blank()){
				alert('请选择[费用类别]，再进行提交！');
				categoryName[i].focus();
				return false;
			}
			
			if(itemCode[i].value.blank()){
				alert('请选择[费用科目]，再进行提交！');
				itemCode[i].focus();
				return false;
			}
			if(costPrice[i].value.blank()){
				alert('请填写[申请金额],再进行提交！');
				costPrice[i].focus();
				return false;
			}
			//if(parseFloat(mayApplyValue[i].value) < parseFloat(costPrice[i].value)){
			if(parseFloat(costPrice[i].value) >= 2000){
				alert('[申请金额]不能大于[本月预算余额]！');
				costPrice[i].focus();
				return false;				
			}
			if(costPrice[i].value == 0){
				alert('[申请金额]不能为0！')
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
			alert('请选择[费用类别]，再进行提交！');
			categoryName.focus();
			return false;
		}
		if(itemCode.value.blank()){
			alert('请选择[费用科目]，再进行提交！');
			itemCode.focus();
			return false;
		}
		if(costPrice.value.blank()){
			alert('请填写[本次申请额]，再进行提交');
			costPrice.focus();
			return false;
		}

		if(costPriceOld.value < costPrice.value){
			alert('[本次申请额]不能超过' + costPriceOld.value + '！');
			costPrice.focus();
			return false;
		}
		try{ $('_editCode').disabled = true;}catch(ex){}
		return true;
	},
	

	deleteBusinessCost : function(bcId){
		var frm = $('frmBusinessCostList');
		var url = '?action=deleteBusinessCost&bcId=' + bcId;
		if(confirm('是否确定删除该费用？')){
			frm.action = url;
			frm.submit();
		}else{
			return false;	
		}			
	},
	
	delCost : function(bcId,bcdId){
		var frm = $('formBusinessCost');
		var url = '?action=delCost&bcId='+ bcId +'&bcdId=' + bcdId;
		if(confirm('是否确定删除该费用？')){
			frm.action = url;
			frm.submit();
		}else{
			return false;	
		}			
	},
	
	delCustomer : function(bcdId,bcsId,costPrice){
		var frm = $('bcItem');
		var url = '?action=delCustomer&bcdId='+bcdId+'&bcsId='+bcsId+'&costPrice='+costPrice;
		if(confirm('是否确定删除该分摊人员？')){
			frm.action = url;
			frm.submit();
		}else{
			return false;
		}
		
	},
	
	
	submitCost : function(bcId){
		var frm = $('frmBusinessCostList');
		var url = '?action=submitCost&bcId='+ bcId;
		if(confirm('是否确定提交该费用申请？')){
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
				el.update('正在加载...');
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
			alert('请选择分摊的员工！');
			return false;
		}
		var url = '?action=setBcCustmoer&bcdId=' + bcdId + '&eIdStr=' + eIdStr
		frm.action = url;
		frm.submit();
		
	},
	
	// 验证
	_checkNaN : function(obj){
		if(obj.value == '' || isNaN(obj.value)){
			obj.className = 'qs_inputWrong';
			return 0;
		}else{
			obj.className = '';
			return 1;
		}
	},


	// 全选与反选
	selectAllLine: function(elementName){
		BtnEvent.selectAll(elementName);
	},
	
	// 选中
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
	
	// 选中行
	selectedLine : function(lineNode){
		if(saveNode!=null) saveNode.className = '';
		saveNode = lineNode;
		lineNode.className = 'listSelectedS6';
	}
	
}




var Row = {
	
	// 获取数据表
	getRowTable : function(){
		return $('rowTable');
	},
	
	// 获取数据行
	getRowElements : function(){
		return $('rowElements');
	},
	
	// 以哪列判断，如果为空将认定为空项
	getRowPrimaryElements : function(){
		return document.getElementsByName('costPrice');
	},
	
	// 重置行数据
	resetRow : function(newRowNode) {
		var selects = newRowNode.getElementsByTagName('select');
		for ( var i = 0; i < selects.length; i++){
			Row.setSelectFirstOption(selects[i]);
		}
		
		var sltCreditNo = newRowNode.cells[1].childNodes[0];
		var sltLength = sltCreditNo.length;
		var optDefault = new Option('请选择');
		for(var i = 0; i < sltLength; i++){
			sltCreditNo.removeChild(sltCreditNo[0]);
		}
		sltCreditNo.add(optDefault);
		
		newRowNode.cells[5].childNodes[0].value = '';
		newRowNode.cells[6].childNodes[0].value = '';
		newRowNode.className = '';
	},

	// 增加项目
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
	
	// 删除项目
	deleteLastRows : function(rows) {
		Row.deleteRows(rows, false)
	},

	// 删除空项目
	deleteBlankRows : function(rows) {
		Row.deleteRows(rows, true);
	},

	deleteRow : function(element) {
		if (element.rowIndex > 1) {
			Row.getRowElements().removeChild(element);
		} else {
			alert('[提示] 首行不可删除!');
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
	
	// 选择列表首项
	setSelectFirstOption : function(selectElement) {
		selectElement.options[0].selected = true;
	},
	
	//----------------------------------------------------------------------------
	
	// 全选
	selectAll : function(){
		RowEvent.selectAll('factId','listSelectedS6');
	},
	
	// 选中
	selectThis : function(checkbox){
		RowEvent.selectThisLine(checkbox.parentNode,checkbox,'listSelectedS6');
	}
	
}

var CostShare ={
	// 增加分摊项目
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
			
			cloneTrInfo.childNodes[0].innerHTML = '第&nbsp;<span class="font_red">'+addNum+'</span>&nbsp;条';
			
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
			
			cloneTrInfo.childNodes[4].innerHTML = '<textarea name="shareNote'+addNum+'" id="shareNote'+addNum+'" rows="1" style="width:95%;" onfocus="this.rows=3;" onblur="this.rows=1;">暂无备注</textarea>';
			//cloneTrInfo.childNodes[2].innerHTML =  '<span id="_sltEmpList'+addNum+'">'+'<%=CreateSltEmpIdInManyDeptList("sltEmpId'+addNum+'", Session("uId"), Session("deptId"), "", "onchange", "alert('+addNum+');CostShare.getSelectedEmpId('+addNum+');")%>' +'</span>'+'<input type="text" name="toGetEmpId'+ addNum +'" id="toGetEmpId'+ addNum +'" />';
			//cloneTrInfo.childNodes[2].innerValue = '<span id="_sltEmpList'+i+'"></span>';
			
			objTBody.appendChild(cloneTrInfo);
			$("rowTable").appendChild(objTBody);	
		}
		//url 		= '';
		//urlEmp		= '';
	},
	
	//获取选中员工ID
	getSelectedEmpId : function(objTrNum){
		//alert(objTrNum);
		//alert($('sltEmpId'+objTrNum)[$('sltEmpId'+objTrNum).selectedIndex].value);
		$('toGetEmpId'+objTrNum).value = $('sltEmpId'+objTrNum)[$('sltEmpId'+objTrNum).selectedIndex].value;
	},
	
	getCheckedTrNum	: function(objTrNum){
		$('ckdTrNum').value = objTrNum;		//获取并设置当前用户选择的值给隐藏文本
	},
	
	//级联部门对应员工
	getDeptEmpsShare : function(selectedValue){
		var strTrNum	= $('ckdTrNum').value;
		var url	= '?action=getOneDeptEmps&deptId='+ selectedValue+'&trNum='+strTrNum;
		var el	= $('_sltEmpList'+strTrNum);
		
		new Ajax.Request(url,{
			onCreate: function(){
				el.update('正在加载...');
			},
			onComplete: function(t){
				if(t.responseText != ''){
					el.update(t.responseText);
				}
			}
		});
		
	},
	
	//删除分摊行
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
	
	
	//验证分摊
	editCheckCostShare : function(){
		//var addNum          		= (Row.getRowTable()).rows.length - 1;
		var addNum					= parseInt($('copyNum').value)+1;
		var costOfOne         		= document.getElementsByName('costOfOne');
		var hidCostPrice			= $('costPrice').value;
		var hidSumPirce				= $('hidSumPrice').value;		//总余额
		var currentPrice			= $('currentPrice').value;		//当前余额
		
		/*for(var i = 1; i <= addNum; i++){
			if($('sltCompDept'+i).value.blank()){
				alert('请选择[部门名称]！');
				$('sltCompDept'+i).focus();
				return false;
			}
			if($('sltEmpId'+i).value.blank()){
				alert('请选择[员工]！');
				$('sltEmpId'+i).focus();
				return false;
			}
			if($('shareNote'+i).value.blank()){
				alert('请填写[备注]！');
				$('shareNote'+i).focus();
				return false;
			}
		}*/
		for(var j = 0; j < addNum; j++){
			if($('sltCompDept'+parseInt(j+1)).value.blank()){
				alert('请选择[部门名称]！');
				$('sltCompDept'+parseInt(j+1)).focus();
				return false;
			}
			if($('sltEmpId'+parseInt(j+1)).value.blank()){
				alert('请选择[员工]！');
				$('sltEmpId'+parseInt(j+1)).focus();
				return false;
			}
			if(costOfOne[j].value.blank()){
				alert('请填写[费用金额]！');
				costOfOne[j].focus();
				return false;
			}
			if(costOfOne[j].value == 0){
				alert('[费用金额]不能为0！');
				costOfOne[j].focus();
				return false;
			}
			if(parseInt(hidCostPrice) < parseInt(costOfOne[j].value)){
				alert('[员工本次申请额]不能超过' + hidCostPrice + '元！');
				costOfOne[j].focus();
				return false;
			}
			if(parseInt(hidSumPirce) > parseInt(hidCostPrice)){
				alert('[本次分摊总金额]不能超过' + hidCostPrice + '元！');;
				return false;
			}
			if(parseInt(currentPrice) > parseInt(currentPrice)){
				alert('[本次分摊总金额]不能超过（当前余额）' + currentPrice + '元！');;
				return false;
			}
			if($('shareNote'+parseInt(j+1)).value.blank()){
				alert('请填写[备注]！');
				$('shareNote'+parseInt(j+1)).focus();
				return false;
			}
		}
		return true;
	},
	
	//计算总金额并赋值隐藏域
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
	
	//添加分摊
	addShare : function(bcdId){
		var frm = $('frmShareAdd');
		if(CostShare.editCheckCostShare()){
			frm.action = '?action=businessCostShareAdd&bcdId='+bcdId+'&addNum='+$F('copyNum');;
			frm.submit();
		}else{
			return false;
		}
		
	},
	
	//删除分摊
	delShare : function(bcdId,bcsId,costPrice){
		var frm = $('frmShareList');
		var url = '?action=delCostShare&bcdId='+bcdId+'&bcsId='+bcsId+'&costPrice='+costPrice;
		if(confirm('是否确定删除该分摊人员？')){
			frm.action = url;
			frm.submit();
		}else{
			return false;
		}
		
	},
	
	//验证输入金额
	toCheckPrice : function(currentPrice,txtPrice){
		if(txtPrice > currentPrice){
			alert("您输入的金额过大！");
			return false;
		}
	}
	
	
	/*症状：给某个元素的 innerHTML 设置值时，如果提供的 HTML 代码中包含js脚本，很多时候这些脚本无效，或者在某种浏览器上有效，但在其它浏览器上无效。
	
	原因：不同浏览器对插入 innerHTML 中的脚本有不同的处理方法。经过实践，归纳如下： 
	
	对于IE，首先, script 标签必须带 defer 属性，其次,在插入时刻，innerHTML 的所属节点必须在 DOM 树中. 
	对于 Firefox 和Opera，在插入时刻，innerHTML 的所属节点不可以在 DOM 树中。 
	
	根据上面结论，给出通用的设置 innerHTML 方法:*/ 

	/*
	* 描述：跨浏览器的设置 innerHTML 方法
	* 允许插入的 HTML 代码中包含 script 和 style
	* 参数：
	*   el: DOM 树中的节点，设置它的 innerHTML
	*   htmlCode: 插入的 HTML 代码
	* 经测试的浏览器：ie5+, firefox1.5+, opera8.5+
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
	
	//上面的代码还有一个问题：如果插入的 HTML 代码中包含 document.write 语句，那么就会破坏整个页面。对于这种情况，可以通过重新定义 document.write 来避免。代码如下： 
	
	/*
	 描述：重定义 document.write 函数.
	 避免在使用 set_innerHTML 时，插入的 HTML 代码中包含 document.write 语句，导致原页面受到破坏。
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
