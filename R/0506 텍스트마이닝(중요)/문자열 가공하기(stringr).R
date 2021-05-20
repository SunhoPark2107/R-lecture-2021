# 문자열 처리
# 수업자료 : https://m.blog.naver.com/PostView.nhn?blogId=nife0719&logNo=220975845463&proxyReferer=https:%2F%2Fwww.google.com%2F
library(stringr)

# 1. Character로 변환.
example <- 1
typeof(example)     # double => 실수
example <- as.character(example)
typeof(example)     # character이 됨.

# 입력을 받는 경우
input <- readline('Prompt > ')
input
typeof(input)     # 숫자로 바꾸어 주어야 함.
i <- as.numeric(input)
typeof(i)
3 * i             # i를 숫자로 바꾸어 주었기 때문에 연산도 가능.

# 2. String 이어 붙이기
paste('A', 'quick', 'brown', 'fox')    # paste는 기본적으로 문자 사이 공백이 붙음.
paste0('A', 'quick', 'brown', 'fox')

paste('A', 'quick', 'brown', 'fox', sep = "-") # seperate 주면 구분을 다른 걸로 해 줌.
s <- paste('A', 'quick', 'brown', 'fox', sep = "-")
str_split(s, '-')       # [[1]] => 겹 대괄호는 리스트를 뜻함. 나눠진 문자열들이 리스트 형태로 생성되었음.
sample <- c('A', 'quick', 'brown', 'fox' )
paste(sample)                  # 벡터로 들어가있는 걸 그냥 붙이면 이렇게 됨.
paste(sample, collapse = " ")
paste(sample, collapse = "-")
str_c(sample, '1', sep = "_")  # 벡터 내 각 element에 대하여 "_"과 1을 이어붙인다.
str_c(sample, '1', sep = '_', collapse = '@@')  # collapse는 각기 나뉘어져 있는 여러 개의 str을 하나의 문장으로 이어 주는 것.

# 참고로, 리스트는 이렇게 됨.
l <- str_split(s, '-')
l[1]
paste(l)        # 리스트 형태로 되어 있는 것을 그냥 붙이면 이렇게 되어 버림.
# 근데 리스트 형태로 되어 있는 것은 그대로 안붙음. ? 해결방법 못찾았다.

# 3. Character 개수 카운트
x <- 'Hello'
nchar(x)
h <- '안녕하세요'   # 15바이트 (utf-8로 현재 인코딩된 상태.)
nchar(h)            # 하지만 nchar는 5개로 인식을 한다.
str_length(h)

# 4. 소문자 변환(한글은 해당사항 없음)
tolower(x)

# 5. 대문자 변환
toupper(x)

# 6. 2개의 character vector를 중복되는 항목 없이 합하기.
vector_1 <- c("hello", "world", "r", "program")
vector_2 <- c("hi", "world", "r", "coding")
union(vector_1, vector_2)     # 합집합. 따라서 중복된 걸 배제하게 됨.

# 7. 2개의 character vector에서 공통된 항목 추출.
intersect(vector_1, vector_2)   # 교집합

# 8. 2개의 character vector에서 공통되지 않는 항목 추출.
setdiff(vector_1, vector_2)     # 차집합.(vector_1 기준으로.)

# 9. 2개의 character vector 동일 여부 확인(순서 관계 없이.)
vector_3 <- c("r", "hello", "program", "world")
setequal(vector_1, vector_2)
setequal(vector_1, vector_3)

# 10. 공백 없애기
vector_1 <- c("     hello World!    ",  "    Hi  R!    ")
# str_trim은 stringr 라이브러리 포함 함수.
str_trim(vector_1, side = 'left') 
str_trim(vector_1, side = 'both')

# 11. string 반복해서 나타내기
str_dup(x, 3)    # 한 뭉치로 같은 문자열 표현.
rep(x, 3)        # 같은 문자열 복사해서 여러개

# 12. Substring(String의 일정 부분) 추출
string_1 <- "Hello World"
substr(string_1, 7, 9)
substring(string_1, 7, 9)
str_sub(string_1, 7, 9)
substr(string_1, 7)     # substr 함수는 from 만 설정하고 to를 설정하지 않아 오류 남.

substring(string_1, 7)  # substring함수는 from만 걸어줘도 끝까지 출력함.
str_sub(string_1, 7)
str_sub(string_1, 7, -1)
str_sub(string_1, 7, -3)
str_sub(string_1, 7, -5)   # - 는 뭔지 모르겠네...? 구글링 고고 
string_1[7:9]              # 그냥 인덱스 하면 NA NA NA 오류 뜸.
# 평소에 substring이나 sub_str사용하는 편이 좋을듯

# 13. string의 특정 위치에 있는 값 바꾸기
str_1 <- "Today is Monday"
substr(str_1, 10, 12) <- "Sun"
str_1
substr(str_1, 10, 12) <- "Thurs"
str_1                  # 문자열 길이가 안 맞아서 들어가다 만다.
# 다른 함수도 마찬가지로 문자열 길이가 안 맞으면 안 바뀜 ㅠ

# 14. 특정 패턴(문자열)을 기준으로 string자르기.
strsplit(str_1, split = " ")
str_split(str_1, pattern = " ")
str_split(str_1, patter = " ", n = 2)    # 2조각으로 나눠짐.
str_split(str_1, patter = " ", n = 2, simplify = TRUE)  # matrix 형태가 됨. 근데 실제로 잘 사용안함.
str_split_fixed(str_1, patter = " ", n = 2)             # 위에거랑 같은 것.
s <- str_split(str_1, pattern = " ")
typeof(s)      # string자르면 리스트 형태가 됨.
s[1]
s[[1]]     # => 이렇게 해야 벡터 형태 출력됨.
s[[1]][1]  # => 리스트 인덱스는 이렇게 해야 된다.

# 리스트를 벡터로 변환
# 리스트 형태로 되어 있으면 사용이 너무 불편함..
unlist(s)
paste(unlist(s), collapse = " ")

# 15. 특정 패턴(문자열) 찾기(기본 function 사용.)
vector_1 <- c("Xman", "Superman", "Joker")
grep("man", vector_1)   # 첫번째, 두번째에 "man"이 있다고 1, 2 이렇게 알려줌.
grep("man" vector_1, value = TRUE)

regexpr("man", vector_1)
gregexpr("man", vector_1)   # list의 형태로 보여 줌.
# 근데 얘네 두개 다 별로 안쓸듯.

# 16. 특정 패턴(문자열) 찾기(stringr 패키지에 포함된)
fruit <- c("apple", "banana", "cherry")
str_count(fruit, "a")
str_detect(fruit, "a")
str_locate(fruit, "a")
str_locate_all(fruit, "a")

people <- c("rorori", "emilia", "youna")
str_match(people, "o(\\D)")  #\\D는 non-digit character를 의미합니다.

# 17. 특정 패턴(문자열)찾아서 다른 패턴(문자열)으로 바꾸기.
fruits <- c("one apple", "two pears", "three bananas")
sub('a', 'A', fruits) # => a를 맨 앞에 나온걸 A로 바꿈
gsub('a', 'A', fruits) # => 모든 a를 A로 바꿈.

str_replace(fruits, 'a', 'A')
str_replace_all(fruits, 'a', 'A')

sub("[aeiou]", "-", fruits)
gsub("[aeiou]", "-", fruits)

# https://regexr.com/
# regular expression 바로 적용해 보는 사이트.(수업자료 블로그에 나와 있는 부록 표 참고.)


# 정규 표현식(Regular Expression)
fruits <- c("one apple", "two pairs", "three bananas")
str_match(fruits, '[aeiou]')
str_match_all(fruits, '[aeiou]')

str_match(fruits, "\\d")
str_match(fruits, '[[:digit:]]')



