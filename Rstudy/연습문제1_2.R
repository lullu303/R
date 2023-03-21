n1 #double

#2.
n2 <- c(11:15)
n2 #integer

#3.
odd_nums <- seq(1,10, by=2)
odd_nums

#4.
seq(3,30)





# 여러 값을 한번에 출력하기 위해 cat() 함수 사용
cat("총점 : ", total, "/n 평균 : ", avg)

# print() 1개만 출력 가능
# print(total, avg)

vec_ex <- seq(1,10)

# 1번째부터 5번째
vec_ex[1:5]

# 1번째부터 5번째까지 데이터만 빼고 출력
vec_ex[-1:-5]

# 데이터 변경
vec_ex[3] <- 0

# 맨 앞에 추가
vec_ex <- append(vec_ex, 0, after=0)

#12번째에 11을 추가하고 출력
vec_ex <- append(vec_ex, 11, after=11)

#
vec_ex <- append(vec_ex, 14:20)

7 %in% vec_ex

# names(c(열이름, 열이름2))
vec_ex1 <- c(100,200,300)
names(vec_ex1) <- c('A', 'B', 'C')
vec_ex1

#
date = seq(as.Date("2020-01-01"),
           as.Date("2020-05-31"),
           by='month')
date

vec_ex2 <- c('봄','여름','가을','겨울')
vec_ex3 <- c('봄', '여름', '가을', '겨울')

setdiff(vec_ex2, vec_ex3)
setdiff(vec_ex3, vec_ex2)

#######################################
# 행렬 연습문제
seasons <- c("봄", "여름", "가을", "겨울")
season1 <- matrix(seasons, nrow=2)
matrix(seasons, nrow=2, byrow=T)

season1[,1]
season1[1,]
season1[1]

#행렬의 행과 열
rbind(season1, c("초봄", "초가을"))
cbind(season1, c("초봄", "초가을"))

#배열
array(seasons, dim=c(2,2))
test <- array(seasons, dim=c(2,2,2))
test[1,1,]
test[1,1,2]
test[,,2]

