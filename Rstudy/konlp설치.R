# KoNLP 패키지 설치
install.packages("KoNLP")
install.packages("multilinguer")
library(multilinguer)
# java 설치
install_jdk()

# KoNLP 패키지 종속 패키지 설치
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")

# 깃소스 설치 위한 시스템 패키지(devtools와 같이 사용) 
install.packages("remotes")

##remotes와 devtools 기능을 이용해서
#git_hub 소스코드를 설치하는 문장
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
######################################################################
# KoNLP 설치 확인
library(KoNLP)
# Checking user defined dictionary!

# 사전사용(사전설치)
useSejongDic()
