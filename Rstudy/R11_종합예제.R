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
welfare$birth
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

welfare$ageg <- ifelse(welfare$age < 30, "young", 
                  ifelse(welfare$age <= 59, "middle","old"))

table(welfare$ageg)
# middle    old  young 
# 6049   6281   4334 

qplot(welfare$ageg)

# 연령대별과 급여와의 관계 - 연령대별 급여평균의 차이
a_income <- welfare %>%  # 관측한 데이터에서 
  filter(!is.na(income)) %>%  # 급여를 받는 사람만 추출
  group_by(ageg) %>% # 연령대별로 분류한 후에
  summarise(m_income=mean(income)) # 분류된 데이터의 급여 평균을 구함 

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
# 연령대 및 성별에 따른 평균 급여차이
# 변수 : 급여(income), 성별(sex), 연령대(ageg)
# 변수간 관계 : 급여의 평균/그래프시각화 

# 급여에 결측치(NA)가 많으므로 NA가 아닌 데이터만 추출
ageg_sex <- welfare %>% 
  filter(!is.na(income)) %>%  #급여데이터가 있는 관측치 추출
  group_by(ageg,sex) %>%  # 연령대별 및 성별로 분류
  summarise(mean_income = mean(income), .groups='drop_last') # 그룹의 평균
# `summarise()` has grouped output by 'ageg'. You can override using the
# `.groups` argument.
??summarise

# 그래프 작성
ggplot(ageg_sex, aes(x=ageg,  y=mean_income, fill=sex)) +
  geom_col(position='dodge') +
  scale_x_discrete(limits=c("young", "middle", "old"))

# 연령대 및 성별 월급 차이는 연령대별로 차이가 보임
# 초년에는 성별에 따른 급여차이가 크지 않다가
# 중년에 크게 벌어지고 노년에는 성별차이가 줄어들기는 하지만
# 여전히 차이를 보이고 있다


# 4. 나이별 성별 월급 차이 확인
age_s_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% # 동일나이는 같은 그룹
  summarise(mean_income=mean(income))

head(age_s_income)

# 그래프 확인
ggplot(age_s_income,
       aes(x=age, y=mean_income, col=sex)) +
  geom_line()

# 남성은 50세 전후까지 급여가 지속적으로 증가하다
# 급속하게 감소
# 여성은 30세까지 상승하다가 그 이후 지속적으로
# 완만하게 감소하고 있음
# 성별 급여 격차

##############################################
# 5. 직업별 급여 차이
# code_job 컬럼 : 직업코드 
class(welfare$code_job)
table(welfare$code_job)

# 전처리
# 직업분류코드목록을 이용해 직업코드에 대해 직업명으로 변경된 변수 생성 
list_job <- read_excel('data/Koweps_Codebook.xlsx', sheet=2)
head(list_job)
dim(list_job)

welfare <- left_join(welfare,list_job, by='code_job')
welfare %>% select(h10_id,code_job,job)

# 직업코드에 대한 직업명 결합 완료

# 직업별 월급 평균표 생성
welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>%  # 직업과 급여정보를 모두 갖고있는 행 추출
  group_by(job) %>% # 직업명칭별로 그룹
  summarise(mean_income = mean(income)) # 그룹의 급여 평균

dim(job_income) # 142개의 직업 그룹의 급여 평균

# 어떤 직업의 급여 평균이 높은지
job_income %>% 
  arrange(desc(mean_income)) %>% 
head(10)


# 어떤 직업의 급여 평균이 낮은 
job_income %>% 
  arrange(mean_income) %>% 
head(10)





