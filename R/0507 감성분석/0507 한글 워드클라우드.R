# 한글 워드클라우드 (wiki, "빅데이터" 검색 데이터)
# wiki '빅 데이터' 검색 결과 워드클라우드 만들기

library(RCurl)
library(XML)
library(SnowballC)
library(tm)
library(wordcloud2)


# html <- readLines("https://ko.wikipedia.org/wiki/%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0")

enc <- URLencode(iconv('빅 데이터', 'CP949', 'UTF-8'))
url <- paste0('https://ko.wikipedia.org/wiki/', enc)
url
html <- readLines(url)
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p', xmlValue)
length(doc)
doc[1]

# 전처리 수행
# 한글과 space만 남기고 다른 모든 글자를 지운다
hdoc <- gsub('[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣 ]', '', doc)     # 한글 표현 방식 유의 '[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]' ㄱ-ㅎ or ㅏ-ㅣ or 가-힣 
                                                   # '[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣 ]' 는 즉, 한글이 아닌 것. ^ 이 not 표현.
                                                   # 힣 뒤에 space하나 들어갔으므로 스페이스도 남김.
hdoc[1]

# DTM 만들기 - 한글의 조사 때문에 한글을 dtm화 바로 하면 결과가 잘 안 나옴.

corpus <- Corpus(VectorSource(hdoc))   # hdoc활용해서 말뭉치 만들기.
inspect(corpus)
dtm <- DocumentTermMatrix(corpus)
inspect(dtm)                           # 영어처럼 할 수는 없다. 왜냐면 한글은 불용문자가 너무 많은데 이걸 한번에 정리해 주는 함수가 없음.

# 한글 처리(형태소 분석 작업)를 하고 작업 들어가야 함.
library(KoNLP)
useSejongDic()
nouns <- extractNoun(hdoc)
noun_freq <- table(unlist(nouns))
noun_freq[1:10]

SimplePos09()
SimplePos22()

v <- sort(noun_freq, decreasing = T)
v100 <- v[1:100]
wordcloud2(v100)

#####################################################
# 한글 불용어 처리
# 반복해서 stop_words에 단어를 추가하면서 진행.
#####################################################

noun_vec <- unlist(nouns)
stop_words <- c('한', '등', '것', '수', '적', '년', '이', '것', '들', '있')

l <- list()     # 빈 리스트 생성
for (word in unlist(nouns)) {
    if (!word %in% stop_words) {
        l <- append(l, word)
    }
}


noun_freq <- table(unlist(l))

v <- sort(noun_freq, dacreasing=T)
v100 = v[1:100]
v100
wordcloud2((v100))








































