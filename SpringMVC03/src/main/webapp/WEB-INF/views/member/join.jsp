<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	function registerCheck() {
  		var memID = $("#memID").val();
 		$.ajax({
 			url: "${contextPath}/memRegisterCheck.do",
 			type: "get",
 			data: {"memID": memID},
 			success: function(result) {
 				// 중복유무 출력(result=1 : 사용할 수 있는 아이디, 0: 사용할 수 없는 아이디)
 				alert(result);
 				console.log("asdasd");
 			},
 			error: function() {
 				alert("error111");
 			}
 		}); 		
  	}
  </script>
</head>
<body>

<div class="container">
  <jsp:include page="../common/header.jsp"/>
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
		<form action="${contextPath}/memRegister.do/" method="post">
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td style="width: 110px; vertical-align: middle">아이디</td>
					<td><input class="form-control" id="memID" name="memID" type="text" maxlength="20" placeholder="아이디를 입력하세요."/></td>
					<td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인</button></td>
				</tr>
				<tr>
					<td style="width: 110px; vertical-align: middle">비밀번호</td>
					<td colspan="2"><input class="form-control" id="memPassword1" name="memPassword1" onkeyup="passwordCheck()" type="password" maxlength="20" placeholder="패스워드를 입력하세요."/></td>
				</tr>
				<tr>
					<td style="width: 110px; vertical-align: middle">비밀번호 확인</td>
					<td colspan="2"><input class="form-control" id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" type="password" maxlength="20" placeholder="패스워드를 확인하세요."/></td>
				</tr>
				<tr>
					<td style="width: 110px; vertical-align: middle">사용자 이름</td>
					<td colspan="2"><input class="form-control" id="memName" name="memName" type="text" maxlength="20" placeholder="이름을 입력하세요."/></td>
				</tr>
				<tr>
					<td style="width: 110px; vertical-align: middle">나이</td>
					<td colspan="2"><input class="form-control" id="memAge" name="memAge" type="text" maxlength="20" placeholder="나이를 입력하세요."/></td>
				</tr>
				<tr>
					<td style="width: 110px; vertical-align: middle">성별</td>
					<td colspan="2">
						<div class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" id="memGender" name="memGender" autocomplete="off" value="남자" checked="checked"/>남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" id="memGender" name="memGender" autocomplete="off" value="여자"/>여자
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="width: 110px; vertical-align: middle">이메일</td>
					<td colspan="2"><input class="form-control" id="memEmail" name="memEmail" type="text" maxlength="20" placeholder="이메일을 입력하세요."/></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: left">
						<input type="submit" class="btn btn-primary btn-sm pull-right" value="등록">
					</td>
				</tr>
			</table>		
		</form>
    </div>
    <!-- 다이얼로그창 (Modal) -->
    <div class="panel-footer">스프1탄_인프런(황대경)</div>
  </div>
</div>

</body>
</html>
