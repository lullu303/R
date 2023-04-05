library(dplyr)

# [1] ~ 도수분포표로 요약하라

blood = 
  c("B","A","B","A","A","B","O","A","A","A","O","B","AB","B","AB",
    "AB","A","A","O","AB","O","A","B","O","B","B","A","A","O","A",
    "A","AB","B","B","O","B","B","B","A","AB","A","A","B","O","B",
    "B","O","B","O","B","A","A","AB","A","A")

# 도수분포표 생성
blood_table <- table(blood)
blood_table
# blood
# A AB  B  O 
# 20  7 18 10 

blood_df <- data.frame(blood_table)
blood_df
# blood Freq
# 1     A   20
# 2    AB    7
# 3     B   18
# 4     O   10

colnames(blood_df)[1] <- 'Blood_type'

barplot(blood_df$Freq,
        names.arg = blood_df$Blood_type)

# [2] 원도표와 막대도표로 요약하라
pie(table(blood))

# [3] ~ 도수분포표를 그려라 , 히스토그램을 그려라
height = c(170,178,171,168,173,178,171,174,170,170,175,
           170,169,166,162,170,171,175,175,171,171,170,
           172,179,164,170,181,178,180,177,166,169,168,
           165,163,175,166,178,165,168,167,177,168,177,
           174,174,176,179,169,173,167,170,173,170,162)

height_table <- table(height)
# height
# 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 
# 2   1   1   2   3   2   4   3   9   5   1   3   3   4   1   3   4   2   1   1

summary(height)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 162.0   168.0   171.0   171.4   175.0   181.0 

hist(height, breaks=seq(150,190,5))


# [4] 중간고사 성적 표본평균, 중위수
midterm_score <- c(89,78,91,86,76,84)

summary(midterm_score)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 76.00   79.50   85.00   84.00   88.25   91.00 
# 평균 : 84.00, 중위수 : 85.00

midterm_score <- c(89,78,91,86,76,84,42)
summary(midterm_score)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 42.0    77.0    84.0    78.0    87.5    91.0 
# 평균 : 78.0, 중위수 : 84.0

# 표본분산과 표본표준편차를 구하라
midterm_score
# midterm_score
# [1] 89 78 91 86 76 84 42

var(midterm_score)
# [1] 16.78293

sd(midterm_score)
# [1] 16.78293

result.mean <- mean(midterm_score)
result.mean
# [1] 78

# 사분위범위와 제 50백분위수를 구하라
quantile(midterm_score)
# 0%  25%  50%  75% 100% 
# 42.0 77.0 84.0 87.5 91.0 

quantile(midterm_score,0.50)
# 50% 
# 84


# [5] ~ 상자그림을 그려라
noise = c(55.9,63.8,57.2,59.8,65.7,62.7,60.8,51.3,61.8,56.0,
          66.9,56.8,66.2,64.6,59.5,63.1,60.6,62.0,59.4,67.2,
          63.6,60.5,66.8,61.8,64.8,55.8,55.7,77.1,62.1,61.0,
          58.9,60.0,66.9,61.7,60.3,51.5,67.0,60.2,56.2,59.4,
          67.9,64.9,55.7,61.4,62.6,56.4,56.4,69.4,57.6,63.8)
boxplot(noise)


# [6] ~ 사계절 중 어디에 해당하는지를 조사한 결과이다.
birth_seasons <- c("봄", "봄", "가을", "여름", "가을", "가을", "봄", "가을", "여름",
                   "여름", "가을", "봄", "여름", "겨울", "가을", "여름", "봄", "여름", "봄", "겨울",
                   "여름", "가을","가을", "가을", "여름", "겨울", "봄", "겨울", "가을",
                   "가을","봄", "여름", "봄","겨울", "여름", "겨울")
# 도수분포표
birth_seasons_table <- table(birth_seasons)
# 가을 겨울   봄 여름 
# 11    6    9   10 

# 막대그래프
barplot(birth_seasons_table)

# 원도표
pie(birth_seasons_table)


# [7] 각각 표본평균과 중위수 계산
math_score <- c(77, 78, 76, 81, 86, 51, 79, 82, 84, 99)

summary(math_score)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 51.00   77.25   80.00   79.30   83.50   99.00 

# 표본평균 : 79.30, 중위수 : 80.00

quantile(math_score)
# 0%   25%   50%   75%  100% 
# 51.00 77.25 80.00 83.50 99.00 

A_apt <- c(1, 5, 2, 3, 2, 1, 4, 1, 3)
summary(A_apt)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   1.000   2.000   2.444   3.000   5.000 

# 표본평균 : 2.444 중위수 : 2.000

quantile(A_apt)
# 0%  25%  50%  75% 100% 
# 1    1    2    3    5 










