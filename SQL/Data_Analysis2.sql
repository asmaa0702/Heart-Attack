select *
 from dbo.heart_attack_prediction_indonesia 

 -- Add a unique patient identifier as primary key
ALTER TABLE dbo.heart_attack_prediction_indonesia
ADD patient_id INT IDENTITY(1,1) PRIMARY KEY;

-- Missing values summary 

 SELECT 
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_null,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_null,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS region_null,
    SUM(CASE WHEN income_level IS NULL THEN 1 ELSE 0 END) AS income_level_null,
    SUM(CASE WHEN hypertension IS NULL THEN 1 ELSE 0 END) AS hypertension_null,
    SUM(CASE WHEN diabetes IS NULL THEN 1 ELSE 0 END) AS diabetes_null,
    SUM(CASE WHEN cholesterol_level IS NULL THEN 1 ELSE 0 END) AS cholesterol_level_null,
    SUM(CASE WHEN obesity IS NULL THEN 1 ELSE 0 END) AS obesity_null,
    SUM(CASE WHEN waist_circumference IS NULL THEN 1 ELSE 0 END) AS waist_null,
    SUM(CASE WHEN family_history IS NULL THEN 1 ELSE 0 END) AS family_history_null,
    SUM(CASE WHEN smoking_status IS NULL THEN 1 ELSE 0 END) AS smoking_null,
    SUM(CASE WHEN alcohol_consumption IS NULL THEN 1 ELSE 0 END) AS alcohol_null,
    SUM(CASE WHEN physical_activity IS NULL THEN 1 ELSE 0 END) AS activity_null,
    SUM(CASE WHEN dietary_habits IS NULL THEN 1 ELSE 0 END) AS diet_null,
    SUM(CASE WHEN air_pollution_exposure IS NULL THEN 1 ELSE 0 END) AS pollution_null,
    SUM(CASE WHEN stress_level IS NULL THEN 1 ELSE 0 END) AS stress_null,
    SUM(CASE WHEN sleep_hours IS NULL THEN 1 ELSE 0 END) AS sleep_null,
    SUM(CASE WHEN blood_pressure_systolic IS NULL THEN 1 ELSE 0 END) AS bp_sys_null,
    SUM(CASE WHEN blood_pressure_diastolic IS NULL THEN 1 ELSE 0 END) AS bp_dia_null,
    SUM(CASE WHEN fasting_blood_sugar IS NULL THEN 1 ELSE 0 END) AS fbs_null,
    SUM(CASE WHEN cholesterol_hdl IS NULL THEN 1 ELSE 0 END) AS hdl_null,
    SUM(CASE WHEN cholesterol_ldl IS NULL THEN 1 ELSE 0 END) AS ldl_null,
    SUM(CASE WHEN triglycerides IS NULL THEN 1 ELSE 0 END) AS trig_null,
    SUM(CASE WHEN EKG_results IS NULL THEN 1 ELSE 0 END) AS ekg_null,
    SUM(CASE WHEN previous_heart_disease IS NULL THEN 1 ELSE 0 END) AS prev_disease_null,
    SUM(CASE WHEN medication_usage IS NULL THEN 1 ELSE 0 END) AS med_null,
    SUM(CASE WHEN participated_in_free_screening IS NULL THEN 1 ELSE 0 END) AS screening_null,
    SUM(CASE WHEN heart_attack IS NULL THEN 1 ELSE 0 END) AS heart_attack_null,
    COUNT(*) AS total_rows
FROM dbo.heart_attack_prediction_indonesia;

--Check for duplicate rows

SELECT age, gender, region, income_level, hypertension, diabetes,
       cholesterol_level, obesity, waist_circumference, family_history,
       smoking_status, alcohol_consumption, physical_activity, dietary_habits,
       air_pollution_exposure, stress_level, sleep_hours,
       blood_pressure_systolic, blood_pressure_diastolic, fasting_blood_sugar,
       cholesterol_hdl, cholesterol_ldl, triglycerides, EKG_results,
       previous_heart_disease, medication_usage, participated_in_free_screening,
       heart_attack,
       COUNT(*) AS cnt
FROM dbo.heart_attack_prediction_indonesia
GROUP BY age, gender, region, income_level, hypertension, diabetes,
         cholesterol_level, obesity, waist_circumference, family_history,
         smoking_status, alcohol_consumption, physical_activity, dietary_habits,
         air_pollution_exposure, stress_level, sleep_hours,
         blood_pressure_systolic, blood_pressure_diastolic, fasting_blood_sugar,
         cholesterol_hdl, cholesterol_ldl, triglycerides, EKG_results,
         previous_heart_disease, medication_usage, participated_in_free_screening,
         heart_attack
HAVING COUNT(*) > 1;

-- ============================================
-- STEP 4: Check distinct values in categorical columns
-- to detect inconsistent or misspelled entries
-- ============================================
SELECT DISTINCT gender FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT region FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT income_level FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT smoking_status FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT alcohol_consumption FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT physical_activity FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT dietary_habits FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT air_pollution_exposure FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT stress_level FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT EKG_results FROM dbo.heart_attack_prediction_indonesia;

-- Verify binary columns only contain 0 or 1 (no invalid values)
SELECT DISTINCT hypertension FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT diabetes FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT obesity FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT family_history FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT previous_heart_disease FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT medication_usage FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT participated_in_free_screening FROM dbo.heart_attack_prediction_indonesia;
SELECT DISTINCT heart_attack FROM dbo.heart_attack_prediction_indonesia;

-- ============================================
--  Check min, max, and average for numeric columns
-- to detect outliers and unrealistic values
-- ============================================
SELECT 'age' AS col, MIN(age) AS min_val, MAX(age) AS max_val, AVG(age*1.0) AS avg_val 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'cholesterol_level', MIN(cholesterol_level), MAX(cholesterol_level), AVG(cholesterol_level*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'waist_circumference', MIN(waist_circumference), MAX(waist_circumference), AVG(waist_circumference*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'sleep_hours', MIN(sleep_hours), MAX(sleep_hours), AVG(sleep_hours) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'blood_pressure_systolic', MIN(blood_pressure_systolic), MAX(blood_pressure_systolic), AVG(blood_pressure_systolic*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'blood_pressure_diastolic', MIN(blood_pressure_diastolic), MAX(blood_pressure_diastolic), AVG(blood_pressure_diastolic*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'fasting_blood_sugar', MIN(fasting_blood_sugar), MAX(fasting_blood_sugar), AVG(fasting_blood_sugar*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'cholesterol_hdl', MIN(cholesterol_hdl), MAX(cholesterol_hdl), AVG(cholesterol_hdl*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'cholesterol_ldl', MIN(cholesterol_ldl), MAX(cholesterol_ldl), AVG(cholesterol_ldl*1.0) 
FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'triglycerides', MIN(triglycerides), MAX(triglycerides), AVG(triglycerides*1.0) 
FROM dbo.heart_attack_prediction_indonesia;

-- ============================================
-- Outlier Detection using IQR Method
-- IQR = Q3 - Q1
-- Lower Bound = Q1 - 1.5 * IQR
-- Upper Bound = Q3 + 1.5 * IQR
-- ============================================

-- Step 1: Calculate Q1, Q3, and IQR for each numeric column
WITH Quartiles AS (
    SELECT
        -- cholesterol_ldl
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cholesterol_ldl) 
            OVER() AS Q1_ldl,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cholesterol_ldl) 
            OVER() AS Q3_ldl,

        -- cholesterol_hdl
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cholesterol_hdl) 
            OVER() AS Q1_hdl,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cholesterol_hdl) 
            OVER() AS Q3_hdl,

        -- cholesterol_level
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cholesterol_level) 
            OVER() AS Q1_chol,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cholesterol_level) 
            OVER() AS Q3_chol,

        -- blood_pressure_systolic
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY blood_pressure_systolic) 
            OVER() AS Q1_sys,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY blood_pressure_systolic) 
            OVER() AS Q3_sys,

        -- blood_pressure_diastolic
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY blood_pressure_diastolic) 
            OVER() AS Q1_dia,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY blood_pressure_diastolic) 
            OVER() AS Q3_dia,

        -- fasting_blood_sugar
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY fasting_blood_sugar) 
            OVER() AS Q1_fbs,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY fasting_blood_sugar) 
            OVER() AS Q3_fbs,

        -- triglycerides
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY triglycerides) 
            OVER() AS Q1_trig,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY triglycerides) 
            OVER() AS Q3_trig,

        -- age
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age) 
            OVER() AS Q1_age,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age) 
            OVER() AS Q3_age,

        patient_id, age, gender,
        cholesterol_ldl, cholesterol_hdl, cholesterol_level,
        blood_pressure_systolic, blood_pressure_diastolic,
        fasting_blood_sugar, triglycerides

    FROM dbo.heart_attack_prediction_indonesia
)

-- Step 2: Flag rows that fall outside the IQR bounds
SELECT patient_id, age, gender,
       cholesterol_ldl, cholesterol_hdl, cholesterol_level,
       blood_pressure_systolic, blood_pressure_diastolic,
       fasting_blood_sugar, triglycerides
FROM Quartiles
WHERE
    -- cholesterol_ldl outliers
    cholesterol_ldl < (Q1_ldl - 1.5 * (Q3_ldl - Q1_ldl)) OR
    cholesterol_ldl > (Q3_ldl + 1.5 * (Q3_ldl - Q1_ldl)) OR

    -- cholesterol_hdl outliers
    cholesterol_hdl < (Q1_hdl - 1.5 * (Q3_hdl - Q1_hdl)) OR
    cholesterol_hdl > (Q3_hdl + 1.5 * (Q3_hdl - Q1_hdl)) OR

    -- cholesterol_level outliers
    cholesterol_level < (Q1_chol - 1.5 * (Q3_chol - Q1_chol)) OR
    cholesterol_level > (Q3_chol + 1.5 * (Q3_chol - Q1_chol)) OR

    -- blood_pressure_systolic outliers
    blood_pressure_systolic < (Q1_sys - 1.5 * (Q3_sys - Q1_sys)) OR
    blood_pressure_systolic > (Q3_sys + 1.5 * (Q3_sys - Q1_sys)) OR

    -- blood_pressure_diastolic outliers
    blood_pressure_diastolic < (Q1_dia - 1.5 * (Q3_dia - Q1_dia)) OR
    blood_pressure_diastolic > (Q3_dia + 1.5 * (Q3_dia - Q1_dia)) OR

    -- fasting_blood_sugar outliers
    fasting_blood_sugar < (Q1_fbs - 1.5 * (Q3_fbs - Q1_fbs)) OR
    fasting_blood_sugar > (Q3_fbs + 1.5 * (Q3_fbs - Q1_fbs)) OR

    -- triglycerides outliers
    triglycerides < (Q1_trig - 1.5 * (Q3_trig - Q1_trig)) OR
    triglycerides > (Q3_trig + 1.5 * (Q3_trig - Q1_trig)) OR

    -- age outliers
    age < (Q1_age - 1.5 * (Q3_age - Q1_age)) OR
    age > (Q3_age + 1.5 * (Q3_age - Q1_age))

ORDER BY patient_id;


  

 