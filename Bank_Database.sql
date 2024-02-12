
-- Create the BANK database
CREATE DATABASE IF NOT EXISTS BANK;
USE BANK;

--Viewing all Tables in a Database.
SHOW TABLES;

--Creating and Inserting Tables (With and Without Constraints).

-- Create the BRANCH table
CREATE TABLE IF NOT EXISTS BRANCH (
    branch_name VARCHAR(255),
    branch_city VARCHAR(255),
    assets DECIMAL(10, 2),
    PRIMARY KEY (branch_name)
);
-- Create the CUSTOMER table
CREATE TABLE IF NOT EXISTS CUSTOMER (
    customer_name VARCHAR(255),
    customer_street VARCHAR(255),
    customer_city VARCHAR(255),
    PRIMARY KEY (customer_name)
);
-- Create the LOAN table
CREATE TABLE IF NOT EXISTS LOAN (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(255),
    amount DECIMAL(10, 2)
);
-- Create the BORROWER table
CREATE TABLE IF NOT EXISTS BORROWER (
    customer_name VARCHAR(255),
    loan_number INT,
    PRIMARY KEY (customer_name, loan_number),
    FOREIGN KEY (customer_name) REFERENCES CUSTOMER(customer_name),
    FOREIGN KEY (loan_number) REFERENCES LOAN(loan_number)
);
-- Create the DEPOSITOR table
CREATE TABLE IF NOT EXISTS DEPOSITOR (
    customer_name VARCHAR(255),
    account_number INT,
    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (customer_name) REFERENCES CUSTOMER(customer_name),
    FOREIGN KEY (account_number) REFERENCES ACCOUNT(account_number)
);











--Find the names of all branches in the loan relation
SELECT DISTINCT branch_name FROM loan;

--Find all customers having a loan, an account or both at the bank
SELECT DISTINCT customer_name FROM (
    SELECT customer_name FROM borrower
    UNION
    SELECT customer_name FROM depositor
) AS customers_with_accounts_or_loans;

--Find all customers who have both a loan and account at the bank
SELECT b.customer_name 
FROM borrower b
INNER JOIN depositor d ON b.customer_name = d.customer_name;

--Find all customers of the bank who have loan but not account.
SELECT DISTINCT customer_name FROM borrower
WHERE customer_name NOT IN (SELECT customer_name FROM depositor);

--Find all customers of the bank who have an account but not a loan.
SELECT DISTINCT customer_name FROM depositor
WHERE customer_name NOT IN (SELECT customer_name FROM borrower);

--Find average account balance at each branch
SELECT branch_name, AVG(balance) AS avg_balance
FROM account
GROUP BY branch_name;

--Find the average account balance in the Needham branch
SELECT AVG(balance) AS avg_balance
FROM account
WHERE branch_name = 'Needham';

--Find the number of depositors for each branch.
SELECT a.branch_name, COUNT(DISTINCT d.customer_name) AS num_depositors
FROM depositor d
JOIN account a ON d.account_number = a.account_number
GROUP BY a.branch_name;

--For all customer s who have a loan from the bank, find their names, loan numbers, and loan amount
SELECT borrower.customer_name, loan.loan_number, loan.amount
FROM borrower
JOIN loan ON borrower.loan_number = loan.loan_number;

--Find the average account balance at each branch whose average balance is greater than 1200.
SELECT branch_name, AVG(balance) AS avg_balance
FROM account
GROUP BY branch_name
HAVING avg_balance > 1200;

--Find all loan numbers for loans made at the Perryridge branch with loan amount greater than $1200
SELECT loan_number
FROM loan
WHERE branch_name = 'Perryridge' AND amount > 1200;

--Find the names of all customers whose street address includes the substring ‘main’
SELECT customer_name
FROM customer
WHERE customer_street LIKE '%main%';

--Delete all loans with loan amounts between $1300 and $1500
DELETE FROM loan
WHERE amount BETWEEN 1300 AND 1500;

--Delete all account tuples in the Perryridge branch
DELETE FROM depositor WHERE account_number IN (SELECT account_number FROM account WHERE branch_name = 'Perryridge');

--Delete all account tuples at every branch located in Needham.
DELETE FROM account
WHERE branch_name IN (SELECT branch_name FROM branch WHERE branch_city = 'Needham');
