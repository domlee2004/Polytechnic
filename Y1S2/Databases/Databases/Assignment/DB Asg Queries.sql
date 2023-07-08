SELECT FORMAT(DelDateTime, 'dd MMMM yyyy') as 'Date', COUNT(*) as 'Number of orders',
Round(AVG(CAST(DATEDIFF(MINUTE, OrderDateTime, DelDateTime) as float)), 2) as 'Average wait time (minutes)', 
SUM(CAST(DATEDIFF(MINUTE, OrderDateTime, DelDateTime) as float)) as ' Total wait time (minutes)'
FROM orders o 
INNER JOIN Dish d
ON o.DishID = d.DishID
GROUP BY FORMAT(DelDateTime, 'dd MMMM yyyy')
ORDER BY Round(AVG(CAST(DATEDIFF(MINUTE, OrderDateTime, DelDateTime) as float)), 2) DESC


SELECT ETName, COALESCE(SUM(AdultSalesPrice), 0) as 'Money from adult tickets', COUNT(b.PgrID) as 'Number of bookings',  
ROUND(SUM(COALESCE(AdultSalesPrice, 0))/COUNT(*), 2) as 'Average ticket price'
FROM booking b 
Inner JOIN Passenger p 
ON p.PgrID = b.PgrID 
Inner JOIN Event e 
ON b.EventID = e.EventID 
Inner JOIN EventType et 
ON et.ETID = e.ETID 
WHERE BookStatus = 'Booked' AND DATEDIFF(year, PgrDOB, BookDateTime) > 13
GROUP BY ETName 
ORDER BY SUM(AdultSalesPrice) DESC

SELECT TOP 5 r.EatyID, e.EatyName, Count(r.EatyID) as 'Number of reservations', Sum(NoOfPax) as 'Total number of booked customers' 
, ROUND(CAST(SUM(NoOfPax) as float)/CAST(Count(r.EatyID) as 	     	float), 2) as 'Average number of pax per booking'
FROM Reservation r
INNER JOIN Eatery e
ON r.EatyID = e.EatyID
GROUP BY r.EatyID, e.EatyName
HAVING COUNT(r.EatyID) in
(SELECT TOP 5 Count(EatyID) as 'Number of reservations'
FROM Reservation
WHERE ReservStatus = 'Booked'
GROUP BY EatyID
ORDER BY COUNT(EatyID) DESC)
ORDER BY Count(r.EatyID) DESC, Sum(NoOfPax) DESC
