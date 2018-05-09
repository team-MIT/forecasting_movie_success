# forecasting_movie_success

##Crawler

### BeautifulSoup과 Urllib를 이용해서 크롤러를 만듬.
### 긁어온 데이터에서 koNLpy의 Twitter() 형태소 분석기를 통해 조사, 접속사, 구두점 등 불필요한 정보를 뺀 나머지 유의미한 정보를 text 파일로 저장
### koNLpy를 사용하기 위해선 다음과 같은 명령어를 통해 먼저 필요한 Python module들을 가져온다. 개발환경은 docker의 ubuntu이다.

### pip install bs4
### apt-get install g++ openjdk-8-jdk python-dev python3-dev
### pip install konlpy
### pip install jpype1

### 위와같은 모듈들을 설치한 뒤 크롤러를 통해 데이터를 긁어온다.
