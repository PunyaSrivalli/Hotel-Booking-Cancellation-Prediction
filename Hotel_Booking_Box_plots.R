rm(list=ls())

setwd("C:/Users/punya/Downloads")

#install.packages("ggplot2")
#install.packages("corrplot")  # Install the corrplot package if you haven't already
library(corrplot)
library(dplyr)

library("Hmisc")
library("data.table")
library("ggplot2")
library("GGally")
library("plm")
library("stargazer")

booking = fread(file = "booking.csv",
                na.strings = c("NA", ""), 
                sep = "auto",
                stringsAsFactors = FALSE,
                encoding = "UTF-8"
)

head(booking)
summary(booking)
str(booking)
new_col_names <- c("Booking_ID", "number_of_adults", "number_of_children", 
                   "number_of_weekend_nights", "number_of_week_nights", 
                   "type_of_meal", "car_parking_space", "room_type", 
                   "lead_time", "market_segment_type", "repeated", "P_C", 
                   "P_not_C", "average_price", "special_requests", 
                   "date_of_reservation", "booking_status")
names(booking) <- new_col_names
str(booking)
describe(booking)
unique(booking$`car parking space`)

nrow(booking)
nrow(unique(booking))


#box plots
boxplot(booking$`lead_time`, main="Box Plot", xlab="lead time(Days)",col = "lightblue", notch = TRUE)
boxplot(booking$average_price, main="Box Plot", xlab="average price", col = "red")
boxplot(booking$`special requests`, main="Box Plot", xlab="special requests",col="lightgreen")

leadtime_box <- ggplot(data = booking, aes(y = lead_time, fill="lead_time")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Lead Time (Days)",
       y = "Lead Time (Days)")  # Label for y-axis
leadtime_box

##box plots-number_of_adults
adults_box <- ggplot(data = booking, aes(y = number_of_adults, fill="number_of_adults")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Number of Adults",
       y = "Number of Adults")  # Label for y-axis
adults_box

#children_box
children_box <- ggplot(data = booking, aes(y = number_of_children, fill="number_of_children")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Number of Children",
       y = "Number of Children")  # Label for y-axis
children_box

#weekends_box
weekends_box <- ggplot(data = booking, aes(y = number_of_weekend_nights, fill="number_of_weekend_nights")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Number of Weekend Nights",
       y = "Number of Weekend Nights")  # Label for y-axis
weekends_box

#weekdays
weeks_box <- ggplot(data = booking, aes(y = number_of_week_nights, fill="number_of_week_nights")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Number of Week Nights",
       y = "Number of Week Nights")  # Label for y-axis
weeks_box

#typeOfMeal_box
typeOfMeal_box <- ggplot(data = booking, aes(y = type_of_meal, fill="type_of_meal")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Type of Meal",
       y = "Type of Meal")  # Label for y-axis
typeOfMeal_box

#carParking_box
carParking_box <- ggplot(data = booking, aes(y = car_parking_space, fill="car_parking_space")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Car Parking Space",
       y = "Car Parking Space")  # Label for y-axis
carParking_box

#roomType_box
roomType_box <- ggplot(data = booking, aes(y = room_type, fill="room_type")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Room Type",
       y = "Room Type")  # Label for y-axis
roomType_box

#Lead Time
Leadtime_box <- ggplot(data = booking, aes(y = lead_time, fill="lead_time")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Lead Time",
       y = "Lead Time")  # Label for y-axis
Leadtime_box

#market_segment_box
market_segment_box <- ggplot(data = booking, aes(y = market_segment_type, fill="market_segment_type")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Market Segment Type",
       y = "Market Segment Type")  # Label for y-axis
market_segment_box

boxplot(booking$market_segment_type, main="Box Plot", xlab="market segment",col = "lightblue", notch = TRUE)


#repeated_box
repeated_box <- ggplot(data = booking, aes(y = repeated, fill="repeated")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Repeated",
       y = "Repeated")  # Label for y-axis
repeated_box

#P.C_box
P.C_box <- ggplot(data = booking, aes(y = P_C, fill="P_C")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "P.C",
       y = "P.C")  # Label for y-axis
P.C_box

#P.not.C_box
P.not.C_box <- ggplot(data = booking, aes(y = P_not_C, fill="P_not_C")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "P.not.C",
       y = "P.not.C")  # Label for y-axis
P.not.C_box

#avg_price_box
avg_price_box <- ggplot(data = booking, aes(y = average_price, fill="average_price")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "average_price",
       y = "average_price")  # Label for y-axis
avg_price_box

#special_requests_box
special_requests_box <- ggplot(data = booking, aes(y = special_requests, fill="special_requests")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "special_requests",
       y = "special_requests")  # Label for y-axis
special_requests_box

#booking_status_box
booking_status_box <- ggplot(data = booking, aes(y = booking_status, fill="booking_status")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "booking_status",
       y = "booking_status")  # Label for y-axis
booking_status_box


