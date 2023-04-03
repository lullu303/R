# KoNLP : 한글 명사 분석에 사용하는 패키지
# 자연어처리라는 것은 문장에 포함되어 있는 의미를 찾아보자임
# 각 나라 언어에 맞는 형태소 분할이 필요함
# KoNLP를 활용해서 명사를 추출하는 작업을 진행함
# install.packages(KoNLP)
library(KoNLP)
useSejongDic()

# install.packages('wordcloud')
library(wordcloud)

# -----------------------------------------------
# 텍스트마이닝 :
# 문자로 구성된 데이터에서 가치있는 정보를 추출해내는 분석 기법
# KoNLP는 한글 문장에서 명사를 추출할 때 사용하는 패키지
# 명사추출은 SejongDic을 근거로 함
# D:\R-4.2.3\library\KoNLP_dic\current 에 있음

install.packages(".../path/to/package.tar.gz", type="source", repos=NULL)
####################################################
# 명사 추출 : KoNLP의 extractNoun() 사용

v1 <- "봄이 지나면 여름이고 여름이 지나면 가을입니다. 그리고 겨울이죠"
extractNoun(v1)

# 띄어쓰기가 잘못되어 있는 문장
v2 <- "봄이지나 면여름이고 여름이지나면가을입니다."
extractNoun(v2)

############################
# 간단한 실습
test_data <- readLines('data/test1.txt')
test_data # 벡터형

# 명사추출
extractNoun(test_data)
# 반환 타입 : list형

# 벡터로 변환해서 그다음 연산 실행
unlist(extractNoun(test_data))

# unlist(sapply(test_data, extractNoun, USE.NAMES = T))

#############################################
# 불필요한 단어 제거 : gsub() 함수 사용

word_list <- c("창업", "학생", "운영", "회사", "운영", "학교")
length(word_list)

word_list1 <- gsub("운영","",word_list)
length(word_list1) # 불필요한 단어 삭제하는 것이 아닌 다른 단어("")로 대체함
word_list1

# 제거한 단어요소 삭제하기
write(word_list1, 'temp_word.txt')

#
word_list2 <- read.table("temp_word.txt")
word_list2

# 
# gsub제거시 제거 단어가 파일에 있으면
# 반복문으로 한번에 제거 
word_list <- c("창업", "학생", "운영", "회사", "운영", "학교", "친구")

# 제거한 단어가 들어있는 파일
my_list <- readLines("data/my_list.txt")
my_list

for ( i in 1 : length(my_list)) {
  word_list<- gsub(my_list[i], "", word_list)
}

write(word_list, 'temp_word.txt')
read.table('temp_word.txt')


# ------------------------------------------------------------
# greep(패턴, 문자열) : 특정 텍스트를 검색한 결과 반환
# 반환결과 : value=T/F에 따라 패턴이 나타나는 문자열 위치 반환(F)
# 패턴이 포함된 문자열을 반환(T)

st <- c('word_list',123,'my list8910',567,'word') # 모두 문자열 처리
st

grep("my",st) # 3

# integer(0) 반환값이면 문자열에서 패턴을 못찾았음
grep('abc',st)

# [1] 여러개를 찾으면 각 위치 반환
grep("list",st) # [1] 1 3

# [1-1] value= 파라미터에 따라 패턴이 포함되어 있는 문자열을 반환
grep("list",st, value=T)

# [2] 대소문자 구분
grep("Word",st) # integer(0)

# [2-1] 대소문자 구분없이 찾으려고하면 ignore.cast=T 설정
grep("Word", st, ignore.case = T, value = T) # [1] "word_list" "word"  

# [3] 정규식: \\d   (숫자)
grep("\\d", st, value=T) # [1] "123"         "my list8910" "567" 

# [3-1] 정규식 : \\D  (숫자가 아닌 패턴의 요소를 찾음)
grep("\\D", st, value=T) # [1] "word_list"   "my list8910" "word"

#####################################
# 게시판 크롤링 자료를 이용한 워드클라우드 그리기
library(KoNLP)
library(wordcloud)

# 사전 설정
useSejongDic()

#
data1 <- readLines('data/seoul_new.txt')

# 수집된 문장에서 명사 추출
data_Noun_list <- extractNoun(data1)
data_Noun_list

# 전체 list item을 하나의 데이터로 처리하기 위해 벡터 변환
data_temp_Noun <- unlist(data_Noun_list)

# write(data_temp_Noun, "temp.txt")

# 불필요한 단어 제거 : gsub() - \\d+ 숫자가 여러번 반복되는 패턴
data_temp_num <- sub("\\d+","",data_temp_Noun)
data_temp_num <- sub("-","",data_temp_Noun)

# 서울시장 민원 게시판
# 서울시, 서울, 시장, 시장님, 요청, 제안
data_temp_Noun <- gsub("서울시", "", data_temp_Noun)
data_temp_Noun <- gsub("서울", "", data_temp_Noun)
data_temp_Noun <- gsub("시장", "", data_temp_Noun)
data_temp_Noun <- gsub("시장님", "", data_temp_Noun)
data_temp_Noun <- gsub("요청", "", data_temp_Noun)
data_temp_Noun <- gsub("제안", "", data_temp_Noun)


# "" 문자열 제거
write(data_temp_Noun, 'seoul_2.txt')

data_seoul <- read.table('seoul_2.txt')
class(data_seoul)
View(data_seoul)

# table() 단어별 빈도 계산
wordcount <- table(data_seoul)
View(sort(wordcount, decreasing=T))

####
# 불필요한 단어 제거 (빈도확인 후 작업)
data_temp_Noun <- gsub("OO", "", data_temp_Noun)
data_temp_Noun <- gsub("님", "", data_temp_Noun)
data_temp_Noun <- gsub("한", "", data_temp_Noun)
data_temp_Noun <- gsub("관련", "", data_temp_Noun)

########################
write(data_temp_Noun, 'seoul_3.txt')
data_seoul <- read.table('seoul_3.txt')

##############################################
# wordcloud 그리기
library(RColorBrewer)

# 패키지에 내장된 모든 파레트 색상 출력
display.brewer.all(n=10, exact.n = FALSE)

View(brewer.pal.info)

# 색상 세트 반환
brewer.pal(9,"Set3")

###################################
# 워드클라우드 그리기
class(wordcount)
View(wordcount)

names(wordcount) # 정리한 단어
wordcount # 단어의 빈도수 저장

# wordcloud(출력할 단어,
#           freq=출력할 단어의 빈도수,
#           scale=c(최대크기, 최소크기),
#           rot.per= 회전 단어 비율,
#           min.freq= 최소빈도수,
#           random.order=T/F 출력 순서의 임의지정 여부,
#           random.color=T/F 색상정보의 색상 임의 지정 여부,
#           color=색상정보)

palete <- brewer.pal(9,"Set3")

wordcloud(name(wordcount),
          freq=wordcount,
          scale=c(5, 1),
          rot.per= 0.25,
          min.freq= 2,
          random.order= F ,
          random.color=T,
          color= palete)

#################################################################
useNIADic() # 대량의 단어를포함하고 있음
install.packages("wordcloud2")
library(wordcloud2)

word_data <- readLines("data/애국가(가사).txt")
word_data

# 명사 추출
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2

# 리스트 -> 벡터
undata <- unlist(word_data2)
undata

# 단어가 2글자 이상인 것만 추출
undata2 <- Filter(function(x){nchar(x) >2},undata)
word_table2 <- table(undata2)
word_table2

undata2 <- gsub('공활한데', '공화', undata2)
word_table2 <- table(undata2)


#####################################################
# 기본형 워드클라우드 생성하기
wordcloud2(word_table2)

# 배경 등 색상 설정하기
wordcloud2(word_table2,
           color='random-light',
           backgroundColor = 'black')



