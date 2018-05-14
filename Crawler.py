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
from konlpy.tag import Twitter
from selenium import webdriver

def logIn(code):
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
        actor = ""
        if len(s) :
            for a in s:
                cont = fText(a.select(".p_info a"))
                cont = re.sub('<[^>]+>.+?', '', cont)
                actor += str(cont + ",")
        return actor
    #19금 영화일 경우 login 처리를 한다.
    
    USER = "<INSERT YOUR ID>"
    PASS = "<INSERT YOUR PASSWORD>"
    print("PhantomJS 드라이버 실행")
    
    driver = webdriver.PhantomJS()
    #driver.get_screenshot_as_file("web.png")
    driver.get('https://nid.naver.com/nidlogin.login')
    driver.implicitly_wait(3)

    e = driver.find_element_by_id("id")
    e.clear()
    e.send_keys(USER)

    print("아이디 접근 완료")
    e = driver.find_element_by_id("pw")
    e.clear()
    print("pass 접근 완료")
    e.send_keys(PASS)
    form = driver.find_element_by_css_selector("#frmNIDLogin > fieldset > input")
    form.submit()
    
    try:
        _url = ("https://movie.naver.com/movie/bi/mi/detail.nhn?code=" + str(code))
        #print("url : " , _url)
        driver.get(_url)
        html = driver.page_source  
    except:
        return
    #print(html)
    soup = bs4.BeautifulSoup(html,'html.parser')
    director = fText(soup.select("#content > div.article > div.mv_info_area > div.mv_info > dl > dd > p > a")) 
  
    name = fText(soup.select("#content > div.article > div.wide_info_area > div.mv_info > h3 > a"))
    rateList = rText(soup.select("#pointNetizenPersentBasic > em"))
    aList = r2Text(soup.select("#content > div.article > div.section_group.section_group_frst > div.obj_section.noline > div > div.lst_people_area.height100 > ul > li"))
    driver.save_screenshot("web.png")
    if(rateList == None):
        rateList = "0.00"
    
    return name + "|" + director + "|" + rateList + "|" + aList + "|"


def deleteTag(x):
    return re.sub("<[^>]*>", "", x)

def getMovieName(code):
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
        actor = ""
        if len(s) :
            for a in s:
                cont = fText(a.select(".p_info a"))
                cont = re.sub('<[^>]+>.+?', '', cont)
                actor += str(cont + ",")
        return actor
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
    
    director = fText(soup.select("#content > div > div.mv_info_area > div.mv_info > dl > dd > p > a")) 
    name = fText(soup.select("#content > div.article > div.mv_info_area > div.mv_info > h3 > a"))
    rateList = rText(soup.select("#pointNetizenPersentBasic > em"))
    aList = r2Text(soup.select("#content > div.article > div.section_group.section_group_frst > div.obj_section.noline > div > div.lst_people_area.height100 > ul > li"))
    
    if(rateList == None):
        rateList = "0.00"
    
    detail = ""
    #19금 영화일 경우
    if(name == "") :
        print("19금처리")
        #로그인 처리를 해준다
        detail = logIn(code)
    else :
        detail = name + "|" + director + "|" + rateList + "|" + aList + "|"
    return detail
    
def getComments(code):
    def makeArgs(code, page):
        params = {
            'code': code,
            'type': 'after',
            'isActualPointWriteExecute': 'false',
            'isMileageSubscriptionAlready': 'false',
            'isMileageSubscriptionReject': 'false',
            'page': page
        }
        return urllib.parse.urlencode(params)
 
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
 
    retList = []
    colSet = set()
    print("Processing: %d" % code)
    page = 1
    while 1:
        try:
            f = urllib.request.urlopen(
                "http://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?" + makeArgs(code, page))
            data = f.read().decode('utf-8')
        except:
            break
        soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data), 'html.parser')
        cs = soup.select(".score_result li")
        if not len(cs): break
        for link in cs:
            try:
                url = link.select('.score_reple em a')[0].get('onclick')
            except:
                print(page)
                print(data)
                raise ""
            m = re.search('[0-9]+', url)
            if m:
                url = m.group(0)
            else:
                url = ''
            if url in colSet: return retList
            colSet.add(url)
            cat = fText(link.select('.star_score em'))
            cont = fText(link.select('.score_reple p'))
            cont = re.sub('<span [^>]+>.+?</span>', '', cont)
            retList.append((url, cat, cont))
        page += 1

    return retList 
  
def fetch(i):
    outname = 'comments/%d.txt' % i
    try:
        if os.stat(outname).st_size > 0: return
    except:
        None

    rs = getComments(i)
    detail = getMovieName(i)
    #print(rs[0])        
    #print(detail)
    if not len(rs): return

    f = open(outname, 'w', encoding='utf-8')
    
    f.write("%s" %detail)
    f.write('\n')
    twitter = Twitter()
    for idx,r in enumerate(rs):
        #각 사용자가 개인별로 부여한 평점
        f.write("%s|" % (r[1]))
        #koNLpy의 twitter 형태소 분석기를 통해 명사만 뽑아낸다.
        malist = twitter.pos(r[2].replace("'", "''").replace("\\", "\\\\"),norm=True, stem=True)
        word_dic = []
        for word in malist:
            if word[1] != "Josa" and word[1] != "Conjunction" and word[1] != "Punctuation":
                word_dic.append(word[0])
        #print(word_dic)
        f.write("%s\n" %word_dic)           
    f.close()
    time.sleep(1)

#5개의 쓰레드 생성
with ThreadPoolExecutor(max_workers=5) as executor:
    for i in range(10001, 200000):
        executor.submit(fetch, i)
