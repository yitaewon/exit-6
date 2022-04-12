<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>계산기</title>
    <style>
     	.container table{ 
    		border:1px solid #d3d3d3; 
    		border-collapse : collapse;" 
    	} 
        #display{
            text-align: right;
            border: none;
            width: 1130px;
        	display: readonly;
        }
        td{
        	width: 300px;
        	padding:5px;
        }
        tr{
        	width: 300px;
        	padding:5px;
        }
    </style>
</head>
<body>
	<div class="container">
	<h1>계산기!</h1>
	    <table id="calculator" border="1">
	        <tr>
	            <td colspan="4">
	                <input type="text" id="display" disabled>
	            </td>
	        </tr>
	        <tr>
	            <td onclick="add(7)">7</td>
	            <td onclick="add(8)">8</td>
	            <td onclick="add(9)">9</td>
	            <td onclick="add('*')">X</td>
	        </tr>
	        <tr>
	            <td onclick="add(4)">4</td>
	            <td onclick="add(5)">5</td>
	            <td onclick="add(6)">6</td>
	            <td onclick="add('-')">-</td>
	        </tr>
	        <tr>
	            <td onclick="add(1)">1</td>
	            <td onclick="add(2)">2</td>
	            <td onclick="add(3)">3</td>
	            <td onclick="add('+')">+</td>
	        </tr>
	        <tr>
	            <td onclick="reset()">Del</td>
	            <td onclick="add(0)">0</td>
	            <td onclick="add('.')">.</td>
	            <td onclick="calculate()">=</td>
<!-- 	            <td onclick="add('/')">/</td> -->
	        </tr>
	        <tr>
	        </tr>
	    </table>
    </div>
<script>
	var numberClicked = false; // 전역 변수로 numberClicked를 설정
    function add (char) {
        if(numberClicked == false) { 
        	//입력 받은 값이 또 다시 연산자면
            if(isNaN(char) == true) { 
                // 아무것도 하지 않는다.
            } else { 
                document.getElementById('display').value += char; 
            }
        } else { 
            document.getElementById('display').value += char; 
        }
 
 
        // 다음 입력을 위해 이번 입력에 숫자가 눌렸는지 연산자가 눌렸는지 설정한다.
        if(isNaN(char) == true) {
            numberClicked = false; 
        } else {
            numberClicked = true; 
        }
    }
	function calculate() {
	    var display = document.getElementById('display');
	    var display = eval(display.value); // 식을 계산하고 display 변수에 저장한다.
	    document.getElementById('display').value = display;
	}
	function reset() {
	    document.getElementById('display').value = "";
	}
</script>
</body>
</html>