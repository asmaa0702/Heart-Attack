-- ============================================
-- STEP 1: Create Dimension Tables
-- ============================================

-- dim_demographics: Patient demographic information
CREATE TABLE dim_demographics (
    demographic_id INT IDENTITY(1,1) PRIMARY KEY,
    gender VARCHAR(10),
    age TINYINT,
    age_class VARCHAR(20),
    region VARCHAR(20),
    income_level VARCHAR(20)
);

-- dim_lifestyle: Patient lifestyle habits
CREATE TABLE dim_lifestyle (
    lifestyle_id INT IDENTITY(1,1) PRIMARY KEY,
    smoking_status VARCHAR(20),
    alcohol_consumption VARCHAR(20),
    physical_activity VARCHAR(20),
    dietary_habits VARCHAR(20),
    sleep_hours FLOAT,
    sleep_hours_class VARCHAR(20),
    stress_level VARCHAR(20)
);

-- dim_medical: Patient medical history
CREATE TABLE dim_medical (
    medical_id INT IDENTITY(1,1) PRIMARY KEY,
    hypertension BIT,
    diabetes BIT,
    obesity BIT,
    family_history BIT,
    previous_heart_disease BIT,
    medication_usage BIT,
    participated_in_free_screening BIT
);

-- dim_environment: Environmental and physical factors
CREATE TABLE dim_environment (
    environment_id INT IDENTITY(1,1) PRIMARY KEY,
    air_pollution_exposure VARCHAR(20),
    waist_circumference SMALLINT,
    waist_circumference_class VARCHAR(20)
);

-- dim_labs: Lab results and measurements
CREATE TABLE dim_labs (
    labs_id INT IDENTITY(1,1) PRIMARY KEY,
    cholesterol_level SMALLINT,
    cholesterol_class VARCHAR(20),
    cholesterol_hdl SMALLINT,
    hdl_class VARCHAR(20),
    cholesterol_ldl SMALLINT,
    ldl_class VARCHAR(20),
    triglycerides SMALLINT,
    triglycerides_class VARCHAR(20),
    fasting_blood_sugar SMALLINT,
    fasting_blood_sugar_class VARCHAR(20),
    blood_pressure_systolic SMALLINT,
    blood_pressure_diastolic SMALLINT,
    systolic_diastolic_class VARCHAR(30),
    ekg_results VARCHAR(20)
);

-- ============================================
-- STEP 2: Populate Dimension Tables from Staging
-- ============================================

-- Populate dim_demographics
INSERT INTO dim_demographics (gender, age, age_class, region, income_level)
SELECT DISTINCT gender, age, age_class, region, income_level
FROM dbo.heart_attack_prediction_indonesia;

-- Populate dim_lifestyle
INSERT INTO dim_lifestyle (smoking_status, alcohol_consumption, physical_activity, 
                           dietary_habits, sleep_hours, sleep_hours_class, stress_level)
SELECT DISTINCT smoking_status, alcohol_consumption, physical_activity,
                dietary_habits, sleep_hours, sleep_hours_class, stress_level
FROM dbo.heart_attack_prediction_indonesia;

-- Populate dim_medical
INSERT INTO dim_medical (hypertension, diabetes, obesity, family_history,
                         previous_heart_disease, medication_usage, participated_in_free_screening)
SELECT DISTINCT hypertension, diabetes, obesity, family_history,
                previous_heart_disease, medication_usage, participated_in_free_screening
FROM dbo.heart_attack_prediction_indonesia;

-- Populate dim_environment
INSERT INTO dim_environment (air_pollution_exposure, waist_circumference, waist_circumference_class)
SELECT DISTINCT air_pollution_exposure, waist_circumference, waist_circumference_class
FROM dbo.heart_attack_prediction_indonesia;

-- Populate dim_labs
INSERT INTO dim_labs (cholesterol_level, cholesterol_class, cholesterol_hdl, hdl_class,
                      cholesterol_ldl, ldl_class, triglycerides, triglycerides_class,
                      fasting_blood_sugar, fasting_blood_sugar_class,
                      blood_pressure_systolic, blood_pressure_diastolic,
                      systolic_diastolic_class, ekg_results)
SELECT DISTINCT cholesterol_level, cholesterol_class, cholesterol_hdl, hdl_class,
                cholesterol_ldl, ldl_class, triglycerides, triglycerides_class,
                fasting_blood_sugar, fasting_blood_sugar_class,
                blood_pressure_systolic, blood_pressure_diastolic,
                systolic_diastolic_class, ekg_results
FROM dbo.heart_attack_prediction_indonesia;


-- ============================================
-- STEP 3: Create Fact Table
-- ============================================

CREATE TABLE fact_heart_assessment (
    fact_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT,
    demographic_id INT FOREIGN KEY REFERENCES dim_demographics(demographic_id),
    lifestyle_id INT FOREIGN KEY REFERENCES dim_lifestyle(lifestyle_id),
    medical_id INT FOREIGN KEY REFERENCES dim_medical(medical_id),
    environment_id INT FOREIGN KEY REFERENCES dim_environment(environment_id),
    labs_id INT FOREIGN KEY REFERENCES dim_labs(labs_id),
    heart_attack BIT,
    is_outlier BIT
);


-- ============================================
-- STEP 4: Populate Fact Table
-- ============================================

INSERT INTO fact_heart_assessment (
    patient_id, demographic_id, lifestyle_id, medical_id, environment_id, labs_id,
    heart_attack, is_outlier
)
SELECT 
    s.patient_id,
    d.demographic_id,
    l.lifestyle_id,
    m.medical_id,
    e.environment_id,
    lb.labs_id,
    s.heart_attack,
    s.is_outlier
FROM dbo.heart_attack_prediction_indonesia s

JOIN dim_demographics d 
    ON s.gender = d.gender AND s.age = d.age AND s.age_class = d.age_class
    AND s.region = d.region AND s.income_level = d.income_level

JOIN dim_lifestyle l 
    ON s.smoking_status = l.smoking_status AND s.alcohol_consumption = l.alcohol_consumption
    AND s.physical_activity = l.physical_activity AND s.dietary_habits = l.dietary_habits
    AND s.sleep_hours = l.sleep_hours AND s.sleep_hours_class = l.sleep_hours_class
    AND s.stress_level = l.stress_level

JOIN dim_medical m 
    ON s.hypertension = m.hypertension AND s.diabetes = m.diabetes
    AND s.obesity = m.obesity AND s.family_history = m.family_history
    AND s.previous_heart_disease = m.previous_heart_disease
    AND s.medication_usage = m.medication_usage
    AND s.participated_in_free_screening = m.participated_in_free_screening

JOIN dim_environment e 
    ON s.air_pollution_exposure = e.air_pollution_exposure
    AND s.waist_circumference = e.waist_circumference
    AND s.waist_circumference_class = e.waist_circumference_class

JOIN dim_labs lb 
    ON s.cholesterol_level = lb.cholesterol_level AND s.cholesterol_class = lb.cholesterol_class
    AND s.cholesterol_hdl = lb.cholesterol_hdl AND s.hdl_class = lb.hdl_class
    AND s.cholesterol_ldl = lb.cholesterol_ldl AND s.ldl_class = lb.ldl_class
    AND s.triglycerides = lb.triglycerides AND s.triglycerides_class = lb.triglycerides_class
    AND s.fasting_blood_sugar = lb.fasting_blood_sugar
    AND s.fasting_blood_sugar_class = lb.fasting_blood_sugar_class
    AND s.blood_pressure_systolic = lb.blood_pressure_systolic
    AND s.blood_pressure_diastolic = lb.blood_pressure_diastolic
    AND s.systolic_diastolic_class = lb.systolic_diastolic_class
    AND s.ekg_results = lb.ekg_results;


-- ============================================
-- STEP 5: Verify the Star Schema
-- ============================================

-- Check row counts match
SELECT 'Staging'        AS source, COUNT(*) AS rows FROM dbo.heart_attack_prediction_indonesia
UNION ALL
SELECT 'Fact Table'     AS source, COUNT(*) AS rows FROM fact_heart_assessment
UNION ALL
SELECT 'dim_demographics' , COUNT(*) FROM dim_demographics
UNION ALL
SELECT 'dim_lifestyle'    , COUNT(*) FROM dim_lifestyle
UNION ALL
SELECT 'dim_medical'      , COUNT(*) FROM dim_medical
UNION ALL
SELECT 'dim_environment'  , COUNT(*) FROM dim_environment
UNION ALL
SELECT 'dim_labs'         , COUNT(*) FROM dim_labs;