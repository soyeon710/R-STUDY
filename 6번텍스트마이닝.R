# 텍스트 마이닝 - 10장
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("dplyr")
install.packages("stringr")
install.package("wordcloud")  # wordcloud 생성 기능 패키지 설치
install.package("RColorBrewer")
install.package("ggplot2")
install.packages("foreign")
install.packages("readxl")
library(readxl)
library(ggplot2)
library(wordcloud)
library(RColorBrewer) 
library(stringr)
library(foreign)
library(KoNLP)
library(dplyr)
useNIADic()  # 사전 설정하기
# 데이터 준비하기 bit.ly/doit_rd 에서 hiphop.txt 파일 다운로드, readLines()로 불러와 일부 출력하자

txt <- readLines("hiphop.txt")
head(txt)
head(txt,10)
install.packages("stringr")
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")           #특수문자 제거
head(txt, 10)

# 가사에서 명사를 추출한다. 
nouns <- extractNoun(txt)     # extractNoun : 출력 결과를 리스트 형태로 반환
nouns
# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 작성
wordcount <- table(unlist(nouns))    # table(unlist(nouns)) 리스트로 되어 있는 nouns를 빈도테이블로 변환   
wordcount

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)  #분석을 할려면 데이터프레임으로 하는 것이 좋다.

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 자주 사용된 단어 빈도표 만들기
# 한 글자 단어는 삭제, 두 글자 이상으로 구성된 단어 추출 nchar() 사용
df_word <- filter(df_word, nchar(word) >= 2)

# 빈도순으로 정렬한 후, 상위 20개 단어를 추출한다.
top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top_20
# Dark2 색상 목록에서 8개 색상 추출
pal <- brewer.pal(8,"Dark2")               #여러가지 색
set.seed(1234)
wordcloud(words = df_word$word,     # 단어
          freq = df_word$freq,      # 빈도
          min.freq = 2,             # 최소단어 빈도
          max.words = 200,          # 표현 단어 수 
          random.order = F,         # 고빈도 단어를 중앙에 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색상 목록 적용


# 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]  # 색상 목록 생성  파랑색으로만 함
set.seed(1234)                      # 난수 고정

wordcloud(words = df_word$word,     # 단어
          freq = df_word$freq,      # 빈도
          min.freq = 2,             # 최소단어 빈도
          max.words = 200,          # 표현 단어 수 
          random.order = F,         # 고빈도 단어를 중앙에 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색상 목록 적용

# 단어 빈도 막대 그래프 만들기 
install.packages("ggplot2")
library(ggplot2)

order <- arrange(top20, freq)$word # 빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y=freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +           # 빈도순 막대 정렬 
  geom_text(aes(label = freq), hjust = -0.3)  # 빈도 표시

twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

twitter <- rename(twitter,     # 변수명 수정
                  no = 번호,
                  id = 계정이름,
                  data = 작성일,
                  tw = 내용)


