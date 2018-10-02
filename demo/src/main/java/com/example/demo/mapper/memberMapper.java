package com.example.demo.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.vo.memberVO;

@Repository("com.example.demo.mapper.memberMapper")
public interface memberMapper {
  // 
   public memberVO login (memberVO vo) throws Exception;
   
  //
   public boolean joinuser(memberVO vo) throws Exception;
  //
   
   public List<memberVO> viewuser() throws Exception;
   
  //   
   public memberVO checkUser(String id, String pw) throws Exception;

}
