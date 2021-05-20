
# 2. 지니뮤직 일간차트 1~100위 Rank, Last Rank, Title, Artist, Album
library(rvest)
library(stringr)
library(dplyr)
library(httr)

url <- 'https://www.genie.co.kr/chart/top200?ditc=D&rtm=N'
ua <- 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
res <- GET(url=url, user_agent(agent=ua))
html <- read_html(res)

table <- html %>% 
    html_node('table.list-wrap')

trs <- table %>% 
    html_node('tbody') %>% 
    html_nodes('tr')

len <- length(trs)


target = rank %>% gsub("^\\s+|\\s+$|\n| ","",.)

target

substr(target, nchar(target)-1, nchar(target))

typeof(nchar(target))

tr <- trs[1]
rank <- trs %>%
    html_node('td.number') %>%
    html_text()

##################################################################
for (i in 1:50){
    target <- rank[[i]] %>% gsub("^\\s+|\\s+$|\n| ","",.)
    stat <- substr(target, (nchar(target)-1), nchar(target))
    
    print(stat)
    
}


##################################################################
for (i in 1:50){
    target <- rank[[i]] %>% gsub("^\\s+|\\s+$|\n| ","",.)
    if ((i >= 1) & (i <= 9)) {
        stat <- substr(target, (nchar(target)-i), nchar(target))
        if (!(stat %in% c('유지','ew'))) {
            current_rank <- substr(target, 1, 1)
            diff <- substr(target %>% gsub(stat,'',.), 2, 3)
        } else if (stat == '유지') {
            current_rank = substr(target, 1, 1)
            diff = 0
        }
    }
}



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


# 1위곡 title이랑 artist 출력.
anchors <- trs %>% 
    html_node('.info') %>% 
    html_nodes('a')
title <- html_text(anchors[1])
artist <- html_text(anchors[2])
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
title <- trim(title)
artist <- trim(artist)
title
artist


title <- trs %>% 
    html_node('.title.ellipsis') %>% 
    html_text()
artist <- trs %>% 
    html_node('.artist.ellipsis') %>% 
    html_text()
album <- trs %>% 
    html_node('.albumtitle.ellipsis') %>% 
    html_text()

trim(title)
trim(artist)
trim(album)


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
    
    title <- trs %>% 
        html_node('.title.ellipsis') %>% 
        html_text()
    artist <- trs %>% 
        html_node('.artist.ellipsis') %>% 
        html_text()
    album <- trs %>% 
        html_node('.albumtitle.ellipsis') %>% 
        html_text()
    
    title <- trim(title)
    artist <- trim(artist)
    album <- trim(album)
    
    
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