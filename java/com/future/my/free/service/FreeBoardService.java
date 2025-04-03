package com.future.my.free.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.free.dao.IFreeBoardDAO;
import com.future.my.free.vo.FreeBoardSearchVO;
import com.future.my.free.vo.FreeBoardVO;

@Service
public class FreeBoardService {

	@Autowired
	IFreeBoardDAO dao;
	
	public ArrayList<FreeBoardVO> getBoardList(FreeBoardSearchVO searchVO){
		
		//1.전체 건수 조회
		int totalRowCount = dao.getTotalRowCount(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		//2.검색 조건으로 검색된 전체 건수를 기준으로 paing 세팅
		searchVO.pageSetting();
		//3.currrent에 해당하는 firstRow ~ lastRow 까지 목록 조회결과 리턴
		return dao.getBoardList(searchVO);
	}
	
	public void insertFreeBoard(FreeBoardVO vo) throws Exception {
		int result = dao.insertFreeBoard(vo);
		if(result==0) {
			throw new Exception();
		}
	}
	public FreeBoardVO getBoard(int boNo) throws Exception {
		FreeBoardVO board = dao.getBoard(boNo);
		if(board == null) {
			throw new Exception();
		}
		//조회수 증가!
		dao.increaseHit(boNo);
		return board;
	}
}
