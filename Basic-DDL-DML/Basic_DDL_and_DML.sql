-- Data Definition Language (DDL)
 
-- publishers Table
CREATE TABLE publishers (
pubid INT PRIMARY KEY,
pname VARCHAR(255),
email VARCHAR(255),
phone VARCHAR(255)
);

-- authors Table
CREATE TABLE authors (
auid INT PRIMARY KEY,
aname VARCHAR(255),
email VARCHAR(255),
phone VARCHAR(255)
);

-- subjects Table
CREATE TABLE subjects (
subid INT PRIMARY KEY,
sname VARCHAR(255)
);

-- titles Table
CREATE TABLE titles (
titleid INT PRIMARY KEY,
title VARCHAR(255),
pubid INT,
sbuid INT,
pubdate DATE,
cover VARCHAR(255),
price FLOAT,
FOREIGN KEY (sbuid) REFERENCES subjects (subid),
FOREIGN KEY (pubid) REFERENCES publishers (pubid)
);

-- titleauthors Table
CREATE TABLE titleauthors (
titleid INT,
auid INT,
importance VARCHAR(255),
PRIMARY KEY (titleid, auid),
FOREIGN KEY (titleid) REFERENCES titles (titleid),
FOREIGN KEY (auid) REFERENCES authors (auid)
);


-- Data Manipulation Language (DML)

-- Inserting Data into publishers table
INSERT INTO publishers 
VALUES (1, 'Prothoma', 'prothoma@mail.com', '01789631836');
INSERT INTO publishers 
VALUES (2, 'Springers', 'springers@mail.com', '01770661836');

-- Inserting Data into authors table
INSERT INTO authors 
VALUES (1, 'A. K. Zaheer', 'akz@mail.com', '01799031536');
INSERT INTO authors 
VALUES (2, 'Max Bob', 'mb@mail.com', '01345661836');

-- Inserting Data into subjects table
INSERT INTO subjects 
VALUES (1, 'Politics');
INSERT INTO subjects 
VALUES (2, 'Computer Science');

-- Inserting Data into titles table
INSERT INTO titles 
VALUES (1, 'Politics in Mars', 1, 1, '12-JAN-2012', 'Hard Cover', 650.00);
INSERT INTO titles 
VALUES (2, 'Wonder of Computer Science', 2, 2, '23-MAR-2000', 'Hard Cover', 350.00);

-- Inserting Data into titleauthors table
INSERT INTO titleauthors 
VALUES (1, 1, 'Low');
INSERT INTO titleauthors 
VALUES (2, 2, 'High');
