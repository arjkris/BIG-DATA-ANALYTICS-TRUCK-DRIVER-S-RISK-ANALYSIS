CREATE TABLE geolocation
(
	truckid string, 
	driverid string, 
	event string, 
	latitude DOUBLE, 
	longitude DOUBLE, 
	city string, 
	state string, 
	velocity BIGINT, 
	event_ind  BIGINT, 
	idling_ind BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

--LOAD DATA LOCAL INPATH '/geolocation' INTO TABLE geolocation;
