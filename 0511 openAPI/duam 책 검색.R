# 다음 책 검색

library(httr)
library(jsonlite)

kakao_api_key <- readLines('0511 openAPI/kakao_api_key.txt')    # 메모장 기본 타입 utf-8 아니면 encoidng = "UTF-8" 추가해 주기.
kakao_api_key

base_url <- "https://dapi.kakao.com/v3/search/book"
keyword <- URLencode(iconv('데이터 분석', to = "UTF-8"))
query <- paste0('target=title&query=', keyword)
url <- paste(base_url, query, sep = '?')

auth_key <- paste('KakaoAK', kakao_api_key)
auth_key

res <- GET(url, add_headers('Authorization'=auth_key))
res

result <- fromJSON(as.character(res))
class(result)                  # 결과는 리스트
df <- as.data.frame(result)
View(df)


write.csv(df, '0511 openAPI/book.csv', fileEncoding = 'UTF-8')    # ERROR -> 'list'은 'EncodeElement'에서 구현되지 않은 유형입니다
# 결과가 리스트이기 때문에 as.matrix로 matrix형태로 변환하여 write 해 줌.
write.csv(as.matrix(df), '0511 openAPI/book.csv', fileEncoding = 'UTF-8', row.names = F)
# file 내용에 ','가 있어서 제대로 읽어들이지 못함.따라서 sep를 \t (tab) 으로 변경. / csv 는 comma로만 sep 가능한 형태이므로 table 형태로 바꾸어 저장.
df2 <- read.csv('0511 openAPI/book.csv', fileEncoding = 'UTF-8')     # ERROR -> 열의 개수가 열의 이름들보다 많습니다
write.table(as.matrix(df), '0511 openAPI/book.tsv', fileEncoding = 'UTF-8', row.names = F, sep = '\t')
df2 <- read.csv('0511 openAPI/book.tsv', fileEncoding = 'UTF-8', sep = '\t')
View(df2)




























