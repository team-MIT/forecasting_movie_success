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
    def removeTags(s):
        clenr = re.compile('<.*?>')
        cleanText = re.sub(clenr,'',s)
        return cleanText
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
    try:
        _url = ("https://movie.naver.com/movie/bi/mi/detail.nhn?code=" + str(code))
        
        f = urllib.request.urlopen(_url)
        data = f.read().decode('utf-8') 
    except:
        return
    #영화명 감독 배급사 월 국적 장르 등급 주연 조연
    soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')
    name = fText(soup.select("#content > div.article > div.mv_info_area > div.mv_info > h3 > a"))
   # print(name)
    director = fText(soup.select("#content > div > div.mv_info_area > div.mv_info > dl > dd > p > a")) 
    #print(director)
    company = removeTags(fText(soup.select(".agency_name")))
    
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
    overview = removeTags(fText(soup.select(".info_spec p")))
    overview = re.sub(',','',overview)
    overviewList = overview.split()
    rate = removeTags(fText(soup.select(".info_spec")))
    rate = rate.split()
    
    rateGrade = ''
    for a in rate:
        if a == '전체' or a == '12세' or a == '15세' :
            rateGrade = a + '관람가'
            break
        if a == '청소년':
            rateGrade = a + '관람불가'
            break
        if a == 'PG-13':
            rateGrade = a
            break
    #print(rateGrade)
    #print(overviewList)
    genreList = ['코미디','범죄', '액션','모험','SF','드라마','멜로/로맨스','미스터리','스릴러','애니메이션','공포','전쟁','다큐멘터리','가족','공연실황']
    genre = []
    idx = 0
    for a in overviewList:
        if a in genreList:
            idx += 1
            genre.append(a)
    
    overviewList = overviewList[idx:]
    overviewList = overviewList[::-1]

    month = str(overviewList[1])
    month = month[1:3]
    #print(month)
    contry = str(overviewList[len(overviewList)-1])
    #print(contry)
    #print(genre[0])
    #print(contry)
    #print(overviewList)
    detail = []
    
    actor = aList.split("|")
    detail.append(name)
    detail.append(director)
    detail.append(companyName)
    detail.append(month)
    detail.append(contry)
    detail.append(genre[0])
    detail.append(rateGrade)
    if aList != "NULL":
        detail.append(actor[0])
        detail.append(actor[1])
    return detail


url = "https://movie.naver.com/movie/running/current.nhn"
f = urllib.request.urlopen(url)
data = f.read().decode('utf-8')

soup = bs4.BeautifulSoup(re.sub("&#(?![0-9])", "", data),'html.parser')
movList = mText(soup.select(".tit a"))

f = open('newDataSet.csv','w',encoding='euc_kr',newline='')
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

for i in movList:
    #print(int(i))
    detail = getMovieName(int(i))
    val = str(detail[0])

    keyword = ''
    
    for i in range(len(val)):
        if val[i] == '\\' or val[i] =='/' or val[i] == ':' or val[i] == '?' or val[i] =='"': continue

        keyword += str(val[i])
    print(keyword)
    __cnt__ = keyword + 'count'
    result = []
    counter = 0
    for tweet in tweepy.Cursor(api.search, q= keyword + "  -filter:retweets", lang='ko').items(200):
        result.append([tweet.id_str, tweet.text, tweet.created_at])
    outname = keyword + '.txt'
    k = open(outname, 'w', encoding='utf-8')
    d = open(__cnt__ +'.txt', 'w', encoding='utf-8')
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
    
    name = keyword + '.txt'
    counter = keyword +'count.txt'
    test_data = read_data(name)
    d = open(counter,'r')
    cnt = int(d.readline())
    if cnt == 0 : continue
    #print(cnt)
    #test_data2 = read_data('10001.txt')

    train_docs = [(row[1].split(), int(int(row[0])/6)) for row in train_data]
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


    train_docs = train_docs[:20000]

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

    detail.append(str(temp/cnt))

    print(detail)
    wr.writerow(detail)
f.close()
