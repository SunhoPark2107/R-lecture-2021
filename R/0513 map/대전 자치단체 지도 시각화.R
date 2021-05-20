# 대전 소재 자치단체 건물
#  - 다음 지도 검색에서 위도, 경도 정보 알아내기.
library(httr)
library(jsonlite)
library(leaflet)
library(stringr)
getwd()
setwd('C:/map')
dj <- read.csv('대전자치단체.csv', fileEncoding = 'utf-8')
dj

addr <- dj$addr[1]
addr <- substring(addr, 2, )
addr

kakao_api_key <- readLines('C:/workspace/R/0511 openAPI/kakao_api_key.txt', encoding = 'UTF-8')

base_url <- 'https://dapi.kakao.com/v2/local/search/address.json'
keyword <- URLencode(iconv(addr, to = 'UTF-8'))
keyword
query <- paste0('query = ', keyword)
url <- paste(base_url, query, sep = '?')
url

auth_key <- paste('KakaoAK', kakao_api_key)
auth_key

res <- GET(url, add_headers('Authorization'=auth_key))
res
result <- fromJSON(as.character(res))



result$documents$x                  # 경도
as.numeric(result$documents$y)      # 위도




# dj DataFrame에 위도, 경도 정보 추가하기
langs <- c()
lats <- c()
for (i in 1:nrwo(dj)) {
    addr <- dj$addr[i]
    addr <- substring(addr, 2, )                              # 도대체 난 왜 공란이 한 칸 생기는지 모르겠음. 
    keyword <- URLencode(iconv(addr, to = 'UTF-8'))
    query <- paste0('query = ', keyword)
    res <- GET(url, add_headers('Authorization'=auth_key))
    result <- fromJSON(as.character(res))
    lngs <- c(lngs, as.numeric(result$document$x))
    lats <- c(lats, as.numeric(result$document$y))
}



for (i in 1:nrwo(dj)) {
    keyword <- URLencode(iconv(dj$addr[i], to = 'UTF-8'))
    query <- paste0('query = ', keyword)
    res <- GET(url, add_headers('Authorization'=auth_key))
    result <- fromJSON(as.character(res))
    lngs <- c(lngs, as.numeric(result$document$x))
    lats <- c(lats, as.numeric(result$document$y))
}


df$lng <- lngs
df$lat <- lats
View(dj)

# 지도 위에 표시하기
dj$color <- ifelse(str_length(dj$place) > 5, 'dd022', '#1133ee')

leaflet(df) %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>% 
    addTiles() %>% 
    addMarkers(lng=~lng, lat=~lat, label = ~place, popup=~addr,
               weight = 1, radius = ~pop/1000, color = ~color)


