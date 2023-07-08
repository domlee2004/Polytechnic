--1a 
SELECT GETDATE();
--1b
SELECT DATEPART(month,GETDATE());
--1c
SELECT DATENAME(month,GETDATE());
--1d
SELECT DATEPART(year,GETDATE());
--1e
SELECT DATEPART(day,GETDATE());
--Q2
SELECT memberID,Name,DateJoin,DATEDIFF(year,DateJoin,GETDATE()) as "Years of Membership"
FROM member
ORDER BY "Years of Membership" ASC;
--Q3
SELECT LoanNo, ISBN, CopyNo, MemberID, DATEDIFF(day,DateDue,DateReturn) as "Number of Days Overdue"
FROM Loan
WHERE DATEDIFF(day,DateDue,DateReturn) > 0
ORDER BY "Number of Days Overdue" DESC;
--Q4
SELECT StaffID, Name, Gender, DOB
FROM staff
WHERE DatePart(month,dob) = DatePart(month,'2021/02/01')
ORDER BY name ASC;
--Q5
SELECT COUNT(staffID) as "Number of Staff"
FROM staff;
--Q6
SELECT COUNT(staffID) 
FROM staff
WHERE SupervisorID is not NULL;
--Q7
SELECT COUNT(DISTINCT SupervisorID) as "Number Of Supervisors"
FROM staff ;
--Q8
SELECT COUNT(emailaddr) as "Members with email addresses"
FROM member
WHERE EmailAddr is not NULL;
--Q9
SELECT COUNT(*) as "Members without email addresses"
FROM member
WHERE EmailAddr IS NULL;
--Q10
SELECT MIN(rentalrate)
FROM Bookcopy;
--Q11
SELECT COUNT(LoanNo) as"Number of Loan", SUM(RentalRate) as "Total Rental Income"
FROM loan
WHERE DateName(year,'2014/01/01') = DateName(year,DateOut);
--Q12
SELECT COUNT(staffID) as "Number of Staff", SUM(Salary*12) as "Total Annual Salary Payout"
FROM staff;
--Q13
SELECT LoanNo, DateDue as "Old DateDue",DateADD(day,10,DateDue) as "New DateDue"
FROM Loan
ORDER BY "New DateDue" ASC;
--Q14
SELECT Name, ISNULL(EmailAddr, 'Email not found') as "Email Address"
FROM member 
ORDER BY Name;
--Q15
SELECT Name,Address,ContactNo
FROM member
WHERE DatePart(year,'2014/01/01') != DatePart(year,DateJoin) 
AND emailAddr is NULL;