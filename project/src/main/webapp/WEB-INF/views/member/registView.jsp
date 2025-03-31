					<!--회원가입 보이는 창  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 400px;
            background: white;
            padding: 20px;
            margin: 0 auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .message {
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        .error-message {
            color: red;
        }
        .success-message {
            color: green;
        }
        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .signup-btn {
            background-color: #206b68;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            padding: 10px;
            border-radius: 5px;
        }
        .cancel-btn {
            background-color: #ccc;
            border: none;
            padding: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>회원가입</h2>

        <label>아이디:</label>
        <input type="text" id="userId" placeholder="아이디 입력">
        <button onclick="checkUserId()">중복 확인</button>
        <p id="userIdMessage" class="message"></p>

        <label>비밀번호:</label>
        <input type="password" id="password" placeholder="비밀번호 입력" onkeyup="checkPassword()">

        <label>비밀번호 확인:</label>
        <input type="password" id="confirmPassword" placeholder="비밀번호 재입력" onkeyup="checkPassword()">
        <p id="passwordMessage" class="message"></p>

        <label>닉네임:</label>
        <input type="text" id="nickname" placeholder="닉네임 입력">
        <button onclick="checkNickname()">중복 확인</button>
        <p id="nicknameMessage" class="message"></p>

        <label>생년월일:</label>
        <input type="date" id="birthdate">

        <div class="btn-container">
            <button class="signup-btn" onclick="validateForm()">가입하기</button>
            <button class="cancel-btn" onclick="history.back()">취소</button>
        </div>
    </div>

    <script>
        var existingUserIds = ["user123", "hello456", "test789"];
        var existingNicknames = ["닉네임1", "스마트공장", "테스트닉"];

        function checkUserId() {
            var userId = document.getElementById("userId").value;
            var message = document.getElementById("userIdMessage");

            if (!userId.trim()) {
                message.style.display = "block";
                message.textContent = "아이디를 입력해주세요.";
                message.className = "message error-message";
                return;
            }

            if (existingUserIds.includes(userId)) {
                message.style.display = "block";
                message.textContent = "이미 존재하는 아이디입니다.";
                message.className = "message error-message";
            } else {
                message.style.display = "block";
                message.textContent = "사용 가능한 아이디입니다.";
                message.className = "message success-message";
            }
        }

        function checkNickname() {
            var nickname = document.getElementById("nickname").value;
            var message = document.getElementById("nicknameMessage");

            if (!nickname.trim()) {
                message.style.display = "block";
                message.textContent = "닉네임을 입력해주세요.";
                message.className = "message error-message";
                return;
            }

            if (existingNicknames.includes(nickname)) {
                message.style.display = "block";
                message.textContent = "이미 사용 중인 닉네임입니다.";
                message.className = "message error-message";
            } else {
                message.style.display = "block";
                message.textContent = "사용 가능한 닉네임입니다.";
                message.className = "message success-message";
            }
        }

        function checkPassword() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var message = document.getElementById("passwordMessage");

            if (!password || !confirmPassword) {
                message.style.display = "none";
            } else if (password === confirmPassword) {
                message.style.display = "block";
                message.textContent = "비밀번호가 일치합니다.";
                message.className = "message success-message";
            } else {
                message.style.display = "block";
                message.textContent = "비밀번호가 일치하지 않습니다.";
                message.className = "message error-message";
            }
        }

        function validateForm() {
            alert("가입이 완료되었습니다!");
        }
    </script>
</body>
</html>
