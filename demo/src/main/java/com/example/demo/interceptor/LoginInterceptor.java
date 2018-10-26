package com.example.demo.interceptor;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.example.demo.mapper.memberMapper;
import com.example.demo.vo.memberVO;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Resource(name="com.example.demo.mapper.memberMapper")
	memberMapper ser;
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
	
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		System.out.println("ID :" + id+"// PW : "+pw);
		memberVO vo = ser.checkUser(id, pw);
		
		if (vo == null) {
			System.out.println("일치하는거 없음 ");
			response.sendRedirect(request.getContextPath()+"/login");
			return false;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("session_id", vo.getId());	
				
		System.out.println("==========!!!!!!!!!!!!!!!!!!!!!!!!+========");
		response.sendRedirect("/test");
		return false;
		
	}

}