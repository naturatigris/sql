CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    Amount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerName, OrderDate, Amount) VALUES
(1, 'Alice', '2025-04-01', 1200.00),
(2, 'Bob', '2025-04-15', 300.00),
(3, 'Charlie', '2025-03-20', 500.00),
(4, 'David', '2025-03-25', 700.00),
(5, 'Eva', '2025-04-18', 1500.00),
(6, 'Frank', '2025-02-10', 400.00);

SELECT * FROM Orders
WHERE OrderDate >= DATEADD(DAY, -30, GETDATE());

SELECT OrderID, CustomerName, DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysAgo
FROM Orders;

SELECT OrderID, CustomerName, OrderDate,
    CONVERT(VARCHAR, OrderDate, 103) AS FormattedDate
FROM Orders;
