package com.future.my.chat.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.chat.vo.ChatVO;
import com.future.my.chat.vo.RoomVO;

@Mapper
public interface IChatDAO {
	
	//채팅방 리스트
	public ArrayList<RoomVO> getRoomList();
	//채팅방 생성
	public int createRoom(RoomVO roomVO);
	//대화 기록 리스트
	public ArrayList<ChatVO> getChatList(int roomNo);
	//대화 저장
	public int insertChat(ChatVO vo);
	//영화 리스트 조회
	public ArrayList<String> getMovieList();
	//영화 박스오피스 정보
	public ArrayList<Map<String, Object>> getMovieBoxOffice(String movieNm);
	
	
	
    
}
