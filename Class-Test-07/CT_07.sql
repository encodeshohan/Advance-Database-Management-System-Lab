-- 1.	Log in as system and create a user Students having password ADBMS. The user Students is granted unlimited tablespace. Students is also granted the permission to create tables, view and sequence.
CREATE USER Students IDENTIFIED BY ADBMS;
ALTER USER Students DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
GRANT CREATE SESSION TO Students;
GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO Students;

-- 2.	After logging in with username and password Students run the queries from the Supplementary section of PL/SQL Tutorial to create tables and insert data into the created tables.
-- Table Creation:
create table author(a_id number(10)primary key, a_name varchar2(20));
create table book(b_id number(10),b_name varchar2(20), isbn varchar2(20),edition varchar2(20), c_id number(10),a_id number(10), primary key(b_id,edition) );
create table category(c_id number(10)primary key, c_name varchar2(20));
alter table book add constraint fk_category foreign key (c_id) references category(c_id); 
alter table book add constraint fk_author foreign key (a_id) references author(a_id);

-- Data Insertion:
insert into author values('1','J.K. Rowling');
insert into author values('2','Stephenie Meyer');
insert into author values('3','Dan Brown');
insert into author values('4','Humayun Ahmed');
insert into author values('5','Zafar Iqbal');

insert into category values('11','Fantasy');
insert into category values('22','Romance');
insert into category values('33','Thriller');
insert into category values('44','Anti-logic');
insert into category values('55','Science Fiction');

insert into book values('111','HP...Deathly Hallows','978-3-16-148410-0','10','11','1');
insert into book values('222','Breaking Dawn','979-3-16-148410-0','10','22','2');
insert into book values('333','Origin','980-3-16-148410-0','10','33','3');
insert into book values('444','Holud HimuKalo RAB','981-3-16-148410-0','10','44','4');
insert into book values('555','Obonil','982-3-16-148410-0','10','55','5');

-- 3.	Create a function that returns the total number of books stored inside the library.
CREATE OR REPLACE FUNCTION total_books
RETURN NUMBER IS
   total NUMBER;
BEGIN
   SELECT COUNT(*) INTO total FROM book;
   RETURN total;
END;
/

-- 4.	Beast has ordered that all the books in his library should be of the latest edition. So, create a procedure to update the value of the edition column of book table from 10 to 20.
CREATE OR REPLACE PROCEDURE update_edition IS
BEGIN
   UPDATE book SET edition = '20' WHERE edition = '10';
END;
/

-- 5.	Create a record that can output the name of the book whose id is 111.
DECLARE
   book_rec book%ROWTYPE;
BEGIN
   SELECT * INTO book_rec FROM book WHERE b_id = 111;
   DBMS_OUTPUT.PUT_LINE(book_rec.b_name);
END;
/

-- 6.	Create a record that can output the name of all the books inside the library.
DECLARE
BEGIN
   FOR book_rec IN (SELECT b_name FROM book) LOOP
      DBMS_OUTPUT.PUT_LINE(book_rec.b_name);
   END LOOP;
END;
/

-- 7.	Create a cursor that can output the id and name of all the categories the books are sorted in.
DECLARE
   CURSOR c_cat IS SELECT c_id, c_name FROM category;
   rec_cat c_cat%ROWTYPE;
BEGIN
   OPEN c_cat;
   LOOP
      FETCH c_cat INTO rec_cat;
      EXIT WHEN c_cat%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(rec_cat.c_id || ' - ' || rec_cat.c_name);
   END LOOP;
   CLOSE c_cat;
END;
/

-- 8.	Create a trigger in such a way that whenever a new row is inserted into the category table an output ‘New Category Added’ is generated.
CREATE OR REPLACE TRIGGER category_insert_trigger
AFTER INSERT ON category
FOR EACH ROW
BEGIN
   DBMS_OUTPUT.PUT_LINE('New Category Added');
END;
/

-- 9.	Create a trigger in such a way that whenever a row is deleted from the category table an output ‘A Category Deleted’ is generated.
CREATE OR REPLACE TRIGGER category_delete_trigger
AFTER DELETE ON category
FOR EACH ROW
BEGIN
   DBMS_OUTPUT.PUT_LINE('A Category Deleted');
END;
/

-- 10.	Create a package that contains a procedure which can display the book name of any book whose id is passed as its parameter.
CREATE OR REPLACE PACKAGE book_package AS
   PROCEDURE display_book_name(p_b_id IN book.b_id%TYPE);
END book_package;
/

CREATE OR REPLACE PACKAGE BODY book_package AS
   PROCEDURE display_book_name(p_b_id IN book.b_id%TYPE) IS
      v_b_name book.b_name%TYPE;
   BEGIN
      SELECT b_name INTO v_b_name FROM book WHERE b_id = p_b_id;
      DBMS_OUTPUT.PUT_LINE('Book Name: ' || v_b_name);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('Book not found.');
   END display_book_name;
END book_package;
/