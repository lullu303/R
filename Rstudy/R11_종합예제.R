# 복지 패널 데이터
# .sav 파일(spss 통계 프로그램 파일)
# 관련 패키지('foreign')

library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)


# spss 읽어오기(read.spss(file='파일명', to.data.frame=T))
raw_welfare <- read.spss(file='data/Koweps_hpc10_2015_beta1.sav',
                         to.data.frame = T)
dim(raw_welfare)

# 복사본 생성
welfare <- raw_welfare

# 원데이터 확인
View(head(welfare))
View(tail(welfare))
str(welfare)
summary(welfare)

####################
# 대규모 데이터여서 변수가 많고
# 변수명이 코드로 되어 있어서
# 전체 데이터 구조를 한눈에 파악하기 어려움
###################

##################

# 성별 / 급여/나이/직업/종교/결혼여부/지역

# 급여는 성별에 따라 차이가 있나?
# 급여는 나이에 따라 차이가 있나?
# 성별과 나이에 따른 급여차이가 있나?

# 직업에 따른 급여차이 있나?
# 지역에 따른 급여 차이 있나?

# 종교가 결혼유무와 관계가 있는지?
# 종교가 이혼에 영향을 미치는지?
# 연령대별 이혼율

# 지역별로 연령대 비율

# 성별, 나이, 급여, 종교, 직업, 지역
# h10_g3 : sex
# h10_g4 : birth
# h10_g10 : marriage
# h10_g11 : religion
# h10_eco9 : code_job
# p1002_8aq1 : income
# h10_reg7 : code_region

welfare = rename(welfare,
                 sex=h10_g3,
                 birth=h10_g4,
                 marriage=h10_g10,
                 religion=h10_g11,
                 income = p1002_8aq1,
                 code_job = h10_eco9 ,
                 code_region = h10_reg7)
welfare$income
welfare$code_job

# 1. 성별에 따른 월급 차이
# 1) 변수 검토 후 전처리
# - 성별 이상치 : 9
# - 급여 : 1 ~ 9998 / 9999(이상치)
# 2) 변수 간 관계 분석
# - 성별에 따른 월급의 평균을 계산 후 시각화

# 1. 성별 변수 : 1,2 값을 갖는 범주형 변수
class(welfare$sex) # [1] "numeric" => 연속형 변수
# 이상치 확인 - 1/2 외에 다른 값 없음(이상치 없음)
table(welfare$sex)

# tip. 이상치가 있다면 일단 NA로 변환하고 제거
welfare$sex <- ifelse(welfare$sex ==9, NA , welfare$sex)

# 결측치 확인 - 결측치 없음
table(is.na(welfare$sex))
# FALSE 
# 16664 

# 성별항목값을 변경 : 1 -> male, 2 -> female
welfare$sex <- ifelse(welfare$sex == 1, 'male', 'female')
table(welfare$sex)

# 
ggplot(data=welfare, aes(x=sex)) +
  geom_bar()

qplot(welfare$sex)

# --------------------------
# 2. 급여 변수
# 일한 달의 월평균 임금, 단위 : 만원
class(welfare$income) # [1] "numeric"
summary(welfare$income)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#     0.0   122.0   192.5   241.6   316.6  2400.0   12030 
# 평균이 중앙값보다 높에 형성되어 있고, 
# 전반적인 급여는 평균급여보다 낮은 분포를 보일 것.
# 결측치가 있다. - 다른 데이터를 사용해야 하므로 결측치를 유지
# 최소값 0과 9999 는 이상치로 보고 - 결측처리
qplot(welfare$income) + xlim(0,1000)

# 이상치 처리
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA,
                         welfare$income)

# 결측치 확인 - 급여 특성 상 결측치가 많을 수 밖에 없으므로 제거하지 않고 유지
# 계산 시 결측 제외시키고 계산
table(is.na(welfare$income))
# FALSE  TRUE 
# 4620 12044

# 성별에 따른 급여 차이 확인
s_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

# 그래프 차이 확인
ggplot(s_income, aes(sex, mean_income)) +
  geom_col()
# 남성의 급여 평균이 여성의 급여 평균에 비해 두 배 정도 차이가 있다.

#######################################
# 2. 나이와 급여와의 관계
# 필요 변수 : 급여, 나이
# 나이데이터는 없고 생년 변수만 있음
# 태어난 연도를 이용 가공 변수 생성
class(welfare$birth)

# 이상치 : 1900-2014, 모름/무응답 : 9999
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
# 결측치 : 
table(is.na(welfare$birth))

# age 변수 생성
# 2015년도에 조사가 진행됨. 기준: 2015년
welfare$age <- 2015-welfare$birth +1 
summary(welfare$age)

# 나이와 월급 관계
a_income <- welfare %>%  
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(m_income=mean(income))
# table(welfare$age)

ggplot(data=a_income,
       aes(age, m_income)) + geom_line()
# 40-50대 무렵에 가장 많은 월급을 받고 지속적으로 감소
# 70대 이후는 20대보다 낮은 월급을 받는다. 

#############################
# 연령대에 따른 월급차이
# 변수 : 연령대, 급여 
# 연령대별 급여 평균 관계 확인

# 연령대(ageg) : 초(young), 중(middle) 30-59, 노년(old)

welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "young", 
                       ifelse(age <= 59, "middle","old")))
table(welfare$ageg)
# middle    old  young 
# 6049   6281   4334 

qplot(welfare$ageg)

# 연령대별과 급여와의 관계
a_income <- welfare %>%  
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(m_income=mean(income))

a_income
# ageg   m_income
# <chr>     <dbl>
# 1 middle     282.
# 2 old        125.
# 3 young      164.

# 시각화
ggplot(a_income, aes(ageg, m_income)) +
  geom_col() + 
  scale_x_discrete(limits=c("young", "middle", "old"))

##########################################################





