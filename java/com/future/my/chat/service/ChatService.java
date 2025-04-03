package com.future.my.chat.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.chat.dao.IChatDAO;
import com.future.my.chat.vo.ChatVO;
import com.future.my.chat.vo.RoomVO;

@Service
public class ChatService {

		@Autowired
		IChatDAO dao;
		
		//채팅방 리스트
		public ArrayList<RoomVO> getRoomList(){
			return dao.getRoomList();
		}
		//채팅방 생성
		public void createRoom(RoomVO roomVO) {
			dao.createRoom(roomVO);
		}
		//대화 기록 리스트
		public ArrayList<ChatVO> getChatList(int roomNo){
			return dao.getChatList(roomNo);
		}
		//대화 저장
		public void insertChat(ChatVO vo) {
			dao.insertChat(vo);
		}
		
		//영화 리스트 조회
		public ArrayList<String> getMovieList(){
			return dao.getMovieList();
		}
		//영화 박스오피스 정보
		public ArrayList<Map<String, Object>> getMovieBoxOffice(String movieNm){
			return dao.getMovieBoxOffice(movieNm);
		}
		
}
