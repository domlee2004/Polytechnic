--Q1
SELECT * 
FROM member
WHERE BranchNo = 1;
--Q2
SELECT *
FROM Book
WHERE BookCat = 'C';
--Q3
SELECT *  
FROM member
WHERE BranchNo = 1 OR BranchNo = 2;
--Q4
SELECT * 
FROM Book 
WHERE BookCat='C' OR BookCat='F';
--Q5
SELECT * 
FROM member
WHERE (BranchNo = 1 OR BranchNo = 2) AND Datejoin > '2005-12-31';
--Q6
SELECT * 
FROM Book 
WHERE (BookCat='C' OR BookCat='F') AND YearPublish > 2000;
--Q7
SELECT * 
FROM BookCopy 
WHERE Status='D' AND RentalRate >  5;
--Q8
SELECT *  
FROM staff
WHERE Gender='F' AND Salary > 1500;
--Q9
SELECT * 
FROM Loan
WHERE DateOut BETWEEN '2014-12-01' AND '2015-01-31';
--Q10
SELECT * 
FROM member
WHERE DateJoin BETWEEN '2014-01-01' AND '2014-12-31';
--Q11
SELECT *
FROM Book
WHERE BookCat IN ('C', 'F');
--Q12
SELECT * 
FROM member
WHERE BranchNo IN (1,2,3);
--Q13
SELECT * 
FROM member
WHERE Name Like 'Tan%';
--Q14
SELECT * 
FROM Book
WHERE Title LIKE 'Database%';
--Q15
SELECT *
FROM Book
WHERE Title LIKE '%Database';
--Q16
SELECT * 
FROM member
WHERE Name LIKE '%Kim%';
--Q17
SELECT * 
FROM Book
WHERE BookCat IS NULL;
--Q18
SELECT * 
FROM Staff
WHERE SupervisorID IS NULL;
--Q19
SELECT *
FROM Staff
WHERE DOB NOT BETWEEN '1988-01-01' AND '1990-06-30'
ORDER BY DOB ASC;
--Q20
SELECT * 
FROM Book
WHERE (BookCat <> 'C' AND BookCat <> 'F') OR BookCat IS NULL
ORDER BY BookCat, YearPublish DESC;

SELECT * 
FROM Book
WHERE BookCat NOT IN ('C','F') OR BookCat is NULL
ORDER BY BookCat, YearPublish DESC;
--Q21
SELECT * 
FROM Staff
WHERE SupervisorID IS NOT NULL
ORDER BY SupervisorID ASC;
--Q22
SELECT * 
FROM member
WHERE Address LIKE '%Street%'
ORDER BY Name ASC;
--Q23
SELECT * 
FROM Staff
WHERE BranchNo IN (1,3) AND supervisorID IS NULL;
SELECT * 
FROM Staff
WHERE BranchNo <> 2 AND supervisorID IS NULL;
--Q24
SELECT Name, Address, ContactNo
From Member
WHERE EmailAddr IS NULL AND DateJoin < '2014-01-01';
--Q25
SELECT *
FROM BookCategory
WHERE Description='Fiction';
-- More preferable to use '=' because all the descriptions are only 1 word.
--Q26
SELECT * 
FROM Book
WHERE YearPublish NOT BETWEEN 1990 AND 1999;
-- I used the NOT and BETWEEN operator
SELECT *
FROM Book
WHERE YearPublish >= 2000 OR YearPublish < 1990;