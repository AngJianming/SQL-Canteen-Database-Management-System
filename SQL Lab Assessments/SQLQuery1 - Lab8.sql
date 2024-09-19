--Lab 8 Exercise (15/2/24)

Create database Lab8;

Use Lab8;

Create table Publisher (
PublisherID nvarchar(50) Primary key,
Name nvarchar(50),
Address nvarchar(50)
);

Drop table Publisher;


Create table Book (
BookID nvarchar(50) Primary key,
Name nvarchar(50),
Author nvarchar(50),
Price decimal (10,2),
PublisherDate date,
PublisherID nvarchar(50) Foreign key References Publisher(PublisherID)
);

Drop table Book;


insert into Publisher values
('P01', 'Pearson', 'Bukit Jalil'),
('P02', 'Deitel', 'Puchong'),
('P03', 'Rainbow', 'Subang'),
('P04', 'MacHill', 'Kuala Lumpur');
 
 
insert into Book values
('B01', 'Maths', 'J.Wenton', '50.60', '10 January 2016', 'P01'),
('B02', 'Science', 'S.Hanson', '100.00', '12 February 2016', 'P01'),
('B03', 'English', 'K.Vince', '89.30', '9 March 2016', 'P02'),
('B04', 'Biology', 'K.Vince', '150.80', '24 April 2016', 'P03'),
('B05', 'Computing', 'J.Denzin', NULL, NULL, NULL);


--Q4)	Inner Join Publisher and Book table 
Select * from Publisher inner join Book
on Publisher.PublisherID = Book.PublisherID;
--inner join will show the publisher and the books that they published
--Publisher P04 doesn't publish any book, while B05 doesn't have a publisher
--because P04 doesn't publish any book, while B05 doesn't have a publisher

--swap between table 1 and 2
Select * from Book join Publisher
on Publisher.PublisherID = Book.PublisherID;
--'join' and 'inner join' are the same

-- try this, publisherID column will appear only once
Select Publisher.[Name], Publisher.[Address], Book.* from Publisher
inner join Book on Publisher.PublisherID = Book.PublisherID;

--This will generate error because both tables have 'Name' column
Select [Name] from Publisher inner join Book
on Publisher.PublisherID = Book.PublisherID;
--Need to add Book.[Name]

--u can also jioin tables without using 'join', use 'where' instead
Select * from Publisher, Book 
where Publisher.PublisherID = Book.PublisherID;

--another way to speed up typing, u can use any character (more than one also can) to represent a table
Select P.Name, P.Address, B.* from Publisher P, Book B
where P.PublisherID = B.PublisherID;
--or 
Select P.Name, P.Address, B.* from Publisher P inner join Book B
on P.PublisherID = B.PublisherID;


--Q5)	Left Join Publisher with Book table, order by Publisher name (Publisher is left, Book is right)
Select * from Publisher Left join Book
on Publisher.PublisherID = Book.PublisherID 
Order by Publisher.Name;
--Publisher (P04) will be shown even though it doesn't publish any book,
--because left join selects everything from left table which is publisher table
--null will be shown for book table, because no book published by McHill


--Q6)	Right Join Publisher with Book table, order by Book name (Publisher is left, Book is right)
Select * from Publisher Right join Book 
on Publisher.PublisherID = Book.PublisherID 
Order by Book.Name;


--Q7)	Publisher and Book table - Full Outer JOIN
Select * from Publisher 


--Q8)	(PublisherID, Publisher name) union with (BookID, Book name) - SQL UNION



--Q9)	Display a list of book published by ‘Deitel’, show all columns from Publisher and Book




--Q10)	Display a list of book published by ‘Pearson’ and written by ‘S.Hanson’, show all columns from Publisher and Book




--Q11)	Display a list of book published by ‘Pearson’ which cost between 30 to 70 and written by ‘J.Wenton’, show all columns from Publisher and Book




--Q12)	Display a list of book where its publisher’s address is ‘Bukit Jalil’, show all columns from Publisher and Book



--Q13)	Display publishers and the books that they published between date ‘1 January 2016’ to ‘1 March 2016’




--Q14)	Display publishers and the books that they published for those not written by ‘K.Vince’




--Q15)	Display publishers and the books that they published where the date is after ‘1 January 2016’










