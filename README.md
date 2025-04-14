# 🏨 Hotel Booking Cancellation Prediction

## Overview
This project focuses on analyzing and predicting hotel booking cancellations using logistic regression in R. By exploring reservation patterns and customer behaviors from booking data, the model aims to provide valuable insights for hotel revenue management and operational efficiency.

---

## Table of Contents
1. [Objectives](#objectives)
2. [Dataset](#dataset)
3. [Key Methodologies](#key-methodologies)
    - [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
    - [Logistic Regression Modeling](#logistic-regression-modeling)
4. [Classification Strategy](#classification-strategy-binary-outcome)
5. [Results](#results)
6. [Future Scope](#future-scope)
7. [Tools & Libraries](#tools--libraries)

---

## Objectives
- Explore customer and booking trends to understand cancellation behavior.
- Build a logistic regression model to predict cancellations.
- Use model insights to guide hotel strategies for minimizing no-shows and revenue loss.

---

## Dataset
- **Source**: Internal (provided as `booking.csv`)
- **Scope**: Hotel booking data, including reservation details, stay duration, pricing, and customer preferences.
- **Size**: ~44,000 rows (after cleaning)
  - Numerical: features like lead time, number of nights, average price, etc.
  - Categorical: room type, meal plan, market segment
  - Target: `booking_status` (0 = Not Canceled, 1 = Canceled)

---

## Key Methodologies

### Exploratory Data Analysis (EDA)
Performed in `Hotel_Booking_EDA.R`:
- **Descriptive statistics** using `summary()`, `describe()`, and data structure checks.
- **Boxplots** for key numerical variables: `lead_time`, `special_requests`, and `average_price`.
- **Bar and pie charts**:
  - Booking status distribution
  - Market segment share
- **Correlation heatmaps** for numeric relationships.
- **Scatter plots** and **histograms** to explore booking behaviors and pricing patterns.

### Logistic Regression Modeling
Implemented in `BA with R_project.R`:
1. **Data Preprocessing**:
   - Removal of extreme values in `number_of_children`
   - Date conversion and extraction of `year_of_reservation`
   - Binary encoding of `booking_status`
2. **Train-Test Split**:
   - 80/20 ratio with reproducible seed
3. **Model Construction**:
   - Predictor variables: number of guests, nights, lead time, price, room type, and more
   - Logistic model built using `glm()` in R
4. **Performance Evaluation**:
   - Accuracy, TPR (Recall), TNR (Specificity), FPR, FNR
   - Metrics calculated on both train and test datasets
5. **Coefficient Interpretation**:
   - Extracted odds ratios and percentage effects
   - Exported results to `coefficients.xlsx`

---

## Classification Strategy: Binary Outcome

| **Class**         | **Meaning**          |
|------------------|----------------------|
| **0**            | Not Canceled Booking |
| **1**            | Canceled Booking     |

### Purpose
- **Operational Efficiency**: Identify high-risk cancellations early.
- **Revenue Strategy**: Reduce overbooking impact by forecasting cancellations.
- **Customer Insight**: Target customers with a high likelihood of canceling for proactive engagement.

---

## Results

| **Metric**           | **Train (%)** | **Test (%)** |
|----------------------|---------------|--------------|
| Accuracy             |     80.69     |     80.80    |
| TPR (Sensitivity)    |     63.59     |     64.05    |
| TNR (Specificity)    |     89.11     |     88.82    |
| FPR (Type I Error)   |     10.88_    |     11.17    |
| FNR (Type II Error)  |     36.40     |     35.94    |

> 📁 Coefficients and Odds Ratios are saved in `coefficients.xlsx` for interpretability.

---

## Future Scope
- Implement advanced classification algorithms (e.g., XGBoost, Random Forest)
- Use time-series features for early cancellation predictions
- Build a customer segmentation engine for dynamic pricing & offers

---

## Tools & Libraries

### Programming
- **R**

### Visualization
- `ggplot2`, `corrplot`, `reshape2`

### Data Manipulation
- `dplyr`, `Hmisc`, `data.table`

### Modeling & Export
- `glm`, `openxlsx`, `stargazer`

### Editors
- RStudio

---

## Run Instructions

1. Place `booking.csv`, `Hotel_Booking_EDA.R`, and `BA with R_project.R` in your working directory.
2. Open RStudio and run `Hotel_Booking_EDA.R` for data exploration.
3. Then run `BA with R_project.R` for model training and results generation.


