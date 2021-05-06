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
stopwords <- c('a', 'the', 'and', 'in', 'of', 'but')
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

corpus <- paste(l, collapse = ' ')
corpus                             # 불용어 제거 완료.

































































