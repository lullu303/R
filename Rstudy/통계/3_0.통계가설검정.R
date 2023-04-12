# 정규분포의 합의 분포
sample_size <- 1000000
X_sample <- rnorm(sample_size, 1, sqrt(2)) # 평균이 1이고 분산이 2인 정규분포
Y_sample <- rnorm(sample_size, 2, sqrt(3)) # 평균이 2이고 분산이 3인 정규분포

mean(X_sample + Y_sample)      # 3.000027            
var(X_sample + Y_sample)      #  5.006323          

#######################
# 포아송분포의 합의 분포
sample_size <- 1000000
X_sample <- rpois(sample_size, lambda = 3)
Y_sample <- rpois(sample_size, lambda = 4)

# 포아송분포의 합의 분포에 대한 평균과 분산
mean(X_sample + Y_sample) # 7.00037
var(X_sample + Y_sample) # 7.002941

########################
# 정규분포의 표본 평균의 분포

mean = 1
var = 2
n = 10

# 위 내용을 따르는 확률변수의 평균 100000
sample_size <- 100000

df<- data.frame('A'= rnorm(n, mean, sqrt(var)))

for( i in 1 : (sample_size-1)) {
  df2 <- data.frame('A'= rnorm(n, mean, sqrt(var)))
  df <- cbind(df, df2)
} 

dim(df)
sample_mean <- apply(df, 2, mean)
length(sample_mean)
mean(sample_mean)
var(sample_mean)
var/n



















