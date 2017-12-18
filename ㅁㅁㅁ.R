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