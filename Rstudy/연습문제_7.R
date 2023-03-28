# reshape2 연습문제
library(reshape2)
baseball <- read.csv("data/baseball.csv")

# month를 기준으로 long-> wide
baseball_wide <- dcast(baseball, month~pytpe)
View(baseball_wide)


emp_wide <- read.csv('data/2000-2013년 연령별실업율_연령별평균.csv')
# wide->long 변경
# melt(data, 기준열)
emp_melt1 <- melt(emp_wide,
                  id.var='연령별',
                  variale.name='년도',
                  value.name='실업율')
View(emp_melt1)

# long-> wide 변경
emp_dcast <- dcast(emp_melt1, 년도~연령별)
View(emp_dcast)

# cars93 데이터 활용
library(MASS)
View(Cars93)

car_wide <- subset(Cars93,
                   select = c(Type, Origin, MPG.city, MPG.highway),
                   subset = (Type %in% c('Compact', 'Van')))
View(car_wide)
dim(car_wide)

# melt() 사용해서 wide-> long형 변환
car_melt <- melt(car_wide,
                 id.vars = c("Type","Origin"),
                 measure.vars = "MPG.city")
View(car_melt)









