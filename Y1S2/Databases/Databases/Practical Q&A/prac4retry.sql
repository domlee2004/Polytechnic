select bc.isbn, bc.rentalrate, bc.copyno, b.title
from bookcopy bc
inner join book b
on b.isbn = bc.isbn

select b.isbn, b.title, bc.Description
from book b
inner join bookcategory bc
on  b.bookcat = bc.bookcat
order by title asc

select b.branchNo,b.address, s.Name
from branch b
inner join staff s
on b.mgrid = s.staffid

select s.staffId, s.Name, s.DateJoin
from staff s
inner join staff sup
on s.supervisorid = sup.staffId
where sup.name = 'May May'

select b.isbn, b.title, l.dateout
from book b
inner join loan l
on b.isbn = l.isbn
inner join member m
on l.memberId = m.memberId
where m.name = 'Kumar'
order by l.dateout asc

select b.isbn, b.title, A.Name
from book b
inner join bookauthor ba
on b.isbn = ba.isbn
inner join author A
on ba.authorId = A.authorId
order by title asc

select count(l.memberId) as 'Number of Loans', sum(l.rentalrate) as 'Total Rental Rate'
from loan l
inner join member m
on m.MemberID = l.MemberID
where m.name = 'Jeremy Law'

select Distinct s.name
from staff s
inner join staff sup
on s.staffId = sup.SupervisorID
order by name asc

select b.isbn, b.title, b.yearpublish
from book b
inner join BookCategory bc
on b.bookcat = bc.bookcat
inner join publisher p
on p.publisherId = b.publisherId
where p.name = 'Arrow Books' and bc.Description = 'Fiction'
order by YearPublish

select s.staffId, s.Name, s.dateJoin, datediff(year, s.datejoin, getdate()) as 'Years In Service'
from staff s
inner join staff sup
on s.supervisorId = sup.staffID
where sup.Name = 'May May' and datediff(year, s.datejoin, getdate()) < 10