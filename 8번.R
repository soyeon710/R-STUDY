exam <- read.csv("csv_exam.csv") 
exam[]    # 조건 없이 전체 데이터 출력
exam[1,]  # 1 행 추출
exam[2,]  # 2 행 추출
exam[exam$class == 1,]  # class 가 1 인 행 추출
exam[exam$math >= 80,]  # 수학점수가 80 점 이상인 행 추출
exam[exam$class == 1 & exam$math >= 50,] 
exam[exam$english < 90 | exam$science < 50,] 
exam[,1]  # 첫 번째 열 추출
exam[,2]  # 두 번째 열 추출
exam[,3]  # 세 번째 열 추출

exam[, "class"]  # class 변수 추출
exam[, "math"]   # math 변수 추출

exam[,c("class", "math", "english")]  # class, math, english 변수 추출
exam[1,3]
exam[5, "english"]
exam[exam$math >= 50, c("english", "science")] 
exam[exam$math >= 50, "english"] 
var1 <- c(1,2,3,1,2)          # numeric 변수 생성
var2 <- factor(c(1,2,3,1,2))  # factor 변수 생성


var1  # numeric 변수 출력
var2  # factor 변수 출력
var1+2  # numeric 변수로 연산
var2+2  # factor 변수로 연산
변수 타입 확인하기 
class(var1) 
class(var2) 
factor 변수의 구성 범주 확인하기 
levels(var1) 
levels(var2) 
var3 <- c("a", "b", "b", "c")          # 문자 변수 생성
var4 <- factor(c("a", "b", "b", "c"))  # 문자로 된 factor 변수 생성
var3 
var4
class(var3)
class(var4)
mean(var1)
mean(var2)  factor는 평균을 구할수 없음
var2 <- as.numeric(var2)  # numeric 타입으로 변환
mean(var2)                # 함수 재적용
class(var2)               # 타입 확인
levels(var2)              # 범주 확인
# 벡터 만들기
a <- 1 a 
## [1] 1 
b <- "hello" b 
## [1] "hello" 
# 데이터 구조 확인 
class(a) 
## [1] "numeric" 
class(b) 
## [1] "character"
# 데이터 프레임 만들기
x1 <- data.frame(var1 = c(1,2,3),                  var2 = c("a","b","c")) x1 
##   var1 var2 ## 1    1    a ## 2    2    b ## 3    3    c 
# 데이터 구조 확인
class(x1) 
## [1] "data.frame" 
# 매트릭스 만들기 - 1~12 로 2 열
x2 <- matrix(c(1:12), ncol = 2) x2 
##      [,1] [,2] ## [1,]    1    7 ## [2,]    2    8 ## [3,]    3    9 ## [4,]    4   10 ## [5,]    5   11 ## [6,]    6   12 
# 데이터 구조 확인
class(x2) 
## [1] "matrix" 
# array 만들기 - 1~20 으로 2 행 x 5 열 x 2 차원
x3 <- array(1:20, dim = c(2, 5, 2)) x3 
## , , 1 ##  ##      [,1] [,2] [,3] [,4] [,5] ## [1,]    1    3    5    7    9 ## [2,]    2    4    6    8   10 ##  ## , , 2 ##  ##      [,1] [,2] [,3] [,4] [,5] ## [1,]   11   13   15   17   19 ## [2,]   12   14   16   18   20
# array 만들기 - 1~20 으로 2 행 x 5 열 x 2 차원
x3 <- array(1:20, dim = c(2, 5, 2)) x3 
## , , 1 ##  ##      [,1] [,2] [,3] [,4] [,5] ## [1,]    1    3    5    7    9 ## [2,]    2    4    6    8   10 ##  ## , , 2 ##  ##      [,1] [,2] [,3] [,4] [,5] ## [1,]   11   13   15   17   19 ## [2,]   12   14   16   18   20 
# 1. 데이터 추출하기
exam[1,]                                  # 행 번호로 행 추출
exam[exam$class == 1,]                    # 조건을 충족하는 행 추출
exam[exam$class == 1 & exam$math >= 50,]  # 여러 조건을 충족하는 행 추출


exam[,1]                                  # 열 번호로 변수 추출
exam[, "class"]                           # 변수명으로 변수 추출
exam[,c("class", "math", "english")]      # 변수명으로 여러 변수 추출
exam[1,3]                                 # 행 , 변수 동시 추출 - 인덱스
exam[exam$math >= 50, "english"]          # 행 , 변수 동시 추출 - 조건문 , 변수명



# 2. 변수 타입
var <- c(1,2,3,1,2)                   # numeric 변수 만들기
var <- factor(c(1,2,3,1,2))           # facto r 변수 만들기
var <- factor(c("a", "b", "b", "c"))  # 문자로 구성된 factor 변수 만들기
class(var)                            # 변수 타입 확인하기
levels(var)                           # factor 변수의 구성 범주 확인
var <- as.numeric(var)                # factor 타입을 numeric 타입으로 변환하기

NP 정리하기 
# 3. 데이터 구조
a <- 1                                   # 벡터 만들기
b <- "hello" 

x1 <- data.frame(var1 = c(1,2,3),        # 데이터 프레임 만들기
                 var2 = c("a","b","c")) 

x2 <- matrix(c(1:12), ncol = 2)          # 매트릭스 만들기


x3 <- array(1:20, dim=c(2, 5, 2))        # 어레이 만들기


x4 <- list(f1 = a,                       # 리스트 만들기
           f2 = x1,            f3 = x2,            f4 = x3) 

# 리스트 활용하기
x <- boxplot(mpg$cty)  # 상자 그림 만들기
x$stats[,1]            # 요약 통계량 추출
