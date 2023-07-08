--Q1
SELECT BranchNo, COUNT(MemberID)AS 'Number of members'
FROM Member
GROUP BY BranchNo;
--Q2
SELECT ISBN, MAX(CopyNo) AS 'Number of copies'
FROM BookCopy
GROUP BY ISBN
ORDER BY MAX(CopyNo) DESC
--Q3
SELECT ISBN, MAX(CopyNo) AS 'Number of copies'
FROM BookCopy
GROUP BY ISBN
HAVING MAX(CopyNo)>2
ORDER BY MAX(CopyNo) DESC
--Q4
SELECT BookCat, PublisherID,COUNT(*)AS 'Number of books' 
FROM Book
GROUP BY BookCat,PublisherID
--Q5
SELECT BranchNo, SupervisorID, COUNT(staffID) AS 'Number of female staff'
FROM staff
WHERE gender = 'F' and supervisorID is not null
GROUP BY BranchNo, SupervisorID
--Q6
SELECT publisher.Name, COUNT(Book.PublisherID) AS 'Number of Book'
FROM publisher
INNER JOIN Book
ON Book.publisherID = publisher.PublisherID
GROUP BY publisher.Name
ORDER BY COUNT(Book.PublisherID) DESC
--Q7
SELECT ISBN, CopyNo,DateOut
FROM Loan
WHERE MemberID = (SELECT MemberID FROM member WHERE Name = 'Kumar')
--Q8
SELECT Title, YearPublish 
FROM Book
WHERE (SELECT COUNT(CopyNo) FROM BookCopy ) > 0 AND (publisherID is not null and BookCat is not null)
--Q9
SELECT ISBN, Title
FROM Book
WHERE publisherID is NULL
--Q10
SELECT Name, Salary
FROM staff 
WHERE Salary = (SELECT MAX(Salary) FROM staff)
--Q11
SELECT memberID, Name, Gender 
FROM member
WHERE (SELECT COUNT(memberID) FROM Loan WHERE member.MemberID = Loan.memberID)>5
--Q12
SELECT DISTINCT(Name)
FROM Staff
WHERE StaffID IN (SELECT supervisorID FROM staff)
--Q13
/* No. As the join clause only combines data from different tables, and the subquery in 
   q12 selects values from the same table, it is not possible to use the join clause */