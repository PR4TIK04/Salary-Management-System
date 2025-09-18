-- triggers.sql
USE salary_management;

-- Trigger: before update on salaries -> record old and new net_pay
DELIMITER $$
CREATE TRIGGER trg_salary_before_update
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN
  IF OLD.net_pay <> NEW.net_pay THEN
    INSERT INTO audit_log(action, entity, entity_id, old_value, new_value, performed_by)
    VALUES ('SALARY_UPDATE','salaries', OLD.emp_id, CONCAT('net_pay=',OLD.net_pay), CONCAT('net_pay=',NEW.net_pay), 'system');
  END IF;
END$$
DELIMITER ;

-- Trigger: after insert on salaries -> record creation
DELIMITER $$
CREATE TRIGGER trg_salary_after_insert
AFTER INSERT ON salaries
FOR EACH ROW
BEGIN
  INSERT INTO audit_log(action, entity, entity_id, old_value, new_value, performed_by)
  VALUES ('SALARY_CREATE','salaries', NEW.emp_id, NULL, CONCAT('created_salary_id=',NEW.salary_id), 'system');
END$$
DELIMITER ;
