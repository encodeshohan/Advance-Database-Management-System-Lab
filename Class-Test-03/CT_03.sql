----------------------------------------------- Part 01 -----------------------------------------------
-- 1.Write a query that can multiply two numbers taking input from user.
DECLARE
    num1 NUMBER := :num1;
    num2 NUMBER := :num2;
    result NUMBER;
BEGIN
    result := num1 * num2;
    DBMS_OUTPUT.PUT_LINE('Multiplication Result: ' || result);
END;
/

-- 2. Write a query that can add two numbers if the numbers are equal. Use CASE Statement.
DECLARE
    num1 NUMBER := :num1;
    num2 NUMBER := :num2;
    result NUMBER;
BEGIN
    CASE  
    WHEN num1 = num2 THEN  
        result := num1 + num2;  
        DBMS_OUTPUT.PUT_LINE('Numbers are equal. Sum = ' || result);  
    ELSE  
        DBMS_OUTPUT.PUT_LINE('Numbers are not equal. No addition performed.');  
    END CASE;  
END;
/

-- 3. Write a query that can check if two strings are equal or not. Use IF-THEN-ELSIF Statement.
DECLARE
    str1 VARCHAR2(100) := 'HELLO';
    str2 VARCHAR2(100) := 'HELLO';
BEGIN
    IF str1 = str2 THEN
        DBMS_OUTPUT.PUT_LINE('Strings are equal.');
    ELSIF str1 != str2 THEN
        DBMS_OUTPUT.PUT_LINE('Strings are not equal.');
    END IF;
END;
/

-- 4. Write a query that can multiply two numbers. If the result obtained is less than 100, Hi is displayed, if the result obtained is more than 100, Bye is displayed and if the result obtained is equal to 100, ADBMS is displayed. Use IF-THEN-ELSIF Statement
DECLARE
    num1 NUMBER := 10;
    num2 NUMBER := 10;
    result NUMBER;
BEGIN
    result := num1 * num2;
    IF result < 100 THEN
        DBMS_OUTPUT.PUT_LINE('Hi');
    ELSIF result > 100 THEN
        DBMS_OUTPUT.PUT_LINE('Bye');
    ELSIF result = 100 THEN
        DBMS_OUTPUT.PUT_LINE('ADBMS');
    END IF;
END;
/

-- 5. Write a query that can check if two numbers are equal or not.  Use CASE Statement.
DECLARE
    num1 NUMBER := 100;
    num2 NUMBER := 100;
BEGIN
    CASE
    WHEN num1 = num2 THEN
        DBMS_OUTPUT.PUT_LINE('Numbers are equal.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Numbers are not equal.');
    END CASE;
END;
/

----------------------------------------------- Part 02 -----------------------------------------------
-- 6. Write a query that can display the salary of employee ALLEN. If ALLEN’s salary is greater than 2000 display ‘SALARY GREATER THAN 2000’ and If not then display ‘SALARY LESS THAN 2000’.
DECLARE
    a_sal NUMBER;
BEGIN
    SELECT sal INTO a_sal FROM emp WHERE ename = 'ALLEN';
    IF a_sal > 2000 THEN
        DBMS_OUTPUT.PUT_LINE('SALARY GREATER THAN 2000');
    ELSE
        DBMS_OUTPUT.PUT_LINE('SALARY LESS THAN 2000');
    END IF;
END;
/

-- 7. Write a query that can ask user to input the EMPNO of employee WARD and display his salary.
DECLARE
    w_empno NUMBER;
    w_sal NUMBER;
BEGIN
    w_empno := :w_empno;
    SELECT sal INTO w_sal FROM emp WHERE empno = w_empno AND ename = 'WARD';
    DBMS_OUTPUT.PUT_LINE('Salary of WARD: ' || w_sal);
END;
/

-- 8. Write a query that can ask user to input the EMPNO of employee BLAKE,CLARK and TURNER and display their respective salary.
DECLARE  
    empno_blake NUMBER;  
    empno_clark NUMBER;  
    empno_turner NUMBER;  
    salary_blake NUMBER;  
    salary_clark NUMBER;  
    salary_turner NUMBER;  
BEGIN  
    empno_blake := :empno_blake;  
    empno_clark := :empno_clark;  
    empno_turner := :empno_turner;  

    SELECT sal INTO salary_blake FROM emp WHERE empno = empno_blake AND ename = 'BLAKE';  
    SELECT sal INTO salary_clark FROM emp WHERE empno = empno_clark AND ename = 'CLARK';  
    SELECT sal INTO salary_turner FROM emp WHERE empno = empno_turner AND ename = 'TURNER';  

    DBMS_OUTPUT.PUT_LINE('Salary of BLAKE: ' || salary_blake);  
    DBMS_OUTPUT.PUT_LINE('Salary of CLARK: ' || salary_clark);  
    DBMS_OUTPUT.PUT_LINE('Salary of TURNER: ' || salary_turner);  
END;  
/ 

-- 9. Write a query that can ask user to input the EMPNO of employee BLAKE,CLARK and TURNER and display their respective salary, add the salaries and display the total.
DECLARE 
    empno_blake NUMBER; 
    empno_clark NUMBER; 
    empno_turner NUMBER; 
    salary_blake NUMBER; 
    salary_clark NUMBER; 
    salary_turner NUMBER; 
    total_salary NUMBER; 
BEGIN 
    empno_blake := :empno_blake; 
    empno_clark := :empno_clark; 
    empno_turner := :empno_turner; 
 
    SELECT sal INTO salary_blake FROM emp WHERE empno = empno_blake AND ename = 'BLAKE'; 
    SELECT sal INTO salary_clark FROM emp WHERE empno = empno_clark AND ename = 'CLARK'; 
    SELECT sal INTO salary_turner FROM emp WHERE empno = empno_turner AND ename = 'TURNER'; 
 
    total_salary := salary_blake + salary_clark + salary_turner; 
 
    DBMS_OUTPUT.PUT_LINE('Total Salary: ' || total_salary); 
END; 
/

-- 10. Write a query that displays the commission of employee SMITH. If SMITH’s commission is NULL. Display ‘NOT APPLICABLE FOR COMMISSION’
DECLARE 
    s_comm NUMBER; 
BEGIN 
    SELECT COMM INTO s_comm FROM emp WHERE ename = 'SMITH'; 
    IF s_comm IS NULL THEN 
        DBMS_OUTPUT.PUT_LINE('NOT APPLICABLE FOR COMMISSION'); 
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Commission: ' || s_comm); 
    END IF; 
END; 
/

----------------------------------------------- Part 03 -----------------------------------------------
-- 11. Write a query that can display the salary of employee JONES three times using basic loop.
DECLARE  
    j_salary NUMBER;  
    counter NUMBER := 1;  
BEGIN  
    SELECT sal INTO j_salary FROM emp WHERE ename = 'JONES';  
    LOOP  
        DBMS_OUTPUT.PUT_LINE('JONES Salary: ' || j_salary);  
        counter := counter + 1;  
        IF counter > 3 THEN  
            EXIT;  
        END IF;  
    END LOOP;  
END;  
/

-- 12. Write a query that can display the salary of employee JONES three times using while loop.
DECLARE  
    j_salary NUMBER;  
    counter NUMBER := 1;  
BEGIN  
    SELECT sal INTO j_salary FROM emp WHERE ename = 'JONES';  
    WHILE counter <= 3 LOOP  
        DBMS_OUTPUT.PUT_LINE('JONES Salary: ' || j_salary);  
        counter := counter + 1;  
    END LOOP;  
END;  
/

-- 13. Write a query that can display the salary of employee JONES three times using for loop.
DECLARE  
    j_salary NUMBER;  
BEGIN  
    SELECT sal INTO j_salary FROM emp WHERE ename = 'JONES';  
    FOR i IN 1..3 LOOP  
        DBMS_OUTPUT.PUT_LINE('JONES Salary: ' || j_salary);  
    END LOOP;  
END;  
/

-- 14. Create a function that returns the total number of departments.
CREATE OR REPLACE FUNCTION get_total_depts 
RETURN NUMBER IS
    total_depts NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_depts FROM dept;
    RETURN total_depts;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total number of departments: ' || get_total_depts);
END;
/


-- 15. Create a procedure to update the salary of employee Allen to 100.
CREATE OR REPLACE PROCEDURE update_allen_salary 
IS
BEGIN
    UPDATE emp SET sal = 100
    WHERE ename = 'ALLEN';
END;
/