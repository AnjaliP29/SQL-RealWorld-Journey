/* =========================================================
   DAY 01 — SQL BASICS + FILTERING + NULL HANDLING
   Database : SQLite
   Tool     : DBeaver
   Tables   : province_names, doctors, patients, admissions
========================================================= */

------------------------------------------------------------
-- CLEAN START
------------------------------------------------------------
DROP TABLE IF EXISTS admissions;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS province_names;

------------------------------------------------------------
-- LOOKUP TABLE: PROVINCES
------------------------------------------------------------
CREATE TABLE province_names (
    province_id   TEXT PRIMARY KEY,
    province_name TEXT NOT NULL
);

INSERT INTO province_names VALUES
('ON','Ontario'),
('BC','British Columbia'),
('QC','Quebec'),
('AB','Alberta'),
('NY','New York');

------------------------------------------------------------
-- DOCTORS TABLE
------------------------------------------------------------
CREATE TABLE doctors (
    doctor_id   INTEGER PRIMARY KEY,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    specialty   TEXT
);

INSERT INTO doctors VALUES
(1,'Maya','Singh','Cardiology'),
(2,'Ethan','Brown','General Medicine'),
(3,'Olivia','Chen','Neurology'),
(4,'Noah','Patel',NULL),
(5,'Ava','Garcia','Pediatrics');

------------------------------------------------------------
-- PATIENTS TABLE (CONTAINS NULLS)
------------------------------------------------------------
CREATE TABLE patients (
    patient_id   INTEGER PRIMARY KEY,
    first_name   TEXT NOT NULL,
    last_name    TEXT NOT NULL,
    gender       TEXT CHECK (gender IN ('M','F','O')) NOT NULL,
    birth_date   TEXT NOT NULL,          -- YYYY-MM-DD
    height_cm    INTEGER,
    weight_kg    REAL,
    city         TEXT,
    province_id  TEXT,
    allergies    TEXT,
    FOREIGN KEY (province_id) REFERENCES province_names(province_id)
);

INSERT INTO patients VALUES
(101,'Aditi','Katale','F','2002-08-10',160,54.0,'College Park','NY',NULL),
(102,'John','Miller','M','1997-03-22',178,82.5,'Toronto','ON','Penicillin'),
(103,'Sara','Wilson','F','1989-11-05',NULL,67.2,'Vancouver','BC',NULL),
(104,'Arjun','Sharma','M','1975-01-30',172,NULL,'Montreal','QC','Peanuts'),
(105,'Mei','Lin','F','2001-07-19',165,58.0,NULL,'BC',NULL),
(106,'Carlos','Diaz','M','1993-12-12',181,90.1,'Calgary','AB',NULL),
(107,'Nina','Khan','F','1982-06-02',158,60.3,'Toronto','ON','Latex'),
(108,'Omar','Hassan','M','2000-02-14',NULL,NULL,'New York','NY',NULL),
(109,'Priya','Iyer','F','1999-09-09',170,62.0,'Ottawa','ON',NULL),
(110,'Zoe','Martin','O','1995-05-25',168,70.0,'Vancouver','BC','Dust');

------------------------------------------------------------
-- ADMISSIONS TABLE (CONTAINS NULLS)
------------------------------------------------------------
CREATE TABLE admissions (
    admission_id        INTEGER PRIMARY KEY,
    patient_id          INTEGER NOT NULL,
    admission_date      TEXT NOT NULL,
    discharge_date      TEXT,             -- NULL = still admitted
    diagnosis           TEXT,
    attending_doctor_id INTEGER,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (attending_doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO admissions VALUES
(201,101,'2025-12-01','2025-12-03','Flu',2),
(202,102,'2025-11-10','2025-11-15','Hypertension',1),
(203,103,'2025-10-05',NULL,'Migraine',3),
(204,104,'2025-12-20','2025-12-28','Diabetes',2),
(205,105,'2025-12-02','2025-12-05',NULL,5),
(206,106,'2025-09-01','2025-09-02','Sprain',NULL),
(207,107,'2025-12-25',NULL,'Asthma',2),
(208,108,'2025-08-08','2025-08-10','Checkup',4);

------------------------------------------------------------
-- DAY 01 PRACTICE QUERIES
-- Topics: SELECT, WHERE, IN, BETWEEN, LIKE, NULL, COALESCE
------------------------------------------------------------

-- Q1: View all patients
SELECT * FROM patients;

-- Q2: Select names and gender
SELECT first_name, last_name, gender
FROM patients;

-- Q3: Column aliases
SELECT
    first_name AS fname,
    last_name  AS lname,
    birth_date AS dob
FROM patients;

-- Q4: Patients from Ontario
SELECT *
FROM patients
WHERE province_id = 'ON';

-- Q5: Female patients
SELECT patient_id, first_name, last_name
FROM patients
WHERE gender = 'F';

-- Q6: Toronto patients allergic to Latex
SELECT *
FROM patients
WHERE city = 'Toronto'
  AND allergies = 'Latex';

-- Q7: Patients from Toronto or Vancouver
SELECT *
FROM patients
WHERE city IN ('Toronto','Vancouver');

-- Q8: Weight between 60 and 80 kg
SELECT patient_id, first_name, weight_kg
FROM patients
WHERE weight_kg BETWEEN 60 AND 80;

-- Q9: First names starting with 'A'
SELECT *
FROM patients
WHERE first_name LIKE 'A%';

-- Q10: Last names ending with 'son'
SELECT *
FROM patients
WHERE last_name LIKE '%son';

-- Q11: City contains 'van'
SELECT *
FROM patients
WHERE city LIKE '%van%';

-- Q12: Patients with NULL city
SELECT *
FROM patients
WHERE city IS NULL;

-- Q13: Patients with NULL allergies
SELECT patient_id, first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- Q14: Patients with known allergies
SELECT patient_id, first_name, last_name, allergies
FROM patients
WHERE allergies IS NOT NULL;

-- Q15: Replace NULL allergies
SELECT
    patient_id,
    first_name,
    COALESCE(allergies,'Unknown') AS allergies_clean
FROM patients;

-- Q16: Open admissions
SELECT *
FROM admissions
WHERE discharge_date IS NULL;

-- Q17: Admissions with missing diagnosis
SELECT *
FROM admissions
WHERE diagnosis IS NULL;

-- Q18: Admissions without assigned doctor
SELECT *
FROM admissions
WHERE attending_doctor_id IS NULL;

-- Q19: Join patients with admissions
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.admission_date,
    a.diagnosis
FROM patients p
JOIN admissions a
  ON p.patient_id = a.patient_id;

-- Q20: Active admissions with patient names
SELECT
    p.first_name,
    p.last_name,
    a.admission_date
FROM patients p
JOIN admissions a
  ON p.patient_id = a.patient_id
WHERE a.discharge_date IS NULL;

-- Q21: Patients never admitted
SELECT
    p.patient_id,
    p.first_name,
    p.last_name
FROM patients p
LEFT JOIN admissions a
  ON p.patient_id = a.patient_id
WHERE a.patient_id IS NULL;

-- Q22: Patients older than ~30 years
SELECT
    patient_id,
    first_name,
    last_name,
    birth_date
FROM patients
WHERE substr(birth_date,1,4) <= '1995';

-- Q23: Missing height or weight
SELECT *
FROM patients
WHERE height_cm IS NULL
   OR weight_kg IS NULL;

-- Q24: Complete height and weight
SELECT *
FROM patients
WHERE height_cm IS NOT NULL
  AND weight_kg IS NOT NULL;

-- Q25: Patients not in Ontario
SELECT *
FROM patients
WHERE province_id <> 'ON';

-- Q26: Sort patients by weight (descending)
SELECT
    patient_id,
    first_name,
    weight_kg
FROM patients
ORDER BY weight_kg DESC;

-- Q27: Sort admissions by most recent
SELECT *
FROM admissions
ORDER BY admission_date DESC;

-- Q28: Join province names
SELECT
    p.first_name,
    p.last_name,
    pn.province_name
FROM patients p
LEFT JOIN province_names pn
  ON p.province_id = pn.province_id;

-- Q29: Clean reporting view
SELECT
    patient_id,
    first_name,
    last_name,
    COALESCE(city,'Unknown')      AS city,
    COALESCE(allergies,'Unknown') AS allergies
FROM patients;
