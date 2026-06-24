USE depi;
GO                     
-- Calculates the total volume and percentage of heart attack incidents across genders.
SELECT 
    h.gender,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Heart_Attack_Percentage
FROM dbo.heart_attack AS h
GROUP BY h.gender;
GO


-- Analyzes heart attack distribution across customized physiological age groups.
SELECT 
    CASE 
        WHEN CAST(h.age AS INT) < 35 THEN 'Youth (<35)'
        WHEN CAST(h.age AS INT) BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'
        ELSE 'Senior (>55)'
    END AS Age_Group,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Risk_Percentage
FROM dbo.heart_attack AS h
GROUP BY 
    CASE 
        WHEN CAST(h.age AS INT) < 35 THEN 'Youth (<35)'
        WHEN CAST(h.age AS INT) BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'
        ELSE 'Senior (>55)'
    END
ORDER BY Risk_Percentage DESC;
GO



-- Compares baseline medical averages between healthy patients and heart attack cases.
SELECT 
    h.heart_attack,
    COUNT(*) AS Patient_Count,
    ROUND(AVG(CAST(h.blood_pressure_systolic AS FLOAT)), 2) AS Avg_Systolic_BP,
    ROUND(AVG(CAST(h.fasting_blood_sugar AS FLOAT)), 2) AS Avg_Blood_Sugar,
    ROUND(AVG(CAST(h.cholesterol_ldl AS FLOAT)), 2) AS Avg_Bad_Cholesterol_LDL,
    ROUND(AVG(CAST(h.triglycerides AS FLOAT)), 2) AS Avg_Triglycerides
FROM dbo.heart_attack AS h
GROUP BY h.heart_attack;
GO


-- Evaluates the cross-impact of regional environments and average sleep cycles on heart health.
SELECT 
    h.region,
    ROUND(AVG(CAST(h.sleep_hours AS FLOAT)), 2) AS Avg_Sleep_Hours,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Regional_Risk_Rate
FROM dbo.heart_attack AS h
GROUP BY h.region;
GO


-- Measures the correlation between elevated waist circumference metrics and heart attack volumes.
SELECT 
    CASE 
        WHEN CAST(h.waist_circumference AS FLOAT) > 100 THEN 'High Risk (Waist > 100cm)'
        ELSE 'Normal/Low Risk (Waist <= 100cm)'
    END AS Weight_Risk_Category,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS Heart_Attack_Cases,
    ROUND(CAST(SUM(CASE WHEN h.heart_attack = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS Incidence_Rate
FROM dbo.heart_attack AS h
GROUP BY 
    CASE 
        WHEN CAST(h.waist_circumference AS FLOAT) > 100 THEN 'High Risk (Waist > 100cm)'
        ELSE 'Normal/Low Risk (Waist <= 100cm)'
    END;
GO