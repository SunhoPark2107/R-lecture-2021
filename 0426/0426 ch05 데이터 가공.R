# base R을 이용한 데이터 가공

# install.packages는 코드에 포함시키지 말고 콘솔창에서 하기!
library(gapminder)
library(dplyr)


glimpse(gapminder)              # glimpse는 dplyr 패키지 함수(데이터 훑어보기)
                                # tibble (컬럼 이름, 속성, 타입 나오는 것.)

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

# 행/열 단위의 연산
# base R에서는 apply 함수로 했었음.
apply(gapminder[gapminder$country == 'Croatia', c('lifeExp', 'pop')], 2, mean)

# 연평균 증가율 구해보기.(책에 없는 내용임.)
# A-B-C로 변했다고 했을 때, CAGR = ((C셀/A셀)^(1/n))-1
# 예를 들어 10000 -> 20000 기간이 10년 동안 변화했다고 했을 때 연평균 증가율은
2**0.1 - 1
# 복리의 개념과 같다. 만약 이자율이 0.718 이면 10년 뒤에 원금은 2배가 됨.

# 크로아티아의 연평균 인구 증가율(데이터는 크로아티아 인구, 연도 추출한 tibble에서 보면 됨.)
(4493312/3882229)^(1/55) - 1

# 연평균 증가율을 구하는 함수를 만들어 보자.

# 사용자 정의 함수 만들어 apply 함수에 적용해 보기. (단, 변수가 하나인 함수.)
peak2peak = function(x) {
    return(max(x) - min(x))
}

apply(gapminder[gapminder$country == 'Croatia', c('lifeExp', 'pop')], 2, peak2peak)


