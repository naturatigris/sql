--creating table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE OrderLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ChangeType VARCHAR(50),
    ChangedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Customers (FullName, Email, Phone, Address)
VALUES 
('Alice Johnson', 'alice@example.com', '9876543210', '123 Rose Street'),
('Bob Smith', 'bob@example.com', '9988776655', '456 Daisy Avenue'),
('Carol Taylor', 'carol@example.com', '9123456789', '789 Tulip Road');
INSERT INTO Products (ProductName, Description, Price, QuantityInStock)
VALUES 
('Wireless Mouse', 'Bluetooth-enabled ergonomic mouse', 25.50, 100),
('Mechanical Keyboard', 'RGB mechanical keyboard with blue switches', 89.99, 50),
('USB-C Cable', '1.5m long fast-charging cable', 7.99, 200),
('Laptop Stand', 'Adjustable aluminum laptop stand', 34.95, 75),
('Webcam 1080p', 'Full HD webcam with autofocus', 45.00, 60);
--index(just to show how it works)
create index customer_index on Customers(CustomerID);
--trigger for updateing change of quantity and order status
DELIMITER $$
CREATE TRIGGER pdate_change
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
update Products     SET QuantityInStock = QuantityInStock - NEW.Quantity
 where ProductID=new.ProductID;
 update Orders set status='Order Placed';
INSERT INTO OrderLogs (OrderID, ChangeType)
    VALUES (NEW.OrderID, 'Order Placed');
END;
$$
DELIMITER ;
--transaction to insert orders and orderdetails
START TRANSACTION;

INSERT INTO Orders (CustomerID, OrderDate, Status)
VALUES (1, NOW(), 'Pending');

SET @last_order_id = LAST_INSERT_ID();

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (@last_order_id, 2, 3, 19.99);

COMMIT;
--view
CREATE VIEW OrderSummary AS
SELECT 
    o.OrderID, 
    c.FullName AS Customer, 
    o.OrderDate,
    SUM(od.Quantity * od.Price) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, c.FullName, o.OrderDate;

--testing
select * from OrderSummary;
SELECT * FROM Products WHERE ProductID = 2;
SELECT * FROM OrderLogs;
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (1, 2, -5, 19.99);
