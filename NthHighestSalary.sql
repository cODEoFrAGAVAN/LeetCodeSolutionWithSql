-- Using Limit and Offset

CREATE FUNCTION getNthHighestSalary(N INT) 
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE off INT;
  SET off = N - 1;

  RETURN (
    SELECT Salary
    FROM (
      SELECT DISTINCT Salary
      FROM Employee
      ORDER BY Salary DESC
      LIMIT off, 1
    ) AS temp
  );
END;


-- Using Window Functions


CREATE FUNCTION getNthHighestSalary(N INT) 
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN (
    SELECT Salary
    FROM (
      SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
      FROM Employee
    ) AS ranked
    WHERE rnk = N
    LIMIT 1
  );
END;

