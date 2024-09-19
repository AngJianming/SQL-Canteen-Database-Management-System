--Lab 7 Exercise (15/2/24)

Create Database Lab7;
 
Use Lab7;
 
Create table Publisher
(PublisherID nvarchar(50) Not Null Primary Key,
Name nvarchar(50),
Address nvarchar(50));
 
 
create table Book
(BookID nvarchar(50) Not Null Primary Key,
Name nvarchar(50),
Author nvarchar(50),
Price decimal(10,2),
PublishedDate date,
PublisherID nvarchar(50) Foreign Key References Publisher(PublisherID));
 
 
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


--Q4)	Display a list of book published by ‘Deitel’. (in your query, you cannot write where PublisherID = ‘P02’, you need to write where name = ‘Deitel’ using a subquery)

Using Sub-query:
Select *From Book Where PublisherID = 
(Select PublisherID From Publisher where name = 'Deitel');
--the query nested inside the bracket is a sub-query
--Book table does't have publisher name, therefore we use the 
--sub-query to find the publisherID of Deitel first, 
--the use the publisherID returned.
--from sub-query as an input to find the book published by Deitel
--u can execute the sub-query to check the result

--Q5)	Display a list of book published by ‘Pearson’, order the result in descending order by book name.
Select * from Book where PublisherID = 
(Select PublisherID from Publisher 
where Name = 'Pearson')Order By Name DESC


--Q6)	Display a list of book published by ‘Pearson’ and written by ‘S.Hanson’.
Select * from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Pearson') 
and Author = 'S.Hanson';
--or
Select * from Book where Author ='S.Hanson' 
and PublisherID = 
(Select PublisherID from Publisher where Name like 'Pearson');


--Q7)	Display a list of book published by ‘Pearson’ which cost more than 80.
Select * from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Pearson') 
and Price > 80;


--Q8).	Display a list of book published by ‘Pearson’ which cost between 30 to 70 and written by ‘J.Wenton’
Select * from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Pearson') 
and Price between 30 and 70 and Author = 'J.Wenton';


--Q9)	Display a list of book published by ‘Deitel’ and published after the date ’1 March 2016’
Select * from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Deitel') 
and PublishedDate > '1 March 2016';


--Q10)	Count how many books published by ‘Deitel’. (in the result table, give the column name as “NumOfBook”).
Select * from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Deitel') 
and PublishedDate > '1 March 2016';


--Q11)	Sum the Price of books published by ‘Pearson’. (in the result table, give the column name as “TotalPrice”)
Select sum(Price) as TotalPrice from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Pearson');


--Q12)	Find the average price of books published by ‘Pearson’. (in the result table, give the column name as “AvgPrice”)
Select AVG(Price) as AvgPrice from Book where PublisherID = 
(Select PublisherID from Publisher where Name = 'Pearson');


--Q13)	Display a list of book where its publisher’s address is ‘Bukit Jalil’, order in ascending by name.
Select * from Book where PublisherID = 
(Select PublisherID from Publisher 
where Address = 'Bukit Jalil')Order by Name ASC;


--Q14)	Count how many book published by publishers whose address is ‘Puchong’.
Select Count(BookID) as NumOfBook from Book where PublisherID =
(Select PublisherID from Publisher where Address = 'Puchong');


--Q15)	Display a list of book published by ‘Pearson’ and published after the month of January 2016.
Select * from Book where PublisherID =
(Select PublisherID from Publisher where Address = 'Puchong') 
and PublishedDate > '31 January 2016';


--Q16)	Display publisher details who published books written by K.Vince
Select * from Book where PublisherID in 
(Select PublisherID from Publisher where Author = 'K.Vince');
--try to execute the sub-query, it returns 2 values
--if the sub-query returns one value, can use '=' or 'in'
--but if the sub-query returns more than one values, the MUST use 'in'
--in this question, there are 2 books written by K.Vince (different publisher)
--therefore the sub-query will return 2 publisherID, so need to use 'in'
--in conclusion, if u're not sure how many values returned by sub-query, just use 'in' or use exists
select * from Publisher where exists (select BookID from Book where Book.PublisherID = Publisher.PublisherID and Author = 'K.Vince';


--Q17)	Change the publisher address to new address ‘Shah Alam’ for the publisher who published Biology book (*Hint: use update)
Update Publisher
Set Address = 'Shah Alam' where PublisherID 
in (Select PublisherID from Book Where Name = 'Biology');


--Q18)	Show the publisher who had not published any book (*Hint: use Not Exists / Not In)
Select * from Publisher where NOT EXISTS 
(Select * from Book Where Publisher.PublisherID = Book.PublisherID);
Select * from Publisher where NOT EXISTS 
(Select * from PublisherID From Book Where Publisher.PublisherID = Book.PublisherID);
Select * from Publisher where PublisherID NOT in 
(Select PublisherID from Book Where Publisher.PublisherID = Book.PublisherID);
Select * from Publisher where PublisherID NOT in 
(Select PublisherID from Book Where Publisher.PublisherID is not null);


--Q19)	Show the publisher who published more than 1 book (* Hint: use Count & Having & Group by)
Select * from Publisher Where PublisherID in 
(Select PublisherID from Book Group BY PublisherID HAVING COUNT(PublisherID) > 1);
-- 'where' cannot be used for aggregate function such as count, sum, avg, min, max,
--therefore, must use 'having'

--or not using sub-query
Select count(BookID) AS NumOfBooks, 
PublisherID from Book 
Group BY PublisherID HAVING COUNT(PublisherID) > 1;