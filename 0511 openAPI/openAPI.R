#JSON 기본(내장 데이터 처리)
library(jsonlite)

pi
json_pi <- toJSON(pi, digits = 3)      # toJSON => JSON 객체를 만드는 것.
json_pi
fromJSON(json_pi)                      # fromJSON => json내의 데이터가 나옴.

city <- '대전'
json_city <- toJSON(city)
json_city
fromJSON(json_city)

subject <- c('국어', '영어', '수학')
json_subject <- toJSON(subject)
json_subject
fromJSON(json_subject)

# 데이터 프레임
# [
#     {
#         "Name": "Test",
#         "Age": 25,
#         "Sex": "F"
#         "Adress": "Seoul"
#         "Hobby": "Basketball"
#     }   
# ]
name <- c("Test")
age <- c(25)
sex <- c("F")
adress <- c("Seoul")
hobby <- c("Basketball")
person <- data.frame(Name = name, Age = age, Sex = sex, Address = adress, Hobby = hobby)

str(person)

json_person <- toJSON(person)
json_person
prettify(json_person)               # 위의 json_person을 이쁘장하게 찍어라! 이거임. 없어도 데이터값은 다 나옴.

#########################################################################
df_json_person <- fromJSON(json_person)
str(df_json_person)                            # 내가 뭔갈 하지 않아도 R내에 저장하면 df형태가 된다.

# fromJSON, toJSON 이거 두 개만 알면 json 파일 다루기는 쉽다.

# 두 개의 데이터 프레임의 데이터 값이 같은지 비교
all(person == df_json_person)     # 원래 내용과 값이 같다.

# cars 내장 데이터로 테스트.
cars
json_cars <- toJSON(cars)
json_cars
prettify(json_cars)
df_json_cars <- fromJSON(json_cars)
all(cars == df_json_cars)

