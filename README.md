# Enhanced Salary Management System (SQL Project)

This repository contains an **enhanced, portfolio-ready** Salary Management System implemented as SQL scripts (MySQL-compatible).  
The goal: showcase database design, complex queries, stored procedures, triggers, audit logging and analytics — without requiring a running server. Perfect to host on GitHub as a SQL portfolio piece.

## What you'll find
- `schema.sql`          : Database schema (tables, constraints).
- `insert_data.sql`     : Sample data (20 employees, salaries, attendance, etc.).
- `procedures.sql`      : Stored procedures (net salary calculation, attendance deductions).
- `triggers.sql`        : Triggers that populate `audit_log`.
- `queries.sql`         : Useful analytics & investigation queries.
- `README.md`           : This file.

## Unique features added (compared to basic repo)
1. Attendance integration + deduction procedure.  
2. Leave management and tracking.  
3. Tax slabs and simplified tax calculation in stored proc.  
4. Audit logs for salary changes and actions (triggers + proc).  
5. Bonuses table and summary queries.  
6. Promotion eligibility and salary-anomaly detection queries.  
7. Clear project structure so it reads like a case study.

## How to present on GitHub (suggested)
- Keep the SQL files as-is so a recruiter can open and review easily.
- Add `ER_diagram.png` (optional) — a diagram of tables and relations. If you can't generate a PNG, keep an ASCII / Markdown diagram in README.
- Add sample query outputs as screenshots or sample CSV in `/samples/` (optional).
- In README, explain how to run each script in order:
  1. `schema.sql`
  2. `insert_data.sql`
  3. `procedures.sql`
  4. `triggers.sql`
  5. Run `CALL calculate_net_salary(emp_id, year, month);` for employees.
  6. Run `CALL apply_attendance_deductions(year, month);`

## Notes
- This project is designed to be a **showcase**. You don't need to run it locally to present it on your GitHub — but if you want to, install MySQL and execute the scripts in the order above.
- Replace sample data with company-like realistic data if you'd like more polish.

--- 
If you want, I can:
- Generate an `ER_diagram.md` (ASCII) and include it.
- Create a ZIP of all files for you to download.
- Add more sample queries or adjust tax logic for your country.
