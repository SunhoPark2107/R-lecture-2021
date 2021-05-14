# R로 interactive 지도 그리기. (leaflet)
# install.packages("leaflet")
library(leaflet)

# 기본 지도, 대전광역시
leaflet() %>% 
    setView(lng=127.39, lat=36.35, zoom=12) %>%       # lng는 경도, lat은 위도. 초기값은 "중심점"의 좌표를 찍어 주는 것임.
    addTiles()

# 3rd party 제공 지도
leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addProviderTiles('providers$Esri.NatGeoWorldMap')    # google에 leaflet for r 에서 basemap 탭을 보면 포맷 나옴.


# Marker 달기
leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addTiles() %>% 
    addMarkers(lng = 127.3848, lat = 36.3503, label = '대전시청',
               labelOptions = labelOptions(textsize='15px'))             # marker 옵션 조정 가능하고, 자세한 것은 매뉴얼을 참조하기.


leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addTiles() %>% 
    addMarkers(lng = 127.3848, lat = 36.3503, label = '대전시청', 
               labelOptions = labelOptions(
                   style=list(
                       'color' = 'red',
                       'font-size' = '15px',
                       'font-style' = 'italic'
                   )
               )
    )


# Circle Marker
leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addTiles() %>%
    addCircles(lng = 127.3848, lat = 36.3503,
               label = '대전시청', radius = 500)     # radius 는 반지름. 원 사이즈 조정가능.

leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addTiles() %>%
    addCircles(lng = 127.3848, lat = 36.3503,
               label = '대전시청', radius = 500,
               weight = 1, color = 'purple')             # weight는 원 테두리의 두께.

# 사각형 Marker
leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addTiles() %>%
    addRectangles(lng1 = 127.37, lat1 = 36.34,
                  lng2 = 127.39, lat2 = 36.36,
                  fillColor = 'transparent')          # fillcolor = "투명"


leaflet() %>% 
    setView(lng=127.39, lat = 36.35, zoom=12) %>% 
    addProviderTiles('providers$CartoDB.Positron') %>% 
    addRectangles(lng1 = 127.37, lat1 = 36.34,
                  lng2 = 127.39, lat2 = 36.36,
                  fillColor = 'transparent')
































