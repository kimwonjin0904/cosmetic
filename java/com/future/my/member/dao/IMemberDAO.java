package com.future.my.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.member.vo.MemberVO;

@Mapper
public interface IMemberDAO {
	// mapper xml의 id와 매핑됨.
	// input parameterType
	// output resultType
	public int registMember(MemberVO vo);
	
	public MemberVO loginMember(MemberVO vo);
	//프로필 이미지 수정
	public int profileUpload(MemberVO vo);
}
