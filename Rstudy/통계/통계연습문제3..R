# 각 회사에 대한 x의 확률분포
a_set <- c(500,100,-100)
a_prob <- c(0.1, 0.3, 0.6)
data.frame(comp='A사',a_set, a_prob)

b_set <- c(300,100,-100)
b_prob <- c(0.2, 0.4, 0.4)
data.frame(comp='B사', b_set, b_prob)

c_set <- c(600,0,-100)
c_prob <- c(0.1,0.7,0.2)
data.frame(comp='C사', c_set, c_prob)

# 각 회사에 대한 x의 기대값을 구하라
# 가장 높은 기대 수익을 갖는 투자는 어느 회사인가?
a_ex <- sum(a_set * a_prob)
a_ex # [1] 20

b_ex <- sum(b_set * b_prob)
b_ex # [1] 60

c_ex <- sum(c_set * c_prob)
c_ex # [1] 40

res_ex <- c(a_ex, b_ex, c_ex)
names(res_ex) <- c("A사", "B사", "C사")
res_ex # 가장 높은 기대수익 : B사

# 가장 안전한 투자와 가장 위험한 투자는 어느 회사인가?
# 안전함 - 손해볼 확률이 낮은 투자
# 가장 안전 : C사, 가장 위험 : A사









