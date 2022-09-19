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