# Alice.txt 데이터를 텍스트마이닝 하기.
# wordcloud2 R에서는 오류가 너무 많아서 못쓸듯...


library(RCurl)
library(XML)
library(stringr)
library(tm)
library(SnowballC)
library(wordcloud)

require(devtools)

# install_github("lchiffon/wordcloud2")           # 설치시 5: ellipsis (0.3.1  -> 0.3.2 ) [CRAN] 버전으로 설치하기.

library(wordcloud2)


# 1. alice.txt 불러오기 

html_Alice <- readLines("https://github.com/ckiekim/Data-Analysis-2021-1/blob/main/05.NLP/data/Alice.txt") # 웹사이트 url에서 html 다 불러오기.
html_Alice <- htmlParse(html_Alice, asText = T)    # 불러온 html_Alice html 에서 텍스트만 추출.

doc_Alice <- xpathSApply(html_Alice, '//tr', xmlValue)   # xpath 지정하여 html중에서 원하는 데이터만 가져오기(이 과정을 통해서 데이터가 character형태로 변환됨. 따라서 필수임.)

length(doc_Alice)

corpus_Alice <- doc_Alice

# 2. 텍스트 데이터 전처리

stopwords <- c('a', 'the', 'and', 'in', 'of', 'but')

stopwords <- c(stopwords('en'), 'said') # ???

doc2_Alice <- Corpus(VectorSource(doc_Alice))   # 데이터 전처리를 위하여 리스트 형태이던 Alice_doc을 벡터 형태의 Alice_doc2 로 변환하여 주었음.
# inspect(doc2_Alice)

doc2_Alice <- tm_map(doc2_Alice, content_transformer(tolower))  # 소문자 변환
doc2_Alice <- tm_map(doc2_Alice, removeNumbers)                 # 숫자 제거
doc2_Alice <- tm_map(doc2_Alice, removeWords, stopwords('english'))  # 불용어 제거
doc2_Alice <- tm_map(doc2_Alice, removePunctuation)             # 구두점 제거
doc2_Alice <- tm_map(doc2_Alice, stripWhitespace)

# inspect(doc2_Alice)


# DTM 구축
# 이쁘게 전처리가 된 doc2_Alice데이터를 dtm만들어 주기.

dtm_Alice <- DocumentTermMatrix(doc2_Alice)
dim(dtm_Alice)
inspect(dtm_Alice)


m_Alice <- as.matrix(dtm_Alice)   # DTM list를 Matrix로 변환.
m_Alice
typeof(m_Alice)
v_Alice <- sort(colSums(m_Alice), decreasing = T)    # 단어 빈도수가 높은 애들부터 위로 올라오게 나열됨.
v_Alice[1:5]


df_Alice <- data.frame(word = names(v_Alice), freq = v_Alice)   # word, 빈도의 2열로 구성된 데이터 프레임으로 만든 것.
head(df_Alice)

wordcloud2(df_Alice)

d200 <- df_Alice[1:200, ]
d300 <- df_Alice[1:300, ]
wordcloud2(d200, shape = '')

alice_png = system.file("C:/workspace/R/data/Alice_mask.png", package = "wordcloud2")

alice_png <- "C:/workspace/R/data/Alice_mask.png"

wordcloud2(data = d100, figPath = alice_png, size = 1, color = "skyblue")

wordcloud2(data = d100, figPath = "C:/Users/CPB06GameN/Desktop/Alice_mask.png", size = 1, color = "skyblue")

wordcloud2(data = d200, figPath = "C:/Users/CPB06GameN/Desktop/Alice_mask.png", size = 1, color = "skyblue")

wordcloud2(data = d200, figPath = "data/Alice_mask.png", size = 1, color = "skyblue")
wordcloud2(data = d200, figPath = "data/Alice_mask.png", size = 1, color = "black")
wordcloud2(data = d200, figPath = "data/Alice_mask.png", size = 1, color = "black")


wordcloud2(d100, figPath = "data/Alice_mask.png", size = 1, color = "skyblue")
















