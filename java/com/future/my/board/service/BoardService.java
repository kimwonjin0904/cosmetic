package com.future.my.board.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.board.dao.IBoardDAO;
import com.future.my.board.vo.BoardVO;
import com.future.my.board.vo.ReplyVO;

@Service
public class BoardService {

	@Autowired
	IBoardDAO dao;
	
	// 게시글 목록 조회
	public ArrayList<BoardVO> getBoardList(){
		return dao.getBoardList();
	}
	// 게시글 작성
	public void writeBoard(BoardVO vo) throws Exception {
		int result = dao.writeBoard(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	public BoardVO getBoard(int boardNo) throws Exception {
		BoardVO result = dao.getBoard(boardNo);
		if(result == null) {
			throw new Exception();
		}
		return result;
	}
	public void updateBoard(BoardVO vo) throws Exception {
		int result = dao.updateBoard(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	// 댓글 등록
	public int writeReply(ReplyVO vo) throws Exception {
		int result = dao.writeReply(vo);
		if(result == 0) {
			throw new Exception();
		}
		return result;
	}
	// 댓글 조회	
	public ReplyVO getReply(String replyNo) {
		return dao.getReply(replyNo);
	}
	// 댓글 목록 조회
	public ArrayList<ReplyVO> getReplyList(int boardNo){
		return dao.getReplyList(boardNo);
	}
	// 댓글 삭제 
	public int delReply(String replyNo) {
		return dao.delReply(replyNo);
	}
	
}
