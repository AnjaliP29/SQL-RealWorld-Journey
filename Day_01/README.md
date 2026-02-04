\# Day 01 — SQL Basics + Filtering + NULL Handling (SQLite)



\## Goal (What I learned today)

Today I learned the foundations of SQL querying on a real-world style dataset with missing values (NULLs). I practiced selecting columns, filtering rows, pattern matching, and handling NULL/N/A values — the most common issues in real datasets.



---



\## Setup (DB Browser for SQLite)

\*\*Tool:\*\* DB Browser for SQLite  

\*\*Database:\*\* `hospital\_day01.sqlite`



Steps:

1\. Open DB Browser → New Database → save as `hospital\_day01.sqlite`

2\. Go to \*\*Execute SQL\*\*

3\. Paste the schema + seed data (included in `practice.sql`) and run it.

4\. Switch to \*\*Browse Data\*\* tab to view tables.



---



\## Concepts Learned



\### 1) SELECT (retrieving data)

\- `SELECT \*` returns all columns.

\- Prefer selecting only the needed columns for cleaner outputs and faster queries.

\- Use aliases to rename columns for readability: `AS`.



\### 2) WHERE (filtering rows)

\- Filters rows using conditions like `=, !=, >, <, BETWEEN, IN`.

\- Use `AND / OR / NOT` to combine conditions.



\### 3) Pattern matching with LIKE

\- `%` means “any number of characters”

\- `\_` means “exactly one character”

Examples:

\- `first\_name LIKE 'A%'` → starts with A

\- `last\_name LIKE '%son'` → ends with son

\- `city LIKE '\_a%'` → second letter is 'a'



\### 4) NULLs (missing data / N/A)

\- NULL is not equal to anything (even NULL).

\- Don’t write `col = NULL` — use:

&nbsp; - `col IS NULL`

&nbsp; - `col IS NOT NULL`

\- Replace NULL values:

&nbsp; - `COALESCE(allergies, 'Unknown')`



---



\## Real-world usage

These Day 1 skills are used daily for:

\- pulling subsets of customers/patients/orders

\- filtering by dates, location, category

\- cleaning data by identifying missing values

\- creating dataset slices for dashboards and ML features



---



\## Common Mistakes

\- Using `= NULL` instead of `IS NULL`

\- Using `OR` when `IN (...)` is cleaner

\- Writing `SELECT \*` everywhere

\- Forgetting parentheses with `AND/OR`



---



\## Deliverables for today

\- Created tables + inserted sample data with NULLs.

\- Wrote 30+ queries covering:

&nbsp; - SELECT basics

&nbsp; - Filtering (WHERE / AND / OR / IN / BETWEEN)

&nbsp; - LIKE patterns

&nbsp; - NULL detection + COALESCE



