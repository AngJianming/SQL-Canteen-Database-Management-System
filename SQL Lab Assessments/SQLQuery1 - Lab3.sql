--Lab3 exercise

create database Lab3;


use Lab3;


create table Supplier (
[SupplierID] nvarchar (50) Primary key,
[Name] nvarchar (50),
[Address] nvarchar (50),
);

Drop table Supplier;



--Primary Key: SupplierID


create table Product (
[ProductID] nvarchar (50) Primary key,
[Name] nvarchar (50),
[Price_RM] nvarchar (50),
[QuantityInStock] int
);

Drop table Product;


--Primary Key: ProductID


create table Supplies (
[SuppliesID] nvarchar (50) Primary key,
[SupplierID] nvarchar (50) foreign key references Supplier(SupplierID),
[ProductID] nvarchar (50) foreign key references Product(ProductID),
[SuppliedDate] Date,
[QuantitySupplied] int
);

--2 Foreign key: Supplies

Drop table Supplies;

Insert into Supplier values 
('S01', 'ABC Company', 'Penang'),
('S02', 'XYZ Company', 'Johor'),
('S03', 'HJK Company', 'Selangor'),
('S04', 'PQR Company', 'Selangor');

--you can insert multiple rows at once such as above

Insert into Product values
('P01', 'Keyboard', 103.55, 60),
('P02', 'Mouse', 30.90, 70),
('P03', 'Monitor', 200.00, 80),
('P04', 'Pendrive', 40.30, 50);

--no need single quote ' ' for inserting data type number/interger/decimal
--but if u put single quote ' ', it works as well
--however single quote is needed when inserting character

Insert into Supplies values
('001', 'S01', 'P01', '11 Jan 2017', 100),
('002', 'S01', 'P01', '22 Feb 2017', 200),
('003', 'S01', 'P01', Null, 300), -- do NOT put single quote for null
('004', 'S01', 'P01', '30 April 2017', 400);


-- Q4
Alter Authorization on Database::Lab3 to [sa];
--this is mainly for if you are using uni computer cuz you are not the

--Q5 (a)
Select * From Supplier;
--asterisk * represent all columns

--Q5 (b)
Select [Name], Price_RM FROM Product;


--Q6 (a)
Select [Address] FROM Supplier;
Select Distinct [Address] FROM Supplier;
--highlight and execute both queries above to see the difference
--select distict will omit dulicate values


--Q7 (a)
Select * FROM Supplier Where SuppliedDate IS NULL;
--to check if the column contains null value

--Q7 (b)
Select * FROM Supplies Where SuppliedDate IS NOT NULL;


