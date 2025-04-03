package com.future.my.chat.vo;

public class ChatVO {
	
	private int chatNo;         /*챗로그 아이디*/ 
	private String memId;       /*작성자 아이디*/
	private String memNm;       /*작성자 이름*/
	private int roomNo;         /*방 번호*/
	private String chatMsg;     /*작성 내용*/
	private String profileImg;  /*작성자 이미지*/
	private String sendDate;    /*전송 시간*/
	
	public ChatVO() {
	}

	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemNm() {
		return memNm;
	}

	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getChatMsg() {
		return chatMsg;
	}

	public void setChatMsg(String chatMsg) {
		this.chatMsg = chatMsg;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}

	@Override
	public String toString() {
		return "ChatVO [chatNo=" + chatNo + ", memId=" + memId + ", memNm=" + memNm + ", roomNo=" + roomNo
				+ ", chatMsg=" + chatMsg + ", profileImg=" + profileImg + ", sendDate=" + sendDate + "]";
	}

	
}
