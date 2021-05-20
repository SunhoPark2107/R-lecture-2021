# 단계 구분도(Choropleth)
install.packages("geojsonio")
library(geojsonio)
library(leaflet)
library(stringr)

getwd()
setwd("C:/workspace/R/0513 map")

map <- geojson_read('map_data/geo_simple_daejon.json', what = 'sp')

leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 12) %>% 
    addProviderTiles('Staman.TonerLite') %>% 
    addPolygons()

class(map)                  # SpatialPolygonDataFrame

slotNames(map)
map@data

city <- read.csv('대전자치단체.csv', fileEncoding = 'UTF-8')[-1,]
city

# population을 기준으로 단계별로 구분해 보기.
# 연속적인 값의 팔레트
pal <- colorNumeric('RdPu', NULL)

leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 11) %>%
    addProviderTiles(providers$Stamen.TonerLite) %>% 
    addPolygons(
        fillColor = ~pal(city$pop),
        weight = 2,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        label = ~city$place
    )


# map 데이터와 city 데이터를 통합하면 좋지 않을까? ><
names(map@data)
names(city)       # city 데이터에 name이라는 컬럼 추가해서 city와 map을 합친다면?

city$name <- lapply(city$place, 
                    function(x) substring(x, 1, str_length(x) - 1))       # apply 계열의 코드 잘 사용하는 것 중요! (이 코드도 apply 안 쓰면 for loop 돌려야 하는 것. + 그리고 파이썬에서도 활용 가능하다. )

city <- city[c(5,4,3,2,1),]
city

pal <- colorNumeric('YlOrRd', NULL)

leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 11) %>%
    addPolygons(
        fillColor = ~pal(city$pop),
        weight = 2,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        label = ~city$name
    )

# map@data 와 city 를 merge해서 하나의 데이터로 처리.



map@data <- merge(map@data, city, by='name', sort = F) # name 필드를 기준으로 해서 합쳐짐.


pal <- colorNumeric('YlOrRd', NULL)

leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 11) %>%
    addPolygons(
        fillColor = ~pal(pop),
        weight = 2,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        label = ~name
    )


# 단계를 내 마음대로 정하기.
bins <- c(20, 25, 30, 40, 50) * 10000            # 20만, 25만, 30만, ... 이런식으로 나가게 됨.

pal <- colorBin('PuBuGn', domain = map@data$pop, bins = bins)
leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 11) %>%
    addPolygons(
        fillColor = ~pal(pop),
        weight = 2,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        highlight = highlightOptions(weight = 5, color = '#999', dashArray = '', fillColor = 0.7, bringToFront = T),
        
        label = ~name
    ) %>% 
    addLegend(pal = pal, values = ~pop, opacity = 0.7, 
              title = '인구수', position = 'bottomright')

































