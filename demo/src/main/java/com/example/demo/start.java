package com.example.demo;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class start {  // -> als 
	private static int no;	
    public start(int no){
    	this.no = no;
    }
        
    //평가더하기에서 ratings db에 저장 , 완료번튼 만들면 rcmd에서 해당id에 따른 모든 데이터 delete 후 als 실행 
public static void main(String[] args) {	 	 	  
	System.out.println(no+"!!!!!!!!!!!!!!!!!!!!!!!!!!!#$!#@Q#%#");
	  String username = "hadoop";
      String host = "192.168.1.171";
      int port = 22;
      String password = "123456";
      
      System.out.println("==> Connecting to" + host);
      Session session = null;
      Channel channel = null;      
      
      // 2. 세션 객체를 생성한다 (사용자 이름, 접속할 호스트, 포트를 인자로 준다.)
      try {
          // 1. JSch 객체를 생성한다.
          JSch jsch = new JSch();
          session = jsch.getSession(username, host, port);
       
          // 3. 패스워드를 설정한다.
          session.setPassword(password);
       
          // 4. 세션과 관련된 정보를 설정한다.
          java.util.Properties config = new java.util.Properties();
          
          // 4-1. 호스트 정보를 검사하지 않는다.
          config.put("StrictHostKeyChecking", "no");
          session.setConfig(config);
       
          // 5. 접속한다.
          session.connect();
       
          // 6. sftp 채널을 연다.
          channel = session.openChannel("exec");
       
          // 8. 채널을 SSH용 채널 객체로 캐스팅한다
          ChannelExec channelExec = (ChannelExec) channel;
          System.out.println("==> Connected to" + host);
          channelExec.setCommand("spark-shell -i MovieRecommendation.scala --conf spark.driver.args='"+no+"'");
//        channelExec.setCommand("spark-shell -i FavoriteGenre.scala --conf spark.driver.args=910602");
          channelExec.connect();
          System.out.println("==> Connected to" + host);
    
      } catch (JSchException e) {
          e.printStackTrace();
      } finally {
          if (channel != null) {
              channel.disconnect();
          }
          if (session != null) {
              session.disconnect();
          }
      }

 }
}
