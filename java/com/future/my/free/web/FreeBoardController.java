package com.future.my.free.web;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.future.my.common.service.CodeService;
import com.future.my.common.vo.CodeVO;
import com.future.my.free.service.FreeBoardService;
import com.future.my.free.vo.FreeBoardSearchVO;
import com.future.my.free.vo.FreeBoardVO;

@Controller
@RequestMapping("/free")
public class FreeBoardController {

	@Autowired
	CodeService codeService;
	
	//해당 컨트롤러에서 연결되는 화면에서는 comList 사용가능 
	@ModelAttribute("comList")
	public ArrayList<CodeVO> getCodeList(){
		return codeService.getCodeList("BC00"); // 게시판 관련
	}
	@ModelAttribute("comMainList")
	public ArrayList<CodeVO> comMainList(){
		return codeService.getCodeList(null); // test
	}
	
	@Autowired
	FreeBoardService freeBoardService;
	
	@RequestMapping("/test")
	public String test() {
		return "free/test";
	}
	
	@RequestMapping("/freeList")
	public String freeList(Model model
			              //모델 객체 바인딩 & 뷰 데이터 전달 
			              //요청과 응답시 데이터를 유지하기 위해서 
			             ,@ModelAttribute("searchVO") FreeBoardSearchVO searchVO ) {
		System.out.println(searchVO);
		ArrayList<FreeBoardVO> freeList = freeBoardService.getBoardList(searchVO);
		model.addAttribute("freeList", freeList);
		return "free/freeList";
	}
	
	@RequestMapping("/freeView")
	public String freeView(Model model, int boNo) throws Exception {
		
		FreeBoardVO free = freeBoardService.getBoard(boNo);
		model.addAttribute("free", free);
		return "free/freeView";
		
	}
	
	@RequestMapping("/freeForm")
	public String freeView() {

		return "free/freeForm";
	}
	
	@PostMapping("/freeBoardWriteDo")
	public String freeBoardWriteDo(FreeBoardVO vo) throws Exception {
		System.out.println(vo);
		freeBoardService.insertFreeBoard(vo);
		return "redirect:/free/freeList";
	}
	
	
	
}
