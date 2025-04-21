CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Region VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, CustomerName, Region) VALUES
(1, 'Alice', 'North'),
(2, 'Bob', 'South'),
(3, 'Charlie', 'East'),
(4, 'David', 'West'),
(5, 'Eva', 'North');

INSERT INTO Orders (OrderID, CustomerID, Product, Quantity) VALUES
(101, 1, 'Laptop', 2),
(102, 2, 'Mouse', 5),
(103, 1, 'Monitor', 1),
(104, 3, 'Keyboard', 3),
(105, 3, 'Mouse', 2),
(106, 6, 'Laptop', 1);

SELECT Customers.CustomerName, Orders.Product, Orders.Quantity
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName, Orders.Product, Orders.Quantity
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
