-- schema.sql
-- Enhanced Salary Management System schema (MySQL compatible)

DROP DATABASE IF EXISTS salary_management;
CREATE DATABASE salary_management;
USE salary_management;

-- Departments
CREATE TABLE departments (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  manager_emp_id INT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Roles
CREATE TABLE roles (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  level VARCHAR(50),
  base_grade_salary DECIMAL(12,2) DEFAULT 0
);

-- Employees
CREATE TABLE employees (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  gender ENUM('M','F','O') DEFAULT 'O',
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(30),
  department_id INT,
  role_id INT,
  joining_date DATE,
  is_active BOOLEAN DEFAULT TRUE,
  tax_id VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (department_id) REFERENCES departments(dept_id),
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Salaries (monthly records)
CREATE TABLE salaries (
  salary_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT NOT NULL,
  year SMALLINT NOT NULL,
  month TINYINT NOT NULL,
  basic DECIMAL(12,2) DEFAULT 0,
  hra DECIMAL(12,2) DEFAULT 0,
  allowances DECIMAL(12,2) DEFAULT 0,
  deductions DECIMAL(12,2) DEFAULT 0,
  net_pay DECIMAL(12,2) DEFAULT 0,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Attendance (daily)
CREATE TABLE attendance (
  att_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT NOT NULL,
  att_date DATE NOT NULL,
  status ENUM('P','A','L','H') DEFAULT 'P', -- Present, Absent, Leave, Holiday
  check_in TIME NULL,
  check_out TIME NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(emp_id, att_date),
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Leaves
CREATE TABLE leaves (
  leave_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT NOT NULL,
  leave_type VARCHAR(50),
  start_date DATE,
  end_date DATE,
  days DECIMAL(5,2),
  approval_status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Tax slabs (yearly)
CREATE TABLE tax_slabs (
  slab_id INT AUTO_INCREMENT PRIMARY KEY,
  min_income DECIMAL(14,2),
  max_income DECIMAL(14,2),
  rate_percent DECIMAL(5,2)
);

-- Bonuses
CREATE TABLE bonuses (
  bonus_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT NOT NULL,
  amount DECIMAL(12,2),
  reason VARCHAR(255),
  awarded_on DATE,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Audit log
CREATE TABLE audit_log (
  audit_id INT AUTO_INCREMENT PRIMARY KEY,
  action VARCHAR(100),
  entity VARCHAR(50),
  entity_id INT,
  old_value TEXT,
  new_value TEXT,
  performed_by VARCHAR(100),
  performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Simple users table for who performed audit actions (optional)
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) UNIQUE,
  display_name VARCHAR(150),
  role VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
