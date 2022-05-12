library(Rserve)
library(DBI)
library(forecast)
library(Hmisc)
library(dplyr)
library(caret)
library('odbc')


#Establish Connection
con <- dbConnect(odbc::odbc(),
  driver="cloudera ODBC Driver for Impala", 
  host="192.168.211.128",
  port=21050,
  database="default",
  uid="",pwd="")


#Query from the table                 
data <- dbGetQuery(con, "select * from rf_prediction_variable") 


#Add Driver Id as names to data and drop the column
rownames(data) <- data[,c(1)]
data <- data[,-c(1,6)]

data$number_of_events <- as.numeric(data$number_of_events) 
data$max_speed <- as.numeric(data$max_speed) 
data$total_miles <- as.numeric(data$total_miles) 
data$average_mileage <- as.numeric(data$average_mileage) 

set.seed(100)
                 
#Splitting the data
numberofrows <- nrow(data)
train.Ind <- sample(numberofrows,0.7*numberofrows)
train.DF <- data[train.index,]
valid.df <- data[-train.index,]


#Vew the lm on significant variables
plot(risk_factor.df$number_of_events,risk_factor.df$riskfactor)
lm2 <- lm(riskfactor ~ number_of_events, data = train.DF)
abline(lm2)

plot(risk_factor.df$max_speed,risk_factor.df$riskfactor)
lm3 <- lm(riskfactor ~ max_speed, data = train.DF)
abline(risk_factor.lm3)

plot(risk_factor.df$total_miles,risk_factor.df$riskfactor)
lm2 <- lm(riskfactor ~ total_miles, data = train.DF)
abline(lm2)


#Final Model
lm1 <- lm(riskfactor ~ number_of_events + max_speed + total_miles 
          + average_mileage, data = train.DF)

options(scipen = 999)
summary(lm1)


pred <- predict(lm1, valid.df)
accuracy(pred, valid.df$riskfactor)




#Plot actual vs predicted
df <- data.frame("Predicted" = pred, "Actual" = valid.df$riskfactor)
df <- df[order(-df$Actual),]
df$bin = as.numeric(cut2(df$Actual, g = 21))

table(df$bin)

bin_stats = df %>%
  group_by(bin) %>% summarise(mean_Actual = mean(Actual),
                    mean_Predicted = mean(Predicted),
                    min_Actual = min(Actual), min_Predicted = min(Predicted),
                    max_Actual = max(Actual), max_Predicted = max(Predicted) )


p1<- ggplot(bin_stats, aes(bin)) +
  geom_line(aes(y = bin_stats$mean_Predicted, color ="Predicted riskfactor" )) +
  geom_line(aes(y = bin_stats$mean_Actual, color = "Actual riskfactor"))
p1


