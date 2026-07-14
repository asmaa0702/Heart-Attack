/*==============================================================
    HEART ATTACK ANALYSIS - PART 1
    Dataset: Heart_attck_cleaned
==============================================================*/

---------------------------------------------------------------
-- 1. Calculates the total volume and percentage of heart attack
--    incidents across genders.
---------------------------------------------------------------

SELECT
    gender,
    COUNT(*) AS Total_Patients,
    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,
    ROUND(
        SUM(CAST(heart_attack AS FLOAT)) * 100.0 / COUNT(*)
    ,2) AS Heart_Attack_Percentage
FROM Heart_attck_cleaned
GROUP BY gender;
GO

---------------------------------------------------------------
-- 2. Analyzes heart attack distribution across age groups.
---------------------------------------------------------------

SELECT

    CASE

        WHEN age < 35 THEN 'Youth (<35)'

        WHEN age BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'

        ELSE 'Senior (>55)'

    END AS Age_Group,

    COUNT(*) AS Total_Patients,

    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,

    ROUND(

        SUM(CAST(heart_attack AS FLOAT))*100.0/COUNT(*)

    ,2) AS Risk_Percentage

FROM Heart_attck_cleaned

GROUP BY

CASE

        WHEN age <35 THEN 'Youth (<35)'

        WHEN age BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'

        ELSE 'Senior (>55)'

END

ORDER BY Risk_Percentage DESC;

GO

---------------------------------------------------------------
-- 3. Baseline Medical Statistics
---------------------------------------------------------------

SELECT

    heart_attack,

    COUNT(*) AS Patient_Count,

    ROUND(AVG(CAST(blood_pressure_systolic AS FLOAT)),2) AS Avg_Systolic_BP,

    ROUND(AVG(CAST(fasting_blood_sugar AS FLOAT)),2) AS Avg_Blood_Sugar,

    ROUND(AVG(CAST(cholesterol_ldl AS FLOAT)),2) AS Avg_Bad_Cholesterol_LDL,

    ROUND(AVG(CAST(triglycerides AS FLOAT)),2) AS Avg_Triglycerides

FROM Heart_attck_cleaned

GROUP BY heart_attack;

GO

/*==============================================================
 ANALYSIS 1
 Descriptive Statistics
==============================================================*/

SELECT

    heart_attack,

    COUNT(*) AS Patient_Count,

    ROUND(AVG(CAST(blood_pressure_systolic AS FLOAT)),2) AS Avg_Systolic_BP,

    ROUND(AVG(CAST(fasting_blood_sugar AS FLOAT)),2) AS Avg_Blood_Sugar,

    ROUND(AVG(CAST(cholesterol_ldl AS FLOAT)),2) AS Avg_Bad_Cholesterol_LDL,

    ROUND(AVG(CAST(triglycerides AS FLOAT)),2) AS Avg_Triglycerides

FROM Heart_attck_cleaned

GROUP BY heart_attack;

GO

/*==============================================================
 ANALYSIS 2
 Cholesterol Class Risk Analysis
==============================================================*/

SELECT

    cholesterol_class,

    COUNT(*) AS Total_Patients,

    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,

    ROUND(

        SUM(CAST(heart_attack AS FLOAT))*100.0/COUNT(*)

    ,2) AS Heart_Attack_Percentage

FROM Heart_attck_cleaned

GROUP BY cholesterol_class

ORDER BY cholesterol_class;

GO

---------------------------------------------------------------
-- 4. Regional Environment & Sleep Analysis
---------------------------------------------------------------

SELECT

    region,

    ROUND(AVG(CAST(sleep_hours AS FLOAT)),2) AS Avg_Sleep_Hours,

    SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,

    ROUND(

        SUM(CAST(heart_attack AS FLOAT))*100.0/COUNT(*)

    ,2) AS Regional_Risk_Rate

FROM Heart_attck_cleaned

GROUP BY region;

GO

---------------------------------------------------------------
-- 5. Waist Circumference Risk Analysis
---------------------------------------------------------------

SELECT

CASE

WHEN waist_circumference>100

THEN 'High Risk (Waist >100 cm)'

ELSE 'Normal / Low Risk'

END AS Weight_Risk_Category,

COUNT(*) AS Total_Patients,

SUM(CAST(heart_attack AS INT)) AS Heart_Attack_Cases,

ROUND(

SUM(CAST(heart_attack AS FLOAT))*100.0/COUNT(*)

,2) AS Incidence_Rate

FROM Heart_attck_cleaned

GROUP BY

CASE

WHEN waist_circumference>100

THEN 'High Risk (Waist >100 cm)'

ELSE 'Normal / Low Risk'

END;

GO