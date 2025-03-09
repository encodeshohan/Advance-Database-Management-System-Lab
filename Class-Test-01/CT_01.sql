--                                          Create Student Table

CREATE TABLE Student(
S_Id INT PRIMARY KEY,
S_Name VARCHAR(255),
S_CGPA FLOAT,
CHECK (S_CGPA <= 4),
S_BloodStatus VARCHAR(255),
H_No INT NOT NULL,
FOREIGN KEY (H_No) REFERENCES House (H_Id)
);


--                                         Create House Table

CREATE TABLE House(
H_Id INT PRIMARY KEY,
H_Name VARCHAR(255) NOT NULL,
H_Points INT
);


--                                         Insert Values into House Table

INSERT INTO House VALUES (11, 'Gryffindor', 892);
INSERT INTO House VALUES (22, 'Hufflepuf', 785);
INSERT INTO House VALUES (33, 'Ravenclaw', 789);
INSERT INTO House VALUES (44, 'Slytherin', 850);


--                                         Insert Values into Student Table

INSERT INTO Student VALUES (2, 'Harry', 3.45, 'Halfblood', 11)
INSERT INTO Student VALUES (7, 'Ron', 3.01, 'Pureblood', 11)
INSERT INTO Student VALUES (12, 'Hannah, NULL, 'Pureblood', 22)
INSERT INTO Student VALUES (17, 'Cedric', 3.78, 'Pureblood', 22)
INSERT INTO Student VALUES (22, 'Cho', 3.55, 'Muggleborn', 33)
INSERT INTO Student VALUES (27, 'Luna', 2.89, NULL, 33)
INSERT INTO Student VALUES (32, 'Draco', 3.88, 'Pureblood', 44)
INSERT INTO Student VALUES (37, 'Goyle', 2.10, 'Pureblood', 44)


--                                               Queries

-- What is the percentage CGPA of each student?
SELECT S_Name, S_CGPA, S_CGPA * 100 AS Percentage FROM Student;


-- Show the student information (ID, Name, and Blood Status) in a single string format? 
SELECT S_Id, S_Name || ' - ' || S_BloodStatus AS Student_Info FROM Student;


-- Show the student IDs and names, with appropriate column aliases?
SELECT S_Id AS Student_ID, S_Name AS S tudent_Name FROM Student;


-- Show the students have names that start with the letter 'H'?
SELECT * FROM Student WHERE S_Name LIKE 'H%';


-- Show the students have a NULL value for their blood status?
SELECT * FROM Student WHERE S_BloodStatus IS NULL;


-- Show the list all students ordered by their CGPA in descending order?
SELECT * FROM Student ORDER BY S_CGPA DESC;


-- Show the first three characters of each student's name along with their ID?
SELECT S_Id, SUBSTR(S_Name, 1, 3) AS Short_Name FROM Student;


-- Show the student IDs, names, and CGPA values, replacing NULL CGPA with 0?
SELECT S_Id, S_Name, NVL(S_CGPA, 0) AS CGPA FROM Student;


-- Show the highest CGPA among all students?
SELECT MAX(S_CGPA) AS Highest_CGPA FROM Student;


-- Show the total number of house points across all houses?
SELECT SUM(H_Points) AS Total_House_Points FROM House;


-- Show their how many students belong to each house?
SELECT H_No, COUNT(*) AS Number_of_Students FROM Student GROUP BY H_No;


-- Show which houses have more than 1 students?
SELECT H_No, COUNT(*) AS Number_of_Students 
FROM Student 
GROUP BY H_No 
HAVING COUNT(*) > 1;