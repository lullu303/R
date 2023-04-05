##! 출처 : http://roycekimmons.com/tools/generated_data/exams
# 출처 : https://www.kaggle.com/mirichoi0218/insurance
# 상대적인 수치 생성 예제

# 패키지
library(dplyr)
library(ggplot2)

# 데이터 불러오기
scores <- read.csv('data/StudentsPerformance.csv')
View(scores)

insurance = read.csv("data/insurance.csv")
View(insurance)

# 순위와 백분위 계산
rank(insurance$charges)
percent_rank(insurance$charges)

# 상위 10% 관측치 선책
insurance %>% 
  mutate(PR=percent_rank(charges)) %>% 
  filter(PR >= 0.9)

slice_max(insurance,order_by = charges, prop=0.1)
slice_max(insurance, order_by = charges, n=10)

## 최대최소 정규화
insurance %>% 
  mutate(MINMAX=(charges-min(charges))/(max(charges)-min(charges))) %>% 
  select(charges, MINMAX)

# 표준화 : 평균과의 차이(중심화), 표준편차 활용 척도화
## scale(x, center=T/F, scale=T/F)
mean(c(60,80)) # 70
sd(c(60,80)) # [1] 14.14214
(60-70)/14.14214 # [1] -0.7071066
(80-70)/14.14214 # [1] 0.7071066

# 중심화/척도화 하지 않음
scale(c(60,80), center=F, scale=F) # 값의 변화가 없음
# 중심화(평균과의 차이)
scale(c(60,80), center=T, scale=F)
# 척도화(100을 기준으로 비율 계산)
scale(c(60,80), center=F, scale=T)
# 표준화 계산
scale(c(60,80), center=T, scale=T)

################################
# 집단간의 차이 비교 : 평균비교

insurance %>% 
  summarise(MEAN = mean(charges)) # 1 13270.42

insurance %>% 
  group_by(region, smoker) %>% 
  summarise(MEAN = mean(charges))

insurance %>% 
  mutate(charges_c= scale(charges, center=T, scale=F)) %>% 
  group_by(region, smoker) %>% 
  summarise(MEAN = mean(charges),
            MEAN_R = mean(charges_c))

##! 실습 (StudentsPerformance.csv 데이터 활용)
##! math.score의 최대최소 정규화 후 0.9 이상인 관측치만 선택
head(scores)

scores %>% 
  mutate(MINMAX=(math.score-min(math.score))/(max(math.score)-min(math.score))) %>% 
  filter(MINMAX >=0.9 )
















