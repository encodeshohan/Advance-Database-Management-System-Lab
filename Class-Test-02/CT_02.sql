--                                              Part: 01

-- 1.	Write a query that displays Hello ADBMS Section A using the concept of literal.
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello ADBMS Section A');
END;

-- 2.	Write a query that can add two numbers using the concept of inner block and outer block.
DECLARE
    n1 NUMBER := 100;
    n2 NUMBER := 200;
BEGIN
    DECLARE
        result NUMBER;
    BEGIN
        result := n1 + n2;
        DBMS_OUTPUT.PUT_LINE('Sum: ' || result);
    END;
END;

-- 3.	Write a query that can multiply three numbers using the concept of literal.
BEGIN
    DBMS_OUTPUT.PUT_LINE(5 * 5 * 5);
END;

-- 4.	Write a query that stores Hello World in a variable and displays it in block letters.
DECLARE
    mesg VARCHAR2(20) := 'Hello World';
BEGIN
    DBMS_OUTPUT.PUT_LINE(UPPER(mesg));
END;

-- 5.	Write a query that can subtract a smaller number from a larger number and display the result using the concept of variable.
DECLARE
    n1 NUMBER := 100;
    n2 NUMBER := 200;
    result NUMBER;
BEGIN
    result := GREATEST(n1, n2) - LEAST(n1, n2);
    DBMS_OUTPUT.PUT_LINE('Result: ' || result);
END;

-- 6.	There are four numbers given i.e. 12,14,16,18.  Find out the average.
DECLARE
    avg NUMBER;
BEGIN
    avg := (12 + 14 + 16 + 18) / 4;
    DBMS_OUTPUT.PUT_LINE('Average: ' || avg);
END;

-- 7.	Write a query that displays the value of pi using the concept of constant.
DECLARE
    PI CONSTANT NUMBER := 3.1416;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Value of PI: ' || PI);
END;


--                                               Part: 02

-- 1.	Write a query that can display the name of the department which has department number 10.
DECLARE
    deptName VARCHAR2(50);
BEGIN
    SELECT dname INTO deptName
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE('Department Name: ' || deptName);
END;

-- 2.	Write a query that can display the name of the department in lower case which has department number 20.
DECLARE
    deptName VARCHAR2(50);
BEGIN
    SELECT LOWER(dname) INTO deptName
    FROM dept
    WHERE deptno = 20;
    
    DBMS_OUTPUT.PUT_LINE('Lowercase Department Name: ' || deptName);
END;

--3.	Write a query that displays the incremented salary (sal+250) of employee Smith.
DECLARE
    newSal NUMBER;
BEGIN
    SELECT sal + 250 INTO newSal
    FROM emp
    WHERE ename = 'SMITH';
    DBMS_OUTPUT.PUT_LINE('Smith''s New Salary: ' || newSal);
END;

-- 4.	Write a query that displays the hiredate of employee KING.
DECLARE
    empHD DATE;
BEGIN
    SELECT hiredate INTO empHD
    FROM emp
    WHERE ename = 'KING';
    DBMS_OUTPUT.PUT_LINE('King''s Hire Date: ' || empHD);
END;

--5.	Write a query that displays the sum of salary of all the employees.
DECLARE
    totalSal NUMBER;
BEGIN
    SELECT SUM(sal) INTO totalSal
    FROM emp;
    DBMS_OUTPUT.PUT_LINE('Total Salary: ' || totalSal);
END;

-- 6.	Write a query that displays the salary and commission of employee Allen.
DECLARE
    allenSal NUMBER;
    allenComm NUMBER;
BEGIN
    SELECT sal, comm INTO allenSal, allenComm
    FROM emp
    WHERE ename = 'ALLEN';
    DBMS_OUTPUT.PUT_LINE('Allen - Salary: ' || allenSal || ', Commission: ' || allenComm);
END;

--7.	Write a query that displays only those employees who have TT (double T) in their name.
				-- Without LOOP
DECLARE
  empTT VARCHAR2(50);
BEGIN
  SELECT ename INTO empTT 
  FROM emp
  WHERE ename LIKE '%TT%';
    DBMS_OUTPUT.PUT_LINE('Employees with "TT": ' || empTT);
END;

				--With LOOP
BEGIN
    FOR emp_rec IN (
        SELECT ename
        FROM emp
        WHERE UPPER(ename) LIKE '%TT%'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee with TT: ' || emp_rec.ename);
    END LOOP;
END;