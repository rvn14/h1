SET SERVEROUTPUT ON;
SET VERIFY ON;

DECLARE
   v_no Student.Std_No%TYPE;
   v_name Student.Std_Name%TYPE;
v_dept_id employees.department_id%TYPE := &department_id;


   CURSOR cur_student IS
      SELECT Std_No, Std_Name
      FROM Student
      ORDER BY Std_No;

CURSOR cur_emp(p_dept_id employees.department_id%TYPE) IS
      SELECT employee_id, first_name
      FROM employees
      WHERE department_id = p_dept_id;
BEGIN
   OPEN cur_student;

   LOOP
      FETCH cur_student INTO v_no, v_name;
      EXIT WHEN cur_student%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(v_no || ' - ' || v_name);
   END LOOP;

   CLOSE cur_student;
END;
/


SET SERVEROUTPUT ON;

DECLARE
   CURSOR cur_student IS
      SELECT Std_No, Std_Name, Address
      FROM Student;
BEGIN
   FOR rec IN cur_student LOOP
      DBMS_OUTPUT.PUT_LINE(rec.Std_No || ' - ' || rec.Std_Name || ' - ' || rec.Address);
   END LOOP;
END;
/

CURSOR cur_student_by_city(p_city VARCHAR2) IS
   SELECT Std_No, Std_Name
   FROM Student
   WHERE Address = p_city;

   IF SQL%ISOPEN THEN
      DBMS_OUTPUT.PUT_LINE('Implicit cursor is open.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Implicit cursor is closed.');
   END IF;
   IF SQL%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('Employee not found.');
   END IF;


INSERT INTO Student VALUES ('CT105', 'Nimesha', 'Matara');
   DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' row inserted.');

UPDATE Student
   SET Std_Name = 'Ayesh'
   WHERE Std_No = 'CT102';

DELETE FROM Student
   WHERE Address = 'Colombo';

COMMIT;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No employee found with employee id 200.');
END;
/


