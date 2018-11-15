<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="/common/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML>
<html>
<head>
<s:include value="/common/basePath.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的测试页面</title>
<link href="css/common.css" rel="stylesheet" type="text/css" />
<link href="plugin/extjs/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
</head>

<body>
<s:bean name="com.mx.travel.util.Util" id="myUtil"/>
<span class="second">  
    <input type="text" name="inputSearch" id="inputSearch" onfocus="openSelect()" onkeyup="searchTxt(this.value);"  placeholder="请选择或输入"/>   <!-- onfocus="openSelect()" -->
    <select name="selectTravel" id="selectTravel" onchange="changeF(this.value)" size="10" style="display:none;">  
        <option value="北京天安门">北京天安门</option>  
        <option value="北京天坛">北京天坛</option>  
        <option value="上海明珠">上海明珠</option>  
        <option value="襄阳照明台">襄阳照明台</option>  
        <option value="襄阳诸葛亮广场">襄阳诸葛亮广场</option>  
        <option value="武汉周黑鸭">武汉周黑鸭</option>  
        <option value="北京烤鸭">北京烤鸭</option>  
        <option value="深圳深圳">深圳深圳</option>  
    </select>  
</span>  
</body>
<script type="text/javascript">
	var getSelectValues ="";
	//页面加载时执行 
	$(function(){ 
		getSelectValues = getSelectText();
	}); 
	function openSelect(){
		 $("#selectTravel").css('display', '');  
	}
	//模糊搜索
	function searchTxt(inputValue){
		var checkboxCheckbox=0,cpdIds="";
		var checkbox = getSelectValues.split(",");
		$("#selectTravel option[value !='']").hide(); //1.先将不等于空的值都隐藏
		for(var i=0; i<checkbox.length; i++){
			if((checkbox[i]).indexOf(inputValue) > -1){ //2.模糊匹配上的值都显示
				$("#selectTravel option[value ='"+checkbox[i]+"']").show();
			}
		}
		$("#selectTravel").css('display', '');  
	}
	//赋选中值
	function changeF(value){
		$("#inputSearch").val(value);
		$("#selectTravel").css('display', 'none');  
	}
	
	//获取下拉框所有的值
	function getSelectText(){
		//获得所有select标签
		var bject = document.getElementById('selectTravel');
		//保存所有option 的值
		var allText = '';
		for(i=0; i<bject.length; i++)
		{
			allText += bject[i].value+','; //关键是通过option对象的innerText属性获取到选项文本
		}
		allText = allText.substring(0,allText.length-1); 
		return allText;
	}

</script>
<style type="text/css">  
		#inputSearch{  
		    width: 166px;  
		    height:20px;
		    outline: none;  
		    border: 0pt;  
		    position: absolute;  
		    line-height: 30px;  
		    left: 200px; 
		    top: 9px;   
		    border: 1px solid #999;  
		}  
		
		#selectTravel{  
		    width: 167px;  
		    top: 30px;     
		    position: absolute;  
		    line-height: 30px;  
		    left: 200px;   
		}  
</style> 
</html>
