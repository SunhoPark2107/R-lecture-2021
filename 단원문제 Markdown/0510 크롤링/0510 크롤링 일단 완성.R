# 과제
# 1. 한빛미디어 새로나온 책 목록 25페이지 전체 크롤링해서 .csv 형식으로 저장하기.\

library(rvest)
library(stringr)
library(dplyr)

# 웹 사이트 읽기
base_url <- 'https://www.hanbit.co.kr/media/books/'
sub_url <- 'new_book_list.html'
url <- paste0(base_url, sub_url)
html <- read_html(url)
url


sub_book_list <- html_node(html, '.sub_book_list_area')
lis <- html_nodes(sub_book_list, 'li')    

html_node(html, '.sub_book_list_area') %>% 
    html_nodes(sub_book_list, 'li')               # 변수 지정 일일이 안 하고 요렇게 해줘도 됨.



title_vector <- c()
writer_vector <- c()
page_vector <- c()
price_vector <- c()

for (i in 1:25) {
    page_url <- paste0('?page=', i)
    print(page)
    for (li in lis) {
        info <- html_node(li, '.info')
        title <- info %>% 
            html_node('.book_tit') %>% 
            html_text()
        writer <- info %>% 
            html_node('.book_writer') %>% 
            html_text()
        href <- li %>% 
            html_node('.info') %>% 
            html_node('a') %>% 
            html_attr('href')
        book_url <- paste(base_url, href, sep='/')
        book_html <- read_html(book_url)
        info_list <- html_node(book_html, 'ul.info_list')
        book_lis <- html_nodes(info_list, 'li')
        for (book_li in book_lis) {
            item <- book_li %>% 
                html_node('strong') %>% 
                html_text()
            if (substring(item, 1, 3) == '페이지') {
                page <- book_li %>% 
                    html_node('span') %>% 
                    html_text()
                len <- str_length(page) 
                page <- as.integer(substring(page, 1, len-2))
                break
            }
        }
        pay_info <- html_node(book_html, '.payment_box.curr')
        ps <- html_nodes(pay_info, 'p')
        price <- ps[2] %>% 
            html_node('.pbr') %>% 
            html_node('strong') %>% 
            html_text()
        price <- as.integer(gsub(',','',price))
        
        title_vector <- c(title_vector, title)
        writer_vector <- c(writer_vector, writer)
        page_vector <- c(page_vector, page)
        price_vector <- c(price_vector, price)
    }
}
    
new_books <- data.frame(
    title=title_vector,
    writer=writer_vector,
    page=page_vector,
    price=price_vector
)

View(new_books)
write.csv(new_books, "C:/workspace/R/data/new_books.csv")

# 2. 지니뮤직 일간차트 1~100위 Rank, Last Rank, Title, Artist, Album
library(rvest)
library(stringr)
library(dplyr)
library(httr)

url <- 'https://www.melon.com/chart/day/index.htm'
ua <- 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
res <- GET(url=url, user_agent(agent=ua))
html <- read_html(res)

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
rank <- as.integer(rank)
# 전주 순위: 1, 2, 3, 22 (유지, 상승, 하강, 신규)
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

anchors <- tr %>% 
    html_node('.wrap_song_info') %>% 
    html_nodes('a')
title <- html_text(anchors[1])
artist <- html_text(anchors[2])

title <- tr %>% 
    html_node('.ellipsis.rank01') %>% 
    html_node('a') %>% 
    html_text()
artist <- tr %>% 
    html_node('.ellipsis.rank02') %>% 
    html_node('a') %>% 
    html_text()
album <- tr %>% 
    html_node('.ellipsis.rank03') %>% 
    html_node('a') %>% 
    html_text()

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
    
    title <- tr %>% 
        html_node('.ellipsis.rank01') %>% 
        html_node('a') %>% 
        html_text()
    artist <- tr %>% 
        html_node('.ellipsis.rank02') %>% 
        html_node('a') %>% 
        html_text()
    album <- tr %>% 
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
    rank=rank_vec, last_rank=last_vec, title=title_vec,
    artist=artist_vec, album=album_vec
)
View(week_chart)
