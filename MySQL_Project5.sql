DROP DATABASE IF EXISTS MySQL_Project5;
CREATE DATABASE MySQL_Project5;
USE MySQL_Project5;

CREATE TABLE StudentDetails
(
	StudId INT AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
	EnrollmentNo INT NOT NULL,
    DateOfJoining DATE NOT NULL,
    PRIMARY KEY (StudId)
);

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
