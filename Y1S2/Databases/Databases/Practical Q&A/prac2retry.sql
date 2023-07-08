SELECT * 
FROM member
WHERE branchNo = 1

SELECT * 
FROM Book
WHERE BookCat = 'C'

SELECT * 
FROM member
WHERE BranchNo = 1 OR BranchNo = 2

SELECT * 
FROM Book
WHERE bookcat = 'C' or bookcat = 'F'

SELECT * 
FROM member
WHERE (BranchNo = 1 or BranchNo = 2) AND DateJoin > 2013-12-31

SELECT * 
FROM Book
WHERE (bookcat = 'C' or bookcat = 'F') and yearpublish > 2000

--SKIP Q7

SELECT * 
FROM staff
WHERE gender = 'F' and salary > 1500


select * 
from loan 
where dateout between '2014-12-01' and '2015-01-31'

select *
from member
where datejoin between '2014-01-01' and '2014-12-31'

select * 
from book
where bookcat in ('C','F')

select * 
from member
where branchno in (1,2,3)

select * 
from member
where name like '%Tan%'

select *
from book 
where title like 'Database%'

select * 
from member
where name like '%kim%'

select *
from book 
where bookcat is null

select * 
from staff 
where SupervisorID is null
select *
from staff
where dob not between '1988-01-01' and '1990-06-30'

select *
from book 
where bookcat <> 'C' or bookcat <> 'F'
order by bookcat asc,YearPublish desc

select *
from staff 
where supervisorId is not null
order by supervisorId asc

select * 
from member 
where address like '%Street%'
order by name asc

select *
from staff
where (branchno = 1 or branchno = 3) and SupervisorID is null

select name, address, contactNo
from member
where datejoin < '2014-01-01' and emailaddr is null

select bookcat
from book
where bookcat = 'F'
--more pref bcoz it is only 1 character long

select * 
from book
where YearPublish not between '1990-01-01' and '1999-12-31'

select * from book
where YearPublish not like '%199%'