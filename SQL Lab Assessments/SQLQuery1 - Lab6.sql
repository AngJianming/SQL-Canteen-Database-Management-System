--Lab 6 Exercise (6/2/24)

Create Database Lab6;
 
Use Lab6;
 
Create table Publisher (
PublisherID nvarchar(50) Not Null Primary Key,
Name nvarchar(50),
Address nvarchar(50)
);

Drop table Publisher;

create table Book (
BookID nvarchar(50) Not Null Primary Key,
Name nvarchar(50),
Author nvarchar(50),
Price decimal(10,2),
PublishedDate date,
PublisherID nvarchar(50) Foreign Key References Publisher(PublisherID)
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


-- Q4)
Select top 2 * from Publisher;


-- Q5)
Select top 3 * from Book where Price < 130;


-- Q6)
Select min(price) as LowestPrice
From Book


-- Q7)
Select Name, Price as LowestPrice 
from Book where Price =
(Select min(Price) from Book);


-- Q8)
SELECT Min(Name) FROM Book;
-- Biology
-- Min (Name) is sort by the first starting character of the book name


-- Q9)
Select Max(Price) as HighestPrice
From Book;


-- Q10)
Select Name, price AS HighestPrice
From Book Where Price =
(Select max(Price) From Book);


-- Q11)
SELECT max(Name) from Book;


-- Q12)
Select SUM([Price]) as TotalPrice
from Book;


-- Q13)
Select avg(Price) as AveragePrice from Book;


-- Q14)
select Name, Price
from Book where Price > 
(select avg (Price) from Book);


-- Q15)
Select Count (*) As TotalBooks FROM Book;


-- Q16)
Select count(*) from book where Author='K.Vince';


-- Q17)
select COUNT(*) as BookCostMoreThanRM60 
from book where price > 60;


-- Q18)
SELECT COUNT(BookID) AS BooksCostMoreThanAverage
FROM Book
WHERE [Price]>(
    SELECT AVG(Price)
    FROM Book
);

Select Count(Price) as BooksCostMoreThanAverage from Book
Where Price > (Select Avg(Price) from Book);


-- Q19)
Select Author, Count(Name) AS 'TotalBooksByAuthor' 
From Book Group by Author;


-- Q20)
Select PublisherID, count(*) as TotalBooksByPublisher 
from Book group by PublisherID;


-- Q21)
Select sum(Price) AS BookPriceByPublisher 
from Book group by Author;


-- Q22)
Select PublisherID, sum(Price) as BookPriceByPublisher 
from Book group by PublisherID;


-- Q23)


-- Q24)
update Book
Set price = price - 20
where BookID = 'Biology';


