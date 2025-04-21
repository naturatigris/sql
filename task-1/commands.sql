--create
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

--insert
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Wireless Mouse', 'Electronics', 499.99, 120),
(2, 'USB-C Charger', 'Electronics', 999.00, 75),
(3, 'Notebook', 'Stationery', 55.50, 200),
(4, 'Water Bottle', 'Accessories', 150.00, 50),
(5, 'Bluetooth Speaker', 'Electronics', 1299.99, 30);
--retrive
SELECT * FROM Products;
