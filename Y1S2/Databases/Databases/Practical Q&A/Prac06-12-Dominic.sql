
create table BOOKCATEGORY
(bookcat char(2),
description varchar(100) not null,
constraint pk_bcategory primary key (bookcat)
)

create table publisher
(publisherID smallint primary key,
name varchar(50) not null
)

create table book
(isbn char(10) primary key,
title varchar(200) not null,
yearpublish char(4) not null,
publisherID smallint null foreign key references publisher(publisherID),
bookcat char(2) null,
constraint fk_book_bookcat foreign key (bookcat) references BOOKCATEGORY(bookcat))

INSERT INTO book
Select * from NP40Book.dbo.book

INSERT INTO publisher
Select * from NP40Book.dbo.publisher

INSERT INTO bookcategory
Select * from NP40Book.dbo.bookcategory
--Q8
Insert into book(ISBN, Title, yearpublish, publisherID, bookcat)
Values ('0385605196', 'Not the end of the world', '2002', 4, 'F')

Insert into book(ISBN, Title, yearpublish, publisherID, bookcat)
Values ('0385605196', 'The Devil wears Prada', '2003', 4, 'F')

-- When inserting the 2nd book record there is an error message which says
-- violation of primary key constraint. This happens as the primary key is the duplicate of the first but all pk should be unique.

--Q9
INSERT INTO publisher(publisherID, name)
VALUES (9, 'Pearson Prentice Hall')
INSERT INTO book(isbn, title, yearpublish, publisherID, bookcat)
Values ('981244579X', 'Database', '2003', 9, 'NF')
--Insert into publisher before book table. As publisher ID in book table (primary key) is the foreign key in book table
-- If book table is inserted first, there will be no primary key to reference causing error

--Q10
UPDATE publisher
SET name = 'Happy Day'
WHERE name = 'Doubleday'

select * from book
--Q11
UPDATE bookcategory
SET description = 'Comedy'
WHERE description = 'Children'

--Q12 
UPDATE book
SET bookcat = 'NF', publisherID = (Select PublisherID from publisher WHERE name = 'Addison Wesley')
WHERE title = 'Database Systems'

--Q13
UPDATE publisher
SET name = 'Heinz'
WHERE publisherID = (Select publisherID from book where title = 'The Best of Catherine Lim')

--Q14 
DELETE book
WHERE ISBN = '0072126949'

--Q15
DELETE book
WHERE ISBN = '981244579X'

DELETE publisher
WHERE publisherID = 9
--Delete the foreign key first because if you delete the primary key first than the foreign key
-- will have nothing to reference to and will cause an error

--Q16
create table Member
(memberID smallint not null ,
name varchar(50) not null,
address varchar(150) null,
contactNo char(10) null,
emailAddr varchar(50) null,
gender char(1) null CHECK(gender IN ('M','F')),
datejoin smalldatetime not null CHECK(datejoin <= GetDate()),
branchNo tinyint not null,
constraint pk_member primary key (memberID)
)

--Q17
INSERT INTO Member
SELECT * FROM NP40Book.dbo.Member

--Q18
create table reservation
(memberID smallint not null,
isbn char(10) not null,
resDate Datetime not null DEFAULT(GETDATE()),
endDate Datetime not null,
constraint pk_reservation primary key (memberID, ISBN),
constraint fk_reservation1 foreign key (memberID) references Member(memberID),
constraint fk_reservation2 foreign key (ISBN) references Book(ISBN)
)

--Q19
Insert into reservation
Values (3, '0330255800', '2015-05-02', '2015-05-12'),
(5, '9971643359', '2015-05-14', '2015-06-14'),
(5, '0201708574', '2015-05-18', '2015-05-28'),
(6, '9971643359', '2015-05-20', '2015-06-03'),
(3, '0201708574', GETDATE(), GETDATE() + 14
)

--Q20
SELECT b.isbn,title,yearpublish,publisherID,bookcat,Format(resDate,'MM/yyyy') as resDate, Format(endDate,'MM/yyyy') as endDate
FROM book b
INNER JOIN reservation r
ON b.isbn = r.isbn
WHERE resDate >= '2015-05-15' and resDate <= '2015-05-30'

SELECT * FROM book
SELECT * FROM bookcategory
SELECT * FROM publisher
SELECT * FROM member
SELECT * FROM reservation

