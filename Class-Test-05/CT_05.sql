-- 1.	Create a cursor that can output all the data from salgrade table.
DECLARE
    CURSOR c_salgrade IS
        SELECT * FROM salgrade;
    v_row  salgrade%ROWTYPE;
BEGIN
    OPEN c_salgrade;
    LOOP
        FETCH c_salgrade INTO v_row;
        EXIT WHEN c_salgrade%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'Grade: ' || v_row.grade || 
            ' | Low Salary: ' || v_row.losal || 
            ' | High Salary: ' || v_row.hisal
        );
    END LOOP;
    CLOSE c_salgrade;
END;
/

-- 2.	Create a record that can output the id, name, job, and hiredate of the employee whose Id is 7654.
DECLARE
    emp_rec emp%ROWTYPE;
BEGIN
    SELECT * INTO emp_rec FROM emp WHERE empno = 7654;
    
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.empno);
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec.ename);
    DBMS_OUTPUT.PUT_LINE('Employee Job Title: ' || emp_rec.job);
    DBMS_OUTPUT.PUT_LINE('Employee Hire Date: ' || emp_rec.hiredate);   
END;
/

-- 3.	Create a trigger in such a way that whenever a new row is inserted into the salgrade table an output ‘New Row Added’ is generated.
CREATE OR REPLACE TRIGGER salgrade_added
AFTER INSERT ON salgrade
FOR EACH ROW
BEGIN
   dbms_output.put_line('New Row Added');
END;
/

INSERT INTO salgrade (grade, losal, hisal) VALUES (6, 5000, 10000);

-- 4.	Create a package that contains a procedure which can display the grade whose losal and hisal is passed as its parameter. 
CREATE OR REPLACE PACKAGE grade_pkg AS
    PROCEDURE display_grade(
        p_losal IN salgrade.losal%TYPE,
        p_hisal IN salgrade.hisal%TYPE
    );
END grade_pkg;
/

CREATE OR REPLACE PACKAGE BODY grade_pkg AS
    PROCEDURE display_grade(
        p_losal IN salgrade.losal%TYPE,
        p_hisal IN salgrade.hisal%TYPE
    ) IS
        v_grade salgrade.grade%TYPE;
    BEGIN
        SELECT grade INTO v_grade
        FROM salgrade
        WHERE losal = p_losal
        AND hisal = p_hisal;
        
        DBMS_OUTPUT.PUT_LINE('Grade for losal ' || p_losal || ' and hisal ' || p_hisal || ' is: ' || v_grade);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No grade found for the specified losal and hisal.');
    END display_grade;
END grade_pkg;
/

BEGIN
   grade_pkg.display_grade(2001, 3000);
END;
/

