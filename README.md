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


---

## 🚀 How to Run the Project

You can run this project in **two ways**:

###  Using Local Database (MySQL / MariaDB)
1. Install [MySQL](https://dev.mysql.com/downloads/) or use MariaDB.
2. Create a new database:
   ```sql
   CREATE DATABASE salary_mgmt;
   USE salary_mgmt;

3. Import the files in this order:
   ```
   mysql -u root -p salary_mgmt < schema.sql
   mysql -u root -p salary_mgmt < insert_data.sql
   mysql -u root -p salary_mgmt < procedures.sql
   mysql -u root -p salary_mgmt < triggers.sql

4.Run queries:
  ```
  mysql -u root -p salary_mgmt < queries.sql


