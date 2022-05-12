CREATE TABLE trucks_mg(driverid string, truckid string, model string, Tdate string, miles bigint, gas bigint ) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");


--LOAD DATA LOCAL INPATH '/trucks_mg' INTO TABLE trucks_mg;