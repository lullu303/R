# 세개 이상의 변수 평균 차이 검정
# 귀무 가설 : 모든 그룹의 평균이 같다
# 대립 가설 : 최소 한개 그룹의 평균은 다르다

df <- read.csv("data/지점별_일별판매량.csv", header = T)
head(df)
dim(df)
# 특정 업체의 3지점의 7월 판매량
# 지점별 7월 판매량간의 유의미한 차이가 있는가?
# 모든 집단에 대해서 정규성과 등분산성이 만족되어야 함

# tip. 
# 모든 집단에 대해 등분산 확인 후 분산이 같지 않으면 다른 분석
# Kruskal-Willis H test

A = na.omit(df$지점A)
A

B = na.omit(df$지점B)
B

C = na.omit(df$지점C)
C

# 시각화
boxplot(A,B,C)

# 정규성 검정
shapiro.test(A)
shapiro.test(B)
shapiro.test(c)

#Levene 검정 : 집단간 분산이 같은지의 여부를 확인할 때 사용
# 두집단 뿐 아니라 세집단에서도 사용할 수 있고
# 정규성을 보이지 않아도 사용 가능

# leveneTest()를 사용한다
# leveneTest(종속변수, 독립변수, 대표값, dataset)
# car 패키지 함수
# r 패키지의 leveneTest() 함수의 설정은 다음과 같다.
# ● y: 종속변수(formula 입력 가능)
# ● group: 독립변수
# center: 집단의 대표값 설정
# data: formula 사용시 데이터프레임 할당
# Center의 상세 설명은 다음과 같다.
# - MEAN: Classical Levene’s Test 방법으로 평균을 기준으로 검정
# - MEDIAN: Robust Brown-Forsythe 방법으로 중앙값을 기준으로 검정
# ※ 분포의 평균값이 대표값이라고 판단하기 어려운 경우
# - TRIMMED: Levene-type Test 방법으로 절사평균(trimmed mean)을 기준으로 검정
# ※ 상, 하위 극단치 제거가 필요한 경우
# ** 참고 : levene.test()는 사용하지 않는다.

library(reshape2)
df_long <- melt(df, id.var='일자')
head(df_long)
tail(df_long)

# install.packages("car")
library(car)
leveneTest(y=df_long$value, df_long$variable)
# Levene's Test for Homogeneity of Variance (center = median)
#       Df F value Pr(>F)
# group  2  1.2446 0.2931
#       87 

# Pr(>F) : p-value
# 세 집단은 등분산성을 갖는다.

# 일원분산분석
raw_aov <- aov(value~variable, data=df_long)
summary(raw_aov)

# F value Pr(>F)    
# 178.4   <2e-16 ***

# p_value Pr(>f) 값이 0에 수렴하므로 귀무가설 기각
# 세집단의 평균은 유의한 차이가 있다.




































