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
WHERE OrderDate BETWEEN 
	(SELECT
	DATEADD(YEAR,-1,MAX(OrderDate))
	FROM Orders)

	AND

	(SELECT
	MAX(OrderDate)
	FROM Orders)
	
GROUP BY ShipCountry
ORDER BY AverageFreight DESC;

-- ^This gets the correct answer, but look at it when you're fresh 
-- and see if you can make it more elegant. 






