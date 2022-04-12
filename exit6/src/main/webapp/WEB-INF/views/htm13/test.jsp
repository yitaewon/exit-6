<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>
<head>
<title>test</title>
<style type="text/css">
A:link {text-decoration:none}
A:visited {text-decoration:none}
A:active {text-decoration:none}
A:hover {color:#FFCC00; text-decoration:none}
body, table, tr, td, select,input,form,textarea {
font-family: 굴림, 돋움, verdana;
font-size:9pt;  line-height: 150%;
}
body {
scrollbar-face-color:white;
scrollbar-highlight-color: white;
scrollbar-3dlight-color: gray;
scrollbar-shadow-color: white;
scrollbar-darkshadow-color: gray;
scrollbar-track-color: white;
scrollbar-arrow-color: gray}
</style>
<style type="text/css">
form{
	width: 450px;
	margin: 10px; padding: 10px;
	background-color: #888;
}
footer{
	width: 100%;
	display: block;
	text-align: center;
}
header{
	display: block;
	font-family: Tahoma,Geneva,sans-serif;
	text-align: center;
	font-style: oblique;
}
</style>
<script type="text/javascript">
var ctx;
var cwidth=500, cheight=400;
var cardW=75, cardH=107; //카드 너비,높이
var playerXp=30, playerYp=220; //플레이어 카드 가로세로위치
var houseXp=300, houseYp=30; //딜러 카드 가로세로
var houseTotal, playerTotal; //총점 저장용
var pi=0; //플레이어, 딜러의 다음 카드 인덱스
var hi=0;
var deck=[]; //모든 카드 저장용 배열
var playerHand=[]; //플레이어, 딜러 카드 저장용 배열
var houseHand=[];
var back=new Image(); //카드 뒷면 그림 저장용
var needNewDeck=false; //새로운 카드덱이 필요한가 여부***
var dealOk=true; //카드 더 받기가 가능한지 여부***

function init(){
	ctx=document.getElementById('canvas').getContext('2d');
	ctx.font="italic 15pt Georgia";
	ctx.fillStyle="white";
	buildDeck(); //카드 덱 생성
	back.src="/html5/cardback.png";
	canvas1=document.getElementById('canvas');
	window.addEventListener('keydown', getKey, false);
	shuffle(); //카드 섞기
	dealStart(); //처음 카드 4장 분배
}

function getKey(event){
	var keyCode;
	if(event==null){
		keyCode=window.event.keyCode;
		//window.event.preventDefault();
	}else{
		keyCode=event.keyCode;
		//event.preventDefault();
	}
	switch(keyCode){
		case 68: deal(); break; //d키-플레이어나 딜러에게 다른 카드 나눠줌
		case 72: playerDone(); break; //h키-플레이어 차례 끝냄
		case 78: newGame(); break; //n키-새 게임 시작
		default: //alert("d, h, n 중 하나를 누르세요.");
	}
}

function dealStart(){ //처음 카드 4장 분배
	playerHand[pi]=dealFromDeck(1); //플레이어 첫카드 가져오기
	//플레이어 카드 캔버스에 그리기
	ctx.drawImage(playerHand[pi].picture,playerXp,playerYp,cardW,cardH);
	playerXp=playerXp+30; //가로 포인터 조정
	pi++; //플레이어 카드 카운터 증가
	houseHand[hi]=dealFromDeck(2);
	ctx.drawImage(back,houseXp,houseYp,cardW,cardH);
	houseXp=houseXp+20;
	hi++;
	playerHand[pi]=dealFromDeck(1); //플레이어 두번째 카드 가져오기
	ctx.drawImage(playerHand[pi].picture,playerXp,playerYp,cardW,cardH);
	playerXp=playerXp+30;
	pi++;
	houseHand[hi]=dealFromDeck(2);
	ctx.drawImage(back,houseXp,houseYp,cardW,cardH);
	houseXp=houseXp+20;
	hi++;
}

function deal(){ //카드 추가
	if(add_up_player()<22 && dealOk){
		playerHand[pi]=dealFromDeck(1);
		ctx.drawImage(playerHand[pi].picture,playerXp,playerYp,cardW,cardH);
		playerXp=playerXp+30;
		pi++;
		if(add_up_player()>21){ playerDone(); }
	}

	if(more_to_house()){ //딜러 카드 추가
		houseHand[hi]=dealFromDeck(2);
		ctx.drawImage(back,houseXp,houseYp,cardW,cardH);
		houseXp=houseXp+20;
		hi++;
	}
	return false;
}

function more_to_house(){
	var ac=0; //에이스 저장용
	var sumUp=0; //점수 합계 저장용
	for(var i=0; i<hi; i++){ //딜러 소유 카드 점수 합산
		sumUp += houseHand[i].value; 
		if(houseHand[i].value==1) {ac++;} //에이스일 경우
	}
	if(ac>0){ //에이스가 있을 경우
		if((sumUp+10)<=21){ //에이스를 11로 했을때 오버가 아니면
			sumUp += 10; //에이스는 11로 설정
		}
	}
	houseTotal=sumUp;
	if(sumUp<17){ //총점이 17점 미만이면 한 장 더 받음
		return true; 
	}else{ 
		return false; 
	}
}

function dealFromDeck(who){
	var card;
	var ch=0; //미분배 카드의 인덱스 저장용
	while((deck[ch].dealt>0)&&(ch<51)){ //현재 카드가 분배되었으면
		ch++; //다음 카드 수행을 위해 ch 증가
	}
	if(ch>=51){ //분배되지않은 카드가 있는지 검사
		ctx.fillText("카드가 없습니다. Next Game 버튼을 누르세요.",60,370);
		dealOk=false; //카드 더 받기 중지.
		needNewDeck=true; //새 카드 덱 필요.*************************************
		ch=51; //이 함수가 돌아가도록 변수값을 51로 지정
	}
	deck[ch].dealt=who; //이 카드가 분배되었음을 기억하기위해 0이 아닌 값 지정
	card=deck[ch]; //카드 지정
	return card; //카드 반환
}

function buildDeck(){
	var index=0; //deck 배열에 넣은 요소 보관용
	var picName; //코드 간소화용
	var suitNames=["clubs","hearts","spades","diamonds"];
	var nums=["a","2","3","4","5","6","7","8","9","10","j","q","k"];
	for(var i=0; i<4; i++){
		for(var j=0; j<13; j++){
			picName="html5/"+suitNames[i]+"-"+nums[j]+"-75.png";
			deck[index]=new MCard(j+1,suitNames[i],picName);
			index++;
		}
	}
}

function MCard(n,s,picname){ //카드 생성함수
	this.num=n;
	if(n>10) n=10; //j,q,k일 경우 10으로 취급
	this.value=n; //카드 값
	this.suit=s; //카드 군
	this.picture=new Image();
	this.picture.src=picname;
	this.dealt=0;
}

function add_up_player(){ //플레이어 카드 총점 구하기
	var ac=0; //에이스 카드용
	var sumUp=0;
	for(var i=0; i<pi; i++){ //플레이어 소유 카드 순환
		sumUp += playerHand[i].value; //총점에 카드값 더하기
		if(playerHand[i].value==1){ ac++; } //에이스일 경우 체크
	}
	if(ac > 0){ //에이스가 있으면
		if((sumUp+10)<=21){ //총점이 21을 넘지 않으면
			sumUp += 10; //에이스를 11로 간주
		}
	}
	return sumUp; //총점 반환
}

function playerDone(){ //플레이어 차례 끝, 게임 결과 판정
	while(more_to_house()){
		houseHand[hi]=dealFromDeck(2);
		ctx.drawImage(back,houseXp,houseYp,cardW,cardH);
		houseXp=houseXp+20;
		hi++;
	}
	showHouse(); //딜러 카드 보이기
	playerTotal=add_up_player(); //플레이어 총점 구하기
	if(playerTotal>21){
		if(houseTotal>21){
			ctx.fillText("무승부! 사용자, 딜러 모두 21점을 초과.",30,190);
		}else{
			ctx.fillText("패배! 사용자가 21점을 초과.",60,190);
		}
	}else if(houseTotal>21){
		ctx.fillText("승리! 딜러가 21점을 초과.",60,190);
	}else if(playerTotal>=houseTotal){
		if(playerTotal>houseTotal){
			ctx.fillText("승리!",190,190);
		}else{
			ctx.fillText("무승부!",190,190);
		}
	}else if(houseTotal<=21){
		ctx.fillText("패배!",190,190);
	}else{
		ctx.fillText("승리! 딜러가 21점을 초과.",60,190);
	}
	dealOk=false; //승부가 난 뒤에도 카드 더 받기가 가능한 버그 수정용
	return false;
}
function showHouse(){ //딜러 카드 표시
	houseXp=300;
	for(var i=0; i<hi; i++){
		ctx.drawImage(houseHand[i].picture,houseXp,houseYp,cardW,cardH);
		houseXp=houseXp+20;
	}
}

function shuffle(){
	var i=deck.length-1; //i가 최종카드를 가리키게 지정
	var s; //무작위 선택 저장용
	while(i>0){ //카드가 다떨어질때까지
		s=Math.floor(Math.random()*(i+1)); //무작위 수를 받아
		swapInDecks(s,i); //서로 바꾸기
		i--;
	}
}
function swapInDecks(j,k){ //두 카드 서로 바꾸기
	var hold=new MCard(deck[j].num, deck[j].suit, deck[j].picture.src);
	deck[j]=deck[k];
	deck[k]=hold;
}
function newGame(){ //새 게임 시작
	if(needNewDeck){ //카드덱을 다 사용해 새 카드덱이 필요시
		init();
		needNewDeck=false;
	}
	dealOk=true;
	ctx.clearRect(0,0,cwidth,cheight);
	pi=0, hi=0;
	playerXp=30, houseXp=300;
	dealStart();
	return false;
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#333333" link="#006699" vlink="#006699" alink="#006699" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow:auto" onLoad="init();">
<table width="510"  border="2" cellpadding="5" cellspacing="5" bordercolor="#000000">
  <tr> 
    <td width="471" bgcolor="#336699"> 
	<header><font color="#FFFFFF">Black Jack Game</font>  </header> 
		<canvas id="canvas" width="500" height="400"> 
	    </canvas> <br/>
	<button onClick="deal();">Hit</button>
	<button onClick="playerDone();">Stand</button><br/>
	    <button onClick="newGame();">Next Game</button>
	  <footer><font color="#FFFFFF">카드 추가는 Hit, 그만 받기는 Stand, 새 게임은 Next Game 버튼을 누르세요.<br/>
      <font color="#CCCCCC">카드 그림 출처: http://www.eludication.org/playingcards.html 
      </font> </font> </footer> <tr>
    <td bgcolor="#000000"><div align="center">
        <p>&nbsp;</p>
        <p><font size="+1"><strong><font color="#CCCCCC">Black Jack 게임(HTML5 + Javascript)</font></strong></font><font color="#CCCCCC"><br>
          J,Q,K 카드는 10으로 계산하고 Ace의 경우 1 또는 11로 계산하여<br>
          받은 카드 수의 합이 21에 가까운 수를 얻는 쪽이 이기는 게임.<br>
          플레이어와 딜러는 처음에 각가 2장씩의 카드를 받고<br>
          원하면 카드를 더 받을 수 있지만 카드 수의 합이 21이 넘어서면 지게된다.<br>
          그외에도 실제 블랙잭의 경우 여러 규칙이 있지만 생략.</font></p>
        <p>&nbsp;</p>
      </div>
</table>
<br>
<table width="406" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="406"><p align="left"> 책보고 HTML5 + javascript로 블랙잭 게임 따라하기.<br>
        크기 축소, Hit, Stand, 새게임 등 키보드 이벤트에서 버튼 클릭으로 변경.<br>
        카드를 무한히 받을 수 있는 버그와 승부가 난 뒤 에도 카드 더 받기가 가능한 버그 수정. <br>
        카드덱 다 떨어진 뒤 New Game 버튼 클릭시 새 카드덱 만드는 기능 추가.</p>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>

