#5장 데이터 분석 - 5장 내용(데이터 분석하고 가시화 하기)
exam <- read.csv("csv_exam.csv") 
head(exam)      # 앞에서부터 6 행까지 출력
head(exam, 10)  # 앞에서부터 10 행까지 출력
tail(exam)      # 뒤에서부터 6 행까지 출력
tail(exam, 10)  # 뒤에서부터 10 행까지 출력
View(exam) 
dim(exam)  # 행 , 열 출력
str(exam)  # 데이터 속성 확인
summary(exam)  # 요약통계량 출 력


# ggplo2 의 mpg 데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg) 

#2. 데이터 수정하기 - 변수명 바꾸기 
#dplyr 패키지 설치 & 로드 
install.packages("dplyr")  # dplyr 설치
library(dplyr)             # dplyr 로드
df_raw <- data.frame(var1 = c(1, 2, 1),                      
                     var2 = c(2, 3, 2)) df_raw 
#1. 데이터 프레임 복사본 만들기 
df_new <- df_raw  # 복사본 생성
df_new            # 출력
#2. 변수명 바꾸기 
df_new <- rename(df_new, v2 = var2)  # var2 를 v2 로 수정
df_new
#변수 조합해 파생변수 만들기 
#데이터 프레임 생성 
df <- data.frame(var1 = c(4, 3, 8),                  
                 var2 = c(2, 6, 1)) df 
파생변수 생성 
df$var_sum <- df$var1 + df$var2  # var_sum 파생변수 생성
df
파생변수 생성 
df$var_mean <- (df$var1 + df$var2)/2  # var_mean 파생변수 생성
df 
## 1.기준값 정하기 
summary(mpg$total)  # 요약 통계량 산출

##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  ##   10.50   15.50   20.50   20.15   23.50   39.50 
hist(mpg$total)     # 히스토그램 생성
# 20 이상이면 pass, 그렇지 않으면 fail 부여
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail") 
# 1. 데이터 준비 , 패키지 준비
mpg <- as.data.frame(ggplot2::mpg)  # 데이터 불러오기
library(dplyr)                      # dplyr 로드
library(ggplot2)                    # ggplot2 로드


# 2. 데이터 파악
head(mpg)     # Raw 데이터 앞부분
tail(mpg)     # Raw 데이터 뒷부분
View(mpg)     # Raw 데이터 뷰어 창에서 확인
dim(mpg)      # 차원
str(mpg)      # 속성
summary(mpg)  # 요약 통계량
# 3. 변수명 수정
mpg <- rename(mpg, company = manufacturer) 

# 4. 파생변수 생성
mpg$total <- (mpg$cty + mpg$hwy)/2                   # 변수 조합
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")  # 조건문 활용


# 5. 빈도 확인
table(mpg$test)  # 빈도표 출력
qplot(mpg$test)  # 막대 그래프 생성



