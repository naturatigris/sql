-- Non-recursive CTE: Average salary per department and filter above 60000
WITH DeptAvg AS (
    SELECT Department, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY Department
)
SELECT * FROM DeptAvg
WHERE AvgSalary > 60000;

-- Recursive CTE: Organizational hierarchy
CREATE TABLE OrgChart (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    ManagerID INT
);

INSERT INTO OrgChart (EmpID, EmpName, ManagerID) VALUES
(1, 'CEO', NULL),
(2, 'CTO', 1),
(3, 'CFO', 1),
(4, 'Dev Manager', 2),
(5, 'Developer', 4),
(6, 'Finance Manager', 3),
(7, 'Accountant', 6);

WITH RECURSIVE OrgHierarchy AS (
    SELECT EmpID, EmpName, ManagerID, 1 AS Level
    FROM OrgChart
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT o.EmpID, o.EmpName, o.ManagerID, h.Level + 1
    FROM OrgChart o
    INNER JOIN OrgHierarchy h ON o.ManagerID = h.EmpID
)
SELECT * FROM OrgHierarchy;

