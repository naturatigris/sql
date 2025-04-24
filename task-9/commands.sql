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

DELIMITER $$

CREATE PROCEDURE GetTotalSales(IN StartDate DATE, IN EndDate DATE)
BEGIN
    SELECT SUM(Amount) AS TotalSales
    FROM Orders
    WHERE OrderDate BETWEEN StartDate AND EndDate;
END$$

DELIMITER ;

CALL GetTotalSales('2025-03-01', '2025-04-30');

DELIMITER $$

CREATE FUNCTION CalculateDiscount(amount DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(10,2);
    IF amount > 1000 THEN
        SET discount = amount * 0.10;
    ELSE
        SET discount = 0;
    END IF;
    RETURN discount;
END$$

DELIMITER ;

SELECT OrderID, CustomerName, Amount, CalculateDiscount(Amount) AS Discount
FROM Orders;
