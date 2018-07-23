import urllib
import urllib.request
import urllib.parse
import bs4
import re
import os
import time
from concurrent.futures import ThreadPoolExecutor
from threading import Lock 
import codecs
from selenium import webdriver
import csv
import nltk
import tweepy
import json
from konlpy.tag import Twitter
import pymysql
#계봉 예정 영화에 대한 각종 정보를 긁어온다.

conn = pymysql.connect(
      host = '192.168.1.172',
      user = 'root',
      password = '123456',
      db = 'hadoop',
      charset = 'utf8',
)
def deleteTag(x):
    return re.sub("\"/><[^>]*>", "", x)
def saveImage(__url__, name):
    #print("여기 실행됨")
    name = name.replace(":", "@")
    name = name + ".jpg"
    print(name)
    print(__url__)
    f = urllib.request.urlopen(__url__)
    data = f.read().decode('utf-8')
    soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')
    img_url = soup.select("a")

    img_url = str(img_url[0]).split("\" src=\"")
    #print(img_url[1])
    img_tt = img_url[1]
    img_tt = deleteTag(img_tt)
    outPath = './OTTEHOT/'
    try :
        if os.stat(name).st_size > 0 : return
    except :
        None
    saveName = outPath + name
    #print(saveName)
    urllib.request.urlretrieve(img_tt,saveName)

def adult(code):
    
    def innerHTML(s, sl=0):
        ret = ''
        for i in s.contents[sl:]:
            if i is str:
                ret += i.strip()
            else:
                ret += str(i)
        return ret
 
    def fText(s):
        if len(s): return innerHTML(s[0]).strip()
        return ''

    USER = "<INSERT YOUR ID>"
    PASS = "<INSERT YOUR PASSWORD>"
    #print("PhantomJS 드라이버 실행")
    
    driver = webdriver.PhantomJS()
    driver.implicitly_wait(3)
    
    driver.get('https://nid.naver.com/nidlogin.login')
    driver.find_element_by_id("id").send_keys(USER)
    driver.find_element_by_id("pw").send_keys(PASS)
    driver.find_element_by_xpath('//*[@id="frmNIDLogin"]/fieldset/input').click()

    try:
        _url = ("https://movie.naver.com/movie/bi/mi/detail.nhn?code=" + str(code))
        #print("url : " , _url)
        driver.get(_url)
        ui.WebDriverWait(driver, 3).until(EC.visibility_of_element_located((By.CLASS, "h_movie")))
        html = driver.page_source  
    except:
        return
    #print(html)
    soup = bs4.BeautifulSoup(html,'html.parser')
    return soup
    
def mText(s):
    ret = []
    for temp in s:
        num = str(temp).split("code=")
        code = ''
        idx = 0
        while(True):
            if num[1][idx] >= '0' and num[1][idx] <= '9':
                code += num[1][idx]
                idx += 1
            else : 
                break
        ret.append(code)
    return ret
def getStory(code):
    def removeTags(s):
        context = re.sub("<br>", "\"n", s)
        context = re.sub("\r","" , context)
        #context = re.sub("\\","" , context)
        context = re.sub("<br/>\xa0","" , context)
        context = re.sub("\"","" , context)
        context = re.sub("\'","" , context)
        context2 = re.sub("&nbsp;", "", context)
        return context2
    def innerHTML(s, sl=0):
        ret = ''
        for i in s.contents[sl:]:
            if i is str:
                ret += i.strip()
            else:
                ret += str(i)
        return ret
 
    def fText(s):
        if len(s): return innerHTML(s[0]).strip()
        return ''

    try:
        _url = ("https://movie.naver.com/movie/bi/mi/basic.nhn?code=" + str(code))
        # + str(code)
        #print("url : " , _url)
        f = urllib.request.urlopen(_url)
        #print("여기까진 실행됨")
        data = f.read().decode('utf-8') 
    except:
        return
    soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')
    story = fText(soup.select(".con_tx"))

    if story == "":
        soup = adult(code)
        if soup == None : return
        story = fText(soup.select(".con_tx"))
    return removeTags(story)

def getMovieName(code):
    def removeTags2(s):
        context = re.sub("<br>", "\"n", s)
        context = re.sub("\r","" , context)
        #context = re.sub("\\","" , context)
        context = re.sub("<br/>\xa0","" , context)
        context = re.sub("\"","" , context)
        context = re.sub("\'","" , context)
        context2 = re.sub("&nbsp;", "", context)
        return context2
    def removeTags(s):
        clenr = re.compile('<.*?>')
        cleanText = re.sub(clenr,'',s)
        return cleanText

    def innerHTML(s, sl=0):
        ret = ''
        for i in s.contents[sl:]:
            if i is str:
                ret += i.strip()
            else:
                ret += str(i)
        return ret
 
    def fText(s):
        if len(s): return innerHTML(s[0]).strip()
        return ''
    def rText(s):
        if len(s): return (innerHTML(s[0]).strip() + innerHTML(s[1]).strip() + innerHTML(s[2]).strip() + innerHTML(s[3]).strip())
    def r2Text(s):
        if not len(s): return
        #actor = ""
        juIndex = 0
        ju = ""
        joIndex = 0
        jo = ""
        if len(s) :
            for a in s:
                cont = fText(a.select(".p_info a"))
                cont = re.sub('<[^>]+>.+?', '', cont)
                temp = fText(a.select(".in_prt em"))
                if temp == "주연" :
                    if juIndex > 3 : continue
                    juIndex += 1
                    ju += str(cont + ",")
                if temp == "조연" :
                    if joIndex > 3 : continue
                    joIndex += 1
                    jo += str(cont + ",")
        return ju + "|" + jo

    #print("여기까진 실행됨", code)
    try:
        _url = ("https://movie.naver.com/movie/bi/mi/detail.nhn?code=" + str(code))
        # + str(code)
        #print("url : " , _url)
        f = urllib.request.urlopen(_url)
        #print("여기까진 실행됨")
        data = f.read().decode('utf-8')   
    except:
        return
    #print("여기도 실행댐")
    #bs4를 이용해서 각각의 css 선택자를 통해 데이터를 긁어온다
    soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')
    title = fText(soup.select("#content > div.article > div.mv_info_area > div.mv_info > h3 > a"))
    
    if title == "" :
        soup = adult(code)
        if soup == None : return #영화가 없는것.
        title = fText(soup.select("#content > div.article > div.mv_info_area > div.mv_info > h3 > a"))
    saveImage("https://movie.naver.com/movie/bi/mi/photoViewPopup.nhn?movieCode=" +str(code), title)
    director = fText(soup.select("#content > div > div.mv_info_area > div.mv_info > dl > dd > p > a")) 
    aList = r2Text(soup.select("#content > div.article > div.section_group.section_group_frst > div.obj_section.noline > div > div.lst_people_area.height100 > ul > li"))
    company = removeTags(fText(soup.select(".agency_name")))
    title = removeTags2(title)
    compList = []
    compList = company.split()
   
    tempName = ''
    idx = 0
    for i in compList:
        idx += 1
        if str(i) == "배급":
            tempName = compList[idx:]
            break
    companyName = ''
    for i in tempName:
        companyName += str(i)
   # print(companyName)
    aList = r2Text(soup.select("#content > div.article > div.section_group.section_group_frst > div.obj_section.noline > div > div.lst_people_area.height100 > ul > li"))
    #print(aList)
    if aList == None:
        aList = "NULL"
    overview = soup.select(".info_spec span a")

    contry = ""
    genre = ""
    rateGrade = ""
    for a in overview:
        token = str(a).split("?")
        if len(token) > 1 :
            token = token[1].split("=")
            if token[0] == 'genre' and genre == "":
                genre = re.sub(r"\d{1,2}\">", "",token[1])
                genre = re.sub(r"</a>", "", genre)
                print(genre)
            if token[0] == 'nation' and contry == "":
                contry = re.sub(r"\w{1,3}\">", "",token[1])
                contry = re.sub(r"</a>", "", contry)
                print(contry)
            if token[0] == 'grade' and rateGrade == "":
                rateGrade = re.sub(r"\d{1,10}\">", "",token[1])
                rateGrade = re.sub(r"</a>", "", rateGrade)
                print(rateGrade)

    
    rate = removeTags(fText(soup.select(".info_spec")))
    rate = rate.split()
    #print(rate)
    tempIdx = 0
    r_date = ""
    running_time = ""
    regex = re.compile(r'\d{1,3}분')
    for a in rate:
        if a == "개봉" :
            r_date = rate[tempIdx-2] + rate[tempIdx-1] +" "+ a
            break
        run = regex.search(a)
        if run != None :
            running_time = run.group(0)
        tempIdx +=1        
    
    
    story = getStory(code)
   # print(story)
    detail = []
    # detail = [ title, director, company, contry, genre, grade, actor1, actor2, story]
    actor = aList.split("|")

    detail.append(code)
    detail.append(title)
    detail.append(director)
    detail.append(companyName)
    detail.append(contry)
    detail.append(genre)
    detail.append(rateGrade)
    if aList != "NULL":
        detail.append(actor[0])
        detail.append(actor[1])
    else :
        detail.append("")
        detail.append("")
    detail.append(story)
    #print('select movie from MovieList where title = "'+title+'" and director like "%'+director+'%"')
    cur.execute('select movie from MovieList where title = "'+title+'" and director like "%'+director+'%"')
    rows = cur.fetchone()
    if rows == None :
        detail.append(0)
    else :
        detail.append(rows[0])

    detail.append(r_date)
    detail.append(running_time)
    
    return detail


#개봉 예정영화 url
url = "https://movie.naver.com/movie/running/premovie.nhn"
f = urllib.request.urlopen(url)
data = f.read().decode('utf-8')
soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')

movList = mText(soup.select(".tit a"))

url = "https://movie.naver.com/movie/running/current.nhn"
f = urllib.request.urlopen(url)
data = f.read().decode('utf-8')
soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')

# 개봉 예정영화 + 상영작
movList += mText(soup.select(".tit a"))

f = open('ONNI2.csv','w',encoding='utf-8',newline='')
wr = csv.writer(f)

#############################################################################
#############  트위터 객체 생성 ##############################################
CREDENTIALS_FILENAME = 'creds-twitter.json'
jf = open(CREDENTIALS_FILENAME)
creds = json.load(jf)
jf.close()

CONSUMER_KEY = creds['CONSUMER_KEY']
CONSUMER_SECRET = creds['CONSUMER_SECRET']
ACCESS_TOKEN = creds['ACCESS_TOKEN']
ACCESS_TOKEN_SECRET = creds['ACCESS_TOKEN_SECRET']

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

api = tweepy.API(auth, wait_on_rate_limit=True)


twitter = Twitter()

################################################################################
######################## nltk ##################################################


train_data = []

outname = '__final2__'
def features(doc):
    return dict(('contains(%s)' % w, True) for w in set(doc) for word in selected_words)
def read_data(filename):
    with open(filename, 'r') as f:
        data = [line.split('|') for line in f.read().splitlines()]
        data = data[1:]   # header
    return data
#d = open(outname, 'r', encoding='utf-8')
#print(d.read())
train_data = read_data(outname)
train_docs = [(row[1].split(), int(int(row[0])/6)) for row in train_data]

det = ['영화명', '감독', '배급사','월','국적','장르','등급','주연','조연','개봉일','점수']
wr.writerow(det)
try:
    cur = conn.cursor()
    for i in movList:
        cur.execute('select code from MovieList2 where code = %d' %(int(i)))
        rows = rows = cur.fetchone()
        if rows != None : continue
        # 이미 있는거는 아님
        print(i)

        detail = getMovieName(int(i))
        print(detail)
        if detail :                                                                                                                                                                              #    title, director, company, country, genre, grade, actor1, story, code, r_date, runningtime
            cur.execute('INSERT INTO MovieList2(title, director, company, country, genre, grade, actor1, story, code, r_date, runningtime) VALUES("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", %d, "%s","%s")' %(detail[1], detail[2], detail[3], detail[4], detail[5], detail[6], detail[7], detail[9], int(detail[0]), detail[11], detail[12]))
        #영화명을 토대로 트위터에서 긁어온다.
        val = str(detail[1])
        keyword = ''
        for i in range(len(val)):
            if val[i] == '\\' or val[i] =='/' or val[i] == ':' or val[i] == '?' or val[i] =='"': continue
            keyword += str(val[i])
        print(keyword)
        result = []
        counter = 0
        for tweet in tweepy.Cursor(api.search, q= keyword + "  -filter:retweets", lang='ko').items(200):
            result.append([tweet.id_str, tweet.text, tweet.created_at])
        outPath = './twee/'

        outname = outPath + keyword + '.txt'
        __cnt__ = outPath + keyword + 'count.txt' 
        k = open(outname, 'w', encoding='utf-8')
        d = open(__cnt__, 'w', encoding='utf-8')
        malist = []
        
        for temp in result:
            counter+=1
            k.write("%s|" %temp[0])
            malist = twitter.pos(temp[1], norm=True, stem=True)
            word_dic = ""
            for word in malist:
                if word[1] != "Josa" and word[1] != "Conjunction" and word[1] != "Punctuation" and word[1] != "ScreenName" and word[1] != "URL":
                    word_dic += word[0] + '/' + word[1] + " "
            k.write("%s\n" %word_dic)
        d.write("%d\n" %counter)
        k.close()
        d.close()
        #print(detail)
        
        test_data = read_data(outname)
        d = open(__cnt__,'r')
        cnt = int(d.readline())
        if cnt == 0 : continue
        #print(cnt)
        #test_data2 = read_data('10001.txt')

        
        #test_docs = [row[1].split() for row in test_data]
        #test_docs = []

        test_docs = [(row[1].split(), int(row[0])) for row in test_data]

        #test_docs2 = [(row[1].split(), int(row[0])/6) for row in test_data2]

        #for line in enumerate(test_data):
        #    test_docs.append(line[1][1].split())

        # 잘 들어갔는지 확인
        from pprint import pprint

        tokens = [t for d in train_docs for t in d[0]]
        text = nltk.Text(tokens, name='NMSC')

        selected_words = [f[0].encode('utf-8') for f in text.vocab().most_common(2000)]


        train_docs = train_docs[:10000]

        train_xy = [(features(d), c) for d, c in train_docs]
        #test_xy = [(features(d), ) for d in test_docs]
        test = [(features(d)) for d, c in test_docs]



        #test2 = [(features(d)) for d, c in test_docs2]


        #print(test)
        # 초간단함
        classifier = nltk.NaiveBayesClassifier.train(train_xy)
        #print(nltk.classify.accuracy(classifier, test_xy))

        sorted(classifier.labels())
        classifier.classify_many(test)
        
        temp = 0
        for pdist in classifier.prob_classify_many(test):
            if pdist.prob(1) > pdist.prob(0):
                temp += pdist.prob(1)
            else :
                temp -= pdist.prob(0)
            print('%.4f %.4f' % (pdist.prob(1), pdist.prob(0)))
        print(temp/cnt)
        tempList = []
        #영화명 감독 배급사 월 국적 장르 등급 주연 조연 개봉일 점수
        m_list = detail[11].split(".")
        month = m_list[1]

        r_dt = detail[11].split(" ")
        r_dtt = str(r_dt[0]).replace(".", "-")

        dett = []
        dett.append(detail[1])  #영화명
        dett.append(detail[2])  #감독
        dett.append(detail[3])  #배급사
        dett.append(month)      #월
        dett.append(detail[4])  #국적
        dett.append(detail[5])  #장르
        dett.append(detail[6])  #등급
        dett.append(detail[7])  #주연
        dett.append(detail[8])  #조연
        dett.append(r_dtt)  #개봉일
        dett.append(str(temp/cnt))
        print(dett)
        wr.writerow(dett)
    f.close()
finally:
        cur.close()
        conn.commit()
        conn.close()