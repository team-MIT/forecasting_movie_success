from collections import Counter
import urllib
import random
from konlpy.tag import Hannanum
import pytagcloud # requires Korean font support
import sys
import pymysql

conn = pymysql.connect(
		host = '192.168.1.172',
		user = 'root',
		password = '123456',
		db = 'hadoop',
		charset = 'utf8',
)

readFile = []

id = sys.argv[1]
print(id)
print(type(id))

try:
    cur = conn.cursor()
    cur.execute('select hashtag from hashtag where title in (select title from ratings where id="'+id+'")')
    readFile += cur.fetchall()
finally:
    cur.close()
    conn.close()

if sys.version_info[0] >= 3:
    urlopen = urllib.request.urlopen
else:
    urlopen = urllib.urlopen


r = lambda: random.randint(0,255)
color = lambda: (r(), r(), r())

#ffile = open('hash_tag.csv', 'r', encoding='euc-kr')
#readFile = csv.reader(ffile)
print(type(readFile))

def get_tags(ntags=30, multiplier=5):
    nouns = []
    for temp in readFile:
        print(type(temp))
        temp2 = str(temp)
        print(type(temp2))
        temp3 = ""
        for i in temp2:
            if i == '\'':
                continue
            if i == '(':
                continue
            if i == ')':
                continue
            if i == ' ':
                continue
            else:
                temp3 += i
        templist = temp3.split(',')
        for ttemp in templist:
            if '#' not in ttemp:
                continue
            print(ttemp)
            nouns.append(ttemp)

    count = Counter(nouns)
    return [{ 'color': color(), 'tag': n, 'size': c*multiplier }\
                for n, c in count.most_common(ntags)]

def draw_cloud(tags, filename, fontname='Noto Sans CJK', size=(800, 600)):
    pytagcloud.create_tag_image(tags, filename, fontname=fontname, size=size)
    #webbrowser.open(filename)
    
tags = get_tags()
print(tags)
draw_cloud(tags, 'wordcloud.png')