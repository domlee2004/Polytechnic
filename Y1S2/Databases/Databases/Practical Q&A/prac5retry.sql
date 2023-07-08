select branchNo, count(distinct memberid) as 'Number of Members'
from member
group by branchNo

select isbn, count(copyNo) as 'Number of Copies'
from bookcopy
group by isbn
order by 'Number of Copies' DESC

select isbn, count(copyNo) as 'Number of Copies'
from bookcopy 
group by isbn 
Having count(copyNo) > 2

select bookcat, publisherId, count(isbn) as 'Number of Books'
from book
group by bookcat, publisherId

select branchNo, supervisorId, count(staffId) as 'Number of Female Staffs'
from staff 
where gender = 'F'and supervisorId is not null
group by branchNo, supervisorId

select p.Name, count(b.isbn) as 'Number of books'
from publisher p
inner join book b
on p.publisherId = b.publisherId
group by p.Name
order by count(b.isbn) DESC

select isbn, copyNo, dateout
from loan 
where memberId = (select memberId from member where name = 'Kumar')

select title, yearpublish
from book 
where (select count(copyNo) from bookcopy) > 0 and (publisherId is not null and bookcat is not null)

select isbn, title
from book 
where isbn not in (select isbn from loan)

select name, salary 
from staff 
where salary = (select max(salary) from staff)

select memberid, name, gender
from member
where (select count(memberid) from loan where member.memberId = loan.memberid) > 5

select branchNo, count(memberId) as 'Number of Members'
from member
group by branchNo
having count(memberId) >= 3

select branchNo, gender, count(memberId) as 'Number of Members'
from member
group by branchNo, gender

select a.name as 'Author', count(a.AuthorID) as 'Number of Books'
from bookauthor ba
inner join author a
on a.AuthorID = ba.AuthorID
group by a.name
order by count(a.AuthorId) DESC

select loanNo, isbn, dateout
from loan
where 

select branchNo, supervisorId, gender, count(staffId) as 'Number of Staffs'
from staff
where supervisorId is not null
group by branchNo, supervisorId, gender
