setwd("../")
getwd()
# 데이터를 다루는 기초
# (1) "/Users/jihyepark/Desktop"
# 원시데이터 불러오기
exam <- read.csv("data/csv_exam.csv")
exam

#데이터를 파악할 떄 사용하는 함수들
# head() 함수 : 첫번쨰 데이터부터 설정된 데이터만큼 보여주는 함수

# 앞에서부터 6행 출력
head(exam)

# 원하는 만큼의 행 수 출력
# head(데이터세트, 출력행수)
head(exam,10)

# tail(데이터세트) 함수 : 입력된 마지막 데이터부터 6행을 출력
# tail(데이터세트, 출력행수)\
tail(exam)
tail(exam,2)

# 많은양의 전체 데이터를 시트에서 확인
# View(데이터세트) : 주의 V 대문자
View(exam)
View(head(exam,10))

# dim() : 데이터 세트의 전체 행/전체 열 수를 출력
dim(exam)
# [1] 20  5 : 행 열 벡터로 반환

# str(데이터세트) : 속성, 전체 행/렬 구성, 각 켤럼의 정보
str(exam)

# summary(데이터세트 ) 함수 : 데이터세트의 각 열별 요약통계량 산출 후 출력
# 컬럼 속성이 수치형인 경우만 산출
summary(exam)

#결과에 나온 id, class의 요약통계량은 무의미함
#수학점수 평균 : 57.45인 반면에 중간값은 54.00
# 수학점수는 54점을 중심으로 45.75~75.75 사이에 몰려 ㅇㅣㅆㄷㅏ.my

# (2) 변수명 변경
# names(), colnames() R 내장 함수 사용
# test 데이터
df_raw <- data.frame(var1=c(1,2,1),
                     var2=c(2,3,2))

# 원본 원시데이터는 보관하는 것이 좋다
# 원본 보관하는 이유
#작업 중 오류가 발생하더라도 원상태로 복귀 가능
# 원시데이터와 비교하면서 변형되는 과정을 검토할 수 있음

df_new <- df_raw

# 변수명 변경
names(df_new) <- c("a", "b")
colnames(df_new) <- c("n1", "n2")
df_new

# 전체 변수명을 변경할 때 주로 사용
# dplyr 패키지 : 데이터 가공 및 ㅊ출과 관련된 여러 함수를 갖고 있다
# rename(데이터변수명, 새변수명1=기존변수명1) df의 일부 변수명을 수정할 수 있다.
# df의 원본을 변경하지는 않는다.
# 주의! 변수명 순서가 바뀌면 에러 새변수명1=기존변수명1

# install.packages("dplyr")
library(dplyr)

exam_test <- exam
head(exam_test,1)
exam_test <- rename(exam_test,no=id)
head(exam_test,1)


#######################################
# 파생변수 생성하기
# 수집된 변수를 활용하여추가로 생성하는 변수
# 데이터 연산 방식 : 총점, 평균
# 변수 변환 방식 : 평점
#######################################
 ddd
# 데이터프레임에 대한 사칙연산
# 열 + 열 -> 열의 각 행 요소들끼리 연산
exam
exam$math + exam$english #각열의 같은 행들끼리 연산 진행

df_raw <- data.frame(var1=c(1,2,1),
                     var2=c(2,3,2))
# 파생변수 생성
df <- df_raw
df$var1 + df$var2
#df에 추가
df$var_sum <- df$var1 + df$var2
df

df$var_mean <- df$var_sum/2

df

# 조건문을 활용해 파생변수 만들기
# result 파생변수 : var_mean이 2이상이면 pass, 미만이면 fail
df$result <- ifelse(df$var_mean >=2, "pass", "fail")

# exam df에 대하여 학새별 모든 과목의 총점, 평균,
# 평균을 비교하여 60이상이면 합격 아니면 불합격을
# result 변수를 추가하시오

exam_tot <- exam
# sum() 사용 : 다른 결과가 나옴
exam_tot$total <- sum(exam_tot$math, exam_tot$english, exam_tot$science)
exam_tot


exam_tot$total <- exam_tot$math + exam_tot$english + exam_tot$science
exam_tot

exam_tot$mean <- exam_tot$total/3
exam_tot

exam_tot$result <- ifelse(exam_tot$mean >= 60, "합격", "불합격")
head(exam_tot)

########################################
# dplyr 패키지를 사용한 데이터 전처리
# dplyr 패키지 : 전처리 작업에 가장 많이 사용되는 패키지 

head(exam)

# filter(df, 조건) : 조건에 맞는 행 추출

# 1반 학생들 정보를 조회
filter(exam, class==1)

# %>% : 파이프 연산 (ctrl + shift + m) %>% 
# 앞 연산의 결과값을 뒤에 따라오는 연산을 입력값으로 전달
exam %>% filter(calss==1) %>% select(math)

# 1반 학생들의 점수 정보
exam %>% filter(class==1)

# 1번이 아닌 학생들이 점수 정보
exam %>% filter(class != 1)

# 수학 점수가 50을 초과하는 학생 정보
exam %>% filter(math>50)

# 1반학생들 중 수학 점수가 60점 이상인 학생 정보
exam %>% filter(class==1 & math > 60)

# 수학점수가 90점 이상 이거나 영어점수가 90점 이상인 학생 정보
exam %>% filter(math >= 90 | english >=90)

# 1,3,5 반 학생 정보 추출
exam %>% filter(class ==1 | class ==3 | class ==5)
# 또는 
exam %>% filter(class %in% c(1,3,5))

#1반 학생들의 정보를 저장하는 변수 class1을 생성
class1 <- exam %>% filter(class==1)
mean(class1$english) # 1반 학생들의 영어 평균

# select() 함수 : 열(변수) 추출
# select(df, 변수명1, 변수명2, ... , 변수명n)
# 제외조건 : (- 기호 )
exam

# 변수명 확인
names(exam)

# 학생 id와 영어점수 조회
select(exam, id, english)
exam %>% select(id, english)

#영어점수를 제외한 데이터 조회
exam %>% select(-english)

#수학, 영어점수를 제외한 데이터 조회
exam %>% select(-math, -english)

# 1반 학생들의 과학 점수 조회(filter, select 함수를 연결해서 사용)
exam %>% filter(class==1) %>% select(science)

# 여러 행으로 코드 작성 가능
exam %>% # %>% -> 이전 수식과 연결되어 있어야 한다.
  filter(class==1) %>% 
  select(english)

# 필요한 만큼 함수연산은 확장 가능
exam %>% filter(class %in% c(1,5)) %>% 
  select(class,math,english) %>% 
  head(3)

exam %>% filter(class %in% c(1,5)) %>% 
  select(class,math,english) %>% 
  tail(5)

# arrange(데이터세트, 기준열) : 데이터 정렬(오름차순) 
# arrange(데이터세트, desc(기준열) : 데이터 정렬(내림차순) 

# 수학점수를 기준으로 오름차순 정렬 후 조회 
arrange(exam, math)

# 수학점수를 기준으로 내림차순 정렬 후 조회
exam %>% arrange(desc(math))

# 기준열의 값이 동일하면 2차 기준을 적용 
# 수학점수를 기준으로 내림차순 정렬 후, 
# 수학점수가 동일한 학생들은 영어점수가 높은 순으로 배치
exam %>% arrange(desc(math), desc(english))

# 파생변수 추가 함수
# mutate(데이터세트, 새로운 파생변수명=파생변수 생성식,
# 새로운 파생변수명2=파생변수 생성식2)
# 원본 데이터세트에 반영되지는 않는다. 저장해야 함

# 학생별 점수 총점 total변수 추가
exam %>% 
  mutate(total = math+english+science) %>% 
  head

# 학생별 점수 총점 total변수, 평균 mean 변수 추가
exam %>% 
  mutate(total = math+english+science,
         mean = total/3)%>% 
  head

# 학생별 점수 총점 total변수, 평균 mean, result 변수 추가
exam %>% 
  mutate(total = math+english+science,
         mean = total/3,
         result = ifelse(mean >=60, "합격", "불합격"))%>% 
  head

# 3과목의 점수를 합한 총점 total 변수를 추가하고
# total을 기준으로 오름차순 정렬 후 
# 최저 10명의 정보를 조회하시오
exam %>% 
  mutate(total = math+english+science) %>% 
  arrange(total) %>% 
  head(10)

# summarise() 함수 : 통계치 산출(집단함수를 사용하게 해주는 함수)
# 통계관련 함수를 사용할 수 있음 









