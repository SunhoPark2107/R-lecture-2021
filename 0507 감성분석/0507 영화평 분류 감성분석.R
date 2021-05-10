# IMDB 영화평 감성분석
# install.packages("text2vec")
library(text2vec)
library(caret)
library(tm)
library(SnowballC)

str(movie_review) # 중요한 것은 sentiment와 review.

# 전처리(소문자, 불용어, 구두점, 숫자, tag(/br 등), 중복/Null)
# 8:2 비율로 훈련 집합과 테스트 집합으로 나누기.

train_index <- createDataPartition(y = movie_review$sentiment, p=0.8, list = F)
m_train <- movie_review[train_index, ]
m_test <- movie_review[-train_index, ]

# 훈련/테스트 셋 동시에 dtm만들어서 훈련 시키는 게 아니라, train 셋의 dtm을 만들어 훈련시키고, train셋의 dtm을 활용하여 test 한다.
# 왜냐면 test데이터에만 있는 단어가 있더라도 극히 적을 것이라고 예상하고, 훈련 셋에 있는 단어가 테스트 셋에 없을 수도 있고, 있더라도 dtm순서가 동일하지 않을 수 있으므로.

# 훈련 데이터셋에 대해 DTM 구축.
# 테스트 데이터셋에 대해서도 동일하게 적용해야 함.
doc <- Corpus(VectorSource(m_train$review))
# inspect(doc)

stop_words <- c(stopwords('en'), '<br />')    # stopwords는 함수(? 벡터 데이터 셋?)이다.

doc <- tm_map(doc, content_transformer(tolower))  # 소문자 변환
doc <- tm_map(doc, removeNumbers)                 # 숫자 제거
doc <- tm_map(doc, removeWords, stop_words)  # 불용어 제거
doc <- tm_map(doc, removePunctuation)             # 구두점 제거
doc <- tm_map(doc, stripWhitespace)                # 앞뒤 공백 제거

?DocumentTermMatrix            # 사용전에 weighting 파트 한번 읽어보기.
dtm <- DocumentTermMatrix(doc,
                          control=list(weighting = weightTf))    # weightTf(Term frequency) => 용어의 빈도에 따라 가중치 부여하는 함수.

dim(dtm)
inspect(dtm)   # film, movie와 같은 단어들이 가장 많은데, 이 단어들은 항상 빠지지 않고 등장하므로 weightTf 함수에 의해서 나중에 순위에서 밀려날 것.

dtm_tfidf <- DocumentTermMatrix(doc, control=list(weighting = weightTfIdf))    
inspect(dtm_tfidf)

# 모델링이 가능한 형태로 DTM을 변환해야 함.
dtm_small <- removeSparseTerms(dtm, 0.9)       # 모델링에 방해가 되는 빈 공간을 없애는 것. (?)
dim(dtm_small)                                 # 4만개가 넘던 dtm 데이터가 100개 내외로 확 줄었음.

# sentiment(y)와 DTM을 묶어서 데이터프레임을 형성.
X <- as.matrix(dtm_small)
dataTrain <- as.data.frame(cbind(m_train$sentiment, X))
head(dataTrain)
colnames(dataTrain)[1] <- 'y'
dataTrain$y <- as.factor(dataTrain$y)

# Decision Tree로 학습.

library(rpart)

dt <- rpart(y~., dataTrain)      # 결정트리로 학습 완!

# 테스트 데이터셋으로 모델 성능 평가하기.

# 테스트 셋에도 전처리는 동일하게 지정.
doc_Test <- Corpus(VectorSource(m_test$review))


doc_Test <- tm_map(doc_Test, content_transformer(tolower))  # 소문자 변환
doc_Test <- tm_map(doc_Test, removeNumbers)                 # 숫자 제거
doc_Test <- tm_map(doc_Test, removeWords, stop_words)  # 불용어 제거
doc_Test <- tm_map(doc_Test, removePunctuation)             # 구두점 제거
doc_Test <- tm_map(doc_Test, stripWhitespace) 

dtmTest <- DocumentTermMatrix(doc_Test, control = list(dictionary = dtm_small$dimnames$Terms))  # dtm_samll <- 처리하기 너무 많아서 줄인 데이터 쓰는 것임!
dim(dtmTest)


# Sentiment(y) 와 DTM_Test를 묶어서 데이터프레임을 생성.
x <- as.matrix(dtmTest)
dataTest <- as.data.frame(cbind(m_test$sentiment, x))
colnames(dataTest)[1] <- 'y'
dataTest$y <- as.factor(dataTest$y)

# 학습했던 모델로 예측
dt_pred <- predict(dt, dataTest, type = 'class')
table(dt_pred, dataTest$y)

# dt_pred   0   1
# 0 211  73
# 1 274 442

# 궁금한점 => 우리가 DTM_train 만든 건 빈도분석인데, 어떻게 그걸로 긍부정 예측을 할 수가 있지????
# sentiment => 그럼 우리는 sentiment가 이미 부여되어 있는 데이터 셋에서만 긍부정 예측을 할 수 있는건가?
# sentiment 는 어떻게 부여되었는데? 
# 0,1이 어떻게 "영화에 대한 긍정적/부정적 평가"의 의미를 가지는지?



###################################
# SVM으로 훈련
###################################
library(e1071)

svc <- svm(y~., dataTrain)
sv_pred <- predict(svc, dataTest, type = 'class')
table(sv_pred, dataTest$y)





