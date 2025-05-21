-- Create Address table first (referenced by Student_info)
CREATE TABLE Address (
    a_id NUMBER PRIMARY KEY,
    city VARCHAR2(50),
    country VARCHAR2(50),
    Country_code NUMBER
);

-- Create Student_info table with foreign key
CREATE TABLE Student_info (
    S_Id NUMBER PRIMARY KEY,
    S_Name VARCHAR2(50),
    S_CGPA NUMBER(4,2),
    S_BloodStatus VARCHAR2(50),
    S_BloodGroup VARCHAR2(3),
    a_id NUMBER,
    FOREIGN KEY (a_id) REFERENCES Address(a_id)
);

-- Insert Address data
INSERT INTO Address VALUES (11, 'Dhaka', 'Bangladesh', 101);
INSERT INTO Address VALUES (22, 'Doha', 'Qatar', 102);
INSERT INTO Address VALUES (33, 'Washington D.C', 'USA', 103);
INSERT INTO Address VALUES (44, 'London', 'UK', 104);

-- Insert Student_info data
INSERT INTO Student_info VALUES (1, 'Mira', 3.59, 'Halfblood', 'O+', 11);
INSERT INTO Student_info VALUES (2, 'Rahman', 3.90, 'Pureblood', 'A+', 11);
INSERT INTO Student_info VALUES (3, 'Sharon', NULL, 'Pureblood', 'B+', 22);
INSERT INTO Student_info VALUES (4, 'Caprio', 3.21, 'Pureblood', 'AB+', 22);
INSERT INTO Student_info VALUES (5, 'Winslet', 3.55, 'Muggleborn', 'AB-', 33);
INSERT INTO Student_info VALUES (6, 'Khadija', 2.85, NULL, 'O-', 33);
INSERT INTO Student_info VALUES (7, 'Shekhar', 2.30, 'Pureblood', 'O+', 44);
INSERT INTO Student_info VALUES (8, 'Florina', 3.10, 'Pureblood', 'B+', 44);



-- Query
-- 1.	Display the name, CGPA, (CGPA-0.5) of the students from the Student_info table.
DECLARE
  CURSOR student_cursor IS
    SELECT S_Name, S_CGPA, (S_CGPA - 0.5) AS Adjusted_CGPA
    FROM Student_info;
BEGIN
  FOR student IN student_cursor LOOP
    DBMS_OUTPUT.PUT_LINE('Name: ' || student.S_Name ||
                         ', CGPA: ' || student.S_CGPA ||
                         ', Adjusted CGPA: ' || student.Adjusted_CGPA);
  END LOOP;
END;
/

-- 2.	Display country and country code together as “Country_info” using concatenation function.
DECLARE
  CURSOR address_cursor IS
    SELECT country || ' (' || country_code || ')' AS country_info
    FROM address;
BEGIN
  FOR addr IN address_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(addr.country_info);
  END LOOP;
END;
/

-- 3.	Display the student name and student blood status with the column name “Student Name” and “Student Blood Status” from Student_info.
DECLARE
  CURSOR student_cursor IS
    SELECT S_Name AS "Student Name", S_BloodStatus AS "Student Blood Status"
    FROM Student_info;
BEGIN
  FOR student IN student_cursor LOOP
    DBMS_OUTPUT.PUT_LINE('Student Name: ' || student."Student Name" ||
                         ' - ' || 'Student Blood Status: ' || student."Student Blood Status");
  END LOOP;
END;
/


-- 4.	Display all students who have only one ‘o’ in their name.
BEGIN
    FOR rec IN (SELECT S_Name FROM Student_info WHERE (LENGTH(LOWER(S_Name)) - LENGTH(REPLACE(LOWER(S_Name), 'o', ''))) = 1) 
    LOOP
        DBMS_OUTPUT.PUT_LINE(rec.S_Name);
    END LOOP;
END;
/

-- 5.	Display the student name , CGPA who have null value in their CGPA.
BEGIN
  FOR student IN (SELECT S_Name FROM Student_info WHERE S_CGPA IS NULL) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('Student: ' || student.S_Name || ' has NULL CGPA');
  END LOOP;
END;
/

-- 6.	Display the city, country, country_code and those must be shown from highest numbered country code to lowest numbered country code.
BEGIN
  FOR rec IN (
    SELECT city, country, country_code 
    FROM Address 
    ORDER BY country_code DESC
  ) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('City: ' || rec.city || ' - Country: ' || rec.country || ' - Country Code: ' || rec.country_code);
  END LOOP;
END;
/

-- 7.	Display the student name, student CGPA and student blood status together where the blood status is pureblood using SUBSTR.
BEGIN
  FOR student IN (
    SELECT S_Name, S_CGPA, SUBSTR(S_BloodStatus, 1, 9) AS Blood_Short 
    FROM Student_info 
    WHERE S_BloodStatus = 'Pureblood'
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Name: ' || student.S_Name || ' - ' || 'CGPA: ' || student.S_CGPA || ' - ' || 'Blood Status: ' || student.Blood_Short);
  END LOOP;
END;
/

-- 8.	Show all the students with their CGPA and blood status. If there is any null value use NVL function.
BEGIN
  FOR student IN (
    SELECT S_Name, NVL(TO_CHAR(S_CGPA), 'N/A') AS CGPA, NVL(S_BloodStatus, 'N/A') AS Blood_Status
    FROM Student_info
  ) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('Student: ' || student.S_Name || ' - ' || 'CGPA: ' || student.CGPA || ' - ' || 'Status: ' || student.Blood_Status);
  END LOOP;
END;
/

-- 9.	Find out the student who is holding maximum CGPA.
BEGIN
  FOR student IN (SELECT S_Name, S_CGPA 
    FROM Student_info 
    WHERE S_CGPA = (SELECT MAX(S_CGPA) FROM Student_info)
  ) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('Top Student: ' || student.S_Name || ' with CGPA: ' || student.S_CGPA);
  END LOOP;
END;
/
