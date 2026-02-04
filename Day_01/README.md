# 📘 Day 01 — SQL Basics with Real-World Data

## 📌 Objective
Build a strong foundation in SQL by working with a **realistic hospital database**.
This day focuses on **reading, filtering, and cleaning data**, mirroring how SQL is
used in real analytics and data roles.

---

## 🗂️ Dataset Overview (Hospital System)

We simulate a small hospital database with **4 interconnected tables**:

### 1️⃣ patients
Stores demographic and health-related patient information.
- Includes real-world issues such as **missing city, height, weight, and allergies**

### 2️⃣ doctors
Contains doctor information and medical specialties.
- Includes **NULL specialties** to reflect incomplete records

### 3️⃣ admissions
Tracks hospital admissions and discharges.
- Includes **open admissions** (NULL discharge dates)
- Includes **missing diagnoses and doctors**

### 4️⃣ province_names
Lookup table used to normalize province/state names.

---

## 🧱 Database Schema

### patients
| Column Name   | Type    | Description |
|--------------|---------|-------------|
| patient_id   | INTEGER | Primary key |
| first_name   | TEXT    | Patient first name |
| last_name    | TEXT    | Patient last name |
| gender       | TEXT    | M / F / O |
| birth_date   | TEXT    | Date of birth (YYYY-MM-DD) |
| height_cm    | INTEGER | Height in centimeters |
| weight_kg    | REAL    | Weight in kilograms |
| city         | TEXT    | City of residence |
| province_id  | TEXT    | Province/state code |
| allergies    | TEXT    | Known allergies |

---

### doctors
| Column Name | Type    | Description |
|------------|---------|-------------|
| doctor_id  | INTEGER | Primary key |
| first_name | TEXT    | Doctor first name |
| last_name  | TEXT    | Doctor last name |
| specialty  | TEXT    | Medical specialty |

---

### admissions
| Column Name           | Type    | Description |
|----------------------|---------|-------------|
| admission_id         | INTEGER | Primary key |
| patient_id           | INTEGER | References patients |
| admission_date       | TEXT    | Admission date |
| discharge_date       | TEXT    | Discharge date (NULL = active) |
| diagnosis            | TEXT    | Medical diagnosis |
| attending_doctor_id  | INTEGER | References doctors |

---

### province_names
| Column Name    | Type | Description |
|---------------|------|-------------|
| province_id   | TEXT | Province code |
| province_name | TEXT | Full province name |

---

## 🧪 Concepts Practiced

✔ SELECT statements  
✔ WHERE filtering  
✔ AND / OR conditions  
✔ IN operator  
✔ BETWEEN  
✔ LIKE patterns  
✔ NULL handling (`IS NULL`, `IS NOT NULL`)  
✔ COALESCE for data cleaning  
✔ Sorting with ORDER BY  
✔ INNER JOIN and LEFT JOIN  
✔ Identifying missing and unmatched records  

---

## 📂 Files in This Folder

- `Day_01_Practice.sql` — SQL setup + all practice queries
- `README.md` — Concept explanations and schema documentation

---

## 🎯 Key Takeaways
- Learned to query **realistic, messy data**
- Understood how to safely handle **NULL values**
- Built intuition for filtering and cleaning data
- Established a professional SQL workflow using DBeaver


