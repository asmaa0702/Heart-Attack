# Heart Attack Risk Analysis & Prediction
### Case Study: Indonesia Healthcare Dataset

![Python](https://img.shields.io/badge/Python-3.12-blue)
![SQL](https://img.shields.io/badge/SQL-Analytics-orange)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow)
![Tableau](https://img.shields.io/badge/Tableau-Visualization-blue)
![Excel](https://img.shields.io/badge/Excel-Dashboard-green)
![Status](https://img.shields.io/badge/Project-Completed-success)

##  Team Members
* **Asmaa Mohamed Ali**

* **Rawan Mohamed Hussein**

* **Giovanna Michel Nassif**

* **Ali Mamdouh Ali**

* **Mostafa Mahmoud El-Abd**

* **Yasmin Ahmed Hosny**
***

##  Instructor

### **Amal Mahmoud**

---

# Table of Contents

- Project Overview
- Business Problem
- Objectives
- Dataset Description
- Data Preparation
- Feature Engineering
- Statistical Analysis
- Key Statistical Findings
- Exploratory Data Analysis
- Excel Dashboard
- SQL Analysis
- Python Analysis
- Tableau Dashboard
- Power BI Dashboard
- Key Insights
- Feature Importance
- Business Value
- Project Structure
- Technologies Used
- Recommendations
- Future Work
- References

---

# Project Overview

Cardiovascular disease remains one of the leading causes of mortality worldwide. Early identification of high-risk individuals enables healthcare providers to implement preventive interventions before serious clinical outcomes occur.

This project analyzes a large healthcare dataset from Indonesia to identify the major factors associated with heart attack occurrence. Using statistical analysis, feature engineering, SQL analytics, dashboards, and machine learning interpretation techniques, the project provides data-driven insights that support preventive healthcare strategies.

Rather than focusing solely on prediction, this project emphasizes understanding **why** heart attacks occur and identifying the factors that contribute most to cardiovascular risk.

Dataset Source:

https://www.kaggle.com/datasets/ankushpanday2/heart-attack-prediction-in-indonesia

---

# Business Problem

Hospitals and healthcare organizations often possess large amounts of patient data but lack effective analytical tools for identifying individuals at elevated cardiovascular risk.

Without data-driven prioritization:

- High-risk patients may remain undetected.
- Preventive resources may be allocated inefficiently.
- Clinical interventions may occur too late.

This project demonstrates how healthcare analytics can support early detection and better allocation of preventive resources.

---

# Objectives

The main objectives of this project were to:

- Explore the dataset using Exploratory Data Analysis (EDA)
- Engineer meaningful healthcare features
- Identify statistically significant cardiovascular risk factors
- Compare patient groups using multiple statistical techniques
- Build interactive dashboards across multiple BI platforms
- Rank feature importance using ensemble learning models
- Generate actionable healthcare recommendations

---

# Dataset Description

The dataset contains healthcare records collected from Indonesian patients.

### Dataset Summary

| Item | Value |
|------|------|
| Rows | 158,355 |
| Original Features | 28 |
| Target | Heart Attack (Yes / No) |
| Source | Kaggle |

The dataset combines demographic, lifestyle, clinical, laboratory, and environmental information.

Main categories include:

- Demographics
- Lifestyle Habits
- Medical History
- Blood Pressure
- Blood Sugar
- Lipid Profile
- Environmental Exposure
- Screening History

---

# Data Preparation

Several preprocessing steps were applied before analysis.

### Data Cleaning

- Checked missing values
- Validated categorical labels
- Removed inconsistencies
- Standardized feature formats
- Verified numerical ranges

### Feature Categorization

Continuous variables were transformed into clinically meaningful categories using internationally accepted medical guidelines.

Examples include:

- Age Groups
- Blood Pressure Classes
- Cholesterol Classes
- Blood Sugar Classes
- Waist Circumference Categories
- Sleep Duration Categories

Medical thresholds were based on WHO, ADA, ATP III, and Indonesian clinical guidelines.

---

# Feature Engineering

To improve interpretability, several new healthcare indicators were engineered.

| Feature | Description |
|---------|-------------|
| Risk Score | Composite cardiovascular risk indicator |
| Lifestyle Score | Overall lifestyle quality score |
| Metabolic Syndrome | Combined metabolic abnormality indicator |
| TG/HDL Ratio | Cardiovascular metabolic risk marker |
| Pulse Pressure | Difference between systolic and diastolic blood pressure |

These engineered variables significantly improved the ability to identify high-risk patient groups.

---

# Statistical Analysis

Multiple statistical techniques were used to evaluate the relationship between patient characteristics and heart attack occurrence.

### Methods Used

| Statistical Method | Purpose |
|--------------------|---------|
| Pearson Correlation | Numerical relationships |
| Point-Biserial Correlation | Binary variables |
| ANOVA | Categorical comparison |
| Chi-Square Test | Independence testing |
| Odds Ratio | Clinical risk estimation |
| Random Forest | Feature importance |
| XGBoost | Predictive importance |

Using multiple statistical methods provides stronger evidence than relying on a single analytical technique.

---

# Key Statistical Findings

## ANOVA

Smoking status demonstrated the strongest association with heart attack occurrence.

| Feature | F-Score |
|---------|---------:|
| Smoking Status | 3166.08 |
| Cholesterol Class | 1728.97 |
| Fasting Blood Sugar Class | 303.14 |
| Age Class | 154.29 |

All major variables above were highly significant (p < 0.001).

---

## Pearson Correlation

Among numerical variables, the engineered Risk Score exhibited the strongest correlation with heart attack incidence.

| Feature | Correlation |
|---------|------------:|
| Risk Score | 0.316 |
| Age | 0.106 |
| Cholesterol Level | 0.093 |
| Fasting Blood Sugar | 0.070 |
| Waist Circumference | 0.068 |

---

## Binary Feature Analysis

The strongest binary predictors were:

| Feature | Correlation |
|---------|------------:|
| Previous Heart Disease | 0.275 |
| Hypertension | 0.269 |
| Diabetes | 0.195 |
| Obesity | 0.172 |
| Metabolic Syndrome | 0.117 |

---

## Odds Ratio Analysis

Odds Ratio was calculated to estimate the relative increase in heart attack risk.

| Risk Factor | Odds Ratio |
|-------------|-----------:|
| Previous Heart Disease | **4.05×** |
| Hypertension | **3.31×** |
| Diabetes | **2.65×** |
| Obesity | **2.22×** |
| Metabolic Syndrome | **1.62×** |

Patients with previous heart disease were approximately **four times more likely** to experience a heart attack than patients without prior cardiovascular disease.

Likewise, hypertension and diabetes substantially increased cardiovascular risk.

---

# Exploratory Data Analysis

EDA focused on understanding how demographic characteristics, medical conditions, and lifestyle habits influence cardiovascular outcomes.

Major analytical questions included:

- Which age groups experience the highest incidence?
- Does smoking significantly increase heart attack occurrence?
- Which biological factors contribute most to cardiovascular risk?
- How do lifestyle behaviors affect patient outcomes?
- Which engineered features improve risk stratification?
---

***
## Excel Project (till the problem with git get solved): [Link](https://drive.google.com/drive/folders/1xu7XkC9bDAchqBM4y-OontBZGSo49gDT)
### -The Habits Dashboard: This explains how habits affect the heart's health. Like, Bad Habits for women will cause higher heart attack rate especially for Elderly and Older Adult
<img width="1516" height="660" alt="image" src="https://github.com/user-attachments/assets/976d775c-f505-4655-99d9-bb2ed8ea514f" />

### -The Biological Dashboard: this explains how the biological side affects the heart's health. Like, Elderly Females with high colostrol and currently smoking the risk score is Higher and they have Diabits and Obasity problems. 
<img width="1512" height="662" alt="image" src="https://github.com/user-attachments/assets/daae5e67-27a5-4e34-ae09-045c374a7e85" />
***
## SQL Project
### Important Quieries:

### The Heart Attack incidence rate was significantly higher than the High-Risk Patient segment, indicating that heart attacks represent actual clinical outcomes, while the high-risk group identifies patients with elevated future risk. This analysis enables proactive healthcare resource allocation by prioritizing preventive monitoring and early intervention, helping hospitals shift from reactive treatment to predictive prevention.
<img width="1600" height="1200" alt="image" src="https://github.com/user-attachments/assets/5afc35e7-46bb-4daa-8066-46a47a4cef26" />

### This analysis challenged common assumptions by showing that age and blood glucose levels were stronger indicators of heart attack risk than blood pressure and cholesterol within this dataset. The findings highlight the importance of data-driven decision-making, demonstrating that the most predictive factors are not always the ones traditionally expected.
<img width="1600" height="1200" alt="image" src="https://github.com/user-attachments/assets/a5e3015c-521c-4957-99e4-d3ca8294b338" />


***
## Python Project
### -The Habits Dashboard: This explains how habits affect the heart's health. Like, Bad Habits for women will cause higher heart attack rate especially for Elderly and Older Adult
<img width="1516" height="660" alt="image" src="https://github.com/user-attachments/assets/976d775c-f505-4655-99d9-bb2ed8ea514f" />

### -The Biological Dashboard: this explains how the biological side affects the heart's health. Like, Elderly Females with metoblic syndrom have heart attack rate equels to 55.6%
<img width="1536" height="669" alt="image" src="https://github.com/user-attachments/assets/0db7ba90-abca-4523-919f-7c9c91f8a2ab" />

***
## Tableau Project
### -The Habits Dashboard: This explains how habits affect the heart's health. Like, Individuals aged 60 years and above experienced the highest heart attack rate (64.1%). Heart attack incidence increased markedly across the predefined risk groups, reaching 88.6% among high-risk individuals.
<img width="1279" height="638" alt="image" src="https://github.com/user-attachments/assets/40db52f0-0dd1-422e-91dc-29400314e155" />

***
## Power BI Project
### -The Habits Dashboard: This explains how habits affect the heart's health. Like, Bad Habits for women will cause higher heart attack rate especially for Elderly and Older Adult
<img width="1271" height="720" alt="image" src="https://github.com/user-attachments/assets/e6d43485-4965-486b-812e-1683c3237341" />

### -The Biological Dashboard: this explains how the biological side affects the heart's health. Like, Analysis revealed that unhealthy diet and low physical activity are the strongest lifestyle risk factors, with poor dietary habits accounting for 59% of all heart attack cases. Surprisingly, sleep duration, stress levels, and air pollution showed minimal variation in attack rates across categories, suggesting limited independent impact. Income level also played a notable role, with 85% of cases concentrated among middle and low-income patients. Overall, dietary and physical activity interventions appear to be the most impactful targets for heart attack prevention.
<img width="1271" height="720" alt="image" src="https://github.com/user-attachments/assets/35319114-8c9a-4335-b273-effbec726736" />

# Machine Learning Interpretation

Although the primary objective of this project was analytical rather than predictive modeling, ensemble learning techniques were employed to evaluate feature importance.

## Random Forest

Top contributing variables:

| Rank | Feature |
|------|---------|
| 1 | Previous Heart Disease |
| 2 | Risk Score |
| 3 | Cholesterol Level |
| 4 | Hypertension |
| 5 | Fasting Blood Sugar |

---

## XGBoost

Top contributing variables:

| Rank | Feature |
|------|---------|
| 1 | Previous Heart Disease |
| 2 | Hypertension |
| 3 | Risk Score |
| 4 | Diabetes |
| 5 | Obesity |

Both models consistently identified **Previous Heart Disease**, **Hypertension**, and the engineered **Risk Score** as the strongest predictors of heart attack occurrence.

---

# Key Findings

The analysis identified several important healthcare insights:

- Smoking was the strongest categorical predictor of heart attack occurrence.
- Previous heart disease increased the likelihood of heart attack by approximately fourfold.
- Hypertension and diabetes remained among the most influential clinical risk factors.
- The engineered Risk Score demonstrated the strongest numerical association with the target variable.
- Elderly patients consistently represented the highest-risk age group.
- Poor lifestyle behaviors substantially increased cardiovascular risk.
- Combining statistical analysis with feature engineering provided more meaningful insights than relying on individual variables alone.

---

# Business Value

This project demonstrates how healthcare analytics can support evidence-based decision-making.

Potential applications include:

- Identifying high-risk patients before clinical deterioration.
- Prioritizing preventive healthcare resources.
- Supporting physician decision-making.
- Improving public health planning.
- Guiding lifestyle intervention programs.
- Enhancing cardiovascular screening strategies.

---

# Recommendations

Based on the analytical findings, the following recommendations are proposed:

- Prioritize continuous monitoring for patients with previous cardiovascular disease.
- Expand hypertension and diabetes management programs.
- Strengthen smoking cessation initiatives, as smoking showed the strongest statistical association with heart attack incidence.
- Promote healthier dietary habits and increased physical activity through community-based intervention programs.
- Integrate engineered indicators such as **Risk Score** and **Metabolic Syndrome** into clinical risk assessment workflows.
- Increase preventive screening efforts among elderly populations and low-income communities.
- Develop interactive decision-support dashboards for hospitals to identify high-risk patients in real time.

---

# Limitations

Several limitations should be considered when interpreting the results:

- The dataset represents the Indonesian population and may not generalize to other countries.
- Observational data cannot establish causal relationships.
- Some variables are self-reported and may contain reporting bias.
- The findings are intended to support clinical decision-making rather than replace medical diagnosis.

---

# Future Work

Potential future improvements include:

- Build and compare additional machine learning models.
- Deploy the project as a Streamlit web application.
- Develop automated ETL pipelines for healthcare data.
- Integrate real-time electronic health records.
- Compare cardiovascular risk patterns across multiple countries.
- Perform explainable AI analysis using SHAP and LIME.

---

# Technologies Used

| Category | Tools |
|----------|------|
| Programming | Python |
| Data Analysis | Pandas, NumPy |
| Visualization | Matplotlib, Plotly |
| Statistical Analysis | SciPy, Statsmodels |
| Machine Learning | Scikit-learn, XGBoost |
| Database | SQL |
| Dashboards | Excel, Tableau, Power BI |
| Version Control | Git & GitHub |

---
# References

- World Health Organization (WHO)
- American Diabetes Association (ADA)
- NCEP ATP III Guidelines
- Indonesian Society of Hypertension
- Riskesdas Indonesia
- Kaggle Heart Attack Prediction Dataset

---

## Conclusion

This project demonstrates how statistical analysis, feature engineering, SQL analytics, and interactive dashboards can transform healthcare data into actionable insights. By combining multiple analytical techniques across different tools, the project provides a comprehensive understanding of cardiovascular risk factors and supports evidence-based healthcare decision-making.
