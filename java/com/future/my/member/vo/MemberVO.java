package com.future.my.member.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.future.my.common.valid.Regist;

/**
 * Class Name  : MemberVO
 * Author      : LeeApGil
 * Created Date: 2025. 3. 19.
 * Version: 1.0
 * Purpose: members table VO or DTO     
 * Description: 회원 정보 관리 빈 
 */
public class MemberVO {
	
	@NotEmpty(message="아이디 필수!!", groups= {Regist.class})  
	private String memId;           /*회원 아이디 */
	@Pattern(regexp="^\\w{4,10}$", message="패스워드는 영문 숫자 4 ~10", groups= {Regist.class})
	private String memPw;           /*회원 비밀번호 */
	@Size(min=1, max=20, message="이름 20자 이내로!", groups= {Regist.class})
	private String memNm;           /*회원 이름 */
	private String profileImg;      /*회원 프로필사진 경로 */
	private String memAddr;         /*회원 주소 */
	
	public MemberVO() {
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemPw() {
		return memPw;
	}

	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}

	public String getMemNm() {
		return memNm;
	}

	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getMemAddr() {
		return memAddr;
	}

	public void setMemAddr(String memAddr) {
		this.memAddr = memAddr;
	}

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPw=" + memPw + ", memNm=" + memNm + ", profileImg=" + profileImg
				+ ", memAddr=" + memAddr + "]";
	}
	
	

}
