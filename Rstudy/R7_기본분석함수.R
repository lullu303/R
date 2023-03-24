################################
# aggregate() 함수
# 특정 열을 기준으로 통계량을 계산 해주는 함수
# 데이터 프레임을 대상 통계 함수 사용

# install.packages("googleVis")
library(googleVis)
Fruits


# 년도별 판매량의 합계를 구하시오
# aggreate( 계산될 열 ~ 기준 열 , 데이터셋, 함수)
aggregate(Sales~Year, Fruits,sum)

# 과일별 판매 수량의 합계
aggregate(Sales~Fruit, Fruits,sum)

# 가장 적게 판매된 과일의 수량
aggregate(Sales~Fruit, Fruits, min)

# 가장 많이 판매된 과일별 수량
# aggregate(Sales~Fruit, Fruits, max)

# 기준열 추가
# '+ 추가조건'
aggregate(Sales ~ Fruit + Year, Fruits, sum)
Fruits

# 계산열 추가
aggregate(cbind(Sales, Expenses) ~ Year, Fruits, mean)

aggregate(cbind(Sales, Expenses) ~ Year+Date, Fruits, mean)

# 1~4호선 승하차 승객수 활용
df_subway <- read.csv("data/1-4호선승하차승객수.csv")
head(df_subway)

# 노선번호별 총 승차 인원수
aggregate(승차 ~ 노선번호, df_subway, sum)
class(res)

# 노선번호별 총 하차 인원수
aggregate(하차 ~ 노선번호, df_subway, mean)


aggregate(cbind(승차,하차) ~ 시간, df_subway, sum)

# apply() 계열 함수
# 함수를 적용해서 결과를 얻는 함수
# apply() : 행려르이 행 또는 열 방향으로 특정 함수를 적용

mat1 <- matrix(c(1,2,3,4,5,6), nrow=2, byrow=T)
mat1

apply(mat1,1,sum) #각 행의 합계를 구함
apply(mat1,2,sum) #각 행의 합계를 구함
















