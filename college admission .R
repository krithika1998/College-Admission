df <- read.csv("College_admission.csv")
View(df)

#To find the null values
sum(is.na(df$admit))
sum(is.na(df$gre))      
sum(is.na(df$gpa))
sum(is.na(df$ses))
sum(is.na(df$Gender_Male))
sum(is.na(df$Race))
sum(is.na(df$rank))

#To find the outliers using boxplot
boxplot(df$admit, horizontal = TRUE)
boxplot(df$gre, horizontal = TRUE) #outlier present 
boxplot(df$gpa, horizontal = TRUE) #outlier present
boxplot(df$ses, horizontal = TRUE)
boxplot(df$Gender_Male, horizontal = TRUE)
boxplot(df$Race, horizontal = TRUE)
boxplot(df$rank, horizontal = TRUE)

#Outlier removal for GRE
outliers1 <- boxplot(df$gre, plot=FALSE)$out
df[which(df$gre %in% outliers1),]
df <- df[-which(df$gre %in% outliers1),]
boxplot(df$gre, horizontal = TRUE)

#Outlier removed for GPA
outliers2 <- boxplot(df$gpa, plot=FALSE)$out
df[which(df$gpa %in% outliers2),]
df <- df[-which(df$gpa %in% outliers2),]
boxplot(df$gpa, horizontal = TRUE)

#to find the structure of the dataset
str(df)

#to convert numeric data to factor data
df$gpa_fac <- as.factor(df$gpa)
str(df)

df$admit_fac <- as.factor(df$admit)
str(df)

table(df$Gender_Male)
df$Gender_Male <- as.factor(df$Gender_Male)

table(df$Race)
df$Race <- as.factor(df$Race)

table(df$ses)
df$ses <- as.factor(df$ses)

table(df$rank)
df$rank <- as.factor(df$rank)

#to find the normal distribution for each column 
x1 <- df$admit 
y = dnorm(x1, mean(x1), sd(x1)) 
plot(x1, y) 

x2 <- df$gre 
y = dnorm(x2, mean(x2), sd(x2)) 
plot(x2, y)   

x3 <- df$gpa 
y = dnorm(x3, mean(x3), sd(x3)) 
plot(x3, y) 

x4 <- df$ses 
y = dnorm(x4, mean(x4), sd(x4)) 
plot(x4, y) 

x5 <- df$Gender_Male 
y = dnorm(x5, mean(x5), sd(x5)) 
plot(x5, y) 

x6 <- df$Race 
y = dnorm(x6, mean(x6), sd(x6)) 
plot(x6, y) 

x7 <- df$rank 
y = dnorm(x7, mean(x7), sd(x7)) 
plot(x7, y) 

#Variable Reduction
library(Hmisc)
res <- rcorr(as.matrix(df))
round(res$P, 3)

#Logistic Regression
df_2 <- df[,-c(1,4,5,6,8)]
View(df_2)

#Train Test Split
set.seed(37)
sample_rows <-sample(nrow(df_2),nrow(df_2)*0.7)
train<-df_2[sample_rows,]
test<-df_2[-sample_rows,]

#logistic regression
logit_model<-glm(formula=admit_fac ~., family = binomial(link="logit"), data= train,model=TRUE)
summary(logit_model)

test$admit_prob <-predict(logit_model,newdata = test,type='response')
test$admit_pred <- as.factor(ifelse(test$admit_prob > 0.4,"1","0"))
View(test)
#to predict the accuracy of logistic regression
library("caret")
x<- table(test$admit_fac,test$admit_pred)
confusionMatrix(x)

#SVM
library(e1071)
df_3 <- df[,-c(1,4,5,6,8)]
View(df_3)
sample_rows_1 <-sample(nrow(df_3),nrow(df_3)*0.7)
train1<-df_3[sample_rows,]
test1<-df_3[-sample_rows,]
svm_model1<-svm(formula=admit_fac ~., data = train1)
svm_model1
summary(svm_model1)
test1$prediction_svm<-predict(svm_model1,newdata=test1)
View(test1)
x <- table(test1$admit_fac,test1$prediction_svm)
confusionMatrix(x)

#decision tree
library(rpart)
df_4 <- df[,-c(1,4,5,6,8)]
View(df_4)
sample_rows_2 <-sample(nrow(df_4),nrow(df_4)*0.7)
train2<-df_4[sample_rows,]
test2<-df_4[-sample_rows,]
dt_model <- rpart(formula=admit_fac ~. , data=train2, method="class")
summary(dt_model)
dt_pred <- predict(dt_model,newdata=test2)
test2$admit_prob_dt <- dt_pred[,2]
test2$admit_pred_dt <- ifelse(test2$admit_prob_dt > 0.2,"1","0")
str(test2)
x <- table(test2$admit_fac,test2$admit_pred_dt)
confusionMatrix(x)

