
library(tm)
library(NLP)
library(wordcloud)
library(ggplot2)
library(RColorBrewer)
library(RWeka)


setwd("/Users/ashwinbalaji/Desktop/Rlabs/")
mydata <-read.table("excerpt1.txt", sep = "\t")
mydata 


mycorpus <- Corpus(VectorSource(mydata$V1))
mycorpus <- tm_map(mycorpus, content_transformer(tolower))
# Remove numbers
mycorpus <- tm_map(mycorpus, removeNumbers)
# Remove english common stopwords
mycorpus <- tm_map(mycorpus, removeWords, stopwords("english"))
# Remove punctuations
mycorpus <- tm_map(mycorpus, removePunctuation)
# Eliminate extra white spaces
mycorpus <- tm_map(mycorpus, stripWhitespace)
as.character(mycorpus[[1]])





# Bigrams 
minfreq_bigram<-2

token_delim <- " \\t\\r\\n.!?,;\"()"
bitoken <- NGramTokenizer(mycorpus, Weka_control(min=1,max=1, delimiters = token_delim))
two_word <- data.frame(table(bitoken))
sort_two <- two_word[order(two_word$Freq,decreasing=TRUE),]
wordcloud(sort_two$bitoken,sort_two$Freq,random.order=FALSE,scale = c(2,0.35),min.freq = minfreq_bigram,colors = brewer.pal(8,"Dark2"),max.words=150)





