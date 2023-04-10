# 정규분포 관련 함수
# 특정 숫자가 발생하는 확률 반환(추정값)
# dnorm(x,mean,sd)
# 주어진 숫자 범위까지의 누적확률 반환
# pnorm(q,mean,sd)
# 주어진 누적확률값에 해당하는 확률변수 계산
# qnorm(p,mean,sd)
# 난수 생성
# rnorm(n(생성 개수), mean, sd)

# 평균이 0, 표준편차가 1인 정규분포를 따르는 난수를 10개 생성
rnorm(n=10, mean=0, sd=1) # mean=1, sd=1 기본값

# 평균이 100 표준편차가 20인 정규분포를 따르는 난수 10개 생성
rnorm(n=10, mean=100, sd=20)

set.seed(0)
rnorm(10)

# 정규분포에서 확률값을 계산
set.seed(0)
rNorm10 <- rnorm(10)
rNorm10

p <- dnorm(rNorm10)
p

library(ggplot2)
# 확률분포 그래프 확인
n_df <- data.frame(rNorm10, p)
n_df

ggplot(n_df, aes(x=rNorm10, y=p)) +
  geom_line()




