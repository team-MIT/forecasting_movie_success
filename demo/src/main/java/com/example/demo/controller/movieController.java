package com.example.demo.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.WordCloud;
import com.example.demo.favorite;
import com.example.demo.start;
import com.example.demo.mapper.movieMapper;
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
import com.example.demo.vo.topposterVO;

@Controller
public class movieController {
	@Resource(name = "com.example.demo.mapper.movieMapper")
	movieMapper mm;

	public static String binarySearch(String key, String[] direc) {
		int mid;
		int left = 0;
		int right = direc.length - 1;
		StringTokenizer st;

		String returnValue = null;
		while (right >= left) {
			mid = (right + left) / 2;

			String name = direc[mid];
			if (name.contains(".jpg")) {
				name = name.substring(0, name.length() - 4);
				st = new StringTokenizer(name, "_");

				String movName = st.nextToken();
				if (key.equals(movName)) {
					returnValue = name;
					break;
				}

				if (key.compareTo(name) < 0) {
					right = mid - 1;
				} else {
					left = mid + 1;
				}
			} else {

				if (key.compareTo(name) < 0) {
					right = mid - 1;
				} else {
					left = mid + 1;
				}
			}
		}
		return returnValue;
	}

	@RequestMapping("/test")
	private ModelAndView list(HttpSession session) throws Exception {
		// image
		System.out.println("=============== !! image !! ==============");
		String session_id = (String) session.getAttribute("session_id");
		if (session_id == null) {
			System.out.println("sessionid없당");
			ModelAndView mav = new ModelAndView();
			mav.setViewName("member/login");
			return mav;
		}

		// String fileDir = "C:\\Users\\BIT\\Documents\\imagePost\\new"; // 파일을 보여줄 디렉토리
		String fileDir = "D:\\default";

		File f = new File(fileDir);

		// -------------------------------------------------------------------//
		List<defaultVO> db_list = mm.defaultMovie(session_id);

		HashSet<String> hs = new HashSet<>();
		HashSet<String> hs2 = new HashSet<>();

		for (int a = 0; a < db_list.size(); a++) {
			String str = db_list.get(a).getTitle();
			String rr = db_list.get(a).getR_date().toString();
			String rr2 = rr.substring(0, 4);
			hs.add(str);
			hs2.add(rr2);

		}

		//
		String[] directory = f.list();
		int db_size = db_list.size();
		// ModelAndView mav = new ModelAndView();
		// mav.addObject("list", img_list);
		// mav.setViewName("test");
		List<movieDetailVO> detailList = mm.scorePlus(session_id);
		List<movieDetailVO> detailList2 = new LinkedList<>();
		for (movieDetailVO mvo : detailList) {
			if (hs.contains(mvo.getTitle()) && hs2.contains(mvo.getR_date().substring(0, 4))) {

				String title = mvo.getTitle();
				String director = mvo.getDirector();
				int movie = mvo.getMovie();
				if (director.contains(",")) {
					director = director.split(",")[0];
					mvo.setDirector(director);
				}
				if (title.contains("%")) {
					title = title.replaceAll("%", "&");
				}
				if (title.contains(":")) {
					title = title.replaceAll(":", "@");
				}
				mvo.setFileName(title + "_" + director);
				detailList2.add(mvo);
			}

			// else {
			// detailList.remove(mvo);
			// }

		}

		List<movieDetailVO> detailList3 = new LinkedList<>();

		for (int a = 0; a < db_list.size(); a++) {
			String title = db_list.get(a).getTitle();
			for (int j = 0; j < detailList2.size(); j++) {
				if (title.equals(detailList2.get(j).getTitle())) {
					detailList3.add(detailList2.get(j));
				}
			}
		}

		for (int i = 0; i < detailList2.size(); i++) {
			System.out.println(detailList2.get(i).getTitle() + "//");
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("detailList2", detailList3);
		mav.setViewName("test");
		return mav;

		// ------------------------------------20170720----------------------------//

		// List<movieDetailVO> detailList = mm.scorePlus(session_id);
		// for(movieDetailVO mvo : detailList) {
		// String title = mvo.getTitle();
		// String director = mvo.getDirector();
		// int movie = mvo.getMovie();
		// if(director.contains(",")) {
		// director = director.split(",")[0];
		// mvo.setDirector(director);
		// }
		// if(title.contains("%")) {
		// title = title.replaceAll("%", "&");
		// }
		// if(title.contains(":")) {
		// title = title.replaceAll(":", "@");
		// }
		// mvo.setFileName(movie+"_"+ title + "_" +director );
		// }
		//
		// ModelAndView mav = new ModelAndView();
		// mav.addObject("detailList",detailList);
		// mav.setViewName("test");
		// return mav;
		//

	}

	// css 템플릿 적용시킨 평가더하기 컨트롤러
	// 수정해야 할 곳
	// ( DemoApplication.java에서 이미지파일경로 인기순으로 이미지 저장한 경로로 수정해주어야 한다. )
	// scorePlus.jsp에서 코드가 살짝 바뀌었으므로 수정해야 한다.
	// PlusVO라는 객체를 추가했다.

	@RequestMapping("/scorePlus")
	private ModelAndView scorePlus(HttpSession session) throws Exception {

		// (1) 영화 포스터가 있는 디렉터리를 읽어서 보여주는 방법
		String fileDir = "C:\\Users\\BIT\\Documents\\scorePlus"; // 파일을 보여줄 디렉토리

		File f = new File(fileDir);

		// List<PlusVO> list = new ArrayList<>();
		// StringTokenizer st;
		// movieListVO 객체들의 집합
		// TreeMap<Integer, PlusVO> tMap = new TreeMap<>();

		// for (String name : f.list()) {
		// int nameSize = name.length();
		// st = new StringTokenizer(name.substring( 0 , nameSize-4 ), "_");
		// int movie = Integer.parseInt(st.nextToken());
		// String title = st.nextToken();
		// String director = st.nextToken();
		// tMap.put(movie, new PlusVO(movie,title,director));
		// }
		//
		// Set<Integer> keySet = tMap.keySet();
		// for (Integer num : keySet) {
		// list.add(tMap.get(num));
		// }
		//
		// (2) DB에서 접근하여 평가 더하기의 포스터를 뿌려주는 방식

		String session_id = (String) session.getAttribute("session_id");
		if (session_id == null) {
			System.out.println("sessionid없당");
			ModelAndView mav = new ModelAndView();
			mav.setViewName("member/login");
			return mav;
		}

		List<movieDetailVO> detailList = mm.scorePlus(session_id);
		for (movieDetailVO mvo : detailList) {
			String title = mvo.getTitle();
			String director = mvo.getDirector();
			int movie = mvo.getMovie();
			if (director.contains(",")) {
				director = director.split(",")[0];
				mvo.setDirector(director);
			}
			if (title.contains("%")) {
				title = title.replaceAll("%", "&");
			}
			if (title.contains(":")) {
				title = title.replaceAll(":", "@");
			}
			mvo.setFileName(movie + "_" + title + "_" + director);
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("detailList", detailList);
		mav.setViewName("scorePlus");
		return mav;
	}

	@RequestMapping("/starScore") // 사용자의 평가늘리기를 위한 별점등록컨트롤러
	public void startScore(@ModelAttribute ScoreVO svo, HttpSession session) {
		svo.setId((String) session.getAttribute("session_id"));
		System.out.println(svo.getId());
		mm.starScore(svo);

		System.out.println("TITLE:" + svo.getTitle());
		System.out.println("Rating:" + svo.getRating());

		// return "movie/home";
	}

	// img -> X
	@RequestMapping("testimage")
	public String img() {
		System.out.println("============== img Controller =================");
		return "/imgtest";
	}

	// view
	@RequestMapping(value = "/view/{TITLE}", method = RequestMethod.GET)
	public ModelAndView view(@PathVariable("TITLE") String TITLE) throws Exception {
		System.out.println("=====================!! view !! ====================");
		System.out.println("#####################" + TITLE + "####################");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/testupdate");
		mav.addObject("vo", mm.read(TITLE));
		return mav;
	}

	// update
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute movieVO vo) throws Exception {
		System.out.println("=====================!! UPDATE !!======================");
		mm.movieupdate(vo);
		return "redirect:test";
	}

	// insert
	@RequestMapping(value = "/testwrite", method = RequestMethod.GET)
	public String write() throws Exception {
		System.out.println("============================!!!testwrite Controller!!!==============================");
		return "/testwritejsp";
	}

	//
	@RequestMapping(value = "/testinsert", method = RequestMethod.POST)
	public String insert(@ModelAttribute movieVO vo) throws Exception {
		System.out.println("=======================!! testinsert COntroller !!========================= ");
		mm.movieinsert(vo);
		return "redirect:/test";
	}
	//

	// delete
	@RequestMapping(value = "/testremove", method = RequestMethod.GET)
	public String remove() {
		System.out.println("==================!! testremove Controller!! ==================");
		return "/testdelete";
	}

	@RequestMapping(value = "/testdelete")
	public String delete(@PathVariable String TITLE) throws Exception {
		System.out.println("================!! testdelete Controller !! ==================");
		mm.moviedelete(TITLE);
		return "redirect:/test";
	}

	// star
	@RequestMapping(value = "/star")
	public String Star() throws Exception {
		return "/NewFile";
	}

	// top list -> 추천영화 top10
	@RequestMapping(value = "/top")
	private ModelAndView toplist(HttpSession session, HttpServletResponse response) throws Exception {
		System.out.println("===========================!!!!! top list controller!!!!!==============================");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		String id = (String) session.getAttribute("session_id");
		if (id == null) {
			System.out.println("sessionid없당");
			ModelAndView mav = new ModelAndView();
			mav.setViewName("member/login");
			return mav;
		}
		ModelAndView mav = new ModelAndView();

		// 평가더하기의 영화평점을 20개 이상 매기지 않았으면 scorePlus페이지로 이동하게 하는 내용
		int scoreNum = mm.topConfirm(id); // scorePlus에서 평가한 개수
		if (scoreNum < 20) {
			int num = 20 - scoreNum;
			out.print("<script>alert('평가더하기 " + num + "개를 더 해 주세요'); location.href='/scorePlus';</script>");
			out.flush();
			out.close();
		}
		HashMap<String, Double> titleratingmap = new HashMap<>();
		// HashSet<String> hs = new HashSet<>();
		System.out.println("ID :" + id);
		List<topVO> list = mm.toplist(id);
		if (list.size() == 0) {
			out.print("<script>alert(' 분석 중 입니다. 잠시 후 다시 시도해주세요.'); location.href='/test';</script>");
			out.flush();
			out.close();
		}

		// 평점 조절
		for (int i = 0; i < list.size(); i++) {
			double num = list.get(i).getRating();
			int num2 = (int) num;
			if (num - num2 <= 0.25)
				list.get(i).setRating(num2);
			else if (num - num2 > 0.25 && num - num2 <= 0.75)
				list.get(i).setRating(num2 + 0.5);
			else
				list.get(i).setRating(num2 + 1);
		}

		System.out.println(list.get(0).getId() + "//" + list.get(0).getTitle() + "//" + list.get(0).getRating());

		// 중복
		for (int i = 0; i < list.size(); i++) {
			titleratingmap.put(list.get(i).getTitle(), list.get(i).getRating());
		}

		///////////////////////////////////////////////

		// MovieList테이블에서 장르 배우 저장
		List<topposter2VO> mllist = mm.MovieDetail();
		System.out.println(mllist.get(0).getTitle() + "///////////////" + mllist.get(0).getStory());
		System.out.println(mllist.size());

		// List<topposter2VO> mmmm = mm.MovieList();

		// image

		String fileDir = "C:\\Users\\BIT\\Documents\\scorePlus"; // 파일을 보여줄 디렉토리
		File f = new File(fileDir);
		StringTokenizer st;
		StringTokenizer st2;
		List<topposterVO> list2 = new LinkedList<>();

		for (String name : f.list()) {
			String fileName = (String) name.subSequence(0, name.length() - 4);
			st2 = new StringTokenizer(fileName, "_");
			int no = Integer.parseInt(st2.nextToken()); // no
			String title = st2.nextToken();
			String director = st2.nextToken(); // director
			System.out.println(title + "/1/" + director + " /1/");
			st = new StringTokenizer(director, ",");
			director = st.nextToken();
			System.out.println(title + "/2/" + director + " /2/");
			String title2 = title.replaceAll("@", ":");
			title2 = title2.replaceAll("&", "%");

			// System.out.println(title +"///" + title2);

			if (titleratingmap.containsKey(title2)) { // title
				for (topposter2VO v : mllist) {
					if (v.getTitle().equals(title2) && v.getDirector().contains(director)) {
						String title3 = title2.replaceAll(":", "@");// 다시 @ 처리
						title3 = title3.replaceAll("%", "&");// 다시 @ 처리

						System.out.println("*****->>" + v.getTitle() + "/" + v.getGenre() + "/" + v.getActor1() + "/"
								+ v.getCode());
						list2.add(new topposterVO(no, title3, director, titleratingmap.get(title2), v.getGenre(),
								v.getActor1(), v.getCountry(), v.getStory(), v.getR_date(), v.getRunningtime(),
								v.getCode()));

						// System.out.println("*****->>" + title3 +"//" + titleratingmap.get(title2));
						// list2.add(new
						// topposterVO(no,title3,director,titleratingmap.get(title2),"","","","",""));
						break;
					}
				}
				titleratingmap.remove(title2);
			}
		}

		//////////////////////////////////////////////

		Map<String, Object> map = new HashMap<>();
		// map.put("list", list);
		map.put("list2", list2);
		mav.addObject("map", map);
		mav.setViewName("testtop");
		return mav;

	}
	// =========================== start Spark ===========================//
	// 1. delete 먼저진행
	// 2. spark 실행

	@RequestMapping(value = "/startSpark")
	public String startSpark(HttpSession session, HttpServletResponse response) throws Exception {
		String id = (String) session.getAttribute("session_id");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		if (id == null) {
			System.out.println("sessionid없당");
			return "member/login";
		}
		PrintWriter out = response.getWriter();

		int scoreNum = mm.topConfirm(id); // scorePlus에서 평가한 개수
		if (scoreNum < 20) {
			int num = 20 - scoreNum;
			out.print("<script>alert('평가더하기 " + num + "개를 더 해 주세요'); location.href='/scorePlus';</script>");
			out.flush();
			out.close();
		}else {

		favoritedelete(id);
		rcmddelete(id);
		topfav(id);
		FAVs(id);
		}
		// word클라우드는 finish를눌렀을 때 생성됨 ( 이미지파일이 )
		WordCloud wc = new WordCloud();
		String[] command = { "python",
				"C:\\Users\\BIT\\Documents\\workspace-sts-3.9.4.RELEASE\\demo\\demo\\wordcloud.py", id };
		wc.main(command);
		out.print("<script>alert('평가더하기를 완료했습니다.');");
		out.print("location.href='/test';</script>");
		out.flush();
		out.close();

		return "redirect:/test";
	}

	// wordcloud

	//// als 전 -> 완료번튼시 rcmd delete
	// @RequestMapping(value = "/rcmddelete/{id}")
	public String rcmddelete(@PathVariable String id) throws Exception {
		mm.rcmddelete(id);
		System.out.println("================!! Rcmddelete 실행 !! ==================");
		return "redirect:/test";
	}

	// favorite delete
	// @RequestMapping(value = "/favoritedelete/{id}")
	public String favoritedelete(@PathVariable String id) throws Exception {
		// favorite delete -> favorite 버튼 시 delete후 실행되도록
		mm.favoritegenredelete(id);
		mm.favoriteactordelete(id);
		mm.favoritedirectordelete(id);
		mm.favoritecountrydelete(id);
		System.out.println("===============favorite delete 실행 ===============");

		//
		return "redirect:/test";
	}

	// top spark

	// @RequestMapping(value = "/topspark/{id}")
	private String topfav(@PathVariable("id") String id) throws Exception {
		//
		// topspark 명령어 실행 !
		int no = mm.topsparkno(id);
		System.out.println(" >>>>>>>>>>>>>>>>>>> als 돌리기 위한 너의 no는 : " + no);
		start st = new start(no);
		st.main(null);
		System.out.println("=========top spark 명령어 실행 완료 =========");
		return "redirect:/test";
	}

	// favorite spark

	// @RequestMapping(value = "/favoritespark/{id}")
	private String FAVs(@PathVariable("id") String id) throws Exception {
		// favoritespark 명령어 실행 !
		favorite ff = new favorite(id);
		ff.main(null);
		System.out.println("=========favorite spark 명령어 실행 완료 =========");
		return "redirect:/test";
	}

	// ==================================================================//

	// favorite
	// @RequestMapping(value = "/favorite/{id}")
	// private ModelAndView FAV(@PathVariable("id") String id,HttpSession session)
	// throws Exception {
	//
	// System.out.println("===========================!!!!! favorite
	// controller!!!!!==============================");
	//
	// String sessionid = (String) session.getAttribute("session_id");
	// if(sessionid == null){
	// System.out.println("sessionid없당");
	// ModelAndView mav = new ModelAndView();
	// mav.setViewName("member/login");
	// return mav;
	// }
	//
	// System.out.println("ID :" + id);
	//
	// // genre
	// List<favoritegenreVO> genrelist = mm.favoritegenre(id);
	// // actor
	// List<favoriteactorVO> actorlist = mm.favoriteactor(id);
	// // director
	// List<favoritedirectorVO> directorlist = mm.favoritedirector(id);
	// // country
	// List<favoritecountryVO> countrylist = mm.favoritecountry(id);
	//
	// Map<String, Object> map = new HashMap<>();
	// map.put("genrelist", genrelist);
	// map.put("actorlist", actorlist);
	// map.put("directorlist", directorlist);
	// map.put("countrylist", countrylist);
	//
	// ModelAndView mav = new ModelAndView();
	// mav.addObject("map", map);
	// mav.setViewName("favoriteview");
	// return mav;
	// }

	@RequestMapping(value = "/favorite")
	private ModelAndView FAV(HttpSession session, HttpServletResponse response) throws Exception {

		System.out.println("===========================!!!!! favorite controller!!!!!==============================");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String id = (String) session.getAttribute("session_id");
		if (id == null) {
			System.out.println("sessionid없당");
			ModelAndView mav = new ModelAndView();
			mav.setViewName("member/login");
			return mav;
		}

		System.out.println("ID :" + id);

		PrintWriter out = response.getWriter();
		int scoreNum = mm.topConfirm(id); // scorePlus에서 평가한 개수
		if (scoreNum < 20) {
			int num = 20 - scoreNum;
			out.print("<script>alert('평가더하기 " + num + "개를 더 해 주세요'); location.href='/scorePlus';</script>");
			out.flush();
			out.close();
		}

		// genre
		List<favoritegenreVO> genrelist = mm.favoritegenre(id);
		// actor
		List<favoriteactorVO> actorlist = mm.favoriteactor(id);
		// director
		List<favoritedirectorVO> directorlist = mm.favoritedirector(id);
		// country
		List<favoritecountryVO> countrylist = mm.favoritecountry(id);

		if (genrelist.size() == 0 || actorlist.size() == 0 || directorlist.size() == 0 || countrylist.size() == 0) {
			out.print("<script>alert(' 분석 중 입니다. 잠시 후 다시 시도해주세요. '); location.href='/test';</script>");
			out.flush();
			out.close();
		}

		Map<String, Object> map = new HashMap<>();
		map.put("genrelist", genrelist);
		map.put("actorlist", actorlist);
		map.put("directorlist", directorlist);
		map.put("countrylist", countrylist);
		map.put("session_id", id);

		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map);
		mav.setViewName("favoriteview");
		return mav;
	}

}