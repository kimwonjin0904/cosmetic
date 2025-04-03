package com.future.my.board.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.future.my.board.service.BoardService;
import com.future.my.board.vo.BoardVO;
import com.future.my.board.vo.ReplyVO;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	
	
	@ExceptionHandler(Exception.class)
	public String errorView(Exception e, Model model) {
		e.printStackTrace();
		return "errorView";
	}
	
	
	@RequestMapping("/boardView")
	public String boardView(Model model) {
		
		ArrayList<BoardVO> boardList = boardService.getBoardList();
		// Model은 spring에서 컨트롤러와 뷰 사이의 데이터를 전달하기 위한 객체
		// key:value형태로 모델에 저장장됨  [배열, 기본타입 모두 상관없음].
		model.addAttribute("boardList", boardList);
		return "board/boardView";
	}
	
	@RequestMapping("/boardWriteView")
	public String boardWriteView(HttpSession session) {
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "board/boardWriteView";
	}
	@RequestMapping("/boardWriteDo")
	public String boardWriteDo(BoardVO board) throws Exception {
	    boardService.writeBoard(board);
		return "redirect:/boardView";
	}
	
	@RequestMapping("/getBoard")
	public String boardDetailView (Model model, int boardNo) throws Exception {
		System.out.println(boardNo);
		BoardVO vo = boardService.getBoard(boardNo);
		model.addAttribute("board", vo);
		ArrayList<ReplyVO> replyList = boardService.getReplyList(boardNo);
		model.addAttribute("replyList", replyList);

		return "board/boardDetailView";
	}
	@RequestMapping("/boardEditView")
	public String boardEditView(Model model, int boardNo) throws Exception {
		BoardVO vo = boardService.getBoard(boardNo);
		model.addAttribute("board", vo);
		return "board/boardEditView";
	}
	
	@RequestMapping("/boardEditDo")
	public String boardEditDo(BoardVO board) throws Exception {
	    boardService.updateBoard(board);
		return "redirect:/boardView";
	}
	@ResponseBody  // java class 객체를 json 데이터 형태로 리턴 
	@PostMapping("/writeReplyDo")
	public ReplyVO writeReplyDo(@RequestBody ReplyVO vo) throws Exception {
		System.out.println(vo);
		Date date = new Date();
		SimpleDateFormat fdr = new SimpleDateFormat("yyMMddHHmmssSSS");
		String uniquId = fdr.format(date);
		vo.setReplyNo(uniquId);
		//댓글 저장
		boardService.writeReply(vo);
		//저장된 댓글 조회
		ReplyVO result = boardService.getReply(uniquId);
		
		return result;
	}
	@ResponseBody
	@PostMapping("/delReplyDo")
	public String delReplyDo(@RequestBody ReplyVO vo) {
		System.out.println(vo);
		String result  = "s";
		int cnt = boardService.delReply(vo.getReplyNo());
		if(cnt == 0) {
			result = "f";
		}
		return result;
	}
	
	
	
}
