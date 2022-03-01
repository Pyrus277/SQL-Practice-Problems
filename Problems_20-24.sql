--Q20 Show the total number of products in each category. Category names from Categories, 
-- Product info from Products.
SELECT
	c.CategoryName,
	count(*) AS TotalProducts
FROM Categories c
JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
-- ^Future ref-- Don't forget to include all SELECT statement 
--items in the GROUP BY statement when you're joining and using aggregates!
ORDER BY TotalProducts DESC;


-- Q21 Show the total number of customers per Country and City
SELECT 
	Country,
	City,
	Count(*) AS TotalCustomers
FROM Customers	
GROUP BY Country, City
ORDER BY TotalCustomers DESC;


-- Q22 What needs reordering? Show records where UnitsInStock is less than or
-- equal to ReorderLevel
SELECT 
	ProductID,
	ProductName,
	UnitsInStock,
	ReorderLevel
FROM Products
WHERE UnitsInStock <= ReorderLevel
ORDER BY ProductID


-- Q23 Similar to above but show records but list records where UnitsInStock
-- plus UnitsOnOrder is less than or equal to Reorder level. Also do not inclue
-- discontinues items. 
SELECT 
	ProductID,
	ProductName,
	UnitsInStock,
	UnitsOnOrder,
	ReorderLevel,
	Discontinued
FROM Products
WHERE (UnitsInStock + UnitsOnOrder) <= ReorderLevel
	AND Discontinued != 1
ORDER BY ProductID;


-- Q24 - List all customers, sorted by region alphabetically, except
-- show all the NULL region customers at *the bottom*. Within the same
-- region, sort by CustomerID

-- Approach-- NULL will precede the other items in the region category when sorted
-- alphabetically, so we need to first sort by an additional column the rows of which
-- are given a value based on whether or not region is null, at the same time, we don't
-- want to see this column, so we incorporate it solely in the ORDER BY statement as seen
-- below. 

SELECT
	CustomerID,
	CompanyName,
	Region
FROM Customers
ORDER BY ISNULL(Region, 'zzz'), Region, CustomerID; 




















