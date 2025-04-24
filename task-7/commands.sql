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

select *,Rank() Over (partition by Department order by Salary desc) as Ranks from employees
SELECT 
    EmpID,
    EmpName,
    Department,
    Salary,
    LAG(Salary) OVER (PARTITION BY Department ORDER BY Salary ASC) AS PrevSalary,
    LEAD(Salary) OVER (PARTITION BY Department ORDER BY Salary ASC) AS NextSalary
FROM 
    Employees;
