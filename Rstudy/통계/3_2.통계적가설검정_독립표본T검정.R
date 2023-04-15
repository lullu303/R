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

##############################
# 두 독립된 집단(소표본)의 평균 비교 Ex

rawN3 <- read.csv('data/htest01.csv', header = TRUE)
rawN3

# 그룹 이름 확인
unique(rawN3$group)
# [1] "A" "B"

# 그룹 나누기
groupA <- rawN3[rawN3$group == "A", 1:2]
groupB <- rawN3[rawN3$group == "B", 1:2]

# 그룹별 평균
mean(groupA[,2]) # 170
mean(groupB[,2]) # 181

# 각 그룹별 정규성 검정
qqnorm(groupA$height)
qqline(groupA$height)

ks.test(groupA$height, 'pnorm',
        mean=mean(groupA$height),
        sd = sd(groupA$height))
# p-value = 1 귀무가설 채택 정규성 가정

qqnorm(groupB$height)
qqline(groupB$height)

ks.test(groupB$height, 'pnorm',
        mean=mean(groupB$height),
        sd = sd(groupB$height))
# p-value = 0.8802 귀무가설 채택 정규성 가정

# 두 독립표본의 등분산성 검정
var.test(groupA$height, groupB$height)
# p-value = 0.5385 유의수준보다 크기 때문에 귀무가설 채택, 등분산성 가정

###############
# 등분산성 검정 Ex2
jumsu <- read.csv('data/반별_점수_type1.csv',fileEncoding = "euc-kr")
head(jumsu)
unique(jumsu$반)

# 반별로 분류
A <- subset(jumsu, jumsu$반 == 'A')
B <- subset(jumsu, jumsu$반 == 'B')
var.test(A$점수, B$점수)
# 0.1597 : 귀무가설 채택

var(A[,2])
# [1] 32.26053

var(B[,2])
# [1] 68.54444

32/68
# [1] 0.4705882

##########################
# 등분산 검정 Ex 3

rawN10 <- read.csv('data/htest02.csv',header = T)
rawN10

groupA2 <- rawN10[rawN10$group=='A',1:2]
groupB2 <- rawN10[rawN10$group=='B',1:2]

var.test(groupA2[,2], groupB2[,2])
# p-value = 0.02602 : 귀무가설 기각 (등분산성 가정할 수 없음)


########################
# 독립표본 t 검정

#  [1] 두 집단의 키의 평균은 차이가 있는가? groupA, groupB
t.test(groupA[,2], groupB[,2], var.equal = T, alternative = 'less')
# p-value = 0.1154 귀무가설 채택(두 집단의 평균차이는 없다.)

#  [2] 두 반의 성적의 평균은 차이가 있는가? A,B
# 정규성 확인
shapiro.test(A[,2]) #  p-value = 0.7485 : 귀무가설 채택
shapiro.test(B[,2]) #  p-value = 0.1646 : 귀무가설 채택

# 두 집단 평균차이에 대한 t검정
t.test(A[,2], B[,2], var.equal = T, alternative = "less")
# p-value = 0.991 : 귀무가설 채택(두집단의 평균차이는 없다)

#  [3] 두 집단의 키의 평균은 차이가 있는가? groupA2, groupB2 
#     - 등분산이 아님
# 정규성 검정 : 정규성 가정
shapiro.test(groupA2[,2])
shapiro.test(groupB2[,2])

# 두 집단은 등분산이 아님
# 두 집단의 평균차이 검정
t.test(groupA2[,2], groupB2[,2], var.equal = F, alternative = 'less')
# p-value = 0.01912 : 귀무가설 기각(두집단의 평균에는 차이가 있다.)



