# base R을 이용한 데이터 가공

# install.packages는 코드에 포함시키지 말고 콘솔창에서 하기!
library(gapminder)
library(dplyr)


glimpse(gapminder)              # glimpse는 dplyr 패키지 함수(데이터 tibble 형태로 훑어보기)
                                # tibble (컬럼 이름, 속성(요소), 타입 나오는 것.)

# 각 나라의 기대 수명(lifeExp)
tail(gapminder[, c('country', 'lifeExp')])
tail(gapminder[, c('country', 'lifeExp', 'year')])   # 나라 및 년도별 기대 수명 (너무 많아서 tail로 6개 데이터만 본 것.)

# sampling = filtering (샘플과 속성의 추출 (flitering and selection))
gapminder[1000:1009, c('country', 'lifeExp', 'year')] # 여기서 행 조건 주는 것이 filtering, 열 조건 주는 것이 selection
gapminder[gapminder$country == 'Croatia', ]     # 크로아티아(행)의 모든 변수 데이터(열) 가져오라
gapminder[gapminder$country == 'Croatia', c('year', 'pop')]  

### 데이터 세트/테이블/프레임/변수명 등등 이름은 """대소문자 구분"""을 잘 해주어야 함! (엥간하면 이름은 tap으로 넘어가자)


# 크로아티아의 1990 년도 이후의 연도, 기대수명과 인구

gapminder[gapminder$country == 'Croatia' & gapminder$year >= 1990 , c('year', 'lifeExp', 'pop')]





