CREATE TABLE BookCategory (
Bookcat char(2) Primary Key,
Description varchar(100) not null
)
select * from bookcategory

CREATE TABLE Publisher(
PublisherID smallint,
Name varchar(50) not null,
constraint pk_publisher Primary key (PublisherID)
)

CREATE TABLE Book(
ISBN char(10) primary key,
Title varchar(200) not null,
YearPublish Char(4) not null,
PublisherID smallint null,
BookCat char(2) null,
constraint fk_publisher foreign key (PublisherID) references Publisher(PublisherID),
constraint fk_bookcat foreign key (Bookcat) references BookCategory(Bookcat)
)

INSERT INTO BOOKCATEGORY
select * from NP40book.dbo.BookCategory

Insert into publisher
select * from NP40Book.dbo.publisher

Insert into book
select * from NP40Book.dbo.Book

Insert into book
Values('0385605196', 'Not the end of the world', '2002', 4,'F')

Insert into book
Values('0385605196', 'The Devil wears Prada', '2003', 4,'F')

insert into publisher(publisherID, name)
values( 9, 'Pearson Prentice Hall')

Insert into Book
Values('981244579X', 'Database', '2003', 9, 'NF')

UPDATE Publisher
SET name = 'Happy Day'
where publisherId = 4

UPDATE BookCategory
SET Description = 'Comedy'
Where BookCat = 'C'

UPDATE Book
SET BookCat = 'NF', PublisherID = (Select PublisherId from publisher where name = 'Addison Wesley')
Where Title = 'Database Systems'

UPDATE Publisher 
SET Name = 'Heinz'
From book b
inner join publisher p
on b.publisherId = p.PublisherID
where title = 'The Best of Catherine Lim'

DELETE Book
where isbn = '0072126949'

Delete book
from book
where isbn = '981244579X'

Delete publisher 
from publisher
where publisherId = 9

CREATE TABLE Member(
MemberId smallint primary key,
Name varchar(50) not null,
Address varchar(150) null,
ContactNo varchar(150) null,
EmailAddr varchar(50) null,
Gender char(1) check (gender in ('M','F')) null,
DateJoin smalldatetime check(dateJoin <= GETDATE()) not null,
BranchNo tinyint not null,
)

insert into member
select * from NP40Book.dbo.member

Create Table Reservation(
memberId smallint not null,
ISBN char(10) not null,
ResDate datetime not null default(getdate()),
EndDate datetime not null --problem with endate,
constraint pk_Reservation primary key (MemberID, ISBN, ResDate),
constraint fk_memberId foreign key (memberId) references member(memberId),
constraint fk_Isbn foreign key (ISBN) references book(ISBN)
)

Insert into Reservation(memberId, isbn, resdate, enddate)
Values(3,'0330255800','2 May 2015','12 May 2015')
Insert into Reservation(memberId, isbn, resdate, enddate)
Values(5,'9971643359','14 May 2015','14 May 2015')
Insert into Reservation(memberId, isbn, resdate, enddate)
Values(5,'0201708574','18 May 2015','28 May 2015')
Insert into Reservation(memberId, isbn, resdate, enddate)
Values(6,'9971643359','20 May 2015','3 June 2015')
Insert into Reservation(memberId, isbn, resdate, enddate)
Values(3,'0201708574',getdate(),getdate()+day(14))

select r.isbn, Format(r.resdate, 'dd/MM/yyyy') as 'ResDate', Format(r.enddate, 'dd/MM/yyyy') as 'EndDate', b.title,b.yearpublish,b.publisherID, b.bookcat
from reservation r
inner join book b
on r.isbn = b.isbn
where  ResDate between '15 May 2015' and '30 May 2015'
select * from member
select * from book
select * from publisher
select * from bookcategory
select * from reservation
drop table book