# shape 파일로부터 단계구분도 그리기
# 대전 법정동 단계구분도
library(raster)
library(leaflet)
library(rgdal)


map <- shapefile('map_data/LSMD_ADM_SECT_UMD_대전/LSMD_ADM_SECT_UMD_30.shp')
map <- spTransform(map, CRSobj = CRS(
    '+proj=longlat + ellps=WGS84 + datum=WGS84 + no_defs'))

slotNames(map)
class(map)              # SpatialPolygonsDataFrame

pal <- colorNumeric('RdPu', NULL)

leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 11) %>%
    addProviderTiles("Stamen.TonerLite") %>% 
    addPolygons(
        fillColor = 'Yellow',
        weight = 2,
        opacity = 1,
        color = 'blue',
        dashArray = '3',
        fillOpacity = 0.7
    )
leaflet(map) %>% 
    setView(lng=127.39, lat=36.35, zoom=12)      # lng는 경도, lat은 위도. 초기값은 "중심점"의 좌표를 찍어 주는 것임.
    

# 동별로 단계 구분도 그리기
head(map@data) 
rand <- sample(100:1000, 177)
map@data$rand <- rand

leaflet(map) %>% 
    setView(lng = 127.39, lat = 36.35, zoom = 11) %>%
    addProviderTiles("Stamen.TonerLite") %>% 
    addPolygons(
        fillColor = ~pal(rand),
        weight = 2,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        highlight = highlightOptions(
            weight = 3, colot = '#999', dashArray = '',
            fillColor = 0.7, bringToFront = T),
        label = ~EMD_NM
    ) %>% 
    addLegend(pal = pal, values = ~pop, opacity = 0.7, 
              title = '인구수', position = 'bottomright')





























