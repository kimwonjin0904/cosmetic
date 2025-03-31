					<!-- 첫 화면 페이지 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>화장품 첫 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #206b68;
            padding: 10px 20px;
            color: white;
        }
        .logo img {
            width: 50px;
            height: auto;
        }
        .nav {
            background-color: white;
            padding: 10px;
            display: flex;
            justify-content: center;
            border-bottom: 2px solid #ddd;
        }
        .nav a {
            text-decoration: none;
            color: black;
            margin: 0 15px;
            font-weight: bold;
        }
        .login-btn {
            background-color: white;
            color: black;
            border: 1px solid #ddd;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }
        .modal input {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        .login-btn-modal {
            background-color: #206b68;
            color: white;
        }
        .signup-btn {
            background-color: #ddd;
        }
        .close-btn {
            background: none;
            border: none;
            font-size: 20px;
            float: right;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img src="피부로그사진.png" alt="피부 로고">
        </div>     
        <button class="login-btn" onclick="openModal()">Login</button>
    </div>
    
    <div class="nav">
        <a href="#">카테고리</a>
        <a href="#">랭킹</a>
        <a href="#">커뮤니티</a>
    </div>
    <div class="nav">
        <a href="#">건성</a>
        <a href="#">지성</a>
        <a href="#">복합성</a>
        <a href="#">수부지</a>
        <a href="#">민감성</a>
        <a href="#">여드름</a>
    </div>
    
    <div class="product-container">
        <p>화해 화장품 데이터 가져올 것들</p>
    </div>


    <div id="loginModal" class="modal">
        <button class="close-btn" onclick="closeModal()">×</button>
        <img src="피부로그사진.png" alt="피부 로고" width="50">
        <input type="text" placeholder="아이디">
        <input type="password" placeholder="비밀번호">
        <div>
            <input type="checkbox" id="remember">
            <label for="remember">아이디 저장하기</label>
        </div>
        <button class="login-btn-modal">로그인</button>
        <button class="signup-btn" onclick="goToSignup()">회원가입</button>
    </div>

    <script>
        function openModal() {
            document.getElementById("loginModal").style.display = "block";
        }
        function closeModal() {
            document.getElementById("loginModal").style.display = "none";
        }
        function goToSignup() {
            window.location.href = "signuppage.html";
        }
    </script>
</body>
</html>
