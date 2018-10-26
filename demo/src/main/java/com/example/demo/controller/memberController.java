package com.example.demo.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.mapper.memberMapper;
import com.example.demo.vo.memberVO;

@Controller
public class memberController {
	@Resource(name="com.example.demo.mapper.memberMapper")
	  memberMapper mm;
		
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		System.out.println("============login jsp 이동 ===========");
		return "member/login"; //login jsp 이동 
	}
	
	
	
	
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout() {
		System.out.println("==========logout===========");
		return "redirect:test"; // test Controller 이동  
	}
	
	@RequestMapping(value="/loginPost", method=RequestMethod.POST)
	public void loginPost(@ModelAttribute memberVO vo, HttpSession session, Model model) throws Exception {		
		System.out.println("==INTERCEPTER==");
	}
	
	@RequestMapping(value="/joinPost", method=RequestMethod.POST)
	public void joinPost(@ModelAttribute memberVO vo, HttpServletResponse response) throws Exception {
		System.out.println("==========joinPostController-> 회원가입 후 test Controller로 이동 ==========");
		boolean bool = mm.joinuser(vo);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(bool) {
			System.out.println("회원가입성공");

			out.print("<script>alert('회원가입이 완료되었습니다.');location.href='/login';</script>");
			out.flush();
			out.close();
		}
		else {
			System.out.println("회원가입 실패");
			out.print("<script>alert('이미 존재하는 ID입니다.');location.href='/login';</script>");
			out.flush();
			out.close();
		}

	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		System.out.println("===========joinController -> join jsp 이동 ==========");
		return "member/join";
	}
	

	
	//dbview
	@RequestMapping(value="/dbview")
	public ModelAndView dbview() throws Exception {
		System.out.println("===========Dbview ==========");
		  List<memberVO> list = mm.viewuser();
		  System.out.println(list.get(0).getNo()+"//" + list.get(0).getId() +"//" +list.get(0).getPw());
		  System.out.println(list.get(1).getId() +"//" +list.get(1).getPw());
		  System.out.println(list.get(2).getId() +"//" +list.get(2).getPw());
		  System.out.println(list.get(3).getId() +"//" +list.get(3).getPw());
		  System.out.println(list.get(4).getId() +"//" +list.get(4).getPw());
		  Map<String, Object> map = new HashMap<>();
		  map.put("list", list);
		  ModelAndView mav = new ModelAndView();
		  mav.addObject("map",map);
		  mav.setViewName("dbdb");
		  return mav;
	}
	


	
	
	
	
	
}
