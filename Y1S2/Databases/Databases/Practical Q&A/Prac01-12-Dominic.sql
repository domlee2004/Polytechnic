--Question 1
Select * from staff

--Question 2
Select * from book

--Question 3
Select StaffID, Name,Gender from staff

--Question 4
Select isbn,title,publisherID,Bookcat from book

--Question 5
select supervisorID from staff

--Question 6
select distinct supervisorID from staff

--Question 7
select branchNo from member

--Question 8
select distinct branchNo from member

--Question 9
select isbn,copyNo,rentalrate,rentalrate*0.98 as "New RentalRate" from bookcopy

--Question 10
select staffID, name,salary,salary*1.1 as"New Salary" from staff

--Question 11
select name from staff Order by name asc

--Question 12
select * from staff order by name desc

--Question 13
select staffID,contactNo from staffcontact order by staffID asc

--Question 14
select name,salary from staff order by salary desc

-- Question 15
select * from bookcopy order by datein desc

--Question 16
select branchno,name,salary from staff order by branchno asc, name asc
