-- (ctrl k + c to comment out)

-- Problem 32
-- Identify high-value customers as those who've made at least 1 order with a total 
-- value (not including discount) equal to $10k or more. Only want to consider order
-- placed in 2016

SELECT 
	c.CustomerID
	,c.CompanyName
	,o.OrderID
	,SUM(od.UnitPrice * Quantity) as TotalOrderAmount
FROM Customers c  
	JOIN Orders o ON c.CustomerID = o.CustomerID
	JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2016 
GROUP BY c.CustomerID, c.CompanyName, o.OrderID
HAVING SUM(od.UnitPrice * Quantity) >= 10000
ORDER BY TotalOrderAmount DESC
;

-- Problem 33
--The manager has changed his mind since the last problem.
--He wants to define high-value customers differently. 
--Instead of requiring that customers have at least one order totaling $10,000 or
--more, high-value customers are those who have orders totaling $15,000 or more
--in 2016. How would you change the query above to find this?

SELECT 
	c.CustomerID
	,c.CompanyName
	,SUM(od.UnitPrice * Quantity) as TotalOrderAmount
FROM Customers c  
	JOIN Orders o ON c.CustomerID = o.CustomerID
	JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2016 
GROUP BY c.CustomerID, c.CompanyName
HAVING SUM(od.UnitPrice * Quantity) >= 15000
ORDER BY TotalOrderAmount DESC
-- Removing order ID collapsed the groupings allowing us to see the total order amounts!
-- This allows us to group at the customer level and not the order level. 
;

-- Problem 34
-- Change the answer from the previous problem to use the discount when calculating
-- high value customers. 
SELECT 
	c.CustomerID
	,c.CompanyName
	,SUM(od.UnitPrice * Quantity) AS 'Totals Without Discount'
	,SUM((od.UnitPrice * Quantity)*(1-Discount)) AS 'Totals With Discount'
FROM Customers c  
	JOIN Orders o ON c.CustomerID = o.CustomerID
	JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 2016 
GROUP BY c.CustomerID, c.CompanyName
HAVING SUM((od.UnitPrice * Quantity)*(1-Discount)) >= 15000
ORDER BY 'Totals With Discount' DESC
;

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

-- Problem 35
-- Show all orders made on the last day of the month.
-- Order by EmployeeID and OrderID

-- One way to do it:
SELECT 
	EmployeeID
	,OrderID
	,OrderDate
FROM Orders
WHERE MONTH(OrderDate) = 1 AND DAY(OrderDate) = 31
	OR MONTH(OrderDate) = 2 AND DAY(OrderDate) = 28
	OR MONTH(OrderDate) = 2 AND DAY(OrderDate) = 29
	OR MONTH(OrderDate) = 3 AND DAY(OrderDate) = 31
--						.
--						.
--						.
--					(and so on)
ORDER BY EmployeeID, OrderID
;

-- Another way using EOMONTH()
SELECT 
	EmployeeID
	,OrderID
	,OrderDate
FROM Orders
WHERE DAY(OrderDate) = DAY(EOMONTH(OrderDate))
ORDER BY EmployeeID, OrderID

-- 


