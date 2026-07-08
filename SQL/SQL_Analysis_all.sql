USE [depi]; 
GO

-- 1. Calculates the total volume and percentage of heart attack incidents across genders.
SELECT 
    h.gender,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Heart_Attack_Percentage
FROM dbo.heart_attack_prediction_indonesia AS h
GROUP BY h.gender;
GO

-- 2. Analyzes heart attack distribution across customized physiological age groups.
SELECT 
    CASE 
        WHEN CAST(h.age AS INT) < 35 THEN 'Youth (<35)'
        WHEN CAST(h.age AS INT) BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'
        ELSE 'Senior (>55)'
    END AS Age_Group,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack_prediction_indonesia AS h
GROUP BY 
    CASE 
        WHEN CAST(h.age AS INT) < 35 THEN 'Youth (<35)'
        WHEN CAST(h.age AS INT) BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'
        ELSE 'Senior (>55)'
    END
ORDER BY Risk_Percentage DESC;
GO

-- 3. Compares baseline medical averages between healthy patients and heart attack cases.
SELECT 
    h.heart_attack,
    COUNT(*) AS Patient_Count,
    ROUND(AVG(CAST(h.blood_pressure_systolic AS FLOAT)), 2) AS Avg_Systolic_BP,
    ROUND(AVG(CAST(h.fasting_blood_sugar AS FLOAT)), 2) AS Avg_Blood_Sugar,
    ROUND(AVG(CAST(h.cholesterol_ldl AS FLOAT)), 2) AS Avg_Bad_Cholesterol_LDL,
    ROUND(AVG(CAST(h.triglycerides AS FLOAT)), 2) AS Avg_Triglycerides
FROM dbo.heart_attack_prediction_indonesia AS h
GROUP BY h.heart_attack;
GO

-- 4. Evaluates the cross-impact of regional environments and average sleep cycles on heart health.
SELECT 
    h.region,
    ROUND(AVG(CAST(h.sleep_hours AS FLOAT)), 2) AS Avg_Sleep_Hours,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Regional_Risk_Rate
FROM dbo.heart_attack_prediction_indonesia AS h
GROUP BY h.region;
GO

-- 5. Measures the correlation between elevated waist circumference metrics and heart attack volumes.
SELECT 
    CASE 
        WHEN CAST(h.waist_circumference AS FLOAT) > 100 THEN 'High Risk (Waist > 100cm)'
        ELSE 'Normal/Low Risk (Waist <= 100cm)'
    END AS Weight_Risk_Category,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Incidence_Rate
FROM dbo.heart_attack_prediction_indonesia AS h
GROUP BY 
    CASE 
        WHEN CAST(h.waist_circumference AS FLOAT) > 100 THEN 'High Risk (Waist > 100cm)'
        ELSE 'Normal/Low Risk (Waist <= 100cm)'
    END;
GO

-- 6. Interactive Cross-Impact Analysis: Lifestyle & Chronic Diseases
SELECT 
    smoking_status, stress_level, hypertension, diabetes,
    COUNT(*) AS Total_Patients,
    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CAST(heart_attack AS INT)) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack_prediction_indonesia
GROUP BY smoking_status, stress_level, hypertension, diabetes
ORDER BY Risk_Percentage DESC;
GO

-- 7. Comprehensive Lipid Profile Index
SELECT 
    CASE WHEN TRY_CAST(cholesterol_ldl AS INT) > 130 THEN 'High LDL' ELSE 'Normal LDL' END AS ldl_class,
    CASE WHEN TRY_CAST(cholesterol_hdl AS INT) < 40 THEN 'Low HDL' ELSE 'Normal HDL' END AS hdl_class,
    CASE WHEN TRY_CAST(triglycerides AS INT) > 150 THEN 'High Triglycerides' ELSE 'Normal Triglycerides' END AS triglycerides_class,
    COUNT(*) AS Total_Patients,
    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CAST(heart_attack AS INT)) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack_prediction_indonesia
GROUP BY 
    CASE WHEN TRY_CAST(cholesterol_ldl AS INT) > 130 THEN 'High LDL' ELSE 'Normal LDL' END,
    CASE WHEN TRY_CAST(cholesterol_hdl AS INT) < 40 THEN 'Low HDL' ELSE 'Normal HDL' END,
    CASE WHEN TRY_CAST(triglycerides AS INT) > 150 THEN 'High Triglycerides' ELSE 'Normal Triglycerides' END
ORDER BY Risk_Percentage DESC;
GO

-- 8. Socio-Environmental Risk Matrix
SELECT 
    region, air_pollution_exposure,
    CASE 
        WHEN TRY_CAST(sleep_hours AS INT) < 6 THEN 'Poor (<6 hrs)'
        WHEN TRY_CAST(sleep_hours AS INT) BETWEEN 6 AND 8 THEN 'Optimal (6-8 hrs)'
        ELSE 'Excessive (>8 hrs)'
    END AS sleep_hours_class,
    COUNT(*) AS Total_Patients,
    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CAST(heart_attack AS INT)) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack_prediction_indonesia
GROUP BY region, air_pollution_exposure,
    CASE 
        WHEN TRY_CAST(sleep_hours AS INT) < 6 THEN 'Poor (<6 hrs)'
        WHEN TRY_CAST(sleep_hours AS INT) BETWEEN 6 AND 8 THEN 'Optimal (6-8 hrs)'
        ELSE 'Excessive (>8 hrs)'
    END
ORDER BY Risk_Percentage DESC;
GO

-- 9. Physical Activity Counter-Effect Analysis
SELECT 
    physical_activity, dietary_habits, alcohol_consumption,
    COUNT(*) AS Total_Patients,
    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CAST(heart_attack AS INT)) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack_prediction_indonesia
GROUP BY physical_activity, dietary_habits, alcohol_consumption
ORDER BY Risk_Percentage DESC;
GO

-- 10. Financial & Socioeconomic Risk Distribution
SELECT 
    income_level, region,
    COUNT(*) AS Total_Patients,
    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CAST(heart_attack AS INT)) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack_prediction_indonesia
GROUP BY income_level, region
ORDER BY Risk_Percentage DESC;
GO
 /* 
   Dashboard Commentary:
   This analysis compares the General Incidence Rate with the 
   High-Risk Segment penetration (Total High-Risk patients relative to the entire cohort). 
   While the general rate reflects the overall clinical burden, the 4.3% segment 
   represents the critical cluster requiring prioritized preventive intervention.
*/

SELECT 
    -- General Incidence Rate: (Total Heart Attacks / Total Patients) * 100
    AVG(CASE WHEN heart_attack = 1 THEN 1.0 ELSE 0.0 END) * 100 AS General_Incidence_Rate,
    
    -- High-Risk Segment Penetration: (Total High-Risk Patients / Total Patients) * 100
    (CAST(SUM(CASE WHEN is_outlier = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100 AS High_Risk_Segment_Rate
FROM dbo.heart_attack_prediction_indonesia;
GO