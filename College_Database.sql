--Add a new column PINCODE with not null constraints to the existing table DEPT:
ALTER TABLE DEPT ADD COLUMN PINCODE INT NOT NULL;
--Rename the column DName to DEPT_NAME in dept table:
ALTER TABLE dept
CHANGE COLUMN DName DEPT_NAME VARCHAR(255);

--Increase the final marks 15%:
UPDATE iamarks
SET FinalIA = FinalIA * 1.15;

--Find the student names with their corresponding marks.:
SELECT S.Sname, I.Test1, I.Test2, I.Test3, I.FinalIA
FROM STUDENT S
JOIN IAMARKS I ON S.USN = I.USN;

--Delete all data in a table DEPT:
DELETE FROM DEPT;

--Delete table DEPT:
DROP TABLE DEPT; 

--Find the student address who has taken three or more courses in a semester:
SELECT DISTINCT S.Address
FROM STUDENT S
JOIN IAMARKS I ON S.USN = I.USN
HAVING COUNT(DISTINCT I.Subcode) >= 3;