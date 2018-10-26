package com.example.demo.vo;

public class PlusVO {
	private int movie;
	private String title;
	private String director;
	
	
	
	public PlusVO(int movie, String title, String director) {
		super();
		this.movie = movie;
		this.title = title;
		this.director = director;
	}
	public int getMovie() {
		return movie;
	}
	public void setMovie(int movie) {
		this.movie = movie;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return movie + "_" + title + "_" + director;
	}
	
	
	
	
	}
