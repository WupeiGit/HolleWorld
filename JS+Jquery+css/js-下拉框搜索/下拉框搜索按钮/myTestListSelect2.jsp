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
<%-- <script type="text/javascript" src="plugin/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="plugin/extjs/ext-all.js"></script>
<script type="text/javascript" src="plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/common/common.js"></script>
<script type="text/javascript" src="js/common/search.js"></script>
<script type="text/javascript" src="js/common/extSelect.js"></script>
<script type="text/javascript" src="js/common/alt.js"></script> --%>
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<%-- <script type="text/javascript" src="js/common/popWin.js"></script>
<script type="text/javascript" src="js/common/popApp.js"></script --%> 
</head>

<body>
<s:bean name="com.mx.travel.util.Util" id="myUtil"/>
<span class="second">  
    <input type="text" name="makeupCo" id="makeupCo" class="makeinp" onfocus="setfocus(this)" oninput="setinput(this);" placeholder="请选择或输入"/>  
    <select name="makeupCoSe" id="typenum" onchange="changeF(this)" size="10" style="display:none;">  
        <option value="">1</option>  
        <option value="">2</option>  
        <option value="">12323</option>  
        <option value="">31</option>  
        <option value="">1332</option>  
        <option value="">412</option>  
        <option value="">42</option>  
        <option value="">11</option>  
    </select>  
</span>  
</body>
<script type="text/javascript">
	var TempArr=[];//存储option  
	
	$(function(){  
	    /*先将数据存入数组*/  
	    $("#typenum option").each(function(index, el) {  
	        TempArr[index] = $(this).text();  
	    });  
	    $(document).bind('click', function(e) {    
	        var e = e || window.event; //浏览器兼容性     
	        var elem = e.target || e.srcElement;    
	        while (elem) { //循环判断至跟节点，防止点击的是div子元素     
	            if (elem.id && (elem.id == 'typenum' || elem.id == "makeupCo")) {    
	                return;    
	            }    
	            elem = elem.parentNode;    
	        }    
	        $('#typenum').css('display', 'none'); //点击的不是div或其子元素     
	    });    
	})  
	  
	function changeF(this_) {  
	    $(this_).prev("input").val($(this_).find("option:selected").text());  
	    $("#typenum").css({"display":"none"});  
	}  
	function setfocus(this_){  
	    $("#typenum").css({"display":""});  
	    var select = $("#typenum");  
	    for(i=0;i<TempArr.length;i++){  
	        var option = $("<option></option>").text(TempArr[i]);  
	        select.append(option);  
	    }   
	}  
	  
	function setinput(this_){  
	    var select = $("#typenum");  
	    select.html("");  
	    for(i=0;i<TempArr.length;i++){  
	        //若找到以txt的内容开头的，添option  
	        if(TempArr[i].substring(0,this_.value.length).indexOf(this_.value)==0){  
	            var option = $("<option></option>").text(TempArr[i]);  
	            select.append(option);  
	        }  
	    }  
	}  
</script>
<style type="text/css">  
		 .second select {  
		    width: 11%;  
		    height: 106px;  
		    margin: 0px;  
		    outline: none;  
		    border: 1px solid #999;  
		    margin-top: 31px;  
		}  
		.second input {  
		    width: 167px;  
		    top: 9px;  
		    outline: none;  
		    border: 0pt;  
		    position: absolute;  
		    line-height: 30px;  
		    left: 8px;  
		    height: 30px;  
		    border: 1px solid #999;  
		}  
		.second ul {  
		    position: absolute;  
		    top: 27px;  
		    border: 1px solid #999;  
		    left: 8px;  
		    width: 125px;  
		    line-height: 16px;  
		}  
		.ul li{  
		    list-style: none;  
		    width: 161px;  
		    /* left: 15px; */  
		    margin-left: -40px;  
		    font-family: 微软雅黑;  
		    padding-left: 4px;  
		}  
		.blue {   
		    background:#1e91ff;   
		}  
</style> 
</html>
