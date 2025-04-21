CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    PricePerUnit DECIMAL(10, 2),
    Region VARCHAR(50)
);

INSERT INTO Orders (OrderID, CustomerName, Product, Quantity, PricePerUnit, Region) VALUES
(1, 'Alice', 'Laptop', 2, 60000, 'North'),
(2, 'Bob', 'Mouse', 5, 500, 'South'),
(3, 'Charlie', 'Keyboard', 3, 1500, 'East'),
(4, 'David', 'Monitor', 1, 12000, 'North'),
(5, 'Eva', 'Laptop', 1, 60000, 'West'),
(6, 'Frank', 'Mouse', 10, 500, 'East'),
(7, 'Grace', 'Keyboard', 2, 1500, 'West'),
(8, 'Hannah', 'Monitor', 2, 12000, 'South'),
(9, 'Ian', 'Laptop', 1, 60000, 'North'),
(10, 'Jane', 'Mouse', 4, 500, 'North');

SELECT COUNT(*) FROM Orders;

SELECT SUM(Quantity) FROM Orders;

SELECT AVG(PricePerUnit) FROM Orders;

SELECT Region, COUNT(*) AS TotalOrders FROM Orders
GROUP BY Region;

SELECT Product, SUM(Quantity) AS TotalQuantity FROM Orders
GROUP BY Product;

SELECT Region, SUM(Quantity) AS TotalQuantity FROM Orders
GROUP BY Region
HAVING SUM(Quantity) > 10;
