--Lab 2  exercise (13 Dec 2023)

create database Lab2;


use Lab2;


create table Publisher (
[PublisherID] nvarchar(50) not null primary key,
[Name] nvarchar(50),
[Address] nvarchar(50)
)

--not null not necessary but is a good habit to put
--Primary key is unique & not NULL
--Foreign key is another primary key form another table
--Cannot delete a primary key row when foreign key is in use, due to the reference gone 

insert into Publisher values ('P01', 'Pearson', 'Bukit Jalil') 
insert into Publisher values ('P02', 'Deitel', 'Puchong')
insert into Publisher values ('P03', 'Rainbow', 'Subang')
insert into Publisher values ('P04', 'MacHill', 'Kuala Lumpur')


create table Book (
[BookID] nvarchar(50) primary key,
[Name] nvarchar(50),
[Author] nvarchar(50),
[Price] decimal(10,2),
[PublisherDate] date,
[PublisherID] nvarchar(50) foreign key references Publisher(PublisherID)
);

drop table Publisher
drop table Book

insert into Book ([BookID], [Name], [Author], [Price], [PublisherDate], [PublisherID]) values 
('B01', 'Maths', 'J.Wenton', 50.60, '10 Jan 2016', 'P01'), 
('B02', 'Science', 'S.Hanson', 100.00, '12 Feb 2016', 'P01'),
('B03', 'English', 'K.Vince', 89.30, '9 March 2016', 'P02'),
('B04', 'Biology', 'K.Vince', 150.80, '24 April 2016', 'P03'),
('B05', 'Computing', 'J.Denzin', NUll, NULL, NULL);

alter table Book
alter column BookID datatype;

delete from Publisher where [Name]= 'Rainbow'

insert into Book values
('B06', 'Maths', 'J.Wenton', 12345678.45, '10 Jan 2016', 'P01'), --can insert
('B07', 'Maths', 'J.Wenton', 123456789.45, '10 Jan 2016', 'P01'), --cannot insert
('B08', 'Maths', 'J.Wenton', 12345678.456, '10 Jan 2016', 'P01'); --can insert but the the .456 will round up to .46
--for data type decimal(10,2), u can insert max of total 10 digital including decimal
--If u insert more than 2 digits 

--Q4
insert into Book values ('B10', 'Harry Potter', 'JK Rowling', 200, '1 Jan 1996', 'P07');
--Can't insert cuz 'P07' does not exists in the PK column of the publisher table

--Q5
delete from publisher where Name = 'Deitel'
--Can delete cuz its PK 'P04' is used in the FK of the Book Table

--Q6
delete from Publisher where Name = 'MacHill'
--Can delete because its PK 'P04' is used in the FK of the Book Table

--Q7
delete from Book where [BookID] = 'B01'; --delete
--

