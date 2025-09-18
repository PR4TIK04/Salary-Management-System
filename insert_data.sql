-- insert_data.sql
USE salary_management;

-- Departments
INSERT INTO departments (name) VALUES
('Engineering'), ('Sales'), ('HR'), ('Finance'), ('Support');

-- Roles
INSERT INTO roles (title, level, base_grade_salary) VALUES
('Software Engineer','L1',30000.00),
('Software Engineer','L2',50000.00),
('Senior Engineer','L3',80000.00),
('HR Executive','L1',30000.00),
('Accountant','L1',35000.00),
('Sales Executive','L1',28000.00),
('Support Engineer','L1',25000.00);

-- Sample users (for audit)
INSERT INTO users (username, display_name, role) VALUES
('admin','Administrator','ADMIN'),
('hr1','HR Manager','HR');

-- Employees (20 sample, diverse)
INSERT INTO employees (first_name,last_name,gender,email,phone,department_id,role_id,joining_date,tax_id) VALUES
('Amit','Shah','M','amit.shah@example.com','+91-9000000001',1,2,'2021-03-15','TAX1001'),
('Rhea','Patel','F','rhea.patel@example.com','+91-9000000002',1,3,'2019-07-22','TAX1002'),
('Karan','Singh','M','karan.singh@example.com','+91-9000000003',2,6,'2022-01-10','TAX1003'),
('Sneha','Desai','F','sneha.desai@example.com','+91-9000000004',3,4,'2020-05-03','TAX1004'),
('Vikram','Kumar','M','vikram.kumar@example.com','+91-9000000005',4,5,'2018-11-30','TAX1005'),
('Iqra','Ali','F','iqra.ali@example.com','+91-9000000006',5,7,'2023-02-14','TAX1006'),
('Rohit','Verma','M','rohit.verma@example.com','+91-9000000007',1,3,'2017-08-20','TAX1007'),
('Neha','Joshi','F','neha.joshi@example.com','+91-9000000008',2,6,'2020-12-01','TAX1008'),
('Sameer','Nair','M','sameer.nair@example.com','+91-9000000009',1,1,'2024-01-05','TAX1009'),
('Pooja','Rao','F','pooja.rao@example.com','+91-9000000010',3,4,'2016-09-09','TAX1010'),
('Arjun','Mehta','M','arjun.mehta@example.com','+91-9000000011',1,2,'2015-04-18','TAX1011'),
('Maya','Menon','F','maya.menon@example.com','+91-9000000012',4,5,'2019-10-25','TAX1012'),
('Dev','Patel','M','dev.patel@example.com','+91-9000000013',5,7,'2022-06-17','TAX1013'),
('Rina','Gupta','F','rina.gupta@example.com','+91-9000000014',2,6,'2021-09-29','TAX1014'),
('Sahil','Chopra','M','sahil.chopra@example.com','+91-9000000015',1,3,'2014-02-12','TAX1015'),
('Alisha','Sharma','F','alisha.sharma@example.com','+91-9000000016',4,5,'2018-07-21','TAX1016'),
('Imran','Khan','M','imran.khan@example.com','+91-9000000017',5,7,'2020-03-02','TAX1017'),
('Tara','Nair','F','tara.nair@example.com','+91-9000000018',3,4,'2013-11-11','TAX1018'),
('Om','Reddy','M','om.reddy@example.com','+91-9000000019',1,1,'2024-05-20','TAX1019'),
('Zoya','Ansari','F','zoya.ansari@example.com','+91-9000000020',2,6,'2016-06-06','TAX1020');

-- Sample salaries (for three months for a few employees)
INSERT INTO salaries (emp_id, year, month, basic, hra, allowances, deductions, net_pay) VALUES
(1,2025,6,50000,15000,5000,2000,0),
(2,2025,6,80000,24000,8000,3000,0),
(3,2025,6,28000,8400,2000,1000,0),
(4,2025,6,30000,9000,2500,1500,0),
(1,2025,7,50000,15000,5000,2000,0),
(2,2025,7,80000,24000,8000,3000,0),
(3,2025,7,28000,8400,2000,1000,0),
(4,2025,7,30000,9000,2500,1500,0);

-- Sample attendance entries (recent month)
INSERT INTO attendance (emp_id, att_date, status, check_in, check_out) VALUES
(1,'2025-07-01','P','09:10:00','18:05:00'),
(1,'2025-07-02','A',NULL,NULL),
(2,'2025-07-01','P','09:00:00','17:55:00'),
(3,'2025-07-01','L',NULL,NULL),
(4,'2025-07-01','P','09:20:00','18:10:00');

-- Sample leaves
INSERT INTO leaves (emp_id, leave_type, start_date, end_date, days, approval_status) VALUES
(3,'SICK','2025-07-01','2025-07-02',2,'APPROVED'),
(6,'CASUAL','2025-07-05','2025-07-05',1,'PENDING');

-- Tax slabs (example simple slabs)
INSERT INTO tax_slabs (min_income, max_income, rate_percent) VALUES
(0,250000,0),
(250001,500000,5),
(500001,750000,10),
(750001,1000000,15),
(1000001,10000000,20);

-- Bonuses
INSERT INTO bonuses (emp_id, amount, reason, awarded_on) VALUES
(2,50000,'Performance Q2','2025-07-15'),
(11,25000,'Referral Bonus','2025-06-10');
