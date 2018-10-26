package com.example.demo;

import java.io.File;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.example.demo.interceptor.LoginInterceptor;
import com.example.demo.interceptor.LogoutInterceptor;

@SpringBootApplication
@MapperScan(value={"com.example.demo.mapper"})
public class DemoApplication extends WebMvcConfigurerAdapter{
//public class DemoApplication {
	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
	
	  /*
     * SqlSessionFactory 설정 
     */
	
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();        
        sessionFactory.setDataSource(dataSource);
        return sessionFactory.getObject();        
    }
    
    ///////////Interceptor///////////// 
    
    @Autowired
    LoginInterceptor LI;
    @Autowired
    LogoutInterceptor LO;       
	public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(LI).addPathPatterns("/loginPost");
		registry.addInterceptor(LO).addPathPatterns("/logout");
	}
		
	   public void addResourceHandlers(ResourceHandlerRegistry registry) {
	       registry
	         .addResourceHandler("/image/**")
	         .addResourceLocations(new File("C:/Users/BIT/Documents/scorePlus").toURI().toString()); 
	       
	       registry.addResourceHandler("/default/**")//C:\Users\bit-user
//	       .addResourceLocations(new File("C:/Users/BIT/Documents/imagePost/new").toURI().toString());
	       .addResourceLocations(new File("D:/default").toURI().toString());
	       registry.addResourceHandler("/wordcloud/**")//C:\Users\bit-user
	       .addResourceLocations(new File("C:/Users/BIT/Documents/workspace-sts-3.9.4.RELEASE/demo/demo").toURI().toString());
	       
	       
	       
	   }

	
	//////////////////////////////////
	    
}
