/* Q1 */
SELECT BookCopy.ISBN, BookCopy.CopyNo, BookCopy.RentalRate,Book.Title
FROM BookCopy
INNER JOIN Book
ON BookCopy.ISBN = Book.ISBN;
/*Q2*/
SELECT ISBN, Title, BookCategory.Description
FROM Book
INNER JOIN BookCategory
ON Book.BookCat = BookCategory.BookCat
ORDER BY Title
/*Q3*/
SELECT Branch.BranchNo, Branch.Address, Staff.Name
FROM Branch
INNER JOIN Staff
ON Branch.MgrID = Staff.StaffID
/*Q4*/
SELECT s.StaffID, s.Name, s.DateJoin
FROM Staff s
INNER JOIN Staff se
ON s.SupervisorID = se.StaffID
WHERE se.Name = 'May May'

/*Q5*/
SELECT Book.ISBN, Loan.DateOut, Book.Title
FROM Loan
INNER JOIN Book ON Book.ISBN = Loan.ISBN
INNER JOIN Member ON Member.MemberID = Loan.MemberID
WHERE Member.Name = 'Kumar'
/*Q6*/
SELECT BookAuthor.ISBN, Book.Title, Author.Name
FROM BookAuthor
INNER JOIN Author ON Author.AuthorID = BookAuthor.AuthorID
INNER JOIN Book ON Book.ISBN = BookAuthor.ISBN
ORDER BY Title
/*Q7*/
SELECT COUNT(Loan.LoanNo), SUM(Loan.RentalRate)
FROM Loan
INNER JOIN Member 
ON Loan.MemberID = Member.MemberID
WHERE Member.Name = 'Jeremy Law'
/*Q8*/
SELECT DISTINCT s.Name
FROM Staff s
INNER JOIN Staff se
ON s.StaffID = se.SupervisorID
ORDER BY Name
/*Q9*/
SELECT Book.ISBN,Book.Title,Book.YearPublish
FROM Book 
INNER JOIN Publisher
ON Publisher.PublisherID = Book.PublisherID
WHERE BookCat='F' AND publisher.Name = 'Arrow Books'
ORDER BY YearPublish
--Q10
SELECT s.StaffID, s.Name, s.DateJoin, DateDIFF(Year, s.DateJoin, GETDATE()) AS 'Years of service'
FROM Staff s 
INNER JOIN Staff se
ON s.supervisorID = se.StaffID
WHERE DateDIFF(Year,s.DateJoin,GetDate()) < 10 AND se.Name = 'May May'