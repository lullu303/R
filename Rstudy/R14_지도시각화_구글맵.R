################################
# ggmap 패키지 : 구글 지도 서비스(api)를 사용할 수 있는 기능 패키지
# get_googlemap() : 지도 좌표에 대한 정보를 얻는 함수
# ggmap() : get_googlemap() 얻은 지도 정보를 이용해서 
# 지도를 시각화하는 함수 
# 구글 API KEY가 필요 : AIzaSyBruNnv1qT4ap96rX64eqDQVttckKJJwzM
# register_google(key='발급받은 키')
# -> 컴퓨터의 register 라는 저장소에 등록
install.packages('ggmap')
library(ggmap)


# 1. api 키 register에 저장
register_google(key='AIzaSyBruNnv1qT4ap96rX64eqDQVttckKJJwzM')

# 2. 구글지도 정보 얻어오기(웹연결되어 있어야 함)
# 변수 <- get_googlemap(대표지역명, maptype=)
ggseoul <- get_googlemap('seoul', maptype = 'terrain')


# 3. 지도 그리기
# ggmap(지도정보)
ggmap(ggseoul)


ggseoul <- get_googlemap('seoul', maptype = 'hybrid')
ggmap(ggseoul)


ggseoul <- get_googlemap('busan', maptype = 'roadmap')
ggmap(ggseoul)

##############################################
# geocode() 함수
# 특정 지역의 위경도 데이터를 요청해서 위경도를 반환받는 함수

geocode('seoul')
#     lon   lat
#     <dbl> <dbl>
#   1  127.  37.6

class(geocode('seoul')) # "tbl_df"     "tbl"        "data.frame"

geocode('대전역')

# 한글전달 시 에러가 나올 수 있음 (ggmap낮은 버전에서 발생)
enc2utf8('대전역') %>%  geocode()


######################
# 대전역 중심으로 지도시각화 후 해당 위치에 포인트
get_googlemap('대전역', maptype='roadmap', zoom=13) %>% 
  ggmap() +
  geom_point(data=dae,
             aes(x=lon, y=lat), size=5, color='red')


############################
# 강동구 공영 주차장 표시
# 수집된 위경도 데이터를 이용하여 강동구 지역의 공영 주차장 표시 

# 위경도 데이터 읽어오기
info <- read.csv('data/서울_강동구_공영주차장_위경도.csv', header = T,
                 encoding='UTF8')
View(info)

geocode('강동구 강일동 292-2')

# 구글키 등록
register_google(key='AIzaSyBruNnv1qT4ap96rX64eqDQVttckKJJwzM')

# 특정 위치 기준으로 구글지도정보 얻어오기
# '암사동' 기준
kangdong <- get_googlemap("암사동",
                          zoom=13,
                          maptype='roadmap')


kangdong


# 지도를 출력하는 코드 변수에 저장해서 사용
kang.map <- ggmap(kangdong)

#---------------------------------
kang.map

# 지도 위에 주차장을 point로 표시
kang.map.point <- kang.map +
                  geom_point(data=info,
                             aes(x=LON, y=LAT),
                             size=2,
                             color='red')
kang.map.point


# 주차장명 표시
kangdong_park <- kang.map.point + geom_text(data=info,
                                            aes(x=LON, y=LAT + 0.001,
                                                label=주차장명),
                                            size=2)
kangdong_park


#####################################################
# 2호선 역명을 이용한 위경도 얻어오기
line_2_sta <- readLines('data/2호선역명.txt')
line_2_sta

sta_lon_lat <- geocode(line_2_sta)

View(sta_lon_lat)

sta_lon_lat$station <- line_2_sta

View(sta_lon_lat)


# 지도에 2호선 역 표시
kd <- get_googlemap('시청역',
                    zoom=11,
                    maptype = 'roadmap') 
ggmap(kd) + geom_point(data=sta_lon_lat,
                       aes(x=lon, y=lat),
                       size=1,
                       color='red') #+
  # geom_line(data=sta_lon_lat,
  #           aes(x=lon, y=lat),
  #           size=1,
  #           color='black')






















