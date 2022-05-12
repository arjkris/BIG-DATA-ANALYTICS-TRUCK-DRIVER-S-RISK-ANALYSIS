--Create table ‘drivermileage’ from existing ‘truck_mileage’ table

CREATE TABLE DriverMileage
AS
SELECT driverid, sum(miles) totmiles
FROM truck_mileage
GROUP BY driverid;
