# 파일 읽기
getwd()
students <- read.table('data/students1.txt', header = T) # header란? 첫 행을 변수값으로 지정할 것인가는 묻는 것. header를 false로 지정할 경우, 첫 행도 데이터의 일부처럼 불러오기 된다.
students
str(students)

# read.csv는 첫 행을 header로 읽는 것이 default.
students <- read.csv('data/students.csv')
students

# 파일 쓰기
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8')
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8')

# row.names=F 설정, 행, 인덱스 번호를 저장하지 않음.
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8', row.names=F)
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8', row.names=F)

# quote = F 옵션, "" 사라짐.
write.table(students, file = 'data/output.txt', fileEncoding = 'utf-8', row.names=F, quote = F)
write.csv(students, file = 'data/output.csv', fileEncoding = 'utf-8', row.names=F, quote = F)

# 제대로 읽는지 확인
students <- read.table('data/output.txt', header = T, fill = T, fileEncoding = 'utf-8')
students
students <- read.csv('data/output.csv', header = T, fileEncoding = 'utf-8')
students

str(students)

# 읽을 때 stringAsFactors=F로 하면 문자열을 범주형으로 읽지 않음.
students <- read.csv('data/output.csv', fileEncoding = 'urf-8', stringsAsFactors = F)
