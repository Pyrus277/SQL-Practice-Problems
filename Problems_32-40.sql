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



-- Problem 36
-- Mobile app developers are testing an app and need samples of orders that
-- have lots of individual line items. 
-- Show the 10 orders with the most line items, in order of total line items

SELECT TOP 10 -- you can add 'with ties' to this statement to return tied values
	OrderID
	,COUNT(*) as TotalOrderDetails
FROM OrderDetails
GROUP BY OrderID
ORDER BY TotalOrderDetails DESC

-- Problem 37
-- Now the mobile app devs would like to get a random assortment of orders
-- for beta testing of their app. Show a random 2% of all orders

SELECT TOP 2 PERCENT 
	OrderID
FROM Orders
ORDER BY NEWID()
;
-- NEWID() creates a GUID, when you order by this, you get a random sorting.
-- This method might cause performance issued on very large tables, so consider
-- an alternate approach. 