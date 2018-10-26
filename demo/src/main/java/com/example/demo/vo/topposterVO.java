package com.example.demo.vo;

public class topposterVO {
   private int movie;
   private String title;
   private String director;
   private double rating;
   
   //
   private String genre;
   private String actor1;
   private String country;
   private String story;
   private String r_date;
   private String runningtime;
   private int code; // 
   
   //
   
   
   public topposterVO(int movie, String title, String director,double rating , String genre, String actor1,String country, String story, String r_date,String runningtime,int code) {
      this.movie = movie;
      this.title = title;
      this.director = director;
      this.rating = rating;
      this.genre = genre;
      this.actor1 = actor1;
      this.country = country;
      this.story = story;
      this.r_date = r_date;
      this.runningtime = runningtime;
      this.code = code;
   }
      
   
   public String getGenre() {
      return genre;
   }
   public void setGenre(String genre) {
      this.genre = genre;
   }
   public String getActor1() {
      return actor1;
   }
   public void setActor1(String actor1) {
      this.actor1 = actor1;
   }

   public double getRating() {
      return rating;
   }
   public void setRating(double rating) {
      this.rating = rating;
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


   public String getCountry() {
      return country;
   }


   public void setCountry(String country) {
      this.country = country;
   }


   public String getStory() {
      return story;
   }


   public void setStory(String story) {
      this.story = story;
   }


   public String getR_date() {
      return r_date;
   }


   public void setR_date(String r_date) {
      this.r_date = r_date;
   }


   public String getRunningtime() {
      return runningtime;
   }


   public void setRunningtime(String runningtime) {
      this.runningtime = runningtime;
   }


   public int getCode() {
      return code;
   }


   public void setCode(int code) {
      this.code = code;
   }


   
         
   }