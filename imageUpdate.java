import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeMap;

public class FileName {
	//fileName : 실제 디렉터리에 존재하는 파일이름 , mvo : DB에 존재하는 이름 , fileSize(fileName에 해당하는 이미지파일의 크기)
	public static void fileCopy(String fileName , MovieListVO mvo, long fileSize) {

		String filePath = "C:\\Users\\BIT\\Documents\\scorePlus";// 초기 원본파일의 path 를 가져 오는 것입니다 파일 확장자 까이 읽어 오는 것을
		String copyFilePath = "C:\\Users\\BIT\\Documents\\scorePlus2";//이제는 복사된 파일의 위치를 지정하는 것인데 꼭 원본 파일 위치랑 동일할 필요 없습니다
		String movie = String.valueOf(mvo.getMovie());
		String title = mvo.getTitle();
		String director = mvo.getDirector();
		try {
			FileInputStream fis = new FileInputStream(new File(filePath + "\\" + fileName + ".jpg"));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath + "\\" + movie + "_" +title + "_" + director + ".jpg"));
			//System.out.println("생성된 파일 명 : " + num + "_" + fileName + ".jpg");
			byte[] b = new byte[(int) fileSize];

			fis.read(b);
			fos.write(b);
			fis.close();
			fos.close();

		} catch (Exception e) {
			System.out.println("파일을 찾을 수 없습니다.");
		}

	}

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//% 를 &로 바꾸기 
		String url = "jdbc:mysql://192.168.1.172:3306/";
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "hadoop", "123456");
			System.out.println("Connection OK!");
			Statement st = conn.createStatement();
			ResultSet rs = st
					.executeQuery(" select movie, title,director from hadoop.MovieList ORDER BY movie asc");
			
			List<Long> list = new ArrayList<>();
			Map<Integer, MovieListVO> map = new HashMap<>();
			
			System.out.println("<<DB테이블 적재중>>");
			while(rs.next()) {
				int movie = rs.getInt(1);
				String title = rs.getString(2);
				String director = rs.getString(3);
				MovieListVO mvo = new MovieListVO(movie,title,director);
				map.put(movie , mvo);  //"movie를 기준으로 파일제목을 삽입할 것이다." DB에서 가져온 제목은 ":"로 되어있으니 "@"로 바꿔주어야 한다.   
			}

			String filePath = "C:\\Users\\BIT\\Documents\\scorePlus";
			File f = new File(filePath);
			StringTokenizer token;
			TreeMap<Integer,String> tMap = new TreeMap<>();  //movie를 키값으로하고, 제목을 받아올 것임.
			TreeMap<Integer,Long> sizeMap = new TreeMap<>();  //movie를 키값으로하고, 제목을 받아올 것임.
			System.out.println("<<FILE목록 적재중>>");
			for(String fullName : f.list()) {
				String fileName = fullName.substring(0, fullName.length()-4);
				token = new StringTokenizer(fileName, "_");
				int movie = Integer.parseInt(token.nextToken());
				tMap.put(movie, fileName);  // scorePlus에서는 "@"로 표시가 되어있음!! 하지만 movie로만 비교할 것이기 때문에 상관없다. 
				sizeMap.put(movie, new File(filePath+"\\"+fullName).length());
			}
			
			System.out.println("<<이미지파일 복사중>>");
			Set<Integer> keySet = tMap.keySet();
			for(Integer a : keySet) {
				String fileName = tMap.get(a);		// 실제 파일 제목이 반환될 것이다.
				MovieListVO dbObj = map.get(a);		// 실제 DB의 movie , title , director가 반환됨.
				Long fileSize = sizeMap.get(a);
				
				String dbTitle = dbObj.getTitle();
				String dbDirector = dbObj.getDirector();
				String changeTitle= "";
				String changeDirector = "";
				if(dbTitle.contains(":")) {			// ":"로 되어있는 DB내용을 @로 바꿔주어야 한다.
					 changeTitle = dbTitle.replaceAll(":" , "@");
					 dbObj.setTitle(changeTitle);
				}
				if(dbTitle.contains("%")) {			// "%"로 되어있는 DB내용을 &로 바꿔주어야 한다.
					changeTitle = dbTitle.replaceAll("%", "&");
					dbObj.setTitle(changeTitle);
				}
				if(dbDirector.contains(",")) {		// 감독명이 2명 이상인 경우에는 첫번째 녀석을 파일 이름으로 하기 위한 코드
					changeDirector = dbDirector.split(",")[0];
					dbObj.setDirector(changeDirector);
				}
				
				fileCopy(fileName, dbObj, fileSize);
				  
			}
			System.out.println("복사완료 ");
			
		}catch(Exception e) {
			System.out.println("===========================ERROR!!==========================");
		}
			
			
	}

}




//  ========================================MovieListVO=============================================


public class MovieListVO {
	private int movie;
	private String title;
	private String director;
	
	
	
	public MovieListVO(int movie, String title, String director) {
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
	
	
}
