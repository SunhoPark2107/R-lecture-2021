getwd()
library(jsonlite)
library(httr)

# person.json 파일로부터 읽기
wiki_person <- fromJSON("OpenAPI/person.json")
wtr(wiki_person)
clas(wiki_person)
wiki_person

# sample.json
data <- fromJSON('OpenAPI/sample.json')
str(data)
data <- as.data.frame(data)
names(data) <- c('id', 'like', 'share', 'comment', 'unique', 'msg', 'time')
data$like <- as.numeric(as.character(data$like))
View(data)

# CSV파일로 저장
write.csv(data, 'OpenAPI/data.csv')

# Data Frame을 JSON 파일로 저장
json_data <- toJSON(data)
write(json_data, 'data.json')
prettify(json_data)



