--Retrieve total salary of employee group by employee name and count similar names.
SELECT Name, SUM(Salary) AS TotalSalary, COUNT(*) AS NameCount
FROM EMPLOYEE
GROUP BY Name;

--Display name of employee in ascending order
SELECT Name FROM EMPLOYEE ORDER BY Name ASC;

--Display name of employee in descending order
SELECT Name FROM EMPLOYEE ORDER BY Name DESC;

--Retrieve employee number and their salary.
SELECT SSN, Salary FROM EMPLOYEE;

--Retrieve average salary of all employee.
SELECT AVG(Salary) AS AverageSalary FROM EMPLOYEE; 

--Retrieve distinct number of employees.
SELECT COUNT(DISTINCT SSN) AS UniqueEmployees FROM EMPLOYEE;

--Retrieve the name of employees and their dept name
SELECT e.Name, d.DName
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DNo = d.DNo;

--Retrieve the name of employees who born in the year 1990.
SELECT Name FROM EMPLOYEE WHERE YEAR(DateOfBirth) = 1990;

--Retrieve total salary of employee which is greater than >120000.
SELECT SUM(Salary) AS TotalSalary FROM EMPLOYEE WHERE Salary > 120000;

--Display details of employee whose name is AMIT and salary greater than 50000.
SELECT * FROM EMPLOYEE WHERE Name = 'AMIT' AND Salary > 50000;

--How the resulting salaries if every employee working on the ‘Research’ Departments is given a 10 percent raise.
UPDATE EMPLOYEE e
JOIN DEPARTMENT d ON e.DNo = d.DNo
SET e.Salary = e.Salary * 1.1
WHERE d.DName = 'Research'; 