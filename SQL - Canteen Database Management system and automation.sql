-- Create Database
CREATE DATABASE APUCafeFoodOrderingSystem;

-- Use Database
USE APUCafeFoodOrderingSystem;

-- Create Menu Table
CREATE TABLE Menu (
	FoodID nvarchar(10) PRIMARY KEY,
	FoodName nvarchar(50) NOT NULL,
	Price decimal(4,2) NOT NULL,
	AvgRating decimal(2,1)
);

-- Create Member Table
CREATE TABLE [Member] (
	MemberID nvarchar(10) PRIMARY KEY,
	MemberName nvarchar(50) NOT NULL,
	[Role] nvarchar(50) NOT NULL,
	Age tinyint, 
	Gender nvarchar(10),
	Email nvarchar(50),
	ContactNumber nvarchar(20)
);

-- Create Rating Table
CREATE TABLE Rating (
	FoodID nvarchar(10) FOREIGN KEY REFERENCES Menu(FoodID) NOT NULL,
	MemberID nvarchar(10) FOREIGN KEY REFERENCES [Member](MemberID) NOT NULL,
	Rating tinyint NOT NULL,
	Feedback ntext,
	PRIMARY KEY (FoodID, MemberID)
);

-- Create Chef Table
CREATE TABLE Chef (
	ChefID nvarchar(10) PRIMARY KEY,
	ChefName nvarchar(50) NOT NULL
);

-- Create Manager Table
CREATE TABLE Manager (
	ManagerID nvarchar(10) PRIMARY KEY,
	ManagerName nvarchar(50) NOT NULL
);

-- Create DispatchWorker Table
CREATE TABLE DispatchWorker (
	DispatchWorkerID nvarchar(10) PRIMARY KEY,
	DispatchWorkerName nvarchar(50) NOT NULL
);

-- Create Cart Table
CREATE TABLE Cart (
	CartID nvarchar(10) PRIMARY KEY,
	MemberID nvarchar(10) FOREIGN KEY REFERENCES [Member](MemberID) NOT NULL,
	PaymentStatus nvarchar(20)
);

-- Create CartDetail Table
CREATE TABLE CartDetail (
	CartID nvarchar(10) FOREIGN KEY REFERENCES Cart(CartID) NOT NULL,
	FoodID nvarchar(10) FOREIGN KEY REFERENCES Menu(FoodID) NOT NULL,
	Quantity tinyint,
	Subtotal decimal(5,2),
	PRIMARY KEY (CartID, FoodID)
);

-- Create Order Table
CREATE TABLE [Order] (
	OrderID nvarchar(10) PRIMARY KEY,
	CartID nvarchar(10) FOREIGN KEY REFERENCES Cart(CartID) NOT NULL,
	ManagerID nvarchar(10) FOREIGN KEY REFERENCES Manager(ManagerID) NOT NULL,
	TotalCost decimal (6,2),
	[Date] DATE,
	PaymentTime TIME
);

-- Create OrderDetail Table
CREATE TABLE OrderDetail (
	OrderDetailID nvarchar(10) PRIMARY KEY,
	OrderID nvarchar(10) FOREIGN KEY REFERENCES [Order](OrderID) NOT NULL,
	ChefID nvarchar(10) FOREIGN KEY REFERENCES Chef(ChefID) NOT NULL,
	CookedTime TIME
);

-- Create Delivery Table
CREATE TABLE Delivery (
	OrderDetailID nvarchar(10) FOREIGN KEY REFERENCES OrderDetail(OrderDetailID) NOT NULL,
	DispatchWorkerID nvarchar(10) FOREIGN KEY REFERENCES DispatchWorker(DispatchWorkerID) NOT NULL,
	DeliveryTime TIME,
	DeliveryStatus nvarchar(20),
	PRIMARY KEY (OrderDetailID, DispatchWorkerID)
);

-- Create Trigger to Update AvgRating in Menu Table
CREATE TRIGGER UpdateAvgRating
ON Rating
AFTER INSERT
AS
BEGIN
    -- Update the AvgRating in the Menu table for every New Rating in Rating Table
    UPDATE Menu
    SET AvgRating = (SELECT AVG(CAST(Rating AS DECIMAL(3, 2))) FROM inserted WHERE Menu.FoodID = inserted.FoodID)
    WHERE Menu.FoodID IN (SELECT FoodID FROM inserted);
END;

-- Create Trigger to Update Subtotal in CartDetail Table
CREATE TRIGGER UpdateSubtotal
ON CartDetail
AFTER INSERT 
AS
BEGIN
    -- Update the Subtotal in CartDetail for every New Food Item in CartDetail Table
	UPDATE CartDetail
	-- Calculate the Total Price for each Food Item
    SET Subtotal = (SELECT Menu.Price * CartDetail.Quantity FROM Menu WHERE Menu.FoodID = inserted.FoodID) 
	FROM inserted
    WHERE CartDetail.CartID = inserted.CartID AND CartDetail.FoodID = inserted.FoodID;
END;

-- Create Trigger to Update TotalCost in Order Table
CREATE TRIGGER UpdateTotalCost
ON [Order]
AFTER INSERT
AS
BEGIN
    -- Update the TotalCost in Order table for every OrderID in Order Table
    UPDATE [Order]
    SET TotalCost = (SELECT SUM(CartDetail.Subtotal) FROM CartDetail WHERE CartDetail.CartID = inserted.CartID)
    FROM [Order]
    JOIN inserted ON [Order].CartID = inserted.CartID;
END;

-- Insert Data into Menu Table (Except AvgRating)
INSERT INTO Menu (FoodID, FoodName, Price) VALUES
('F01', 'Chicken Chop', '10.00'),
('F02', 'Fish and Chips', '12.00'),
('F03', 'Spaghetti Carbonara', '8.00'),
('F04', 'Nasi Lemak', '3.50'),
('F05', 'Fried Rice', '6.50'),
('F06', 'Buttermilk Chicken', '8.50'),
('F07', 'Nasi Kerabu', '7.50'),
('F08', 'Wantan Mee', '6.90'),
('B01', 'Iced Lemon Tea', '3.70'),
('B02', 'Hot Green Tea', '2.00'),
('B03', 'Coca-cola', '3.80'),
('B04', 'Coffee', '4.00');

-- Insert Data into Member Table
INSERT INTO [Member] VALUES
('MB051050', 'Tom Holland', 'Student', 18, 'Male', 'MB051050@mail.apu.edu.my', '+60371642600'),
('MB062010', 'Christopher Nolan', 'Student', 17, 'Male', 'MB062010@mail.apu.edu.my', '+60166293476'),
('MB055011', 'Saashienie Nair', 'Student', 18, 'Female', 'MB055011@mail.apu.edu.my', '+601134832577'),
('MB046720', 'Austin Butler', 'Student', 19, 'Male' ,'MB046720@mail.apu.edu.my', '+60198736701'),
('MB034971', 'Florence Pugh', 'Student', 20, 'Female', 'MB034971@mail.apu.edu.my',' +601159458366'),
('MB047390', 'Timothée Chalame', 'Student', 19, 'Male', 'MB047390@mail.apu.edu.my', '+6059205252'),
('MB042240', 'Jack Black', 'Student', 19, 'Male', 'MB042240@mail.apu.edu.my', '+60129805875'),
('MB039120', 'Ryan Reynolds', 'Student', 20, 'Male', 'MB039120@mail.apu.edu.my', '+6094744542'),
('MB896671', 'Taylor Swift', 'Lecturer', 34, 'Female', 'MB896671@mail.apu.edu.my', '+6037866251'),
('MB887270', 'Ryan Gosling', 'Lecturer', 35, 'Male', 'MB887270@mail.apu.edu.my', '+6011736195'),
('MB842151', 'Michelle Yeoh', 'Lecturer', 39, 'Female', 'MB842151@mail.apu.edu.my', '+60177373198'),
('MB828861', 'Margot Robbie', 'Lecturer', 41, 'Female', 'MB828861@mail.apu.edu.my', '+60107076687');

-- Insert Data into Manager Table
INSERT INTO Manager VALUES ('MGR1', 'James Brown');

-- Insert Data into Chef Table
INSERT INTO Chef VALUES 
('CHF1', 'Neil Miguel'),
('CHF2', 'Emily Wilson'),
('CHF3', 'David Miller');

-- Insert Data into DispatchWorker Table
INSERT INTO DispatchWorker VALUES
('WKR1', 'Michael Thompson'),
('WKR2', 'Jessica Lee'),
('WKR3', 'Ryan Davis');

-- Insert Data into Rating Table
INSERT INTO Rating VALUES 
('F01', 'MB042240', 4, 'Tasted good! Sadly the food was a little cold.'),
('F03', 'MB046720', 2, 'Too salty and cheesy. Unless you are a cheese lover tho.'),
('F04', 'MB047390', 5, 'Best food in the cafeteria, cheap and nice.'),
('F04', 'MB039120', 4, 'The portion is too small for me.'),
('F04', 'MB896671', 5, 'Love the tradisional food!'),
('B03', 'MB896671', 4, 'Too overpriced for a soft drink.'),
('F08', 'MB887270', 5, 'One of the best Chinese noodle.'),
('B01', 'MB828861', 1, 'Felt like they added water in the tea. Ew.'),
('F06', 'MB842151', 4, null),
('F07', 'MB034971', 5, 'Underrated!!'),
('B04', 'MB062010', 5, 'Perfect drink to start the day.'),
('F03', 'MB051050', 5, 'Loved the cheeseeee!!'),
('F01', 'MB051050', 4, null),
('B01', 'MB051050', 4, null);

-- Insert Data into Cart Table
INSERT INTO Cart VALUES
('C001', 'MB051050', 'Paid'),
('C002', 'MB062010', 'Paid'),
('C003', 'MB055011', 'Pending'),
('C004', 'MB046720', 'Paid'),
('C005', 'MB034971', 'Paid'),
('C006', 'MB047390', 'Pending'),
('C007', 'MB042240', 'Paid'),
('C008', 'MB039120', 'Paid'),
('C009', 'MB896671', 'Pending'),
('C010', 'MB887270', 'Paid'),
('C011', 'MB042240', 'Paid'),
('C012', 'MB828861', 'Paid');

-- Insert Data into CartDetail Table
INSERT INTO CartDetail (CartID, FoodID, Quantity) VALUES
('C001', 'F01', 2),
('C001', 'F03', 1),
('C002', 'F05', 1),
('C002', 'F08', 1),
('C003', 'F02', 1),
('C003', 'B01', 1),
('C004', 'F06', 2),
('C005', 'F07', 1),
('C005', 'F08', 1),
('C006', 'F04', 1),
('C006', 'B03', 2),
('C007', 'B04', 1),
('C008', 'F01', 2),
('C009', 'F03', 1),
('C010', 'F04', 3), 
('C010', 'B03', 2),
('C011', 'F07', 1),
('C012', 'F08', 2);

-- Insert Data into Order Table
INSERT INTO [Order] (OrderID, CartID, ManagerID, [Date], PaymentTime) VALUES
('O0001', 'C001','MGR1','2024-01-11','11:15:00'),
('O0002', 'C002','MGR1','2024-01-18','12:00:00'),
('O0003', 'C004','MGR1','2024-01-29','12:45:00'),
('O0004', 'C005','MGR1','2024-02-08','13:30:00'),
('O0005', 'C007','MGR1','2024-02-14','14:15:00'),
('O0006', 'C008','MGR1','2024-02-19','15:00:00'),
('O0007', 'C010','MGR1','2024-02-29','15:45:00'),
('O0008', 'C011','MGR1','2024-03-01','16:30:00'),
('O0009', 'C012','MGR1','2024-03-02','17:15:00');

-- Insert Data into OrderDetail Table
INSERT INTO OrderDetail VALUES
('OD0001', 'O0001', 'CHF1', '11:30:00'),
('OD0002', 'O0002', 'CHF2', '12:13:00'),
('OD0003', 'O0003', 'CHF1', '13:08:00'),
('OD0004', 'O0004', 'CHF3', '13:59:00'),
('OD0005', 'O0005', 'CHF2', '14:26:00'),
('OD0006', 'O0006', 'CHF3', '15:17:00'),
('OD0007', 'O0007', 'CHF1', '16:01:00'),
('OD0008', 'O0008', 'CHF2', '16:50:00'),
('OD0009', 'O0009', 'CHF3', '17:29:00');

-- Insert Data into Delivery Table
INSERT INTO Delivery VALUES
('OD0001', 'WKR1', '11:45:00', 'On Time'),
('OD0002', 'WKR2', '12:31:00', 'Delayed'),
('OD0003', 'WKR3', '13:17:00', 'On Time'),
('OD0004', 'WKR1', '14:10:00', 'On Time'),
('OD0005', 'WKR1', '14:44:00', 'Delayed'),
('OD0006', 'WKR3', null, null),
('OD0007', 'WKR3', '16:20:00', 'Delayed'),
('OD0008', 'WKR2', '17:04:00', 'On Time'),
('OD0009', 'WKR1', null, null);

-- i. List the food(s) which has the highest rating. Show food id, food name, and the rating.
SELECT FoodID, FoodName, AvgRating AS HighestRating
FROM Menu
WHERE AvgRating = (SELECT MAX(AvgRating) FROM Menu);

-- ii. Find the total number of feedback per member. Show member id, member name, and total number of feedback per member.
SELECT [Member].MemberID, [Member].MemberName, COUNT(CONVERT(nvarchar(MAX),Rating.Feedback)) AS TotalFeedback
FROM [Member]
LEFT JOIN Rating ON [Member].MemberID = Rating.MemberID
GROUP BY [Member].MemberID, [Member].MemberName;

-- iii. Find the total number of food(meal) ordered by the manager from each chef.
SELECT [Order].ManagerID, OrderDetail.ChefID, COUNT(OrderDetail.OrderID) AS TotalOrders
FROM [Order]
JOIN OrderDetail ON [Order].OrderID = OrderDetail.OrderID
GROUP BY [Order].ManagerID, OrderDetail.ChefID;

-- iv. Find the total number of food(meal) cooked by each chef. Show chef id, chef name, and the number of meals cooked.
SELECT OrderDetail.ChefID, Chef.ChefName, SUM(CartDetail.Quantity) AS TotalMealsCooked
FROM OrderDetail
JOIN [Order] ON OrderDetail.OrderID = [Order].OrderID
JOIN CartDetail ON [Order].CartID = CartDetail.CartID
JOIN Chef ON OrderDetail.ChefID = Chef.ChefID
GROUP BY OrderDetail.ChefID, Chef.ChefName;

-- v. List all the food where its average rating is more than the average rating of all food.
SELECT Menu.FoodID, Menu.FoodName, Menu.AvgRating
FROM Menu
WHERE Menu.AvgRating > (SELECT AVG(AvgRating) FROM Menu)
ORDER BY AvgRating DESC;

-- vi. Find the top 3 bestselling food(s). The list should include id, name, price, and quantity sold.
SELECT TOP 3 Menu.FoodID, Menu.FoodName, Menu.Price, 
(SELECT SUM(Quantity) FROM CartDetail WHERE CartDetail.FoodID = Menu.FoodID) AS QuantitySold
FROM Menu
ORDER BY QuantitySold DESC;

--vii. Show the top 3 members who spent the most on ordering food. The list should include id, name, and whether they are students or staff.
SELECT TOP 3 [Member].MemberID, [Member].MemberName, [Member].[Role], SUM([Order].TotalCost) AS TotalSpent
FROM [Member]
JOIN Cart On [Member].MemberID = Cart.MemberID
JOIN [Order] On [Order].CartID = Cart.CartID 
GROUP BY [Member].MemberID, [Member].MemberName, [Member].[Role]
ORDER BY TotalSpent DESC;

--viii. Show the total members based on gender who are registered as members. The list should include id, name, role (student/staff), and gender.
SELECT MemberID, MemberName, [Role], Gender
FROM [Member]
GROUP BY MemberID, MemberName, [Role], Gender
ORDER BY Gender;

--ix. Show a list of ordered food that has not been delivered to members. The list should show member id, role (student/staff), contact number, food id, food name, quantity, date, and the status of delivery.
SELECT [Member].MemberID, [Member].[Role], [Member].ContactNumber, CartDetail.FoodID, 
Menu.FoodName, CartDetail.Quantity, [Order].[Date], ISNULL(Delivery.DeliveryStatus, 'Not Delivered') AS DeliveryStatus
FROM [Member]
JOIN Cart ON [Member].MemberID = Cart.MemberID
JOIN CartDetail ON CartDetail.CartID = Cart.CartID
JOIN Menu ON CartDetail.FoodID = Menu.FoodID
JOIN [Order] ON Cart.CartID=[Order].CartID
JOIN OrderDetail ON OrderDetail.OrderID=[Order].orderID
JOIN Delivery ON OrderDetail.OrderDetailID=Delivery.OrderDetailID
WHERE Delivery.DeliveryStatus IS NULL;

--x. Show a list of members who made more than 2 orders. The list should show their member id, name, role (student/staff), and total orders.
SELECT [Member].MemberID, [Member].MemberName, [Member].[Role], COUNT(Cart.MemberID) AS TotalOrder
FROM [Member], cart
WHERE [Member].MemberID = Cart.MemberID
GROUP BY [Member].MemberID, [Member].MemberName, [Member].[Role]
HAVING COUNT(Cart.MemberID) >= 2;










