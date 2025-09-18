-- procedures.sql (MySQL)
USE salary_management;
DELIMITER $$

-- Procedure: calculate_net_salary(emp_id, year, month)
CREATE PROCEDURE calculate_net_salary(IN p_emp_id INT, IN p_year SMALLINT, IN p_month TINYINT)
BEGIN
  DECLARE v_basic DECIMAL(12,2);
  DECLARE v_hra DECIMAL(12,2);
  DECLARE v_allow DECIMAL(12,2);
  DECLARE v_deduct DECIMAL(12,2);
  DECLARE v_gross DECIMAL(14,2);
  DECLARE v_tax DECIMAL(14,2);
  DECLARE v_net DECIMAL(14,2);
  DECLARE v_annual_income DECIMAL(14,2);

  SELECT basic, hra, allowances, deductions INTO v_basic, v_hra, v_allow, v_deduct
  FROM salaries
  WHERE emp_id = p_emp_id AND year = p_year AND month = p_month
  LIMIT 1;

  IF v_basic IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary row not found';
  END IF;

  SET v_gross = v_basic + v_hra + v_allow;
  SET v_annual_income = v_gross * 12;

  -- Simplified tax calc using slabs: pick matching slab
  SELECT COALESCE(SUM((LEAST(v_annual_income, max_income) - min_income) * rate_percent / 100),0) INTO v_tax
  FROM tax_slabs
  WHERE v_annual_income > min_income;

  SET v_net = v_gross - v_deduct - (v_tax / 12);

  -- Update net_pay
  UPDATE salaries SET net_pay = ROUND(v_net,2) WHERE emp_id = p_emp_id AND year = p_year AND month = p_month;

  -- Insert audit log
  INSERT INTO audit_log (action, entity, entity_id, old_value, new_value, performed_by)
  VALUES ('CALCULATE_NET','salaries', p_emp_id, NULL, CONCAT('net_pay=',ROUND(v_net,2)), 'system');
END$$

-- Procedure: apply_attendance_deductions(month, year)
CREATE PROCEDURE apply_attendance_deductions(IN p_year SMALLINT, IN p_month TINYINT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cur_emp INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT emp_id FROM attendance WHERE YEAR(att_date)=p_year AND MONTH(att_date)=p_month;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cur_emp;
    IF done THEN
      LEAVE read_loop;
    END IF;

    -- Count absent days
    SET @absences = (SELECT COUNT(*) FROM attendance WHERE emp_id=cur_emp AND YEAR(att_date)=p_year AND MONTH(att_date)=p_month AND status='A');
    -- Simple rule: for each absence, deduct (basic/30)
    UPDATE salaries s
    JOIN employees e ON e.emp_id = s.emp_id
    SET s.deductions = s.deductions + (IFNULL(s.basic,0) / 30) * @absences
    WHERE s.emp_id = cur_emp AND s.year = p_year AND s.month = p_month;

    -- Audit
    INSERT INTO audit_log(action, entity, entity_id, old_value, new_value, performed_by)
    VALUES ('ATT_DEDUCTION','salaries', cur_emp, NULL, CONCAT('absences=',@absences), 'system');
  END LOOP;
  CLOSE cur;
END$$

DELIMITER ;
