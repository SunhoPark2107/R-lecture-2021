# 멜론 차트 앱

library(rvest)
library(stringr)
library(dplyr)
# 
# url <- 'https://www.melon.com/chart/index.htm'
# ua <- 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
# 
# html <- read_html(url)                  # 406 오류가 나는 이유 => 브라우저 지정까지 해 주어야 하는 사이트들이 있음.
#                                         # ua를 지정해 주어야 함!(브라우저)

 
# ua 지정 위해 httr 패키지의 설치가 필요하다.
# install.packages("httr")
library(httr)
# 멜론 주간 차트
url <- 'https://www.melon.com/chart/week/index.htm'
ua <- 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'

res <- GET(url = url, user_agent(agent = ua))
html <- read_html(res)

##############
# 우리가 할 것 => 순위, 전 주 순위, 곡명, 가수, 앨범
# 새로 차트인 한 곡은 999의 값을 주기로 함.(맘대로 정하세유)
##############

# 순위 구하기

table <- html %>% 
    html_node('div.service_list_song') %>% 
    html_node('table')

trs <- table %>% 
    html_node('tbody') %>% 
    html_nodes('tr')

tr <- trs[1]
rank <- tr %>% 
    html_node('span.rank') %>% 
    html_text()
rank
rank <- as.integer(rank)
rank

# # 전 주 순위: 1, 2, 3, 22 (유지, 상승, 하강, 신규)
# for (i in c(1, 2, 3, 22)) {
#     print(i)
#     tr <- trs[i]
#     tds <- html_nodes(tr, 'td')
#     change <- tds[3] %>% 
#         html_node('span.none') %>% 
#         html_text()
#     print(change)
# }


for (i in c(1, 2, 3, 22)) {
    tr <- trs[i]         # trs[1], trs[2], trs[3], trs[22]
    tds <- html_nodes(tr, 'td') 
    spans <- html_nodes(tds[3], 'span')
    last_str <- html_text(spans[3])
    if (length(spans) == 4) {
        t <- as.integer(html_text(spans[4]))
        if (last_str == '순위 동일') {
            last_rank <- rank
        } else if (last_str == '단계 상승') {
            last_rank <- rank + t
        } else {
            last_rank <- rank - t
        }
    } else {
        last_rank <- 999
    }
}








    # 괄호 뭐가 잘못 닫혔음

song_info <- tr %>% 
    html_node('.wrap_song_info')

anchors <- tr %>% 
    html_node('.wrap_song_info') %>% 
    html_nodes('a')
title <- html_text(anchors[1])
artist <- html_text(anchors[2])


title <- tr %>% 
    html_node('.ellipsis.rank01') %>%
    html_node('a') %>% 
    html_text()
title

artist <- tr %>% 
    html_node('.ellipsis.rank02') %>%
    html_node('a') %>% 
    html_text()
artist

album  <- tr %>% 
    html_node('.ellipsis.rank03') %>%
    html_node('a') %>% 
    html_text()
album

rank_vec <- c()
last_vec <- c()
title_vec <- c()
artist_vec <- c()
album_vec <- c()

for (tr in trs) {
    rank <- tr %>% 
        html_node('span.rank') %>% 
        html_text()
    rank <- as.integer(rank)
    for (i in c(1, 2, 3, 22)) {
        tr <- trs[i]         # trs[1], trs[2], trs[3], trs[22]
        tds <- html_nodes(tr, 'td') 
        spans <- html_nodes(tds[3], 'span')
        last_str <- html_text(spans[3])
        if (length(spans) == 4) {
            t <- as.integer(html_text(spans[4]))
            if (last_str == '순위 동일') {
                last_rank <- rank
            } else if (last_str == '단계 상승') {
                last_rank <- rank + t
            } else {
                last_rank <- rank - t
            }
        } else {
            last_rank <- 999
        }
    }
    
        title <- tr %>% 
            html_node('.ellipsis.rank01') %>%
            html_node('a') %>% 
            html_text()
        
        artist <- tr %>% 
            html_node('.ellipsis.rank02') %>%
            html_node('a') %>% 
            html_text()
        
        album  <- tr %>% 
            html_node('.ellipsis.rank03') %>%
            html_node('a') %>% 
            html_text()
        rank_vec <- c(rank_vec, rank)
        last_vec <- c(last_vec, last_rank)
        title_vec <- c(title_vec, title)
        artist_vec <- c(artist_vec, artist)
        album_vec <- c(album_vec, album)
}
    
week_chart <- data.frame(
    rank = rank_vec, last_rank = last_rank, title_vec = title,
    artist_vec = artist, album_vec = album)

View(week_chart)
