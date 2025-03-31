package com.future.my.member.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@RequestMapping("/registDo")
	public String registDO(HttpServletRequest request) {
		String id = request.getParameter("id");
		String password = request.getParameter("pw");
	}

}
