--Lab exercise 1, 6 Dec 23
create database Lab1;
--upper/lower case dones't matter
--re-fresh the database after every execution
use Lab1; --this step is very important
--This is to switch to the database that we want to use
--Because there could be many databases in the server
--Since we want to create table inside Lab1
--Therefore need to use Lab1

create table Student
(StudentID nvarchar (50),
[Name] nvarchar (50),
[Gender] nvarchar (50),
DOB Date,
[Address] nvarchar(50));

--If you dont want to confuse wether if is it keyword & non-keyword
--Can write the query in single or multiple lines 
--When evecute must high-light the hole thing
-- Right-click the dbo.Student in Lab1 file and click on "design"
-- You have to "Alter" if you want to make any changes

drop table Student;
--drop table is to remove it from the database
--Inorder to put it back you can high-light it and press "Execute"

insert into Student values ('S01', 'Ali', 'Male', '2 February 1996', 'Kuala Lumpur');
--In this case the first value will be inserted into first column of the table
--Second value will be inserted into second column of the table and so on
--Remember to re-fresh database, close the table and reopen

insert into Student values ('S03', 'Melvin', 'Male', '3 June 1999', Null);

insert into Student values ('S03', 'Melvin', 'Male', '3 June 1999', 'Null');
--putting single quote will result in inserting 'Null' as character
--Into the column which is wrong

--The number of values inserted MUST match the number of column defined for that table
--Example the query below will give u error, because the number of values inserted
--do not match the number of column in the table
insert into Student values ('S01', 'Ali', 'Male', '2 February 1996',);

insert into Student values ('S01', 'Ali', 'Male', '2 February 1996', 'Kuala Lumpur');
--The values in the column must follow the table

--Below will give error because can't insert 'Kuala Lumpur' into date of month
insert into Student values ('S01', 'Ali', 'Male', 'Kuala Lumpur', '2 February 1996');

insert into Student values ('S01', 'Ali', 'Male', '32 February 1996', 'Kuala Lumpur');
--Above will have error because we do not have 32 days in a month

--Try different format for date, see which one works
insert into Student values ('S01', 'Ali', 'Male', 'February 2 1996', 'Kuala Lumpur');
insert into Student values ('S01', 'Ali', 'Male', '18/2/1996', 'Kuala Lumpur');
insert into Student values ('S01', 'Ali', 'Male', '1996-18-2', 'Kuala Lumpur');

--You can also insert by specifying the column name
insert into Student (StudentID, Name, Gender, DOB, Address)
values ('S01', 'Ali', 'Male', '2 February 1996', 'Kuala Lumpur');
--do not forget to close the table first
--then execute, re-fresh and reopen the table to see the changes

--can shuffle the order of the column when inserting values
--But make sure its value follows accordingly
insert into Student (StudentID, Name, Gender, DOB, Address)
values ('Female', 'S02', '16 May 1997', 'Bukit Jalil', 'Nancy');

--Query below will insert null into address columnm, because address column
--Is not specified and no value was given 

insert into Student values
('S01', 'Ali', 'Male', '2 February 1996' 'Kuala Lumpur'),
('S02', 'Nancy', 'Female', '16 May 1995' 'Bukit Jalil'),
('S03', 'Melvin', 'Male', '27 November 1999' null),
('S04', 'Angelina', 'Female', '30 December 1995' 'Kuala Lumpur'),
(StudentID, Name, Gender, DOB, Address)
--To insert multiple rows in one execution, u can write like above
--However u need to highlight the whole statement when execute
