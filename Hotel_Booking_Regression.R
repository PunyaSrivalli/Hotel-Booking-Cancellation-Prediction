setwd("C:/Users/punya/Downloads")
HB <- read.csv("booking.csv", header = TRUE, stringsAsFactors = FALSE)
attach(HB)
View(HB)
HB <- HB[!(HB$number.of.children %in% c(10, 9)), ]
class(HB$date.of.reservation)
  
HB$date.of.reservation <- as.Date(HB$date.of.reservation, format = "%m/%d/%Y")
class(HB$date.of.reservation)

HB$year_of_reservation <- format(HB$date.of.reservation, "%Y")
class(HB$booking.status)

HB$booking.status <- ifelse(HB$booking.status == "Not_Canceled", 0, 1)
View(HB)
set.seed(345)
train = sample(1:nrow(HB), nrow(HB)*(4/5))
HB.train = HB[train,]
HB.test = HB[-train,]

logit_model <- glm(booking.status ~ number.of.adults + number.of.children + number.of.week.nights + number.of.weekend.nights + type.of.meal + car.parking.space + room.type + lead.time + market.segment.type + repeated + P.C + P.not.C + average.price + special.requests + year_of_reservation, data = HB.train, family = binomial())

summary(logit_model)


logitPredic_train <- predict(logit_model, HB.train, type = "response")
logitPredictClass_train <- ifelse(logitPredic_train > 0.5, 1, 0)
actual_train <- HB.train$booking.status
predict_train <- logitPredictClass_train
Conf_mat_train <- table(predict_train, actual_train)
tp_train <- Conf_mat_train[2,2]
tn_train <- Conf_mat_train[1,1]
fp_train <- Conf_mat_train[2,1]
fn_train <- Conf_mat_train[1,2]
accuracy_train <- 100*((tp_train + tn_train)/(tp_train + tn_train + fp_train + fn_train))
error_rate_train <- 100- accuracy_train
TPR_train <-  100*(tp_train/(fn_train+tp_train))
TNR_train <- 100*(tn_train/(fp_train+tn_train))
FPR_train <- 100*(fp_train/(fp_train+tn_train))
FNR_train <- 100*(fn_train/(fn_train+tp_train))

logitPredic_test <- predict(logit_model, HB.test, type = "response")
logitPredictClass_test <- ifelse(logitPredic_test > 0.5, 1, 0)
actual_test <- HB.test$booking.status
predict_test <- logitPredictClass_test
Conf_mat_test <- table(predict_test, actual_test)
tp_test <- Conf_mat_test[2,2]
tn_test <- Conf_mat_test[1,1]
fp_test <- Conf_mat_test[2,1]
fn_test <- Conf_mat_test[1,2]
accuracy_test <- 100*((tp_test + tn_test)/(tp_test + tn_test + fp_test + fn_test))
error_rate_test <- 100 - accuracy_test
TPR_test <-  100*(tp_test/(fn_test+tp_test))
TNR_test <- 100*(tn_test/(fp_test+tn_test))
FPR_test <- 100*(fp_test/(fp_test+tn_test))
FNR_test <- 100*(fn_test/(fn_test+tp_test))
 
cat("Details of Training Data set %\n", 
                   "Accuracy Rate: ", accuracy_train, "%\n",
                   "Error Rate: ", error_rate_train, "%\n",
                   "TPR/Recall/sensitivity: ", TPR_train, "%\n",
                   "TNR/Specificity: ", TNR_train, "%\n",
                   "FPR/Type 1 Error rate: ", FPR_train, "%\n",
                   "FNR/Type 2 Error rate: ", FNR_train, "%\n")

cat("Details for Test Data set %\n", 
                   "Accuracy Rate: ", accuracy_test, "%\n",
                   "Error Rate: ", error_rate_test, "%\n",
                   "TPR/Recall/sensitivity: ", TPR_test, "%\n",
                   "TNR/Specificity: ", TNR_test, "%\n",
                   "FPR/Type 1 Error rate: ", FPR_test, "%\n",
                   "FNR/Type 2 Error rate: ", FNR_test, "%\n")
     
coefficients <- coef(summary(logit_model))

# Create a dataframe from the coefficients
coeff_df <- as.data.frame(coefficients)
# Add row names as a column in the dataframe
coeff_df$Variable <- rownames(coeff_df)
# Optional: Move the new 'Variable' column to the first position
coeff_df <- coeff_df[, c("Variable", "Estimate", "Std. Error", "z value", "Pr(>|z|)")]
# Rename the columns for clarity
names(coeff_df) <- c("Variable", "Estimate", "Std. Error", "Z Value", "P Value")
# View the dataframe
print(coeff_df)
result<-coeff_df
class(result)
   
result$OddsRatio <- exp(result$Estimate)
#result
      
result$OddsPercentage <- 100*(result$OddsRatio)-100
result
      
install.packages("openxlsx")
library(openxlsx)
# Write the dataframe to an Excel file
write.xlsx(result, "coefficients.xlsx", rowNames = FALSE)
Conf_mat_train
      
Conf_mat_test
     