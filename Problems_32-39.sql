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



