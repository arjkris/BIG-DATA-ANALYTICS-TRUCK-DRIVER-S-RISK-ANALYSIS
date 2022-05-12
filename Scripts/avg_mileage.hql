--Create table avg_mileage from existing trucks_mileage table

CREATE TABLE avg_mileage
AS
SELECT truckid, avg(mpg) avgmpg
FROM truck_mileage
GROUP BY truckid;
