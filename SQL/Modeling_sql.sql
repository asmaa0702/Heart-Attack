/*==============================================================
  STEP 1: CREATE DIMENSION TABLE - DEMOGRAPHICS
  Description:
  This table stores demographic information about each patient.
==============================================================*/

CREATE TABLE dim_demographics
(
    demographic_id INT IDENTITY(1,1) PRIMARY KEY,

    gender VARCHAR(20),
    age INT,
    age_class VARCHAR(50),
    region VARCHAR(50),
    income_level VARCHAR(50)
);

/*==============================================================
  STEP 2: CREATE DIMENSION TABLE - CLINICAL
  Description:
  Stores patients' clinical and medical characteristics.
==============================================================*/

CREATE TABLE dim_clinical
(
    clinical_id INT IDENTITY(1,1) PRIMARY KEY,

    hypertension BIT,
    diabetes BIT,
    cholesterol_level INT,
    cholesterol_class NVARCHAR(50),
    obesity BIT,
    waist_circumference INT,
    waist_class NVARCHAR(50),
    family_history BIT,
    diabetes_obesity BIT
);

/*==============================================================
  STEP3 : CREATE DIMENSION TABLE - LIFESTYLE
  Description:
  Stores lifestyle-related information.
==============================================================*/

CREATE TABLE dim_lifestyle
(
    lifestyle_id INT IDENTITY(1,1) PRIMARY KEY,

    smoking_status NVARCHAR(30),
    physical_activity NVARCHAR(30),
    dietary_habits NVARCHAR(30),
    lifestyle_score INT,
    smoking_stress BIT
);

/*==============================================================
  STEP 4: CREATE DIMENSION TABLE - ENVIRONMENT
  Description:
  Stores environmental and stress-related information.
==============================================================*/

CREATE TABLE dim_environment
(
    environment_id INT IDENTITY(1,1) PRIMARY KEY,

    air_pollution_exposure NVARCHAR(30),
    stress_level NVARCHAR(30),
    sleep_hours FLOAT,
    sleep_class NVARCHAR(30),
    stress_risk INT
);

/*==============================================================
  STEP 5: CREATE DIMENSION TABLE - SCREENING
  Description:
  Stores laboratory tests, blood pressure,
  lipid profile and screening information.
==============================================================*/

CREATE TABLE dim_screening
(
    screening_id INT IDENTITY(1,1) PRIMARY KEY,

    blood_pressure_systolic INT,
    bp_systolic_class NVARCHAR(50),

    blood_pressure_diastolic INT,
    bp_diastolic_class NVARCHAR(50),

    pulse_pressure INT,

    fasting_blood_sugar INT,
    fasting_class NVARCHAR(50),

    cholesterol_hdl INT,
    hdl_class NVARCHAR(50),

    cholesterol_ldl INT,
    ldl_class NVARCHAR(50),

    triglycerides INT,
    triglycerides_class NVARCHAR(50),

    tg_hdl_ratio FLOAT,

    EKG_results NVARCHAR(30),

    previous_heart_disease BIT,

    medication_usage BIT,

    participated_in_free_screening BIT
);

/*==============================================================
  STEP 6: CREATE DIMENSION TABLE - RISK
  Description:
  Stores patients' calculated cardiovascular risk.
==============================================================*/

CREATE TABLE dim_risk
(
    risk_id INT IDENTITY(1,1) PRIMARY KEY,

    risk_score INT,

    heart_risk_group NVARCHAR(30),

    metabolic_syndrome BIT
);


/*==============================================================
  STEP : LOAD DATA INTO DIM_DEMOGRAPHICS
  Description:
  Insert unique demographic records from the cleaned dataset.
==============================================================*/

INSERT INTO dim_demographics
(
    gender,
    age,
    age_class,
    region,
    income_level
)
SELECT DISTINCT
    gender,
    age,
    age_class,
    region,
    income_level
FROM Heart_attck_cleaned;

/*==============================================================
  STEP 2: LOAD DATA INTO DIM_CLINICAL
==============================================================*/

INSERT INTO dim_clinical
(
    hypertension,
    diabetes,
    cholesterol_level,
    cholesterol_class,
    obesity,
    waist_circumference,
    waist_class,
    family_history,
    diabetes_obesity
)
SELECT DISTINCT

    hypertension,
    diabetes,
    cholesterol_level,
    cholesterol_class,
    obesity,
    waist_circumference,
    waist_class,
    family_history,
    diabetes_obesity

FROM Heart_attck_cleaned;


/*==============================================================
  STEP 3: LOAD DATA INTO DIM_LIFESTYLE
==============================================================*/

INSERT INTO dim_lifestyle
(
    smoking_status,
    physical_activity,
    dietary_habits,
    lifestyle_score,
    smoking_stress
)
SELECT DISTINCT

    smoking_status,
    physical_activity,
    dietary_habits,
    lifestyle_score,
    smoking_stress

FROM Heart_attck_cleaned;


/*==============================================================
  STEP 4: LOAD DATA INTO DIM_ENVIRONMENT
==============================================================*/

INSERT INTO dim_environment
(
    air_pollution_exposure,
    stress_level,
    sleep_hours,
    sleep_class,
    stress_risk
)

SELECT DISTINCT

    air_pollution_exposure,
    stress_level,
    sleep_hours,
    sleep_class,
    stress_risk

FROM Heart_attck_cleaned;

/*==============================================================
  STEP 5: LOAD DATA INTO DIM_SCREENING
==============================================================*/

INSERT INTO dim_screening
(
    blood_pressure_systolic,
    bp_systolic_class,

    blood_pressure_diastolic,
    bp_diastolic_class,

    pulse_pressure,

    fasting_blood_sugar,
    fasting_class,

    cholesterol_hdl,
    hdl_class,

    cholesterol_ldl,
    ldl_class,

    triglycerides,
    triglycerides_class,

    tg_hdl_ratio,

    EKG_results,

    previous_heart_disease,

    medication_usage,

    participated_in_free_screening
)

SELECT DISTINCT

    blood_pressure_systolic,
    bp_systolic_class,

    blood_pressure_diastolic,
    bp_diastolic_class,

    pulse_pressure,

    fasting_blood_sugar,
    fasting_class,

    cholesterol_hdl,
    hdl_class,

    cholesterol_ldl,
    ldl_class,

    triglycerides,
    triglycerides_class,

    tg_hdl_ratio,

    EKG_results,

    previous_heart_disease,

    medication_usage,

    participated_in_free_screening

FROM Heart_attck_cleaned;

/*==============================================================
  STEP 6: LOAD DATA INTO DIM_RISK
==============================================================*/

INSERT INTO dim_risk
(
    risk_score,
    heart_risk_group,
    metabolic_syndrome
)

SELECT DISTINCT

    risk_score,
    heart_risk_group,
    metabolic_syndrome

FROM Heart_attck_cleaned;


/*==============================================================
  STEP 7: CREATE FACT TABLE - FACT_HEART
  Description:
  Stores each patient's heart attack outcome
  and references all dimension tables.
==============================================================*/

CREATE TABLE fact_heart
(
    patient_id INT PRIMARY KEY,

    demographic_id INT NOT NULL,

    clinical_id INT NOT NULL,

    lifestyle_id INT NOT NULL,

    environment_id INT NOT NULL,

    screening_id INT NOT NULL,

    risk_id INT NOT NULL,

    heart_attack BIT,

    CONSTRAINT FK_fact_demographics
        FOREIGN KEY(demographic_id)
        REFERENCES dim_demographics(demographic_id),

    CONSTRAINT FK_fact_clinical
        FOREIGN KEY(clinical_id)
        REFERENCES dim_clinical(clinical_id),

    CONSTRAINT FK_fact_lifestyle
        FOREIGN KEY(lifestyle_id)
        REFERENCES dim_lifestyle(lifestyle_id),

    CONSTRAINT FK_fact_environment
        FOREIGN KEY(environment_id)
        REFERENCES dim_environment(environment_id),

    CONSTRAINT FK_fact_screening
        FOREIGN KEY(screening_id)
        REFERENCES dim_screening(screening_id),

    CONSTRAINT FK_fact_risk
        FOREIGN KEY(risk_id)
        REFERENCES dim_risk(risk_id)
);


/*==============================================================
  STEP 14: LOAD DATA INTO FACT_HEART
  Description:
  Populate the fact table by mapping each patient to the
  corresponding dimension keys.
==============================================================*/

INSERT INTO fact_heart
(
    patient_id,
    demographic_id,
    clinical_id,
    lifestyle_id,
    environment_id,
    screening_id,
    risk_id,
    heart_attack
)

SELECT

    H.patient_id,

    D.demographic_id,

    C.clinical_id,

    L.lifestyle_id,

    E.environment_id,

    S.screening_id,

    R.risk_id,

    H.heart_attack

FROM Heart_attck_cleaned H

/*======================
  Demographics
======================*/
INNER JOIN dim_demographics D
ON H.gender = D.gender
AND H.age = D.age
AND H.age_class = D.age_class
AND H.region = D.region
AND H.income_level = D.income_level

/*======================
  Clinical
======================*/
INNER JOIN dim_clinical C
ON H.hypertension = C.hypertension
AND H.diabetes = C.diabetes
AND H.cholesterol_level = C.cholesterol_level
AND H.cholesterol_class = C.cholesterol_class
AND H.obesity = C.obesity
AND H.waist_circumference = C.waist_circumference
AND H.waist_class = C.waist_class
AND H.family_history = C.family_history
AND H.diabetes_obesity = C.diabetes_obesity

/*======================
  Lifestyle
======================*/
INNER JOIN dim_lifestyle L
ON H.smoking_status = L.smoking_status
AND H.physical_activity = L.physical_activity
AND H.dietary_habits = L.dietary_habits
AND H.lifestyle_score = L.lifestyle_score
AND H.smoking_stress = L.smoking_stress

/*======================
  Environment
======================*/
INNER JOIN dim_environment E
ON H.air_pollution_exposure = E.air_pollution_exposure
AND H.stress_level = E.stress_level
AND H.sleep_hours = E.sleep_hours
AND H.sleep_class = E.sleep_class
AND H.stress_risk = E.stress_risk

/*======================
  Screening
======================*/
INNER JOIN dim_screening S
ON H.blood_pressure_systolic = S.blood_pressure_systolic
AND H.bp_systolic_class = S.bp_systolic_class
AND H.blood_pressure_diastolic = S.blood_pressure_diastolic
AND H.bp_diastolic_class = S.bp_diastolic_class
AND H.pulse_pressure = S.pulse_pressure
AND H.fasting_blood_sugar = S.fasting_blood_sugar
AND H.fasting_class = S.fasting_class
AND H.cholesterol_hdl = S.cholesterol_hdl
AND H.hdl_class = S.hdl_class
AND H.cholesterol_ldl = S.cholesterol_ldl
AND H.ldl_class = S.ldl_class
AND H.triglycerides = S.triglycerides
AND H.triglycerides_class = S.triglycerides_class
AND H.tg_hdl_ratio = S.tg_hdl_ratio
AND H.EKG_results = S.EKG_results
AND H.previous_heart_disease = S.previous_heart_disease
AND H.medication_usage = S.medication_usage
AND H.participated_in_free_screening = S.participated_in_free_screening

/*======================
  Risk
======================*/
INNER JOIN dim_risk R
ON H.risk_score = R.risk_score
AND H.heart_risk_group = R.heart_risk_group
AND H.metabolic_syndrome = R.metabolic_syndrome;


/*==============================================================
  STEP 15: VALIDATE FACT TABLE
==============================================================*/

SELECT COUNT(*) AS Original_Data
FROM Heart_attck_cleaned;

SELECT COUNT(*) AS Fact_Table
FROM fact_heart;