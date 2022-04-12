<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jsp"%>
<%@ include file="/WEB-INF/views/common/nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>달력</title>
<style type="text/css">
	td {
		width: 50px;
		height: 110px;
		text-align: left;
		font-size: 20px;
		font-family: 굴림;
		border: 2px border-color:#3333FF;
		border-radius: 8px; /*모서리 둥글게*/
	}
	
	.cal_top {
		text-align: center;
		font-size: 30px;
		padding-top: 10px;
		padding-bottom: 20px;
	}
	#calendar {
		width: 70%;
		display: table; 
		margin-left: auto; 
		margin-right: auto;
	}
</style>
</head>
<body>
	<div class="cal_top">
		<span id="cal_top_year"></span><br> <span id="tbCalendarY">YYYY년</span><br><a href="#" id="movePrevMonth">
		<span id="prevMonth" class="cal_tit" onclick="prevCalendar()">&lt;</span></a> 
		<span id="tbCalendarM">m월</span> <a href="#" id="moveNextMonth">
		<span id="nextMonth" class="cal_tit" onclick="nextCalendar()">&gt;</span></a>
	</div>
	<table class="table table-striped" id="calendar">
		<tr>
			<th align="left"><font color='red'>일</font></th>
			<th align="left">월</th>
			<th align="left">화</th>
			<th align="left">수</th>
			<th align="left">목</th>
			<th align="left">금</th>
			<th align="left"><font color='blue'>토</font></th>
		</tr>
	</table>
	<!-- 모달 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span>&times;</span>
               </button>
               <h4 class="modal-title" id="myModalLabel">스케줄 입력</h4>
               <h5 class="modal-title"><span id="year"></span>년&nbsp;<span id="month"></span>월&nbsp;<span id="day"></span>일&nbsp;</h5>
            </div>
            <div class="modal-body">
               <div class="table-responsive">
                  <table class="table">
                     <colgroup>
                        <col width="15%">
                        <col width="55%">
                        <col width="20%">
                        <col width="10%">
                     </colgroup>
                     <thead>
                        <tr>
                           <th>시간</th>
                           <th>참가 이름</th>
                           <th>이름 추가</th>
                           <th>삭제</th>
                        </tr>
                     </thead>
                     <tbody id="dataSection">
<%--                         <c:forEach var="calendar" items="${calendar }" varStatus="status"> --%>
<%--                            <tr class="calendarListTable none calendar${calendar.CALDAY }"> --%>
<%--                               <td>${calendar.CALTIME }</td> --%>
<%--                               <td>${calendar.CALCONTENTS }</td> --%>
<!--                               <td> -->
<%--                                  <c:if test="${calendar.CALREQ == 1}"> --%>
<!--                                     <span><font color='red'>*</font></span> -->
<%--                                  </c:if> --%>
<!--                               </td> -->
<!--                               <td class="tc"> -->
<%--                                  <a href="calendarDel?CALNO=${calendar.CALNO }"> --%>
<!--                                     <span>&times;</span> -->
<!--                                  </a> -->
<!--                               </td> -->
<!--                            </tr> -->
<%--                         </c:forEach> --%>
<!-- 						<tr> -->
<!-- 	                        <td id="calTime"></td> -->
<!-- 	                        <td id="calContents"></td> -->
<!-- 	                        <td> -->
<%-- 	                           <c:if test=" == 1}"> --%>
<!-- 	                              <span><font color='red'>*</font></span> -->
<%-- 	                           </c:if> --%>
<!-- 	                        </td> -->
<!-- 	                        <td class="tc"> -->
<!-- 	                           <a href="calendarDel?CALNO="> -->
<!-- 	                              <span>&times;</span> -->
<!-- 	                           </a> -->
<!-- 	                        </td> -->
<!--                      	</tr> -->
                     </tbody>
                  </table>
               </div>
               <form action="calendarInsert" method="post" id="calendarFrm" name="calendarFrm">
<%--                   <input type="hidden"class="form-control w130" id="CALYEAR" name="CALYEAR" value="${year }"> --%>
<%--                   <input type="hidden"class="form-control w130" id="CALMONTH" name="CALMONTH" value="${month }"> --%>
<!--                   <input type="hidden"class="form-control w130" id="CALDAY" name="CALDAY"> -->
 				  <label for="contents">[새로운 항목 추가]</label> 
                  <div class="form-group">
                     <label for="exampleInputName2">시간</label>
                     <input type="time" class="form-control w130" id="CALTIME" name="CALTIME">
                  </div>
                  <div class="form-group">
                     <label for="contents">이름</label> 
                     <input name="name" class="form-control" id="name" type="text" maxlength="10" placeholder="이름을 입력해 주세요.">
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary" data-dismiss="modal" id="save">저장</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
</body>
<script type="text/javascript">
$(function(){
	// buildCalendar 정보 불러오기
	buildCalendar();
});
    var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
    var date = new Date();//today의 Date를 세어주는 역할

  	//이전 달
    function prevCalendar() { 
    //이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
    //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
    //getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
     today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
     buildCalendar(); //달력 cell 만들어 출력 
    }

  	//다음 달
    function nextCalendar() {
        //다음 달을 today에 값을 저장하고 달력에 today 넣어줌
        //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
        //getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
         today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
         buildCalendar();//달력 cell 만들어 출력
    }

  	//현재 달 달력 만들기
    function buildCalendar(){
        var doMonth = new Date(today.getFullYear(),today.getMonth(),1);
        //이번 달의 첫째 날,
        //new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
        //new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
        //왜냐면 getMonth()는 0~11을 반환하기 때문
        var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
        //이번 달의 마지막 날
        //new를 써주면 정확한 월을 가져옴, getMonth()+1을 해주면 다음달로 넘어가는데
        //day를 1부터 시작하는게 아니라 0부터 시작하기 때문에 
        //대로 된 다음달 시작일(1일)은 못가져오고 1 전인 0, 즉 전달 마지막일 을 가져오게 된다
        var tbCalendar = document.getElementById("calendar");
        //날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
        //테이블에 정확한 날짜 찍는 변수
        //innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
        //new를 찍지 않아서 month는 +1을 더해줘야 한다. 
         tbCalendarY.innerHTML = today.getFullYear() + "년 "; 
         tbCalendarM.innerHTML = (today.getMonth() + 1) + "월"; 

         /*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
         while (tbCalendar.rows.length > 1) {
	         //열을 지워줌
	         //기본 열 크기는 body 부분에서 2로 고정되어 있다.
	         tbCalendar.deleteRow(tbCalendar.rows.length-1);
	         //테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
	       	 //30일 이후로 담을달에 순서대로 열이 계속 이어진다.
         }
         var row = null;
         row = tbCalendar.insertRow();
         //테이블에 새로운 열 삽입//즉, 초기화
         var cnt = 0;// count, 셀의 갯수를 세어주는 역할
        // 1일이 시작되는 칸을 맞추어 줌
         for (i=0; i<doMonth.getDay(); i++) {
         /*이번달의 day만큼 돌림*/
              cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
              cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
         }
        /*달력 출력*/
         for (i=1; i<=lastDate.getDate(); i++) {
         	//1일부터 마지막 일까지 돌림
            cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
            cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
            cell.innerHTML = i;//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
            cell.addEventListener('click', function(){ 
				$("#year").text(today.getFullYear());
	            $("#month").text(today.getMonth() + 1);
	            $("#day").text($(this).text());
            	$.ajax({
                    url: "/board/modalCalendar",	
                    type: "post",
                    dataType: "json",
                    data: {calDay : $(this).text()},
     				success : function(calendarList) {
     					alert("성공함.");
   	                var table = "";
	   					table += '<tr>';
	   					table += '<td>'+ calendarList.calTime +'</td>';
	   					table += '<td>'+ calendarList.contents +'</td>';
	   					table += '<td>*</td>';
	   					table += '<td><a href="calendarDel?CALNO='+ calendarList.calNo +'"><span>&times;</span></a></td>';
	   					table += '</tr>';
	  					$('#dataSection').html(table);
	   	            	$('#myModal').modal('show');
     			    },
                     error : function() {
     			        alert("Error!");
     			        boardList();
     			    }
                 });
            });
			if (cnt % 7 == 1) {/*일요일 계산*/
				//1주일이 7일 이므로 일요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
				cell.innerHTML = "<font color=red>" + i
				//1번째의 cell에만 검은색
				// cell.style.background = 'red';
				//1번째의 cell의 배경색 변경 
			}    
			if (cnt%7 == 0){/* 1주일이 7일 이므로 토요일 구하기*/
			    //월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
			    cell.innerHTML = "<font color=blue>" + i
			    //7번째의 cell에만 색칠
			    // cell.style.background = 'blue';
			 	//7번째의 cell의 배경색 변경 
			    row = calendar.insertRow();
			    //토요일 다음에 올 셀을 추가
			}
			/*오늘의 날짜에 노란색 칠하기*/
			if (today.getFullYear() == date.getFullYear()
			   && today.getMonth() == date.getMonth()
			   && i == date.getDate()) {
			    //달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
			  cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
			 }
         }

//          var calendarTable = document.getElementById('calendar');
//          var tdAll = calendarTable.getElementsByTagName('td');
//          var tdAll = document.getElementsByTagName('td');
//          tdAll.click(function(){
//          	event();
//          });
         
//          function zzz(){
//         	var calendarTable = document.getElementById('calendar');
//         	var tdAll = calendarTable.getElementsByTagName('td');
//             var num = tdAll.length;
//              alert('There are ' + num + ' paragraph in #div2');
//         	 alert("버튼 클릭됨");
//          }
    }
</script>
</html>