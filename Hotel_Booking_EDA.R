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


#Lead Time
Leadtime_box <- ggplot(data = booking, aes(y = lead_time, fill="lead_time")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Lead Time (Days)",
       y = "Lead Time (Days)")  # Label for y-axis
Leadtime_box


#avg_price_box
avg_price_box <- ggplot(data = booking, aes(y = average_price, fill="average_price")) +
  geom_boxplot(fill="lightblue") + 
  theme_minimal() +
  labs(title = "Average Price",
       y = "average_price")  # Label for y-axis
avg_price_box


#barplot for booking status
booking_barchart = ggplot(data = booking,
                      aes(x = booking$`booking_status`, fill=booking$booking_status)) + 
  geom_bar(stat = "count",
           width = 0.5)+
           
  ggtitle("Booking Status BarPlot") +
  ylab("Count") + 
  xlab("Booking") +
  theme_classic() 
booking_barchart

#########################################################
#type of booking - piechart
segment_type_pie = subset(booking,
                       select = c("market_segment_type"))
segment_type_pie = segment_type_pie[, count := 1]
#booking = booking[, lapply(.SD, sum), by = c("market_segment_type")]
### Attach the total sum column and take the ratio
segment_type_pie = segment_type_pie[, count_sum := sum(count)]
segment_type_pie = segment_type_pie[, seg_share := count / count_sum]

### Plot
my_colors <- c("#FF6600", "#56B4E9", "#009E73", "#F0E442",'#37475f', '#c0d6e4')
segmentincidence_piechart = ggplot(data = segment_type_pie,
                                   aes(x = "", # Note the difference! only one column but different group defined in aes()
                                       y = seg_share,
                                       fill = market_segment_type)) + 
  geom_bar(stat = "identity",
           width = 1) + # you should NOT specify "fill" here
  coord_polar("y", start=0) + # This line makes the chart "round"
  ggtitle("Share of Each Segment") +
  xlab("Share") + 
  ylab("") +
  scale_fill_manual(values = my_colors) +
  guides() + 
  theme_minimal() # Themes

segmentincidence_piechart
###############################################

my_colors <- c("#FF6600", "#56B4E9", "#009E73", "#F0E442",'#37475f', '#c0d6e4')
segmentincidence_piechart2 = ggplot(data = segment_type_pie,
                                   aes(x = "booking_Status", # Note the difference! only one column but different group defined in aes()
                                       y = seg_share,
                                       fill = market_segment_type)) + 
  geom_bar(stat = "identity",
           width = 1) + # you should NOT specify "fill" here
  coord_polar("y", start=0) + # This line makes the chart "round"
  ggtitle("Share of Each Segment") +
  xlab("Share") + 
  ylab("") +
  scale_fill_manual(values = my_colors) +
  guides() + 
  theme_minimal() # Themes

segmentincidence_piechart2


# corr plot

booking_numeric <- booking

# Get the names of non-numeric variables
non_numeric_vars <- names(booking)[sapply(booking, function(x) !is.numeric(x))]

# Loop through non-numeric variables and convert them to numeric in the new dataframe
for(var in non_numeric_vars) {
  booking_numeric[[var]] <- as.numeric(as.character(booking[[var]]))
}

# Calculate correlation matrix
correlation_matrix <- cor(booking_numeric, method="pearson")
View(booking_numeric)
corrplot(correlation_matrix, method = "color", tl.cex=0.5, tl.col="black")

# Calculate correlation matrix

corr_matrix <- booking %>% select_if(is.numeric) %>% 
  cor(method="pearson", use="pairwise.complete.obs")
corrplot(corr_matrix, method = "color", tl.cex=0.5, tl.col="black")


######################################################################
#density plot for Leadtime and avg_price
leadtime_hist = ggplot(data = booking,
                     aes(x = lead_time)) +
  ggtitle("Leadtime Distribution Histogram") +
  geom_histogram(binwidth=2)+ # Try adjusting the bin width
geom_density(aes(y = ..density..), linetype = "dashed")
leadtime_hist


ggplot(data = booking, aes(x = lead_time)) +
  ggtitle("Leadtime Distribution Histogram") +
  geom_histogram(binwidth = 2, aes(fill = ..density..), alpha = 0.5) +
  geom_density(aes(y = ..density..), linetype = "dashed")




library(reshape2)
melted_data <- melt(booking)

# Create a boxplot using ggplot2
combined_boxplot <- ggplot(melted_data, aes(y = variable, x = value, fill=variable)) +
  geom_boxplot() +
  labs(y = "Variables", x = "Values") +
  ggtitle("Boxplots of Multiple Variables")+
  theme_classic()
 
combined_boxplot 
ggsave(filename = "boxplot_combined.jpeg",
       plot = combined_boxplot,
       width = 1600,
       height = 1400,
       units = "px" # can be "cm", "in", "px"
)


data$booking_status <- factor(data$booking_status)

# Create a scatterplot using ggplot2
ggplot(booking, aes(x = lead_time, y = booking_status, color = booking_status)) +
  geom_point(size = 3, alpha = 0.7) +  # Set point size and transparency
  labs(x = "Lead Time (Days)", y = "Booking Status", color = "Booking Status") +
  ggtitle("Lead Time vs. Booking Status") +
  theme_minimal()  # Set plot theme to minimal




