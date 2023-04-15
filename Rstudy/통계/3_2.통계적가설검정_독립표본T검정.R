###################
# 독립표본 T검정은
# 두 집단의 평균의 차이가 있는지 확인

# 선행조건
# 각 집단은 정규성을 가정할 수 있어야 한다(정규성 검정)
# 각 집단의 등분산성 가정 여부에 따라 사용되어지는 
# 통계량이 달라진다.(등분산성 검정)
raw <- read.csv('data/heights.csv')
raw

# 그룹별 평균
mean(raw$father)
mean(raw$son)

# 정규성 검정
shapiro.test(raw$father)
# p-value = 0.1962 : 정규성을 가정한다

qqnorm(raw$father)
qqline(raw$father)

ks.test(raw$father,"pnorm",mean=mean(raw$father),sd=sd(raw$father))
# p-value = 0.6085 : 정규성을 가정한다.

qqnorm(raw$son)
qqline(raw$son)

ks.test(raw$son,"pnorm",mean=mean(raw$son),sd=sd(raw$son))
# p-value = 0.4333

########################
# 두 독립 표본의 등분산성 검정

# var.test(표본1, 표본2)
# p-value > 0.05 귀무가설 채택
var.test(raw$father, raw$son)
# p-value = 0.4098 : 등분산성을 가정할 수 있다.

# 두 집단의 평균은 차이가 있는가?
# 귀무가설 ; 평균차이가 없다.
# 대립가설 ; 평균차이가 있다.

t.test(raw$father, raw$son, var.equal = TRUE)
# p-value < 2.2e-16  : 0.05보다 훨씬 작은 값이 나왔다.
# 유의수준보다 작은 값이므로 귀무가설을 기각한다. = 두 평균의 차이가 있다.











