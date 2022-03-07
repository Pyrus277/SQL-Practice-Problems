-- Problem 25:
-- Return the three ship countries with the highest avarage freight charges, in descending
-- of that value

SELECT TOP 3
	ShipCountry,
	AVG(Freight) AS AverageFreight
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
;

-- Problem 26
-- Continuing from the question above, show the same thing, except we only want to consider orders
-- from 2015:

SELECT TOP 3
	ShipCountry,
	AVG(Freight) AS AverageFreight
FROM Orders
WHERE YEAR(OrderDate) = 2015
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
;

-- ^This is easy to read, but consider replacing the WHERE statement
-- WHERE
	--OrderDate >= '20150101'
	--and OrderDate < '20160101'
-- This is more flexible than the YEAR function when filtering ranges,
-- and it allows use of the index.


-- Problem 27
-- What follows is an incorrect solution to the problem above. It would return Sweden as having the 
-- third highest average freight costs when it should be France. Why is this incorrect?
SELECT TOP 3
	ShipCountry,
	AVG(Freight) AS AverageFreight
FROM Orders
WHERE 
	OrderDate BETWEEN '20150101' AND '20151231'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

-- There was a large order on '20151231' that bumps france up into the third spot,
-- however, because the OrderDate is a DateTime field, '20151231' is going to be
-- equivalent only to 2015-12-31 00:00:00:000. So anything during the day on 12/31
-- will not be picked up by the otherwise inclusive BETWEEN statement. 
-- (Most didn't cover such a fine grained distinction with date values, lol. Had to 
-- look into the solutions chapter and digest this one.) 


-- Problem 28
-- Continuing with freight charges, we now want the thre countries with the highest
-- average freight charges, but instead of filtering for a particular year, we want
-- the most recent 12 months of order data, using as the end date the last OrderDate
-- in Orders

SELECT TOP 3
	ShipCountry,
	AVG(Freight) AS AverageFreight	
FROM Orders
WHERE OrderDate >=
	(SELECT
	DATEADD(YEAR,-1,MAX(OrderDate))
	FROM Orders)
GROUP BY ShipCountry
ORDER BY AverageFreight DESC;


-- Problem 29
-- We're doing inventory and need to show Employee and Order Detail for all orders
-- Sort by OrderID and ProductID

SELECT
	e.EmployeeID,
	e.LastName,
	o.OrderID,
	p.ProductName,
	od.Quantity
FROM Employees e
	JOIN Orders o ON e.EmployeeID = o.EmployeeID
	JOIN OrderDetails od ON o.OrderID = od.OrderID
	JOIN Products p ON od.ProductID = p.ProductID 
ORDER BY od.OrderID, p.ProductID 


-- Problem 30
-- There are some customers who have never actually placed an order.
-- Show those customers.

SELECT 
	Customers.CustomerID AS Customers_CustomerID,
	Orders.CustomerID AS Orders_CustomerID
FROM Customers 
	LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL;


--Problem 31
-- The employee Margaret Peacock (EmployeeID 4) has placed the most orders,
-- but some customers have never placed an order with her. 
-- Show only those customers

SELECT * 
FROM
	(SELECT 
		CustomerID
	FROM Customers) c_tot
LEFT JOIN
	(SELECT 
		DISTINCT CustomerID
	FROM Orders
	WHERE EmployeeID = 4) c
ON c.CustomerID = c_tot.CustomerID
WHERE c.CustomerID IS NULL
ORDER BY c.CustomerID

-- The book's solutions:

SELECT
	c.CustomerID, 
	o.CustomerID 
FROM Customers c
LEFT JOIN Orders o
	ON c.CustomerID = o.CustomerID
	AND o.EmployeeID = 4  -- <--Didn't know you could do this! 
WHERE 
	o.CustomerID IS NULL
ORDER BY c.CustomerID;

-- Alternatively
SELECT CustomerID
FROM Customers
WHERE
	CustomerID NOT IN (
		SELECT CustomerID 
		FROM Orders
		WHERE EmployeeID = 4
		)

-- And:

SELECT CustomerID
FROM Customers
WHERE NOT EXISTS (
	SELECT CustomerID
	FROM Orders	
		WHERE Orders.CustomerID = Customers.CustomerID
		and EmployeeID = 4
	)

-- Finally:

SELECT CustomerID
FROM Customers
EXCEPT
SELECT CustomerID 
FROM Orders 
WHERE EmployeeID = 4




