select DATEPART(year, GETDATE())
select DATEPART(day, GETDATE())

select memberId, name, datejoin, datediff(year, datejoin, GETDATE()) as 'Years of Membership'
From member
order by 'Years of Membership' ASC

select LoanNo, isbn, copyno, memberid, datediff(day, datedue, datereturn) as 'Number of Days Overdue'
from loan
where datereturn is not null and datedue < datereturn
order by 'Number of Days Overdue' DESC

select staffid, name, gender, dob
from staff 
where datepart(month, dob) = 2
order by name asc

--q5
select count(staffid)
from staff

select count(staffid)
from staff
where supervisorID is not null

select count(distinct supervisorid)
from staff 


select count(emailaddr)
from member


select count(memberid)
from member
where emailAddr is null

--q10
select min(rentalRate)
from bookcopy

select count(loanNo) AS 'Number of Loan', sum(rentalRate) as 'Total Rental Income'
from Loan 
where datepart(year, dateout) = '2014'

select count(staffId) as 'Number of Staff', sum(salary*12) as 'Total Annual Salary Payout'
from staff

select loanNo, datedue as 'Old DateDue', DATEADD(day,10,datedue) as 'New DateDue'
from loan
order by 'New DateDue' ASC

select name, ISNULL(emailAddr,'Email address not available')
from member

select name,address,contactNo
from member
where datepart(year, dateJoin) < '2014' and emailAddr is null
