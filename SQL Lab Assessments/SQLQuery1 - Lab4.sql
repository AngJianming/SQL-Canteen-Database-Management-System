--Lab 4 Exercise (17/1/24)

Create Database Lab4;
 

Use Lab4;
 

Create table Publisher (
PublisherID nvarchar(50) Not Null Primary Key,
Name nvarchar(50),
Address nvarchar(50)
);
 
Drop table Publisher;
 
Create table Book (
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

-- 4)
Select * from Publisher
--used to specify every column in the table
Select PublisherID, [Name],[Address] from Publisher;


-- 5)
Select Name, Author from Book;


-- 6)
Select * From Book
Where [Author]='K.Vince';
--make sure you spell K.Vince correctly 
--else u won't get any results


-- 7)
Select * From Publisher
Where [PublisherID]='P01';


-- 8)
Select * From Book
Where [Price]> 100;
--no need to use single quote for number, but if used also can

-- 9)
Select * From Book
Where [Price]<= 100;


-- 10)
Select * From Book Where [Price] Between 100 And 200;
--If the question did not ask to use 'between', u can also write like below
Select * From Book Where price>=100 And price<=200;


-- 11)
Select * From Book Where [Price] Not Between 100 And 200;
--If the question did not ask to use 'between', u can also write like below
Select * From Book Where Price<100 Or Price>200;
Select * From Book Where Not (Price >=100 and Price <=200);
--The bracket is important, with/without the bracket makes a huge difference


-- 12) 
Select * From Book Where Author = 'S.Hanson' And Price = 100;


-- 13)
Select * From Book Where [Author] = 'J.Wenton' And [Price] = 30;
--no result displayed cause the price is incorrect
--condition is not fufilled
--u cna try to change 'and' to 'or' then u'll get a result
Select * from Book where Author = 'J.Wenton' or Price = 30;


-- 14)
Select * From Book Where Author = 'K.Vince' Or Price Between 50 and 100;
--If question did not ask to use 'between', u can also write like below
Select * From Book Where Author = 'K.Vince' Or (Price >= 50 and Price <= 100);


-- 15)
Select * From Book Where Author = 'K.Vince' Or [Price] Not Between 50 And 100;
Select * from book where Author = 'K.vince' Or Price<50 or Price >100;
--'Computing' book is not in the result as the price is null therefore
--does not fulfill the condition


-- 16)
Select * From Publisher Order By Name;
Select * From Publisher Order By Name ASC;
--it's ok if u don't put 'ASC', since it's ascending by default
--but for descending, must put 'DESC'
--ascending will sort the result from A-Z or smallest to largest
--descending will sort from Z-A or largest to smallest


-- 17)
Select * From Book Order By Name DESC;


-- 18)
Select * from Book Where [Author] = 'K.Vince'
Order by Name DESC;


-- 19)
Select * from Book where [Author] <> 'J.Wenton' And Price > 30
Order by [Price] DESC;

Select * from Book where [Author] = 'J.Wenton' And Price > 30
Order by [Price] DESC;

Select * from Book where [Author] != 'J.Wenton' And Price > 30
Order by [Price] DESC;



-- 20)
Select *from Book where Not Name = 'Science' Order by Author ASC, price DESC;
Select * from Book where Name <> 'Science' Order by Author, Price DESC;
Select * from Book where Name != 'Science' Order by Author, Price DESC;
--It will order in ascending by Author first, then those books with same Author will
--be sorted in descending by Price


-- 21)
Select * from Book where Name != 'S.Hanson' Or Price Not Between 90 and 160
Order by Price ASC;
--Ang not sure if this is correct or not
