SELECT  * FROM dbo.Heart_attck_cleaned;

-- Add unique patient identifier as primary key
ALTER TABLE dbo.Heart_attck_cleaned
ADD patient_id INT IDENTITY(1,1) PRIMARY KEY;


-- ============================================
-- STEP 1: Check row count and preview data
-- ============================================

SELECT COUNT(*) AS total_rows FROM dbo.Heart_attck_cleaned;
SELECT TOP 10 * FROM dbo.Heart_attck_cleaned;

-- ============================================
-- STEP 2: Check NULL values across all columns
-- ============================================

SELECT
    -- Original columns
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
    -- Classification columns
    SUM(CASE WHEN age_class IS NULL THEN 1 ELSE 0 END) AS age_class_null,
    SUM(CASE WHEN waist_class IS NULL THEN 1 ELSE 0 END) AS waist_class_null,
    SUM(CASE WHEN bp_systolic_class IS NULL THEN 1 ELSE 0 END) AS bp_sys_class_null,
    SUM(CASE WHEN bp_diastolic_class IS NULL THEN 1 ELSE 0 END) AS bp_dia_class_null,
    SUM(CASE WHEN fasting_class IS NULL THEN 1 ELSE 0 END) AS fasting_class_null,
    SUM(CASE WHEN cholesterol_class IS NULL THEN 1 ELSE 0 END) AS chol_class_null,
    SUM(CASE WHEN ldl_class IS NULL THEN 1 ELSE 0 END) AS ldl_class_null,
    SUM(CASE WHEN hdl_class IS NULL THEN 1 ELSE 0 END) AS hdl_class_null,
    SUM(CASE WHEN triglycerides_class IS NULL THEN 1 ELSE 0 END) AS trig_class_null,
    SUM(CASE WHEN sleep_class IS NULL THEN 1 ELSE 0 END) AS sleep_class_null,
    -- Score columns
    SUM(CASE WHEN risk_score IS NULL THEN 1 ELSE 0 END) AS risk_score_null,
    SUM(CASE WHEN metabolic_syndrome IS NULL THEN 1 ELSE 0 END) AS metabolic_null,
    SUM(CASE WHEN lifestyle_score IS NULL THEN 1 ELSE 0 END) AS lifestyle_null,
    SUM(CASE WHEN stress_risk IS NULL THEN 1 ELSE 0 END) AS stress_risk_null,
    SUM(CASE WHEN heart_risk_group IS NULL THEN 1 ELSE 0 END) AS heart_risk_null,
    SUM(CASE WHEN tg_hdl_ratio IS NULL THEN 1 ELSE 0 END) AS tg_hdl_null,
    SUM(CASE WHEN pulse_pressure IS NULL THEN 1 ELSE 0 END) AS pulse_null,
    COUNT(*) AS total_rows
FROM dbo.Heart_attck_cleaned;

-- ============================================
-- STEP 3: Check distinct values in categorical columns
-- ============================================

SELECT DISTINCT gender FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT region FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT income_level FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT smoking_status FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT physical_activity FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT dietary_habits FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT air_pollution_exposure FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT stress_level FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT EKG_results FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT heart_risk_group FROM dbo.Heart_attck_cleaned;

-- ============================================
-- STEP 4: Check min, max, avg for numeric columns
-- ============================================

SELECT 'age' AS col, MIN(age) AS min_val, MAX(age) AS max_val, AVG(age*1.0) AS avg_val
FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'cholesterol_level', MIN(cholesterol_level), MAX(cholesterol_level), AVG(cholesterol_level*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'waist_circumference', MIN(waist_circumference), MAX(waist_circumference), AVG(waist_circumference*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'sleep_hours', MIN(sleep_hours), MAX(sleep_hours), AVG(sleep_hours) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'blood_pressure_systolic', MIN(blood_pressure_systolic), MAX(blood_pressure_systolic), AVG(blood_pressure_systolic*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'blood_pressure_diastolic', MIN(blood_pressure_diastolic), MAX(blood_pressure_diastolic), AVG(blood_pressure_diastolic*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'fasting_blood_sugar', MIN(fasting_blood_sugar), MAX(fasting_blood_sugar), AVG(fasting_blood_sugar*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'cholesterol_hdl', MIN(cholesterol_hdl), MAX(cholesterol_hdl), AVG(cholesterol_hdl*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'cholesterol_ldl', MIN(cholesterol_ldl), MAX(cholesterol_ldl), AVG(cholesterol_ldl*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'triglycerides', MIN(triglycerides), MAX(triglycerides), AVG(triglycerides*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'risk_score', MIN(risk_score), MAX(risk_score), AVG(risk_score*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'lifestyle_score', MIN(lifestyle_score), MAX(lifestyle_score), AVG(lifestyle_score*1.0) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'tg_hdl_ratio', MIN(tg_hdl_ratio), MAX(tg_hdl_ratio), AVG(tg_hdl_ratio) FROM dbo.Heart_attck_cleaned
UNION ALL
SELECT 'pulse_pressure', MIN(pulse_pressure), MAX(pulse_pressure), AVG(pulse_pressure*1.0) FROM dbo.Heart_attck_cleaned

-- ============================================
-- STEP 5: Check for duplicate rows
-- ============================================

SELECT age, gender, region, cholesterol_level,
       blood_pressure_systolic, blood_pressure_diastolic,
       heart_attack, COUNT(*) AS cnt
FROM dbo.Heart_attck_cleaned
GROUP BY age, gender, region, cholesterol_level,
         blood_pressure_systolic, blood_pressure_diastolic, heart_attack
HAVING COUNT(*) > 1;

-- ============================================
-- STEP 6: Logical consistency checks
-- ============================================


-- Check negative values in numeric columns
SELECT patient_id, cholesterol_ldl, cholesterol_hdl, triglycerides
FROM dbo.Heart_attck_cleaned
WHERE cholesterol_ldl < 0 OR cholesterol_hdl < 0 OR triglycerides < 0;

-- ============================================
-- STEP 7: Verify binary columns contain only 0 and 1
-- ============================================

SELECT DISTINCT hypertension FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT diabetes FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT obesity FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT family_history FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT previous_heart_disease FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT medication_usage FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT participated_in_free_screening FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT heart_attack FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT metabolic_syndrome FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT diabetes_obesity FROM dbo.Heart_attck_cleaned;
SELECT DISTINCT smoking_stress FROM dbo.Heart_attck_cleaned;



/*==============================================================
 STEP: CALCULATE QUARTILES FOR ALL NUMERIC VARIABLES
==============================================================*/

WITH Quartiles AS
(
    SELECT

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cholesterol_level) OVER() AS Q1_cholesterol,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cholesterol_level) OVER() AS Q3_cholesterol,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY waist_circumference) OVER() AS Q1_waist,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY waist_circumference) OVER() AS Q3_waist,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY blood_pressure_systolic) OVER() AS Q1_sys,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY blood_pressure_systolic) OVER() AS Q3_sys,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY blood_pressure_diastolic) OVER() AS Q1_dia,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY blood_pressure_diastolic) OVER() AS Q3_dia,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY fasting_blood_sugar) OVER() AS Q1_fbs,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY fasting_blood_sugar) OVER() AS Q3_fbs,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cholesterol_hdl) OVER() AS Q1_hdl,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cholesterol_hdl) OVER() AS Q3_hdl,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cholesterol_ldl) OVER() AS Q1_ldl,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cholesterol_ldl) OVER() AS Q3_ldl,

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY triglycerides) OVER() AS Q1_tg,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY triglycerides) OVER() AS Q3_tg

    FROM Heart_attck_cleaned
)

SELECT DISTINCT *
FROM Quartiles;

