# 공공데이터 포털 API 활용
## 지자체별 사고다발지역정보 조회 서비스

library(jsonlite)

service_url <- 'http://apis.data.go.kr/B552061/frequentzoneLg/getRestFrequentzoneLg'
public_api_key <- readLines('0511 openAPI/public_api_key.txt')
year <- 2019
siDo <- 30
guGun <-230
rows <- 10
page <- 1
# ServiceKey=kG1%2FE4Fel3CpR2FRSZQTHVuTb255O85oysrdd1RF2Sijp%2Bdbj0QTmkYYoRRPdOPjTGOqVKcT0JpFaGJ0KWsYdg%3D%3D&searchYearCd=2017&siDo=30&guGun=230&rnumOfRows=10&pageNo=1
url <- sprintf('%s?ServiceKey=%s&searchYearCd=%d&siDo=%d&guGun=%d&numOfRows=%d&pageNo=%d&type=json',
               service_url, public_api_key, year, siDo, guGun, rows, page)
# %s 는 string, %d 는 digit. 주소 뒤에 지정한 인자들이 순서대로 들어가게 됨.

url
response <- fromJSON(url)
str(response)
df <- response$items$item
View(df)

# 결과 메시지
response$resultMsg

# 총 건수
response$totalCount






