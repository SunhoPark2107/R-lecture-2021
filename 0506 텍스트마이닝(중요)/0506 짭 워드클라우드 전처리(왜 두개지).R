# Wikipedia에 있는 "data science" 데이터 가져오기
# install.packages("RCurl")
# install.packages("XML")

library(RCurl)
library(XML)
library(stringr)


html <- readLines("https://en.wikipedia.org/wiki/Data_science") # 경고 메시지는 무시
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p', xmlValue)    # html에서 p태그로 되어 있는 것 가져와라. (태그 이름으로 가져오는 것이 정석.)
length(doc)                                  # 페이지가 p태그로 되어 있는 것들이 13개라는 것.
doc[1] # line feed밖에 없음.
doc[2] # 글자가 들어가 있음. xmlValue를 통해 하이퍼링크 이런거 다 빠지고 글자만 출력되었다.
doc[3]
corpus <- doc[2:3]    # corpus 는 말뭉치 라는 뜻.

# 모두 소문자로 변경.
corpus <- tolower(corpus)
corpus[1]

################ 전처리 할 때 정말 중요한 함수 stringr의 gsub 함수!! ################ 

# 숫자 제거  
# 숫자를 나타내는 정규 표현식: '\\d', '[[:digit:]]'
corpus <- gsub('\\d', '', corpus)
corpus[1]

# gsub(pattern, replacement, x, ignore.case = FALSE, fixed = FALSE)

# 구두점 제거(특문제거) punctuational

corpus <- gsub('[[:punct:]]', '', corpus)
corpus[1]

# 맨 끝에 있는 공백 없애기
corpus <- gsub('\n')
str_trim(corpus, side = "right")
corpus[1]

# > str_trim(x, side=c("both", "left", "right"))
# - x: input character vector
# - side: 공백을 없앨 방향

# 불용어 제거
stopwords <- c('a', 'the', 'and', 'in', 'of', 'but')    # 불용어 데이터 셋 벡터로 만들어 주기.
stopwords <- c(stopwords(en), "said")

# gsub을 사용하면, 만약 "a"를 제거하면, data 가 dt로, algorithm이 lgorithm으로 바뀌는 등의 문제가 발생.
# words에 들어가 있는 단어들을 모두 리스트화. => 공백을 기준으로 나누어서 단어를 모두 추출.

words <- str_split(corpus, ' ')    # 결과가 리스트로 나옴.
unlist(words)                      # 여러 개의 리스트 엘리먼트를 가공하기 쉽게 하나의 벡터로 만듦.

l <- list()                        # 비어 있는 리스트 생성.
for (word in unlist(words)) {      # word 가 stopwords 안에 있는 단어면 제거하도록 하는 것.
    if (!word %in% stopwords) {
        l <- append(l, word)
    }
}

# collapse: character vector 결과가 여러개이고 이를 하나의 character로 붙여서 출력하고 싶을 때 구분자로 들어가는 표시
corpus <- paste(l, collapse = ' ')
corpus                             # 불용어 제거 완료.

`%notin%` <- Negate(`%in%`)   # ``는 backcourt(?) tab키 위에 있는 것.

# 이렇게 만들어서 !%in%를 대신할 수도 있다.
`%notin%` <- Negate(`%in%`)

l <- list()                        # 비어 있는 리스트 생성.
for (word in unlist(words)) {      # word 가 stopwords 안에 있는 단어면 제거하도록 하는 것.
    if (!word %notin% stopwords) {
        l <- append(l, word)
    }
}

 # 위에있는 것과 동일한 코드임.



# DTM

# unigram / bigram(2-gram) / trigram(3-gram)
# i work at google
# i google at work
# 위 두 문장은 unigram으로는 구분이 안 되지만, bigram으로는 구분 가능.
# i work / at google,  i google/at work

# 반복적으로 나오는 단어 영향력 배제하기 위하여 Term Frequency, Inverse Document Frequency 등을 사용 가능하다.
# install.packages("tm")     # text mining 라이브러리
# install.packages("SnowballC")  # 어간 추출 라이브러리
library(tm)
library(SnowballC)

doc <- Corpus(VectorSource(doc))
inspect(doc)

doc <- tm_map(doc, content_transformer(tolower))  # 소문자 변환
doc <- tm_map(doc, removeNumbers)                 # 숫자 제거
doc <- tm_map(doc, removeWords, stopwords('english'))  # 불용어 제거
doc <- tm_map(doc, removePunctuation)             # 구두점 제거
doc <- tm_map(doc, stripWhitespace)                # 앞뒤 공백 제거

#################################
# DTM 구축
#################################

dtm <- DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)

#######################################
# Word Cloud
# 빈도수가 많이 나온 단어를 크게 표현. 
#######################################


# install.packages("wordcloud")
library(wordcloud)

m <- as.matrix(dtm)   # DTM list를 Matrix로 변환.
m
typeof(m)
v <- sort(colSums(m), decreasing = T)    # 단어 빈도수가 높은 애들부터 위로 올라오게 나열됨.
v[1:5]


df <- data.frame(word = names(v), freq = v)   # word, 빈도의 2열로 구성된 데이터 프레임으로 만든 것.
df
head(df)

wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words = 100, random.order = F, rot.per = 0.35)
# 그릴 때마다 모양은 랜덤으로 나온다.

install.packages("wordcloud2")
library(wordcloud2)

wordcloud2(df)

d200 <- df[1:200, ]
d100 <- df[1:100, ]
d50 <-df[1:50 , ]

wordcloud2(d200, shape = '')
wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3, rotateRatio = 1.0)
letterCloud(data = d200, word = '메롱', wordSize=1, fontFamily='굴림')
letterCloud(data = d100, word = '메롱', wordSize=1, fontFamily='굴림')
letterCloud(data = d50, word = '메롱', wordSize = 3, fontFamily='굴림')

wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3, rotateRatio = 1.0, figPath = 'data/alice_mask.png')






















