--Lab 5 Exercise (19/1/24)

Create database Lab5;


Use Lab5;


Create table Publisher (
[PulisherID] nvarchar (50) primary key,
[Name] nvarchar (50),
[Address] nvarchar (50)
);

Drop table Publisher;

Insert into Publisher values 
('P01', 'Pearson', 'Bukit Jalil'),
('P02', 'Deitel', 'Puchong'),
('P03', 'Rainbow', 'Subang'),
('P04', 'MacHill', 'Kuala Lumpur');


Create Table Book (
[BookID] nvarchar(50) not null primary key,
[Name] nvarchar(50),
[Author] nvarchar(50),
[Price] decimal(10,2),
[PublishDate] date,
[PublishID] nvarchar(50)
);

Drop table Book;

insert into Book values
('B01', 'Maths', 'J.Wenton', '50.60', '10 January 2016', 'P01'),
('B02', 'Science', 'S.Hanson', '100.00', '12 February 2016', 'P01'),
('B03', 'English', 'K.Vince', '89.30', '9 March 2016', 'P02'),
('B04', 'Biology', 'K.Vince', '150.80', '24 April 2016', 'P03'),
('B05', 'Computing', 'J.Denzin', NULL, NULL, NULL);



-- 4)
Select * from Publisher
where Name like 'r%';



-- 5)
Select * from Publisher
where Name like '%n'


-- 6)
Select * from Publisher
where Name 

-- 7)
Select * from Book
where [Name] like 'b__%'



-- 8)
Select * from Book
where [Name] like '%i%'


-- 9)
Select * from Book
where [Name] like 'e%h'


-- 10)
Select * from Book
where [Author] like '&n&' 
Order by [Author] ASC and Order by [Price] DESC



-- 13)
Select * from Book
where [Price] in (50,100);
Select * from Book
where [Price] = 50 or [Price] = 100;
Select * from Book
where [Price] in (50) or [Price] in (100);



-- 14)
Select * from Book 
where [Name] in ('Maths', 'Science', 'English')
Order by [Price];



-- 15)
update Publisher set Address = 'Serdang'
where [Name] = 'Person';


-- 16)
update Book set Price = 99
where [Name] = 'English' and Author = 'K.Vince'
--u need to specify both condition in the where clause, since there are 2 book written by K.Vince
--if u omit (where Name = 'English'), then all the book written by K.Vince will be updated
--or u can 


-- 17)
update Book set PublishedDate = '3 September 2017' where Name = 'S.Hamson'


-- 18)
update Book set Price = '98', PublishedDate = '29 April 2019' where Name = 'English';
--u can update multiply rows/columns in one query as long as u define the
--'where' condition correctly


-- 19)
Alter table Book
Add column Name nvarchar(50);
--cannot simply change the data type if there are existing values in the column
--example if existing values are intergers, then cannot change data type to date

-- 20)
Alter table Publisher add Telephone Integer;


-- 21) 
Alter table Publisher sp_rename 'Publisher.Telephone', 'ContactNumber';
--the dot between publisher & telephone indicates which table the column belongs to
--sp_rename is build-in stored procedure in SQL server 


-- 22)
Alter table Publisher
Drop column ContactNumber

Delete from Book where Author = 'K.Vince' and Name = 'Biology';

Delete from Book where Author = 'J.Wenton' and Name = 'Maths';
--if u omit where clause in delete, then all values in the table will be deleted
--such as below

Delete from Book
--the table will be empty, but the table still exists
--to be save, to delete a specific row, use it 







