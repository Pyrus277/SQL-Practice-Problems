
-- Q11 Pull the name, title, and birthdate of each employee, and sort by birth date,
-- but instead of DateTime format, show as yyyy-mm-dd.
SELECT
	FirstName,
	LastName,
	Title,
	CONVERT(date, BirthDate) AS DateOnlyBirthDate
FROM Employees
ORDER BY DateOnlyBirthDate;


-- Q12 Combine first and last names to show full names in its own column:
SELECT 
	FirstName,
	LastName,
	CONCAT(FirstName,' ',LastName) AS FullName
FROM Employees;


-- Q13 From the OrderDetails table, make a column that calculates the total price
-- for each record
SELECT
	OrderID,
	ProductID,
	UnitPrice,
	Quantity,
	(UnitPrice*Quantity) AS TotalPrice
FROM OrderDetails;


-- Q14 Return the total number of customers from the Customers table
SELECT 
	COUNT(*) AS TotalCustomers 
FROM Customers;


-- Q15 Show the earliest order date in the Orders table
-- (In MYSQL it's a normal SELECT statement and you'd end with LIMIT 1)
SELECT TOP 1
	OrderDate as FirstOrder
FROM Orders
Order BY OrderDate;


-- Q16 - Show a list of countries where the company has customers
SELECT Country 
FROM Customers
GROUP BY Country
ORDER BY Country;


-- Q17 - From the Customers table, show the unique ContactTitle items,
-- and their respective counts
SELECT
	ContactTitle, 
	COUNT(*) as TotalContactTitle
FROM Customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC;


-- Q18 Show the ProductID and ProductName from the Products talbe, along with the name 
-- of the associated supplier from the Suppliers table.
SELECT 
	p.ProductID,
	p.ProductName,
	s.CompanyName AS Supplier
FROM Products p 
	JOIN Suppliers s
		ON p.SupplierID = s.SupplierID
ORDER BY p.ProductID;


-- Q19 Show OrderID and OrderDate(date only), and the company name of the shipper.
-- Sort by OrderID, and limit results by only showing rows with an OrderID less than 10270
SELECT 
	o.OrderID,
	o.OrderDate,
	s.CompanyName AS Shipper
FROM Orders o
	JOIN Shippers s
	ON o.ShipVia = s.ShipperID
WHERE OrderID < 10270
ORDER BY OrderID;















