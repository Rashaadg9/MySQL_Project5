DROP DATABASE IF EXISTS MySQL_Project5;
CREATE DATABASE MySQL_Project5;
USE MySQL_Project5;

DROP TABLE IF EXISTS StudentDetails;
CREATE TABLE StudentDetails
(
	StudId INT AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
	EnrollmentNo INT,
    DateOfJoining DATE NOT NULL,
    PRIMARY KEY (StudId)
);


DROP TABLE IF EXISTS StudentStipend;
CREATE TABLE StudentStipend
(
	StudId INT,
    Project VARCHAR(2) NOT NULL,
	Stipend INT NOT NULL,
    PRIMARY KEY (StudId),
    FOREIGN KEY (StudId) REFERENCES StudentDetails(StudId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

ALTER TABLE StudentDetails AUTO_INCREMENT = 11;
SET @@auto_increment_increment = 10;

INSERT INTO StudentDetails VALUES(NULL, "Nick Panchal", 1234567, "2019-01-02");
INSERT INTO StudentDetails VALUES(NULL, "Yash Pancha", 2468101, "2017-03-15");
INSERT INTO StudentDetails VALUES(NULL, "Gyan Rathodl", 3689245, "2018-05-27");

INSERT INTO StudentStipend VALUES(11, "P1", 80000);
INSERT INTO StudentStipend VALUES(21, "P2", 10000);
INSERT INTO StudentStipend VALUES(31, "P1", 120000);

/* 1. Write an SQL query to insert a new student detail in StudentDetails table. */
INSERT INTO StudentDetails VALUES(NULL, "Test Student", 7654321, "2020-01-13");
SELECT * FROM StudentDetails;

/* 2. Write an SQL query to select a specific student detail in StudentDetails table. */
SELECT * FROM StudentDetails WHERE StudId = 21;

/* 3. Write an SQL query to update a project detail in StudentStipend table. */
UPDATE StudentStipend SET Project = "P0" WHERE StudId = 11;
SELECT * FROM StudentStipend;

/* 4. Write an SQL query to drop a StudentStipend table with its structure. */
DROP TABLE StudentStipend;
SHOW TABLES;

/* 5. Write an SQL query to delete only StudentDetails table data. */
TRUNCATE TABLE StudentDetails;
SELECT * FROM StudentDetails;

/* 6. Write an SQL query to fetch student names having stipend greater than or equal to 50000 and less than or equal 100000. */

SELECT d.Name, s.Stipend
FROM StudentDetails d
INNER JOIN StudentStipend s ON d.StudId = s.StudId
WHERE s.Stipend BETWEEN 50000 AND 100000
ORDER BY s.Stipend;

/* 7. Write a query to fetch student names and stipend records. Return student details even if
the stipend record is not present for the student. */

INSERT INTO StudentDetails VALUES(NULL, "Test Student", 7654321, "2020-01-13");

SELECT d.Name, s.*
FROM StudentDetails d
LEFT JOIN StudentStipend s ON d.StudId = s.StudId
ORDER BY s.Stipend;

/* 8. Write an SQL query to fetch all student records from StudentDetails table who have a stipend record in StudentStipend table */

SELECT d.* FROM StudentDetails d
INNER JOIN StudentStipend s ON d.StudId = s.StudId;

/* 9. Write an SQL query to fetch the number of students working in project 'P1'. */
SELECT Project, Count(*) AS StudentCount FROM StudentStipend WHERE Project = "P1";

/* 10.Write an SQL query for fetching duplicate records from a table. */
INSERT INTO StudentDetails VALUES(NULL, "Test Student", 7654321, "2020-01-13");
INSERT INTO StudentDetails VALUES(NULL, "Test Student", 7654321, "2020-01-13");

SELECT *, COUNT(*) FROM StudentDetails GROUP BY EnrollmentNo HAVING COUNT(*) > 1;

SELECT DISTINCT r1.* FROM StudentDetails r1, StudentDetails r2 WHERE (r1.EnrollmentNo = r2.EnrollmentNo) AND (r1.StudId > r2.StudId);

/* 11.Write an SQL query for removing duplicates from a table without using a temporary table.*/
SET SQL_SAFE_UPDATES = 0;
DELETE r1 FROM StudentDetails r1, StudentDetails r2 WHERE (r1.EnrollmentNo = r2.EnrollmentNo) AND (r1.StudId > r2.StudId);

/* 12.Write an SQL query for fetching all the Students who also have enrollmentNo from StudentDetails table. */
INSERT INTO StudentDetails VALUES(NULL, "Test Student2", NULL, "2020-01-13");

SELECT * FROM StudentDetails WHERE EnrollmentNo IS NOT NULL;

/* 13.Write an SQL query for creating a new table with data and structure copied from another table. */
CREATE TABLE StudentDetails_bk (SELECT * FROM StudentDetails);

/* 14.Write an SQL query to fetch a joint record between two tables using intersect. */
-- Note Intersect does not exist in MySQL

DELETE FROM StudentDetails_bk WHERE (StudId = 21) OR (StudId = 31);

SELECT * FROM StudentDetails WHERE StudId IN (SELECT StudId FROM StudentDetails_bk);

/* 15.Write an SQL query for fetching records that are present in one table but not in another table using Minus. */
-- Note Intersect does not exist in Minus

SELECT * FROM StudentDetails s
LEFT JOIN StudentDetails_bk b ON s.StudId = b.StudId
WHERE b.StudId IS NULL;

/* 16.Write an SQL query to fetch count of students project-wise sorted by project’s count in descending order. */

SELECT Project, Count(*) AS StudentCount FROM StudentStipend GROUP BY Project ORDER BY StudentCount DESC;

/* 17.Write an SQL query for creating an empty table with the same structure as some other table. */

CREATE TABLE StudentStipend_bk LIKE StudentStipend;
DESCRIBE StudentStipend;
DESCRIBE StudentStipend_bk;
SELECT * FROM StudentStipend_bk;

/* 18.Write an SQL query for finding current date-time. */
SELECT CURRENT_TIMESTAMP();

/* 19.Write an SQL query for fetching only even rows from the table. */

SET @row_number = 0;

SELECT t.*
FROM (SELECT *, (@row_number := @row_number + 1) AS Row_Num
FROM StudentDetails) t
WHERE (t.Row_Num % 2) = 0;

/* 20.Write an SQL query for fetching all the Students details from StudentDetails table who joined in the Year 2018. */
SELECT * FROM StudentDetails WHERE YEAR(DateOfJoining) = "2018";

/* 21.Write the SQL query to find the nth highest stipend from the table. */
SET @n = 3;

PREPARE STMT FROM "SELECT * FROM StudentStipend ORDER BY Stipend DESC LIMIT ?, 1;";
SET @v = @n - 1;
EXECUTE STMT USING @v;

/* 22.Write SQL query for fetching top n records using LIMIT? */
SET @n = 2;
SET @STMT = CONCAT("SELECT * FROM StudentStipend LIMIT ", @n);
PREPARE STMT FROM @STMT;
EXECUTE STMT;

/* 23.Write a query for fetching only the first name(string before space) from the Name column of StudentDetails table. */
SELECT SUBSTRING_INDEX(Name, ' ', 1) AS First_Name FROM StudentDetails;

/* 24.Write an SQL query for fetching only odd rows from the table. */
SET @row_number = 0;

SELECT t.*
FROM (SELECT *, (@row_number := @row_number + 1) AS Row_Num
FROM StudentDetails) t
WHERE (t.Row_Num % 2) != 0;

/* 25. Write SQL query for finding the 3rd highest stipend from the table without using TOP/limit keyword. */
SELECT * FROM
(SELECT *, DENSE_RANK() OVER(ORDER BY Stipend DESC) Stipend_Rank FROM StudentStipend) Stipend_Ranked
WHERE Stipend_Rank = 3;