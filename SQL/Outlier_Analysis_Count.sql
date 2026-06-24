USE depi;
GO

-- Evaluates all 9 clinical biomarkers by categorizing records into critical risk factors and behavioral/statistical variances.
SELECT 
    h.age, h.gender, h.region,
    h.cholesterol_level, h.cholesterol_hdl, h.cholesterol_ldl,
    h.blood_pressure_systolic, h.blood_pressure_diastolic,
    h.fasting_blood_sugar, h.triglycerides, h.sleep_hours, h.waist_circumference,
    CASE 
        -- GROUP 1: CRITICAL HIGH-RISK CLINICAL OUTLIERS
        -- 1. Blood Pressure Systolic Check
        WHEN TRY_CAST(h.blood_pressure_systolic AS FLOAT) > 200 THEN 'Critical Risk: Extreme Systolic BP (>200 mmHg)'
        WHEN TRY_CAST(h.blood_pressure_systolic AS FLOAT) < 65  THEN 'Critical Risk: Severe Hypotension (<65 mmHg)'

        -- 2. Blood Pressure Diastolic Check
        WHEN TRY_CAST(h.blood_pressure_diastolic AS FLOAT) > 130 THEN 'Critical Risk: Extreme Diastolic BP (>130 mmHg)'
        
        -- 3. Fasting Blood Sugar Check
        WHEN TRY_CAST(h.fasting_blood_sugar AS FLOAT) > 350 THEN 'Critical Risk: Extreme Hyperglycemia (>350 mg/dL)'
        
        -- 4. Cholesterol LDL Check
        WHEN TRY_CAST(h.cholesterol_ldl AS FLOAT) > 250 THEN 'Critical Risk: Extreme LDL Level (>250 mg/dL)'
        
        -- 5. Total Cholesterol Check
        WHEN TRY_CAST(h.cholesterol_level AS FLOAT) > 400 THEN 'Critical Risk: Severe Hypercholesterolemia (>400 mg/dL)'
        
        -- 6. Triglycerides Check
        WHEN TRY_CAST(h.triglycerides AS FLOAT) > 500 THEN 'Critical Risk: Severe Hypertriglyceridemia (>500 mg/dL)'

        -- GROUP 2: BEHAVIORAL / STATISTICAL EDGE OUTLIERS
        -- 7. Sleep Hours Check
        WHEN TRY_CAST(h.sleep_hours AS FLOAT) > 14 THEN 'Behavioral Variance: Extreme Sleep Duration (>14 hrs)'
        WHEN TRY_CAST(h.sleep_hours AS FLOAT) < 3  THEN 'Behavioral Variance: Severe Sleep Deprivation (<3 hrs)'
        
        -- 8. Waist Circumference Check
        WHEN TRY_CAST(h.waist_circumference AS FLOAT) < 45  THEN 'Statistical Edge: Sub-normal Waist Circumference (<45 cm)'
        WHEN TRY_CAST(h.waist_circumference AS FLOAT) > 180 THEN 'Statistical Edge: Extreme Waist Circumference (>180 cm)'
        
        -- 9. Cholesterol HDL Check
        WHEN TRY_CAST(h.cholesterol_hdl AS FLOAT) < 15  THEN 'Statistical Edge: Critically Low HDL (<15 mg/dL)'
        WHEN TRY_CAST(h.cholesterol_hdl AS FLOAT) > 110 THEN 'Statistical Edge: Extremely High HDL (>110 mg/dL)'
        
        ELSE 'Other Clinical Outlier'
    END AS Outlier_Classification
FROM dbo.heart_attack AS h
WHERE 
    (TRY_CAST(h.cholesterol_level AS FLOAT) > 500 OR TRY_CAST(h.cholesterol_level AS FLOAT) < 80)
    OR (TRY_CAST(h.cholesterol_hdl AS FLOAT) > 120 OR TRY_CAST(h.cholesterol_hdl AS FLOAT) < 5)
    OR (TRY_CAST(h.cholesterol_ldl AS FLOAT) > 400 OR TRY_CAST(h.cholesterol_ldl AS FLOAT) < 10)
    OR (TRY_CAST(h.waist_circumference AS FLOAT) > 220 OR TRY_CAST(h.waist_circumference AS FLOAT) < 45)
    OR (TRY_CAST(h.sleep_hours AS FLOAT) > 18 OR TRY_CAST(h.sleep_hours AS FLOAT) < 1)
    OR (TRY_CAST(h.blood_pressure_systolic AS FLOAT) > 260 OR TRY_CAST(h.blood_pressure_systolic AS FLOAT) < 60)
    OR (TRY_CAST(h.blood_pressure_diastolic AS FLOAT) > 160 OR TRY_CAST(h.blood_pressure_diastolic AS FLOAT) < 30)
    OR (TRY_CAST(h.fasting_blood_sugar AS FLOAT) > 700 OR TRY_CAST(h.fasting_blood_sugar AS FLOAT) < 30)
    OR (TRY_CAST(h.triglycerides AS FLOAT) > 2000 OR TRY_CAST(h.triglycerides AS FLOAT) < 20);


    
    USE depi;
GO

-- Computes the detailed breakdown and total volume of clinical outliers across specific biomarkers.
WITH OutlierBreakdown AS (
    SELECT h.age,
        CASE 
            -- Check each biomarker strictly to see which one triggered the outlier filter
            WHEN TRY_CAST(h.waist_circumference AS FLOAT) < 45 OR TRY_CAST(h.waist_circumference AS FLOAT) > 220 THEN 'Waist Circumference Outlier'
            WHEN TRY_CAST(h.sleep_hours AS FLOAT) < 1 OR TRY_CAST(h.sleep_hours AS FLOAT) > 18 THEN 'Sleep Hours Outlier'
            WHEN TRY_CAST(h.cholesterol_level AS FLOAT) < 80 OR TRY_CAST(h.cholesterol_level AS FLOAT) > 500 THEN 'Total Cholesterol Outlier'
            WHEN TRY_CAST(h.cholesterol_hdl AS FLOAT) < 5 OR TRY_CAST(h.cholesterol_hdl AS FLOAT) > 120 THEN 'HDL Cholesterol Outlier'
            WHEN TRY_CAST(h.cholesterol_ldl AS FLOAT) < 10 OR TRY_CAST(h.cholesterol_ldl AS FLOAT) > 400 THEN 'LDL Cholesterol Outlier'
            WHEN TRY_CAST(h.blood_pressure_systolic AS FLOAT) < 60 OR TRY_CAST(h.blood_pressure_systolic AS FLOAT) > 260 THEN 'Systolic BP Outlier'
            WHEN TRY_CAST(h.blood_pressure_diastolic AS FLOAT) < 30 OR TRY_CAST(h.blood_pressure_diastolic AS FLOAT) > 160 THEN 'Diastolic BP Outlier'
            WHEN TRY_CAST(h.fasting_blood_sugar AS FLOAT) < 30 OR TRY_CAST(h.fasting_blood_sugar AS FLOAT) > 700 THEN 'Fasting Blood Sugar Outlier'
            WHEN TRY_CAST(h.triglycerides AS FLOAT) < 20 OR TRY_CAST(h.triglycerides AS FLOAT) > 2000 THEN 'Triglycerides Outlier'
            ELSE 'Other Secondary Outlier'
        END AS Specific_Biomarker_Type
    FROM dbo.heart_attack AS h
    WHERE 
        (TRY_CAST(h.cholesterol_level AS FLOAT) > 500 OR TRY_CAST(h.cholesterol_level AS FLOAT) < 80)
        OR (TRY_CAST(h.cholesterol_hdl AS FLOAT) > 120 OR TRY_CAST(h.cholesterol_hdl AS FLOAT) < 5)
        OR (TRY_CAST(h.cholesterol_ldl AS FLOAT) > 400 OR TRY_CAST(h.cholesterol_ldl AS FLOAT) < 10)
        OR (TRY_CAST(h.waist_circumference AS FLOAT) > 220 OR TRY_CAST(h.waist_circumference AS FLOAT) < 45)
        OR (TRY_CAST(h.sleep_hours AS FLOAT) > 18 OR TRY_CAST(h.sleep_hours AS FLOAT) < 1)
        OR (TRY_CAST(h.blood_pressure_systolic AS FLOAT) > 260 OR TRY_CAST(h.blood_pressure_systolic AS FLOAT) < 60)
        OR (TRY_CAST(h.blood_pressure_diastolic AS FLOAT) > 160 OR TRY_CAST(h.blood_pressure_diastolic AS FLOAT) < 30)
        OR (TRY_CAST(h.fasting_blood_sugar AS FLOAT) > 700 OR TRY_CAST(h.fasting_blood_sugar AS FLOAT) < 30)
        OR (TRY_CAST(h.triglycerides AS FLOAT) > 2000 OR TRY_CAST(h.triglycerides AS FLOAT) < 20)
)
-- Aggregate using WITH ROLLUP to automatically calculate individual counts and the Grand Total
SELECT 
    ISNULL(Specific_Biomarker_Type, 'GRAND TOTAL') AS Outlier_Biomarker,
    COUNT(*) AS Total_Count
FROM OutlierBreakdown
GROUP BY ROLLUP(Specific_Biomarker_Type);
GO