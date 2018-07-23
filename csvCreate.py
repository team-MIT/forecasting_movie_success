# 영화 DB에 필요한 칼럼들을 JOIN시켜 csv파일로 만들기 위한 

import os
import io
import re
import csv
from operator import eq
#  a, b, c, d
"""
file1 = open('C:/Users/BIT/Desktop/sample/movieActorList.csv','r',encoding='euc_kr')
file2 = open('C:/Users/BIT/Desktop/sample/dataset.csv','r',encoding='utf-8')
readFile1 = csv.reader(file1)
readFile2 = csv.reader(file2)
a = list(readFile1)
b = list(readFile2)
newFile = open('C:/Users/BIT/Desktop/sample/newDataset.csv','w',encoding='utf-8',newline='')
nf = csv.writer(newFile)
print(len(a))
for idx in range(0,len(a)) :
    for rf in range(0, len(b)) :
        if b[rf][0] == a[idx][0]:
            nf.writerow([  b[rf][0], b[rf][1],b[rf][2],b[rf][3],b[rf][4],b[rf][5],b[rf][6],b[rf][7],b[rf][8],b[rf][9],b[rf][10], a[idx][1]   ])
            

file1.close()
file2.close() 
newFile.close()
"""
def read_data(filename):
    with open(filename, 'r', encoding = 'utf-8') as f:        
        data = f.read().splitlines()[0]
        data = data.split('|')
    return data


dataFile = open('C:/Users/BIT/Desktop/sample/InitialData.csv','r',encoding='euc_kr')
readFile = csv.reader(dataFile)
a = list(readFile)
print(a[0][0], " | ", a[0][1])
newDataSet = open('C:/Users/BIT/Desktop/sample/inputData2.csv','w',encoding='euc_kr',newline='')
nds = csv.writer(newDataSet)
print(len(a))

# outputFile = open('C:/Users/BIT/Desktop/sample/output.csv','r',encoding='euc_kr')
# readFile2 = csv.reader(outputFile)
# b = list(readFile2)

## 영화명 + 평점
path = 'C:/Users/BIT/Desktop/sample/comments/'
path1 = 'C:/Users/BIT/Desktop/sample/Data/'

for item in os.listdir(path1):
    try:
        fileName = "C:/Users/BIT/Desktop/sample/Data/%s" % item
        data = read_data(fileName)
        for idx in range( 0,len(a) ):
            if eq( a[idx][0] , data[0]):
                if data[1] in a[idx][1]:
                    nds.writerow([ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9],data[2],data[3] ])
                    print(a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9], data[2],data[3])
                    
                    #nds.writerow( [ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9], data[2] ] )
    except:
        continue


dataFile.close()
newDataSet.close()


# def read_data(filename):
#     with open(filename, 'r', encoding = 'utf-8') as f:        
#         data = f.read().splitlines()[0]
#         data = data.split('|')
#     return data


# dataFile = open('C:/Users/BIT/Desktop/sample/scoring.csv','r',encoding='euc_kr')
# readFile = csv.reader(dataFile)
# a = list(readFile)
# print(a[0][0], " | ", a[0][1])
# newDataSet = open('C:/Users/BIT/Desktop/sample/Dataset.csv','w',encoding='euc_kr',newline='')
# nds = csv.writer(newDataSet)
# print(len(a))

# # outputFile = open('C:/Users/BIT/Desktop/sample/output.csv','r',encoding='euc_kr')
# # readFile2 = csv.reader(outputFile)
# # b = list(readFile2)

# ## 영화명 + 평점
# path = 'C:/Users/BIT/Desktop/sample/comments/'
# path1 = 'C:/Users/BIT/Desktop/sample/Data/'

# for item in os.listdir(path1):
#     try:
#         fileName = "C:/Users/BIT/Desktop/sample/Data/%s" % item
#         data = read_data(fileName)
#         for idx in range( 0,len(a) ):
#             if eq( a[idx][0] , data[0] ) :
#                 print("###########DATA INSERT COMPLETE")
#                 nds.writerow( [ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9],a[idx][10], data[2],data[3] ] )
#     except:
#         continue

#####################################

# for item in os.listdir(path):
#     try:
#         fileName = "C:/Users/BIT/Desktop/sample/comments/%s" % item
#         data = read_data(fileName)
#         for idx in range( 0 , len(a) ):
#             print(item)
#             if eq(data[0],a[idx][0]) and data.contains(a[idx][1]):
#                 print("##################################data[2])####################################")
#                 #nds.writerow([ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9], a[idx][10], data[2], data[3]])
#                 nds.writerow([ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9], data[2]])
#     except:
#         continue





# def read_data(filename):
#     with open(filename, 'r', encoding = 'utf-8') as f:        
#         data = f.read().splitlines()[0]
#         data = data.split('|')
#     return data


# dataFile = open('C:/Users/BIT/Desktop/sample/output_2003_2018_1.csv','r',encoding='euc_kr')
# readFile = csv.reader(dataFile)
# a = list(readFile)
# print(a[0][0], " | ", a[0][1])
# newDataSet = open('C:/Users/BIT/Desktop/sample/newDataset4.csv','w',encoding='euc_kr',newline='')
# nds = csv.writer(newDataSet)
# print(len(a))


# ## 영화명 + 평점
# path = 'C:/Users/BIT/Desktop/sample/Data/'

# for item in os.listdir(path):
#     try:
#         fileName = "C:/Users/BIT/Desktop/sample/Data/%s" % item
#         print(item)
#         data = read_data(fileName)
#         for idx in range( 0 , len(a) ):
#             if eq(data[0],a[idx][0]) and eq(data[1],a[idx][1]):
#                 print("################################데이터삽입완료################################")
#                 nds.writerow([ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8],a[idx][9], data[2],data[3]])
#     except:
#         continue
# dataFile.close()
# newDataSet.close()


# csvName = "C:/Users/BIT/Desktop/sample/newDataSet.csv"
# csvFile = open(csvName,'w',encoding='euc_kr', newline='')
# print(len(os.listdir(path)))
# wr = csv.writer(csvFile)


#########################################################################################################################################################

# for item in os.listdir(path):
#     try:
#         fileName = "C:/Users/BIT/Desktop/sample/Data/%s" % item
#         data = read_data(fileName)
        
#         for idx in range(0,len(a)):
#             if a[idx][0] == data[0] and a[idx][1] == data[1]:
#                 nds.writerow([ a[idx][0],a[idx][1],a[idx][2],a[idx][3],a[idx][4],a[idx][5],a[idx][6],a[idx][7],a[idx][8], data[2] , data[3]])
#     except:
#         continue
# csvFile.close()

#########################################################################################################################################################
"""

# csv파일로 저장 ( 배우명 + 영화명 )    
path = 'C:/Users/BIT/Desktop/sample/comments'
csvName = "C:/Users/BIT/Desktop/sample/movieActorList1.csv"
csvFile = open(csvName,'w',encoding='euc_kr', newline='')
print(len(os.listdir(path)))

for item in os.listdir(path):
    try:
       
        fileName = "C:/Users/BIT/Desktop/sample/comments/%s" % item
    # print(item)
        data = read_data(fileName)
        actorList = data[3].split(',')
        #print(data[0])
        wr = csv.writer(csvFile)
        for n in range(0,len(actorList)-1):
            wr.writerow([data[0] , actorList[n]])
    except:
        continue
csvFile.close()

"""
"""
score + 영화제목 
path = 'C:/Users/BIT/Desktop/sample/Data'
outputName = "C:/Users/BIT/Desktop/sample/newDataSet.csv"
outputFile = open(outputName,'w',encoding='utf-8')
for item in os.listdir(path):
    fileName = "C:/Users/BIT/Desktop/sample/Data/%s" % item
    data = read_data(fileName)
    
    outputFile.write(data+'\n')

outputFile.close()

# wr = csv.writer(f)
# wr.writerow([1, 'mkblog'])
# wr.writerow([2, 'co'])
# wr.writerow([3, 'kr'])
# wr.close()
"""
"""
# -*- coding: utf-8 -*- 
import codecs
import nltk
import os
import io
import re

def read_data(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        data = [line.split('|') for line in f.read().splitlines()]
        data = data[1:]   # header
    return data

#addr = '/home/hadoop/downloads/final2'
name = 'amuguna'
d = open(name, 'w', encoding='utf-8') 
#train_data = []
#for item in os.listdir(addr) :
#   outname = '/home/hadoop/downloads/final2/%s' % item
#   f = open(outname, 'r',encoding='utf-8')
#   data = [line.split('|') for line in f.read().splitlines()]
#   data = data[1:]
#   train_data += data
#   f.close()
d.close()

train_data = read_data('/Users/juwon.k/vsCode/final/__final__')
test_data = read_data('/Users/juwon.k/Desktop/10071.txt')

#test_data = read_data('/Users/juwon.k/Desktop/10102.txt')
#print(train_data[0])      # nrows: 150000
#ff = codecs.open('outname2', 'w', 'utf-8' )

#print(len(train_data[0]))   # ncols: 3
#print(len(test_data))       # nrows: 50000
#print(len(test_data[0]))     # ncols: 3

train_docs = [(row[1].split(), int(int(row[0])/6)) for row in train_data]
test_docs = [(row[1].split(), int(int(row[0])/6)) for row in test_data]

# 잘 들어갔는지 확인
from pprint import pprint
#pprint(train_docs[0])
#print(type(train_docs[0]))
#f = codecs.open('outname', 'w', 'utf-8')

#print('*')

tokens = [t for d in train_docs for t in d[0]]
#print(len(tokens))
text = nltk.Text(tokens, name='NMSC')
#text.plot(50)
#print(text)
#f.write(("%s" %text.tokens).decode('unicode_escape'))
#f.write(("%s" %text.tokens).decode('utf-8'))

#print(len(text.tokens))                 # returns number of tokens
#print(len(set(text.tokens)))            # returns number of unique tokens

plist = text.vocab().most_common(10)

#text.plot(50)
#text.collocations()

# 여기서는 최빈도 단어 2000개를 피쳐로 사용
# WARNING: 쉬운 이해를 위한 코드이며 time/memory efficient하지 않습니다
selected_words = [f[0].encode('utf-8') for f in text.vocab().most_common(2000)]

def features(doc):
     return dict(('contains(%s)' % w, True) for w in set(doc) for word in selected_words)


train_docs = train_docs[:5000]

train_xy = [(features(d), c) for d, c in train_docs]
test_xy = [(features(d), c) for d, c in test_docs]

# 초간단함
classifier = nltk.NaiveBayesClassifier.train(train_xy)
print(nltk.classify.accuracy(classifier, test_xy))



#mostList = classifier.most_informative_features(100)
#print("mostList")
#print(mostList)
"""

 
