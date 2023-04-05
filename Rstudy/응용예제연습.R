# 서울시 서대문구의 가장 치킨집이 많은 동네 찾기

# 아래 데이터 사용 
row_data <- read.csv("data/서울특별시_일반음식점.csv")
View(row_data)

# string 관련 패키지
#"소재지전체주소",  "영업 상태명", "위생업태명" 컬럼 사용
# 서대문구 데이터만 추출
# 위생업태명에 통닭이나 치킨이 들어있는 점포
# 동별로 분리 후 빈도 
library(dplyr)
data_fin <- row_data %>% 
  filter(영업상태명 == '영업/정상' & 위생업태명 %in% c('호프/통닭','통닭(치킨)')) %>% 
  select(소재지전체주소,위생업태명)
# 서울시 모든 자치구의 치킨집 data
View(data_fin)

# 서대문구 데이터만 추출
# 소재지 전체 주소에서 서대문국 포함된 행만 추출
# 문자열에 특정 문자열의 포함여부를 확인하는 str_detect()
library(stringr)

# data_fin[서대문구,]
seo_data <- data_fin[str_detect(data_fin$소재지전체주소, '서대문구'),]
dim(seo_data)
head(seo_data)

# 소재지 전체 ㅈ소 열에서 xxx동만 남기고 이후 상세 주소 삭제
# 모든 데이터가 서대문구이므로 동데이터만 남김
# substr() 함수
# 11번째 글자에서 16번째 글자까지 추출

addr <- substr(seo_data$소재지전체주소, 11,16)
head(addr)

# 추출한 데이터에 공백이나 숫자가 들어 있음
# gsub() : 공백과 숫자 제거

# 숫자 제거
addr_n <- gsub("[0-9]","",addr)
head(addr_n)

# 공백 제거
addr_trim <- gsub(" ","",addr_n)
head(addr_trim)

# 동별 업소 갯수확인

# table(addr_trim)

addr_count <- addr_trim %>% table() %>%  data.frame()

head(addr_count)

# 변수명 변경
addr_count <- rename(addr_count, '동명' = '.','빈도'='Freq')
head(addr_count)

# 빈도 기준 정렬
arrange(addr_count, desc(빈도))

# 시각화 진행
# 트리맵으로 표현
# 트리 맵 (Tree Map : 나무지도)
# 데이터가 갖는 계층구조를 타일 모양으로 표현한 것
# 타일은 계층적 속성을 가지며
# 계층은 색상으로 표현됨
# treemap 패키지 
# treemap() 함수 사용하여 표현
# treemap(데이터 세트, 
#            index=구분 열, 	# 계층을 선언하는 매개변수
#            vSize= 분포 열, 	# 타일 크기       
#            vColor=색상, 	# 타일 색상
#            title=제목)

install.packages('treemap')
library(treemap)

treemap(addr_count,
           index='동명', 	# 계층을 선언하는 매개변수
           vSize= '빈도', 	# 타일 크기
           title='서대문구 동별 치킨집 분포정상영업')



