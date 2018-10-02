package com.example.demo.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.vo.ScoreVO;
import com.example.demo.vo.defaultVO;
import com.example.demo.vo.favoriteactorVO;
import com.example.demo.vo.favoritecountryVO;
import com.example.demo.vo.favoritedirectorVO;
import com.example.demo.vo.favoritegenreVO;
import com.example.demo.vo.movieDetailVO;
import com.example.demo.vo.movieVO;
import com.example.demo.vo.topVO;
import com.example.demo.vo.topposter2VO;

@Repository("com.example.demo.mapper.movieMapper")
public interface movieMapper {
	// list
	public List<movieVO> movielistall() throws Exception;

	// scorePlus - detailPage
	public List<movieDetailVO> scorePlus(String id) throws Exception;

	// insert
	public void movieinsert(movieVO vo) throws Exception;

	// read
	public movieVO read(String TITLE) throws Exception;

	// update
	public void movieupdate(movieVO vo) throws Exception;

	// defaultChart
	public List<defaultVO> defaultMovie(String id) throws Exception;

	// delete
	public void moviedelete(String title) throws Exception;

	// toplist
	public List<topVO> toplist(String id) throws Exception;

	// favoriteDelete
	public void favoritegenredelete(String id) throws Exception;

	public void favoriteactordelete(String id) throws Exception;

	public void favoritedirectordelete(String id) throws Exception;

	public void favoritecountrydelete(String id) throws Exception;

	// favoriteGenre
	public List<favoritegenreVO> favoritegenre(String id) throws Exception;

	// favoriteActor
	public List<favoriteactorVO> favoriteactor(String id) throws Exception;

	// favoriteDirector
	public List<favoritedirectorVO> favoritedirector(String id) throws Exception;

	// favoriteCountry
	public List<favoritecountryVO> favoritecountry(String id) throws Exception;

	// rcmddelete
	public void rcmddelete(String id) throws Exception;

	// topspark id -> no topsparkno

	public int topsparkno(String id) throws Exception;

	// Star Score
	public int starScore(ScoreVO svo);

	public List<Integer> duplicateScore(String id);

	// top 10 MovieDetail
	public List<topposter2VO> MovieDetail() throws Exception;

	// top 10 MovieList
	public List<topposter2VO> MovieList() throws Exception;
	
	// top 10 을 확인할 수 있는지 검증하는 DB접근
	public int topConfirm(String id) throws Exception;

}
