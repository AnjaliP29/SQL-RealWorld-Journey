/* =========================================================
   DAY 02 — SORTING, DISTINCT, LIMIT & RESULT CONTROL (WITH ANSWERS)
   Database : SQLite
   Tool     : DBeaver
   Assumes  : Day 01 hospital database already exists
========================================================= */

------------------------------------------------------------
-- SECTION A: ORDER BY (Basic Sorting)
------------------------------------------------------------

-- Q1: List all patients sorted by birth_date (oldest first)
SELECT *
FROM patients
ORDER BY birth_date ASC;

-- Q2: List all patients sorted by weight_kg (heaviest first)
-- (NULL weights last)
SELECT *
FROM patients
ORDER BY (weight_kg IS NULL) ASC, weight_kg DESC;

-- Q3: Sort patients by city alphabetically, then by first_name
-- (NULL cities last)
SELECT *
FROM patients
ORDER BY (city IS NULL) ASC, city ASC, first_name ASC;

-- Q4: Show only the top 5 heaviest patients
-- (exclude NULL weights to get a true “top” list)
SELECT patient_id, first_name, last_name, weight_kg
FROM patients
WHERE weight_kg IS NOT NULL
ORDER BY weight_kg DESC
LIMIT 5;

-- Q5: Show the 3 most recent admissions
SELECT *
FROM admissions
ORDER BY admission_date DESC
LIMIT 3;


------------------------------------------------------------
-- SECTION B: DISTINCT & DE-DUPLICATION
------------------------------------------------------------

-- Q6: List all unique cities where patients live (ignore NULLs)
SELECT DISTINCT city
FROM patients
WHERE city IS NOT NULL
ORDER BY city ASC;

-- Q7: List all unique province_ids from patients (ignore NULLs)
SELECT DISTINCT province_id
FROM patients
WHERE province_id IS NOT NULL
ORDER BY province_id ASC;

-- Q8: Count how many distinct cities exist (ignore NULLs)
SELECT COUNT(DISTINCT city) AS distinct_city_count
FROM patients
WHERE city IS NOT NULL;

-- Q9: List unique diagnoses from admissions (ignore NULLs)
SELECT DISTINCT diagnosis
FROM admissions
WHERE diagnosis IS NOT NULL
ORDER BY diagnosis ASC;


------------------------------------------------------------
-- SECTION C: LIMIT & OFFSET (Pagination Logic)
------------------------------------------------------------

-- Q10: Show the top 3 tallest patients (NULL heights last)
SELECT patient_id, first_name, last_name, height_cm
FROM patients
ORDER BY (height_cm IS NULL) ASC, height_cm DESC
LIMIT 3;

-- Q11: Show patients ranked 4–6 by height (NULL heights last)
SELECT patient_id, first_name, last_name, height_cm
FROM patients
ORDER BY (height_cm IS NULL) ASC, height_cm DESC
LIMIT 3 OFFSET 3;

-- Q12: Paginate admissions (page size = 2) → page 1
-- (Define a stable order; here: most recent first)
SELECT *
FROM admissions
ORDER BY admission_date DESC, admission_id DESC
LIMIT 2 OFFSET 0;

-- Q13: Paginate admissions (page size = 2) → page 2
SELECT *
FROM admissions
ORDER BY admission_date DESC, admission_id DESC
LIMIT 2 OFFSET 2;


------------------------------------------------------------
-- SECTION D: SORTING WITH NULLs (REAL-WORLD EDGE CASES)
------------------------------------------------------------

-- Q14: Sort patients by weight_kg, ensuring NULL weights appear last
SELECT patient_id, first_name, last_name, weight_kg
FROM patients
ORDER BY (weight_kg IS NULL) ASC, weight_kg DESC;

-- Q15: Sort admissions by discharge_date, grouping ongoing admissions logically
-- (Ongoing admissions first, then earliest discharge_date)
SELECT *
FROM admissions
ORDER BY (discharge_date IS NULL) DESC, discharge_date ASC, admission_date ASC;

-- Q16: Sort doctors by specialty, placing NULL specialties at the bottom
SELECT doctor_id, first_name, last_name, specialty
FROM doctors
ORDER BY (specialty IS NULL) ASC, specialty ASC, last_name ASC, first_name ASC;


------------------------------------------------------------
-- SECTION E: MULTI-TABLE SORTING
------------------------------------------------------------

-- Q17: Show admissions with patient name and admission_date,
--      sorted by admission_date (latest first)
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.admission_id,
    a.admission_date,
    a.discharge_date,
    a.diagnosis
FROM admissions a
JOIN patients p
  ON p.patient_id = a.patient_id
ORDER BY a.admission_date DESC, a.admission_id DESC;

-- Q18: Show patients with their province_name,
--      sorted by province_name alphabetically (NULL province last)
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    p.province_id,
    pn.province_name
FROM patients p
LEFT JOIN province_names pn
  ON pn.province_id = p.province_id
ORDER BY (pn.province_name IS NULL) ASC, pn.province_name ASC, p.last_name ASC, p.first_name ASC;

-- Q19: Show doctors with number of admissions handled,
--      sorted from highest to lowest count
-- (LEFT JOIN so doctors with 0 admissions are included)
SELECT
    d.doctor_id,
    d.first_name,
    d.last_name,
    d.specialty,
    COUNT(a.admission_id) AS admissions_handled
FROM doctors d
LEFT JOIN admissions a
  ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialty
ORDER BY admissions_handled DESC, d.last_name ASC, d.first_name ASC;
