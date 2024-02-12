--Creating Database and TABLESPACE
--Creating and Inserting Tables (With and Without Constraints).
-- Create employee table
CREATE TABLE IF NOT EXISTS employee (
    person_name VARCHAR(255) PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255)
);

-- Create works table
CREATE TABLE IF NOT EXISTS works (
    person_name VARCHAR(255),
    company_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (person_name, company_name),
    FOREIGN KEY (person_name) REFERENCES employee(person_name)
);

-- Create company table
CREATE TABLE IF NOT EXISTS company (
    company_name VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255)
);

-- Create manages table
CREATE TABLE IF NOT EXISTS manages (
    person_name VARCHAR(255),
    manager_name VARCHAR(255),
    PRIMARY KEY (person_name),
    FOREIGN KEY (person_name) REFERENCES employee(person_name),
    FOREIGN KEY (manager_name) REFERENCES employee(person_name)
);












--Some Basic Queries
--Modify the database so that Jones now lives in Newtown.
UPDATE employee SET city = 'Newtown' WHERE person_name = 'Jones';

--Modify the database so that Johnson now lives in New York
UPDATE employee SET city = 'New York' WHERE person_name = 'Johnson';

--Find the company with the most employees.
SELECT company_name
FROM works
GROUP BY company_name
ORDER BY COUNT(person_name) DESC
LIMIT 1;

--Find the company with the smallest payroll.
SELECT company_name
FROM works
GROUP BY company_name
ORDER BY SUM(salary) ASC
LIMIT 1;
--Give all employees of First Bank Corporation a 10 percent salary raise.
UPDATE works
SET salary = salary * 1.1
WHERE company_name = 'First Bank Corporation';

--Give all managers in this database a 10 percent salary raise.
UPDATE works
SET salary = salary * 1.1
WHERE person_name IN (SELECT manager_name FROM manages);

--Give all managers in this database a 10 percent salary raise, unless the salary would be greater than $100,000. In such cases, give only a 3 percent raise.
UPDATE works
SET salary = CASE 
                WHEN salary * 1.1 <= 100000 THEN salary * 1.1
                ELSE salary * 1.03
             END
WHERE person_name IN (SELECT manager_name FROM manages);

--Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
SELECT company_name
FROM works
GROUP BY company_name
HAVING AVG(salary) > (SELECT AVG(salary) FROM works WHERE company_name = 'First Bank Corporation');

--Delete all tuples in the works relation for employees of Small Bank Corporation.
DELETE FROM works WHERE company_name = 'Small Bank Corporation';
