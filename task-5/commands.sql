CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmpID, EmpName, Department, Salary) VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'IT', 75000),
(3, 'Charlie', 'IT', 60000),
(4, 'David', 'HR', 55000),
(5, 'Eva', 'Finance', 70000),
(6, 'Frank', 'Finance', 65000),
(7, 'Grace', 'IT', 80000);

SELECT EmpName, Department, Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE Department = 'IT'
);

SELECT EmpName,
    (SELECT AVG(Salary) FROM Employees) AS CompanyAvgSalary
FROM Employees;

SELECT EmpName, Department, Salary
FROM Employees E1
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees E2
    WHERE E1.Department = E2.Department
);
