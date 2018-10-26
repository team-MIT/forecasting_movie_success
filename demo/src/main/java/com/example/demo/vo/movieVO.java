package com.example.demo.vo;

import java.util.Comparator;

public class movieVO {
	private String TITLE;
	private String DIRECTOR;
	private String COMPANY;
	private int MONTH;
	private String TYPE;
	private String COUNTRY;
	private int SCREEN;
	private int VIEWER;
	private String GENRE;
	private String GRADE;
	
	public movieVO() {}
	public movieVO(String title , String director) {
		this.TITLE = title;
		this.DIRECTOR = director;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}
	public String getDIRECTOR() {
		return DIRECTOR;
	}
	public void setDIRECTOR(String dIRECTOR) {
		DIRECTOR = dIRECTOR;
	}
	public String getCOMPANY() {
		return COMPANY;
	}
	public void setCOMPANY(String cOMPANY) {
		COMPANY = cOMPANY;
	}
	public int getMONTH() {
		return MONTH;
	}
	public void setMONTH(int mONTH) {
		MONTH = mONTH;
	}
	public String getTYPE() {
		return TYPE;
	}
	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}
	public String getCOUNTRY() {
		return COUNTRY;
	}
	public void setCOUNTRY(String cOUNTRY) {
		COUNTRY = cOUNTRY;
	}
	public int getSCREEN() {
		return SCREEN;
	}
	public void setSCREEN(int sCREEN) {
		SCREEN = sCREEN;
	}
	public int getVIEWER() {
		return VIEWER;
	}
	public void setVIEWER(int vIEWER) {
		VIEWER = vIEWER;
	}
	public String getGENRE() {
		return GENRE;
	}
	public void setGENRE(String gENRE) {
		GENRE = gENRE;
	}
	public String getGRADE() {
		return GRADE;
	}
	public void setGRADE(String gRADE) {
		GRADE = gRADE;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
