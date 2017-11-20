# ------- 2017_10_23 R 기초 # 
# R 스튜디어 파일관리창 - file - 작업파일 클릭 - More(set as working directory 클릭)
# R 실행  source 창에서 실행 : 블럭 설정하고 ctrl+enter
# R console 창 클리어 : consol 창에서 ctrl+L
# 모든 변수제거 rm(list=ls()) 
# 패키지는 install.packages("패키지명"), 이후 활용시 library(패키지명)
install.packages("package_name") # 패키지 설치, GUI 방식으로 추천
library(package_name) # 패키지 이용시 실행, GUI 방식 즉package 내 네모박스 체크
vignette("package_name") # 패키지에 대한 간단한 설명을 pdf파일로 볼 수 있

# 작업 중간에 한글이 안써질 경우 : alt+tab 화면 변경 후, 재시도
file.create("file_name.R") # working directory에 R파일 생성
file.edit("file_name.R") # 파일 수정
source("file_name.R") # 파일에 저장한 코드를 실행하기 위해 해줌

# 계산된 결과물의 유효자릿수 지정
options(digits=7)
4/3
options(digits=10) # 일단 10자리로 지정 하고 목적에 맞게 변경한다.

# 기초 상식 end


# --------------------------------
# R은 학습용 블로그가 풍부하다.
# --------------------------------

# R  기본 셋 : http://blog.naver.com/PostView.nhn?blogId=sorwd2001&logNo=220575760129&parentCategoryNo=&categoryNo=&viewDate=&isShowPopularPosts=false&from=postView

# http://blog.naver.com/beyondanova/220947740863

# R 공공 자료처리 : http://blog.naver.com/liberty264/220627758839
# Word cloud site http://blog.naver.com/liberty264/220616866103

# http://blog.naver.com/beyondanova/220947740863
# http://blog.naver.com/sw4r/220947662194   꼭 읽어보기
# http://blog.naver.com/sw4r/220947636803
# 객체 - 1개 1개의 자료, 객체의 나열 - list  
# 객체의 자료구조 - 7가지(스칼러, 벡터, 행렬, 배열, 리스트, 팩터, 데이터프레임)   
# http://blog.naver.com/sw4r/220947706818

# 지그드시 blog
# http://blog.naver.com/liberty264/220999922431
# http://blog.naver.com/liberty264/220984298909  R 기초 
# http://blog.naver.com/liberty264/220992998669  R 통계

# 그래프 그리기 ggpplot2, lattice, qplot(), ggmap, 

# http://blog.naver.com/liberty264/221004390848 ggplot2 패키지  그래프 작성에 가장 많이 활용
# http://blog.naver.com/liberty264/221064041168 lattice패키지 활용 그래프 작성
# http://blog.naver.com/liberty264/221065202687 qplot() 패키지
# http://blog.naver.com/liberty264/221065408166 ggmap 패키지
# http://blog.naver.com/liberty264 3차원 산점도
# http://blog.naver.com/liberty264/221018193084 구글 chart
# http://blog.naver.com/liberty264/220982348293 Box plot
# http://blog.naver.com/liberty264/220751221418 그해픽 함수

# https://www.statmethods.net/   R 신속 학습

# R 학습용 블로그 풍부 end


# ---------------
# R의 내장 함수
# ---------------
# 내장함수로 자료 불러오기   패키지로 자료 불러오기  비교

# 1. 내장함수 활용 불러오기
# 자료 다운로드 : 깃허브(bit.ly/doit_ra) 접속 excel_exam.csv 다운로드 후 엑셀에서 열어보기 
# 또는 직접 주소 입력 https://github.com/youngwoos/Doit_R/tree/master/Data
# https://github.com/youngwoos/Doit_R/blob/master/Data/csv_exam.csv

# CSV 파일 : Comma seperated Values 
# CSV 파일은 엑셀, SAS, SPSS, R 등 데부분의 데이터 다루는 프로그램에서 사용 가능 
# 엑셀 .xlsx 파일 형식에 비해 용량이 간단하고 범용 임.

# 프로젝트 폴더에 CSV 파일 삽입하기 

exam <- read.csv("csv_exam.csv")  # 내장 함수로만 불러오기
exam

# 위 에제의 CSV 파일은 전부 숫자로 구성되어 있음 

# 만일 문자가 들어 있는 파일을 불러올 대는 stringsAsFactors = F로 설정해야 함.
# 그래야만 변수를 factor 타입이 아닌 문자타입으로 불러오며 오류가 발생안된다.

exam <- read.csv("csv_exam.csv", stringsAsFactors = F)  # 내장 함수로만 불러오기
exam


# 내장함수로 데이터 추출하기  내장함수는 대괄호 [] 안에 입력
exam[]  # 조건없이 전체 데이터 출력

exam[1,] # 1행 추출
exam[2,] # 2행 추출

exam[,1] # 1렬 추출

exam[3,3]  # 3행3렬 요소 추출

exam[exam$class == 1,]  # class가 1인 행렬 추출
exam[exam$math >= 80,]  # 수학점수가 80점 이상인 행 추출

exam[exam$class == 1 & exam$math >= 50,]  # 1반 이면서 수학점수가 50점 이상인 대상 추출

exam[exam$english < 90 | exam$science < 50,] # 영어검수가 90점 미만이거나 과학점수가 50점 미만 

data1 <- exam[exam$english < 90 | exam$science < 50,]  # 추출 결과를 변수로 대체
data1

# 변수명으로 변수 추출
exam[,"class"]  # class 변수 추출
exam[,"math"]   # math  변수 추출

# []내부에 c() 이용시, 더 많은 변수 추출이 가능
exam[,c("class", "math", "english")]  #  class, math, english 변수 추출

exam[exam$math >=50, c("math", "english")]  # 행 부등호 조건, 열 변수명


## 내장함수 활용과 dplyr 패키지 활용 간의 차이 : dplyr(가독성 우수, 이해도 쉽다.)
# 수학점수 50점이상, 영어점수 80점 이상인 학생들을 대상으로 각 반의 전과목 평균을 구하시오.
options(digits=5)  # 유효숫자 지정
# 1. 내장함수 적용 시 코드     aggregate() : 범주별 요약 통계량을 구하는 R 내장 함수
exam$tot <- (exam$math + exam$english + exam$science)/3
exam$tot
aggregate(data=exam[exam$math >=50 & exam$english >= 80,], tot~class, mean)

# 2. dplyr 적용 시 코드
install.packages(dplyr)
library(dplyr)

exam %>%
  filter(math >= 50 & english >= 80) %>%
  mutate(tot = (math + english + science)/3) %>% 
  group_by(class) %>% 
  summarise(mean = mean(tot))

# R의 내장 함수  end


# 2. 외부 데이터를 패키지를 이용하여 불러오기
# 자료 다운로드 : 깃허브(bit.ly/doit_ra) 접속 excel_exam.xlsx 다운로드 후 엑셀에서 열어보기 
install.packages("readxl")  # l 아파벳트 엘
library(readxl)

df_exam <- read_excel("excel_exam.xlsx")
df_exam

dim(df_exam) # 구성 행렬 크기 
str(df_exam) # 데이터 속성 확인
head(df_exam) # 데이터의 일부만 출력 

head(df_exam, 10) # 데이터 프레임의 경우 ", 숫자" 지정하여 일부 표현 가능
tail(df_exam) # 데이터 뒷부분 확인하기
tail(df_exam, 3) # 데이터 뒷부분 중, 원하는 줄만큼 확인 가능

View(df_exam) # 엑셀과 유사한 창으로 자료를 보여줌
summary(df_exam) #요약된 통계량 표시

mean(df_exam$english)
var(df_exam$english)
sd(df_exam$english)
# 엑셀 파일 첫번째 행이 변수명이 아닐 경우 ?
# read_excel()은 기본적으로 찻번째 행을 변수명으로 인식합니다. 
# 에제 다운로드 : 깃허브(bit.ly/doit_ra) 접속 excel_exam_novar.xlsx 다운로드 후 엑셀에서 열어보기  

df_exam_novar <- read_excel("excel_exam_novar.xlsx")
df_exam_novar

View(df_exam_novar) # 엑셀과 유사한 창으로 자료를 보여줌

# 이 경우에는 col_names = F 파라미터를 설정하면 첫번째 행을 변수명이 아닌 데이터로 인식한다.
# F는 거짓임을 나타내는 논리형 벡터  즉, 열이름을 가져올 것인가에 아니오라고 답한 셈
# 이때 변수명은 "X__숫자"로 자동 저장된다. F 는 대문자 입력 필수   논리형벡터는 모두 대문자

df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar

mean(df_exam$english)
var(df_exam$english)
sd(df_exam$english)

# -------------------------------------------------------------------------------------------------------
install.packages("readxl")  # l 아파벳트 엘
library(readxl)

##### 10월 30일 시작 지점
# 엑셀 파일에 여러점개의 시트가 있다면 ?
# 에제 다운로드 : 깃허브(bit.ly/doit_ra) 접속 excel_exam_sheet.xlsx 다운로드 후 엑셀에서 열어보기  
df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
View(df_exam_sheet)

df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 4)  # sheet 순서가 중요
View(df_exam_sheet)
options(digits=7)
data.frame(df_exam_sheet) # 데이터 전체 출력하기

# 데이터 파악하기 
# 데이터를 파악할 때 사용하는 함수와 기능
# 함수        기능
head(df_exam_sheet)    #  데이터 앞부분 출력 
tail(df_exam_sheet)    #  데이터 뒷부분 출력
View(df_exam_sheet)    #  뷰어창에서 데이터 확인
dim(df_exam_sheet)     #  데이터 차원 출력
str(df_exam_sheet)     #  데이터 속성 출력
summary(df_exam_sheet) #  요약 통계량 출력

# 배포된 csv_exam.csv 파일을 불러온다.
exam <- read.csv("csv_exam.csv") # 자료일어오기

data.frame(exam) # 데이터 전체출력
head(exam) # 데이터의 일부만 출력 
head(exam, 10) # 데이터 프레임의 경우 ", 숫자" 지정하여 일부 표현 가능
tail(exam) # 데이터 뒷부분 확인하기
tail(exam, 5) # 데이터 뒷부분 중, 원하는 줄만큼 확인 가능
View(exam) # 엑셀과 유사한 창으로 자료를 보여줌
dim(exam) # 구성 행렬 크기 
str(exam) # 데이터 속성 확인
summary(exam) #요약된 통계량 표시
# Min(최솟값), 1st Qu(1사분위수 ; 하위 25%지점에 위치하는 값), Meadian(중앙위치값), Mean(평균값), 
# 3rd Qu(하위 75%지점에 위치하는 값), Max(최댓값)


### 데이터 프레임을 CSV 파일로 저장하기 
# 1. 데이터 프레임 만들기
# 2. CSV 파일로 저장하기
# 3. R 전용 데이터 파일로 저장하기  .rdata   .rda

# 1. 데이터 프레임 만들기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50,60,100,20),
                         science = c(98,78,100,88),
                         class = c(1, 1, 2, 2))

df_midterm

# 2. CSV 파일로 저장하기
write.csv(df_midterm, file = "df_midterm.csv")    # 컴마 확인
write.csv(df_midterm, file = "df_lyc.csv")    # 컴마 확인
# 3. R 전용 데이터 파일로 저장하기 
save(df_midterm, file = "df_midterm.rda")
View(df_midterm.rda)
# Rdata 불러오기
rm(df_midterm)
df_midterm

load("df_midterm.rda")
df_midterm


#### read_excel("   .xlsx")     read.csv("      .csv")     load("    .rda")


# ---------------
# 변수 타입 
# ---------------
install.packages(dplyr)
library(dplyr)
# 변수 타입
# 연속변수 : 키, 몸무게, 소득 연속적이고 크기를 의미하는 값 - 가감승제 산술계산 가능  'numeric' 으로 표현
# 범주변수 : 대상을 분류하는 의미를 지니는 변수, 성별, 지역 등 - 산술계산 불가 'factor'로 표현

# 다양한 변수 타입
# Data type      의미          값 예제
# numeric        실수         1, 12.3
# integer        정수         1L, 23L
# complex        복소수       3+2i
# character      문자         "male", "123", "#Female#"
# logical        논리         TRUE, FALSE, T, F
# factor         범주         1, 2, a, b              대상을 분류하는 의미를 지니는 변수
# Date           날짜         "2017-10-23", "23/10/17"      


math <- c(30,20,50,20,56)   # numeric 변수
math

math+3

class(math) # 변수타입확인
levels(math) # factor 변수의 구성 범주 확인하기  Null로 나옴
mean(math) # 정상적으로 계산결과 출력

var2 <- factor(c(30,20,50,20,56))   # factor 변수  Level 이 붙는다.
var2

var2+3

class(var2) # 변수타입확인
levels(var2) # factor 변수의 구성 범주 확인하기 "" 로 나옴
mean(var2)  # 경고

# var2의 평균 계산을 원할 경우, 변수형을 바꾸어 진행 함.
var2 <- as.numeric(var2)

mean(var2)

class(var2)
levels(var2)  # Null로 나옴

# as.numeric(), as.factor(), as.character(), as.Date(), as.data.frame() 등으로 변환
# Data type : numeric(실수), integer(정수), complex(복소수), character(복소수),
#             character(문자), logical(논리  TRUE, FALSE, T, F), factor(범주)


# 문자로 구성된 factor 변수
var3 <- c("a", "b", "c")    # 문자변수 생성
var4 <- factor(c("a", "b", "c"))   # 문자로 된 factor 변수 생성

var3
class(var3)

var4  # level 표시 나옴
class(var4)

# 변수 타입 end



# ---------------
#  데이터 구조 #
# ---------------
# 벡터 : 1차원 : 한가지 변수 타입으로 구성
# 데이터 프레임 : 2차원 : 다양한 변수 타입으로 구성
# 매트릭스(matrix) : 2차원 : 한가지 변수 타입으로 구성
# 어레이(Array) : 다차원 : 2차원 이상의 매트릭스
# 리스트(list) : 다차원 : 서로 다른 데이터 구조 포함

# 1. 벡터
a <- 1
a
class(a)  # 데이터 구조 확인

b <- "Hello"
b
class(b)   # 데이터 구조 확인

# 2. 데이터 프레임
x1 <- data.frame(var1 = c(1,2,3),
                 var2 = c("a", "b", "c"))
x1
class(x1)


# 3. 매트릭스(matrix)
x2 <- matrix(c(1:12), ncol=2)

class(x2)


# 4. 어레이(Arrary)
x3 <- array(1:20, dim=c(2,5,2))
x3      # 2핼 5열이 2개
class(x3)

# 5. 리스트 (list)
x4 <- list(f1 = a,
           f2 = x1,
           f3 = x2,
           f4 = x3)
x4
class(x4)

install.packages("ggplot2") ; library(ggplot2)
mpg <- ggplot2 :: mpg
View(mpg)
class(mpg)
x <- boxplot(mpg$cty)
x


x$stats[,1]       # 요약 통계량
x$stats[,1][3]    # 중앙값 추출
x$stats[,1][2]    # 1분위수 추출
summary(x$stats)
str(x)
# 데이터 구조 학습 end ---------------------------------- 


# help ggplot2, mpg  

# ---------------------
#  박스 그림 Boxplot  #
# --------------------- 

# 측량 예제 : 두점 간의 거리 측정 -------(11번 측정 : 홀수 측정)
survey <- c(100.023, 101.014, 99.921, 100.011, 100.001, 99.987, 99.999, 99.823, 100.092, 99.876, 100.103,98.3)
boxplot(survey)
mean(survey)

# 이상치를 결측값으로 처리하기
survey <- ifelse(survey > 100.3 | survey < 99.0, NA, survey)
survey
mean(survey)

table(is.na(survey))

# 이제 결측치 제외하고 분석하기
mean(survey, na.rm = T)


## 이상치 제거하기 - 극단적인 값  상자그림(box plot)활용 검출 : 극단치 경계값을 +- 초과하는 객체
# 상자그림 설명
# 상자그림                값                  설명
# 상자아래 세로점선       아랫수염            하위 0-25% 내에 해당하는 값
# 상자밑면                1사분위수(Q1)       하위 25% 위치값
# 상자내 굵은 선          2사분위수(Q2)       하위 50% 위치값(중앙값)
# 상자윗면                3사분위수(Q3)       하위 75% 위치값
# 상자 위 세로 점선       윗수염              하위 75-100% 내에 해당하는 값
# 상자 밖 가로선          극단치 경계         Q1, Q3 밖 1.5 IQR 내 최댓값
# 상자 밖 점 표식         극단치              Q1, Q3 밖 1.5 IQR를 벅어난 값

# 1.5 IQR : 4분위 범위(Q1-Q3 간 거리)의 1.5배
### -------------------------------------------------------------------------- 11월 6일 수업할 차례 
boxplot(mpg$hwy)

boxplot(mpg$hwy)$stats
# 출력값 의미(위에서 아래 방향으로)
# 아래쪽 극단치 경계
# 1사 분위수
# 중앙값
# 3사분위수
# 위쪽 극단치 경계        #12-37 범위 이외값은 이상치

# Boxplor 학습 end


# --------------------------------------
# 새로운 작업 전 변수 초기화 작업 
rm(list=ls())  # 작업한 모든 변수 clear
ls()
objects()
# --------------------------------------


# -------------------------------------------------------------------
# ------- 2017_10_23 R 빅데이터 분석 기본기 익히기
# -------------------------------------------------------------------
# 데이터 분석 기초
# 데이터 파악용 함수 : head()  tail()  View()  dim()  str()  summary()

# 데이터 파악하기  
# 데이터를 파악할 때 사용하는 함수와 기능
# 함수        기능
# head()      데이터 앞부분 출력 
# tail()      데이터 뒷부분 출력
# View()      뷰어창에서 데이터 확인
# dim()       데이터 차원 출력
# str()       데이터 속성 출력
# summary()   요약 통계량 출력

# 배포된 csv_exam.csv 파일을 불러온다.
exam <- read.csv("csv_exam.csv") # 자료읽어오기

data.frame(exam) # 데이터 전체출력
head(exam) # 데이터의 일부만 출력 
head(exam, 10) # 데이터 프레임의 경우 ", 숫자" 지정하여 일부 표현 가능
tail(exam) # 데이터 뒷부분 확인하기
tail(exam, 5) # 데이터 뒷부분 중, 원하는 줄만큼 확인 가능
View(exam) # 엑셀과 유사한 창으로 자료를 보여줌
dim(exam) # 구성 행렬 크기 
str(exam) # 데이터 속성 확인
summary(exam) #요약된 통계량 표시
# Min(최솟값), 1st Qu(1사분위수 ; 하위 25%지점에 위치하는 값), Meadian(중앙위치값), Mean(평균값), 
# 3rd Qu(하위 75%지점에 위치하는 값), Max(최댓값)

### 빅데이터 분석 순서
# 1차 작업(자료분석) : 빅데이터 분석을 위한 1차 작업은 수집된 자료의 분석
#   자료구조파악, 결측치, 이상(과대오차)치 유무 파악
#      - NA 유무(처리방법 : 삭제, 무시, 평균값 대체 등)평)
#      - 이상치 : Boxplot 기능으로 과대오차 파악                  
#      - 가공된 Data 변수 이름 부여
# 2차 작업 : 필요한 자료 추출, 즉 가공작업
# 3차 작업 : 정량분석 - 가시화 도구
# 4차 작업 : 정성분석 - 신뢰성 평가(검정 등 통계처리)
#   기술통계 - 평균, 분산, 표준편차 등
#   추론통계 - 가설검정 : t검정, F검정, 상관분석 등)


# Tip ------------------------------------------------
rm(list=ls())  # 작업한 모든 변수 clear
ls()
objects()
# Tip end --------------------------------------------

# mpg 데이터의 구성을 파악해 봅시다. 
# qqplot2 그래프 작성 패키지를 설치해야 mpg 데이터를 mpg 변수로 불러올 수 있다.

# qqplot2 그래프 작성 패키지를 활용한 기본 연습 (그래프 작성용 패키지는 qqplot2 외에도 다양함)
# 패키지 자체에는 자신의 기능을 테스트 해볼 수 있는 다양한 예제 데이터가 있습니다. 
# 예) mpg : qqplot2 패키지 안에 제공된 미국환경보호국 공개자료 (1999 ~ 2008 기간의 자료)
# mpg : mile per gallon
# 각 함수에는 저마다의 기능을 세분하여 기능을 설정하는 세부 파라미터가 존재한다.
# 파라메터 설정을 변경해 보면서 qqplot2 패키지내 함수인 qplot()의 세부 기능을 체험해보자
# ?mpg : mpg 자료 설명

# 함수의 기능이 궁금할 대는 "?함수명" 으로 확인하세요.
?mpg  # 약어 이해   hwy - 자동차가 고속도로에서 1갤런에 몇 마일을 가는지 나타낸 변수

# manufacturer 제조회사   model 자동차 모델멸
# displ 배기량            year 생산년도
# cyl 실린더 개수         trans 변속기 종류
# drv 구동방식            cty 도시연비
# hwy 고속도로 년비       fl 연료타입       class 자동차 종류
 
data.frame(mpg) # 데이터 전체출력
head(mpg) # 데이터의 일부만 출력 
head(mpg, 10) # 데이터 프레임의 경우 ", 숫자" 지정하여 일부 표현 가능
tail(mpg) # 데이터 뒷부분 확인하기
tail(mpg, 5) # 데이터 뒷부분 중, 원하는 줄만큼 확인 가능
View(mpg) # 엑셀과 유사한 창으로 자료를 보여줌
dim(mpg) # 구성 행렬 크기 
str(mpg) # 데이터 속성 확인
summary(mpg) #요약된 통계량 표시


# Tip --------------------------------------------------------------------------
# 객체 - 1개 1개의 자료, 객체의 나열 - list  
# 객체의 자료구조 - 7가지(스칼러, 벡터, 행렬, 배열, 리스트, 팩터, 데이터프레임)
# list는 7가지 자료를 모두 포함할 수 있다.
# http://blog.naver.com/sw4r/220947706818
# Tip end ----------------------------------------------------------------------

# 자료를 파악했으면 필요한 자료의 이름을 쉽게 기억할 수 있는 이름(변수)으로 저장 - 변수명 바꾸기
# dplyr 패키지(데이터를 원하는 형태로 가공하는 툴)의 rename()을 이용해 변수명을 바꾸어 보자

df_raw <- data.frame(var1 = c(1,2,1),       #열(colume)요소로 배열
                     var2 = c(2,3,2))       # 자동으로 2번째 열(colume)요소로 배열
df_raw


install.packages("dplyr")  # 1. dplyr 패키지 설치 및 활성화
library(dplyr)

df_new <- df_raw   # 모든 자료는 원본은 보관하고 복사본을 만들어 가공한다.
df_new                

df_new <- rename(df_new, v2=var2) # 원자료의 변수이름 중, var2를 v2로 수정한다.
df_new

# 변수 확인해 보기
ls() ; objects()

df_new <- rename(df_new, v1=var1) # 원자료(df_new)의 변수이름 중, var1를 v1로 수정한다.
df_new

# 데이터 안의 변수를 활용하여 조합, 새변수 등 파생변수를 만들어 봅시다.
# 예 영어점수, 수학점수 이용해서 데이터 내부에 평균 이라는 새로운 변수, 즉 파생변수를 만들어 봅시다.

df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2 # df$var_sum - df데이터 내부에 새로운 변수 생성, $데이터 내부의 변수명
df

df$var_mean <- (df$var1 + df$var2)/2
df

# ------------------------------------------
# 자료가공 응용으로 다시 mpg를 불러와서 cty, hwy 조건에 대한 연비를 통합한 연비 변수를 말들어 봅시다.
mpg <- as.data.frame(ggplot2::mpg)

mpg$total <- (mpg$cty + mpg$hwy)/2 #  통합연비 변수(total)를 새로생성
mpg
head(mpg) # 자료 앞 부분 확인
str(mpg)  # 자료를 구성하는 변수들의 속성을 확인
summary(mpg) # 자료의 통계 요약량

mean(mpg$total)

options(digits=4)
mean(mpg$total)

# 조건에 따라 객체를 생성하는 파생변수 만들기
# mpg 자료에서 기준치를 중심으로 연비를 분석하여 합격, 불합격 부여

summary(mpg$total)  # total의 평균, 중앙값 확인
hist(mpg$total) # 자동차의 연비 빈도수의 분포 확인  대부분 25이하이고 이상은 많지 않다.

# total값이 20를 넘기면 합격, 이하면 불합격으로 분류한 조건파생변수를 만들어 보자

mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")  
#                 조건(문)         적합시 부적합시 "" 출력내용
head(mpg, 20)
table(mpg$test) # 연비 합격 빈도표 생성
qplot(mpg$test)

# 중첩 조건문 활용하기

# total이 30이상이면 A, 20-29는 B, 20미만이면 C로 분류해 보자
mpg$grade <- ifelse(mpg$total >= 30, "A", 
                    ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 20)
table(mpg$grade)   # 등급 빈도표 생성
qplot(mpg$grade)

# ifelse()를 더 중첩해서 원하는 만큼 세분화 
mpg$grade2 <- ifelse(mpg$total >= 30, "A", 
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))
head(mpg, 20)
table(mpg$grade2)   # 등급 빈도표 생성
qplot(mpg$grade2)


mpg$grade3 <- ifelse(mpg$total >= 30, "수", 
                     ifelse(mpg$total >= 25, "우",
                            ifelse(mpg$total >= 20, "미", "양")))
head(mpg, 20)
table(mpg$grade3)   # 등급 빈도표 생성
qplot(mpg$grade3)



### 자유자재로 Data 가공하기
# dplyr 패키지는 데이터 전처리 작업에 가장 맣이 활용되는 패키지 입니다.
# dplyr 패키지 내의 함수의 종류와 기능은 다음과 같습니다. 

# dplyr 패키지내 함수       기능
# filter()               행 추출
# select()               열(변수) 추출
# arrange()              정렬
# mutate()               변수추가
# summarise()            통계치 산출
# group_by()             집단별로 나누기
# left_join()            데이터 합치기(열)
# bind_rows()            데이터 합치기(행)


## 조건에 맞는 데이타만 추출하기
library(dplyr)  # 앞서 활성화 했으므로 넘어감
exam <- read.csv("csv_exam.csv")
exam

# exam 변수에서 class가 1인 경우만 추출하기
exam %>%                # %>% : 함수를 나열 함. 줄(행)은 여러개 이지만 1개의 행으로 간주
  filter(class == 1)    # dplyr 패키지의 filter 함수 - 조건 만족하는 것만 골라냄

exam %>% 
  filter(class != 3)    # 3반이 아닌 경우

exam %>% 
  filter(math >= 50)    # 수학이 50점 이상인 경우

exam %>% 
  filter(english <= 80)    # 영어가 80점 이하인 경우

# 여건을 모두 충족하는 행 추출하기
exam %>% 
  filter(class == 1 & english >= 80)    # 1반이면서 동시에 영어가 80점 이상인 경우

exam %>% 
  filter(math >= 90 | english >= 95)    # 수학이 90이상 또는 영어가 95점 이상인 경우

# %in% : 매치 연산자, matching operator, 변수의 값이 조건 목록에 해당하는지 확인하는 기능
# %>% 기호와 c() 함수를 이용해 조건 목록 입력해 보기

exam %>% 
  filter (class %in% c(1, 3, 5))  # 1, 3, 5반에 해당하면 추출

# 추출한 행으로 데이터 만들기

class1 <- exam %>% 
            filter(class == 1)  
class1
mean(class1$math)

class2 <- exam %>% 
            filter(class == 2)  
class2
mean(class2$english)
sd(class2$english)
var(class2$english)

# R 에서 사용하는 기호들
# < 작다, <= 작거나 같다, > 크다,  >= 크거나 같다, == 같다, != 같지 않다, | 또는,  & 그리고
# %in% 매칭 확인    ^, ** 제곱, / 나누기, %/% 나눗셈의 몫,  %% 나눗셈의 나머지

# select() 데이터에 들어 있는 수 많은 변수 중, 일부 변수만 추출해 활용하고자 할 때
exam %>%
  select(math) # 수학만 추출

exam %>%
  select(class, math, english) # 반, 수학, 영어 추출

# 변수 제외하기 : -제외할 변수
exam %>%
  select(-math) # 수학만 제외하고 추출

# filter()와 select() 조합 활용하기
exam %>%
   filter(class == 1) %>% 
   select(math) # 1반 수학만 추출

exam %>%
   select(id, math) %>% 
   head # id, 수학 추출

# 순서대로 정렬하기
exam %>%
  arrange(math) # 수학 오름차순 정렬 
  
exam %>%
  arrange(desc(math)) # 수학 내림차순 정렬 


# 파생변수 추가하기  mutate()
exam %>%
  mutate(total = math + english + science) %>% 
  head

exam %>%
  mutate(average = (math + english + science)/3) %>% 
  head

exam %>%
  mutate(total = math + english + science,
         average = (math + english + science)/3) %>% 
  head

# mutate() 에 ifelse() 적용하기
exam %>%
  mutate(test = ifelse(science >=60, "pass", "fail")) %>% 
  head

# 추가한 변수를 바로 활용하기
exam %>%
  mutate(total = math + english + science) %>% 
  arrange(total) %>% 
  head



## 집단별로 요약하기 : summarise()
exam %>%
  summarise(mean_math = mean(math)) # 수학 평균 산출


exam %>%
  group_by(class)   %>%               # 반별로 분리해서 
  summarise(mean_math = mean(math))   # 수학 평균 산출


# 여러 요약 통계량 한번에 산출하기
exam %>%
  group_by(class)   %>%                    # 반별로 분리해서 
  summarise(mean_math = mean(math),        # MATH 평균  
            sum_math = sum(math),          # math 합계
            median_math = median(math),    # math 중앙값
            n = n())                       # 수학 평균 산출       n() 빈도


mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)
 
 
# dplyr 조합하기
# 과제 : 회사별로 "SUV" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고 1-5위까지 출력하기

# 절차        기능                          dplyr 함수
#  1         회사별로 분리                  group_by
#  2         suv 추출                       filter()
#  3         통합 년비 변수의 추가 생성     mutate()
#  4         통합 년비 평균 산출            summarise()
#  5         내림차순 정렬                  arrange()
#  6         1~5위까지 출력                 head()

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)


# 데이터 합치기

test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
test1

test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))
test2

total <- left_join(test1,test2, by = "id")
total 

# 다른 데이터를 활용해 변수 추가하기

name <- data.frame(class = c(1, 2, 3, 4, 5),
                    teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new

# 세로로 합치기 bind_rows

group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60, 80, 70, 90, 85))
group_a


group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))
group_b


group_all <- bind_rows(group_a, group_b)
group_all


# -----------------------------------------------------------------------------------------------------
# 빅 데이터 분석 순서
# 원자료파악 - 복사본 생성 - 결측치(NA), 이상치(과오) 처리 - 필요변수 추출 - 분석 - 신뢰성 검토
# 모든 데이터의 분석을 위해서는 Data를 자유자재로 가공할 수 있어야 한다.
# 모든 자료는 원본은 보관하고 복사본을 만들어 가공(합치거나, 추출하거나, 수정 등)한다.



# 데이터 가공 도구 : dplyr 패키지(데이터를 원하는 형태로 가공하는 툴)

install.packages("dplyr")  # 1. dplyr 패키지 설치 및 활성화
library(dplyr)

# dplyr 패키지 : a grammar of data manipulation  dplyr, 예  "%>%" (dplyr의 기능함수) 
  # "%>%" - ctrl + shift + M 동시 클릭 - 함수들을 연결하는 기능 - 파이프 연산자 - 1문장으로 간주
# dplyr의 기능함수  
  # 행추출 : filter(), 열(변수)추출 : select(), 정렬 : arrange(), 변수추가 : mutate(),  
  # 통계치산출 : summarise(), 집단별로 나누기 : group_by(), 데이터합치기(열) : left_join(), 
  # 데이터합치기(행) : bind_rows()

exam <- read.csv("csv_exam.csv")
exam
# -----------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------
# 데이터 정제 :  빠진 데이터(결측치) NA,  이상한 데이터(이상치) 제거하기
# 빠진 데이터(결측치) = 누락된 값 = 비어있는 값  --> 함수가 적용되지 않거나  왜곡문제 발생
# 문자로 구성된 변수 중 결측치는  <NA> 형태로 출력됨 

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5,4,3,4,NA))
df

# 결측치 확인 is.na()
is.na(df)
table(is.na(df))  # 결측치 빈도수 출력
is.na(df$sex)
table(is.na(df$sex))
table(is.na(df$score))
is.na(df$score)
# 결측치 포함된 자료를 함수에 적용하면 error 발생 NA
mean(df$score)
sum(df$score)

# 결측치 제거하기  filter(is.na())
library(dplyr)
df %>%  filter(is.na(score))  # score가 NA인 데이터 출력

# 결측치를 제외하고 행을 추출
df %>%  filter(!is.na(score))  # score가 NA인 데이터 출력
df_nomiss <- df %>%  filter(!is.na(score))
df_nomiss
mean(df_nomiss$score)
sum(df_nomiss$score)

# 여러 변수 동시에 결측치 없는 데이터 추출하기
df_nomiss <- df %>%  filter(!is.na(score) & !is.na(sex))
df_nomiss

# 결측치가 하나라도 있으면 제거하기
# na.omit()  변수를 지정하지 않고 결측치없는 데이터 추출
df_nomiss2 <- na.omit(df)
df_nomiss2

# 함수의 결측치 제외 기능 활용하기 
mean(df$score, na.rm = T)   # 결측치 제외후 평균값 산출
sum(df$score, na.rm = T)   # 결측치 제외후 합계 산출


exam <- read.csv("csv_exam.csv")
exam

exam[c(3,8,15), "math"] <- NA  # 3, 8, 15 행의 math에 NA 할당
# 대괄호 [ ] ; 데이터의 위치를 지정 []안의 쉼표 왼쪽은 '행'위치, 오른쪽은 '열'위치
# math 열의 3, 8, 15행에다 NA 할당
exam
exam7 <- exam
exam7 %>% summarise(mean_math = mean(math))
# 실행안됨. NA  Not available
# 그러나

exam7 %>% summarise(mean_math = mean(math, na.rm=T))
# 성공

exam7 %>% summarise(mean_math = mean(math, na.rm=T),
                   sum_math = sum(math, na.rm=T),
                   median_math = median(math, na.rm=T))


# 평균값으로 결측치 대체하기
mean(exam$math, na.rm = T)  # 결측치 제외하고 math 평균 산출

# ifelse()를 이용해서NA값을 위에서구한 평균값으로 대체
exam7$math <- ifelse(is.na(exam7$math), 55, exam7$math)  # math가 NA이면 55로 대체 
table(is.na(exam7$math))
exam7

mean(exam7$math)


## 이상치(outlier) 정제하기
  # 이상치 = 정상범주에서 크게 벗어난 값   존재할 수 없는 값

  # 이상치가 포함된 자료 생성
  # sex 성별 구분 1,2   score 점수 1-5점 사이

outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier
# 이상치는 sex에 3, score에 6

table(outlier$sex) # table를 이용해 빈도수 산정 ; 3이 1개 존재
table(outlier$score) # table를 이용해 빈도수 산정 ; 6이 1개 

# 이상치를 결측치로 처리   ifelse()  NA
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

# 이제결측치를 제외하고 분석하면된다. 
# filter() 이용해서 결측치를 제외한 후 성별에 따른 score 평균을 구해보자

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>%   # 온전한 자료 추출
  group_by(sex) %>%                         # 성별로 분류     
  summarise(mean_score = mean(score))       # 각 성별의 평균값 산정 















# ---------------------
# 실전 공공데이터 분석  -  데이터 분석 프로젝트           11월 13일 수업
# ---------------------

## 공개된 빅데이터 제공 장소
   # 공공데이터 포털 www.data.go.kr
   # 서울 열린데이터 광장 http://data.seoul.go.kr
   # 국가공간정보 오픈마켓 http://market.nsdi.go.kr/
   # 한지복지패널 http://koweps.re.kr
   
# 한국인의 삶을 파악하라, 한국복지패널데이터 기반 분석 
# 한국복지패널데이터 분석

# 기본자료 깃허브 bit.ly/doit_rb  접속 또는 직접 https://github.com/youngwoos/Doit_R/#91  입력
# 2016년에 발간된 복지패널데이터 6,914가구  16,664명에 대한 정보를 담고 있음.

# 이하 아래는 연결되는 내용 임.
# 데이터 준비 bit.ly/doit_rb ;<https://github.com/youngwoos/Doit_R/#91>
# 다운로드 koweps_hpc10_2015_beta1.sav 다운오드 : 2016년 발간된 복지 패널데이터(6914가구, 16664명정보)
# https://www.koweps.re.kr 한국복지패널 회원가입 후, https://www.koweps.re.kr:442/data/data/list.do
# ID : gpsgis   PW : gnssuav7
# 
# 통계 sw인 SPSS, SAS, STATA의 전용 파일을 불러올 수 있는 기능 : 패키지 foreign 설치
install.packages("foreign")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("readxl")

library(foreign) # SPSS 파일 불러오기
library(dplyr) # 전처리
library(ggplot2) # 시각화
library(readxl) # 엑셀파일 불러오기

# 데이터 불러오기
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
raw_welfare 
# 복사본 만들기
welfare <- raw_welfare

# 데이터 검토하기
View(welfare)

head(welfare)

tail(welfare)

dim(welfare)

str(welfare)

summary(welfare)

# 변수명 바꾸기
welfare <- rename(welfare,
                  sex = h10_g3,              # 성별
                  birth = h10_g4,            # 태어난 년도
                  marriage = h10_g10,        # 혼인 상태  
                  religion = h10_g11,        # 종교
                  income = p1002_8aq1,       # 월급  
                  code_job = h10_eco9,       # 직업 코드  
                  code_region = h10_reg7)    # 지역 코드

# 데이터 분석절차
# 1단계 : 변수 검토 및 전처리 (결측치 수정, 이상치 제거)
# 2단계 : 변수간 관계분석 (요약표만들기, 그래프 만들기)

# 변수 검토하기
class(welfare$sex)

table(welfare$sex) # 1(남)-7578명, 2(여)-9086명

# sex가 1, 2 이외의 경우는 이상치,  9(모름/무응답) 
# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))
# 확인결과 결측치가 없음 이상없음

# sex 변수의 값은 숫자 1과 2로 되어 있음, 이것을 정상적으로 "male", "female"로 바꾸고
# table(), qplot()을 이용해 반영결과를 확인한다.
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")

table(welfare$sex)
qplot(welfare$sex) # 성별 전처리 작업 완료

# ------------------------------------------------------------------------------
### 가. 성별에 따른 월급 차이  ------- 성별에 따라 월급이 다를까 ?  ------------
# 분석절차
  # 변수검토 및 전처리(성별, 월급) 
  # 변수간 관계분석(성별 월급 평균표 만들기, 그래프 만들기)

# 다음으로 월급변수의 전처리 작업을 수행한다.
# 1. 월급변수 검토 및 전처리 : 기준단위 1만원
class(welfare$income)

summary(welfare$income)

qplot(welfare$income)

# qplot() : 최댓값까지 표현됨, 0-1000까지만 표현되게 설정해보자
qplot(welfare$income) + xlim(0,1000)
qplot(welfare$income) + xlim(0,500)

# 2. 전처리
# 월급은 1-9998 사이값, 모름 또는 무응답은 9999로 코딩된 상태로 조사되어 있음
# 이상치 확인해 보자

summary(welfare$income)
# 결측치가 12030개 있음, 최솟값이 0이 존재함 , 따라서 값이 0 또는 9999일 경우 결측처리 해보자

# 이상치 결측처리
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

# 다시 결측치 확인
table(is.na(welfare$income))

# 성별 월급 평균표 만들기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income

ggplot(data=sex_income, aes(x = sex, y= mean_income)) + geom_col()


# ----------------------------------------------------------------------   11월 20일 수업시자

### 나. 나이와 월급의 관계 ----- 몇살때 월급을 가장 많이 받을 까 ? -----------
# 분석절차
# 변수검토 및 전처리(나이, 월급) 
# 변수간 관계분석(나이별 월급 평균표 만들기, 그래프 만들기)

# 1. 변수 검토하기
class(welfare$birth)

summary(welfare$birth)

qplot(welfare$birth)
# 태어난 년도 1900~2014, 모름/무응답 : 9999

# 2. 이상치 확인
summary(welfare$birth)

# 3. 결측치 확인
table(is.na(welfare$birth))  # 확인 결과 이상치 및 결측치 없음

#만일 이상치가 있었다면 다음 작업이 필요하다. 즉, 이상치의 결측치 화 
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)

table(is.na(welfare$birth))

# 4. 파생변수 생성 - 나이
welfare$age <- 2015 - welfare$birth + 1

summary(welfare$age)

qplot(welfare$age)


# 5. 나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>%  
  summarise(mean_income = mean(income))

head(age_income)

ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_line()
ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_col()


### 다. 년령대에 따른 월급 차이 ----- 어던 연령대의 월급이 가장 많을까 ? -----------
# 분석절차
# 변수검토 및 전처리(연령대, 월급) 
# 변수간 관계분석(년령대별 월급 평균표 만들기, 그래프 만들기)

# 파생변수 만들기 : 초년(30세 미만), 중년(30-59세), 노년(60세 이상)
#  %>% : dplyr 패키지의 함수들은 %>% 를 이용해 조합할 수 있음
# install.packages("dplyr")
# library(dplyr)

welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)

qplot(welfare$ageg)

# 연령대에 다른 월급 차이 분석하기 - 연령대별 월급 평균표 만들기    ???
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col()

ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))


### 라. 연령대 및 성별 월급 차이 - --- 성별 월급차이는 연령대별로 다를까 ?  -----------
# 변수검토 및 전처리(연령대, 성별, 월급) 
# 변수간 관계분석(년령대 및 성별 월급 평균표 만들기, 그래프 만들기)

# 1. 연령대 및 성별 월급 평균표 만들기
# 결측치, 이상치 조정

sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

sex_income

# 2. 그래프 만들기
ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill = sex)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 위 그래프는 각 성별의 월금이 연령대와 함께 표현되어 명확한 이해에 어려움이 있다.
ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill = sex)) + geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))


# 이번에는 년령대로 구분하지 않고 나이 및 성별 월급 평균표를 그래프로 나타내 보자
# 그래프는 선 그래프, 월급 평균선이 다른 색으로 

sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

ggplot(data = sex_age, aes(x=age, y=mean_income, col = sex)) + geom_line()


### 마. 직업별 월급차이 --- 어던 직업이 월금을 가장 많이 받을까 ?
# 직업별 월급 문석하기
# 1. 직업 변수를 검토하고 전처리 작업 수행합시다. - 월급변수 전처리 작업은 앞단계에서 수행했음.
# 변수간 관계를 분석합니다. 변수검토 및 전처리 (직업, 월급) 
# --> 변수간 관계분석(직업볋 월급 평균표, 그래프 작성)
class(welfare$code_job)

table(welfare$code_job)

# 2. 전처리
# library(readxl)
list_job <- read_excel("koweps_Codebook.xlsx", col_names = T, sheet = 2)

head(list_job)


dim(list_job)  # 직업이 149개로 분류

welfare <- left_join(welfare, list_job, id="code_job")     # left_join 으로 job 변수를 welfare에 결합 

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

# 직업별 월급 평균표 만들기, 직업별 월급 평균 구하기

job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

# 어떤 직업의 월급이 많은지 월급을 내림 차순으로 정렬하고 상위 10개를 추출
top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top10

# 그래프로 나타내기
ggplot(data=top10, aes(x=reorder(job, mean_income), y= mean_income)) + 
  geom_col() +
  coord_flip()


# 이번에는 월금이 하위 10위권인 직업을 추출
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)

bottom10

# 그래프 만들가
ggplot(data=bottom10, aes(x=reorder(job, -mean_income), y= mean_income)) + 
  geom_col() +
  coord_flip() +
  ylim(0, 150)

11월 27일 수업 시작 
### 바. 성별 직업 빈도 - "성별로 어던 직업이 가장 많을까 ?
# 분석절차
# 변수 검토 및 전처리(성별, 직업) - 변수간 관계분석(성별 직업 빈도표 만들기, 그래프 만들기)
# 성별 변수 전처리와 직업 변수 전처리는 앞에서 완료했음.  바로 변수간 관계를 분석해 보자
#
# 1. 성별 직업 빈도표 만들기 - 각각 상위 10개를 추출
# 남성 직업별 빈도 상위 10개
job_male <- welfare %>% 
  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_male

# 여성 직업별 빈도 상위 10개
job_female <- welfare %>% 
  filter(!is.na(job) & sex == "female") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_female


# 그래프 만들기

# 남성 직업 상위 10개 그래프
ggplot(data=job_male, aes(x=reorder(job, n), y= n)) + 
  geom_col() +
  coord_flip()

# 여성 직업 상위 10개 그래프
ggplot(data=job_female, aes(x=reorder(job, n), y= n)) + 
  geom_col() +
  coord_flip()


### 사. 종교 유무에 따른 이혼율 - "종교가 있는 사람이 이혼을 덜할까 ?
# 분석절차
# 변수 검토 및 전처리(종교, 혼인상태) - 변수간 관계분석(종교 유무에 따른 이혼율 표 만들기, 그래프만들기)

# 종교 변수 검토 및 전 처리
# 1. 변수 검토하기
class(welfare$religion)

table(welfare$religion)

# 2. 전처리
# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")

table(welfare$religion)

qplot(welfare$religion)


# 혼인상태변수 검토 및 전 처리
# 1. 변수 검토하기
class(welfare$marriage)

table(welfare$marriage)

# 2. 파생변수 만들기
# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))

table(welfare$group_marriage)

table(is.na(welfare$group_marriage))

qplot(welfare$group_marriage)

# 종교유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

religion_marriage

# 앞의 표에서 이혼에 해댕하는 값만 추출해 이혼율 표를 만들어 보자

# 이혼 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(religion, pct)

divorce

# 그래프 만들기
# 이혼율 표를 이용해 그래프를 그려보자

ggplot(data=divorce, aes(x=religion, y= pct)) + geom_col()

# 년령대 및 종교 유무에 따른 이혼률 분석하기
# 년령대별 이혼율 표 만들기
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

ageg_marriage

# 년령대별 이혼률 그래프 만들기
# 초년제외, 이혼 추출
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg, pct)

ageg_divorce

ggplot(data = ageg_divorce, aes(x = ageg, y = pct))+ geom_col()

# 년령대 및 종교 유무에 따른 이혼률 표 만들기
# 년대, 종교유무, 결혼 상태별 비융표 만들기
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  group_by(ageg, religion, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

# 년령대 및 종교 유무별 이혼률 표 만들기
df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion, pct)

df_divorce

ggplot(data = df_divorce, aes(x=ageg, y=pct, fill = religion)) +
  geom_col(position = "dodge")



## 아. 지역별 연령대 비율 - 노년층이 많은 지역이 어디일까요 ?

# 변수 검토 및 전처리(지역, 년령대) - 변수간 관계분석(지역별 연령대 비율표 만들기, 그래프만들기)
# 지역 변수 검토 및 전 처리
# 1. 변수 검토하기
class(welfare$code_region)

table(welfare$code_region)

# 2. 전처리
# code_region ( 1 서울,  2 수도권(인천/경기), 3 부산/경남/울산, 4 대구/경북, 5 대전/충남
#               6 강원/충북,  7 광주/전남/전북/제주도)

# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))

list_region

# 지역별 변수 추가
welfare <- left_join(welfare, list_region, id= "code_region")

welfare %>% 
  select(code_region, region) %>% 
  head

# 지역별 년령대 비율 분석하기
# 지역별 년령대 비율표 만들기
region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)

# 그래프 만들기
ggplot(data=region_ageg, aes(x=region, y= pct, fill = ageg)) + 
  geom_col() +
  coord_flip()

# 노년층 비율 내림차순 만들기
list_order_old <- region_ageg %>% 
  filter(ageg == "old") %>% 
  arrange(pct)

list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region

order

ggplot(data=region_ageg, aes(x=region, y= pct, fill = ageg)) + 
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

# 년령대 순으로 막대 색깔 나열하기
class(region_ageg$ageg)

levels(region_ageg$ageg)

# factor()를 이용해서 ageg 변수를 factor 타입으로 변환하고 level 파라미터를 이용해 순서를 정한다.
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))

class(region_ageg$ageg)

levels(region_ageg$ageg)

ggplot(data=region_ageg, aes(x=region, y= pct, fill = ageg)) + 
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)


