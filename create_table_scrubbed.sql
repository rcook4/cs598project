/*timings*/
CREATE EXTERNAL TABLE scrubbed (
  year bigint,
  quarter bigint,
  month bigint,
  dayofmonth bigint,
  dayofweek bigint,
  flightdate string,
  uniquecarrier string,
  airlineid string,
  carrier string,
  tailnum string,
  flightnum string,
  origin string,
  origincityname string,
  originstate string,
  originstatefips double,
  originstatename string,
  originwac double,
  dest string,
  destcityname string,
  deststate string,
  deststatefips double,
  deststatename string,
  destwac double,
  crsdeptime string,
  deptime string,
  depdelay bigint,
  depdelayminutes double,
  depdel15 bigint,
  departuredelaygroups double,
  deptimeblk string,
  taxiout double,
  wheelsoff double,
  wheelson double,
  taxiin double,
  crsarrtime string,
  arrtime string,
  arrdelay bigint,
  arrdelayminutes double,
  arrdel15 bigint,
  arrivaldelaygroups double,
  arrtimeblk string,
  cancelled bigint,
  cancellationcode string,
  diverted bigint,
  crselapsedtime bigint,
  actualelapsedtime bigint,
  airtime double,
  flights double,
  distance double,
  distancegroup double,
  carrierdelay double,
  weatherdelay double,
  nasdelay double,
  securitydelay double,
  lateaircraftdelay double,
  firstdeptime double,
  totaladdgtime double,
  longestaddgtime double,
  divairportlandings double,
  divreacheddest double,
  divactualelapsedtime double,
  divarrdelay double,
  divdistance double,
  div1airport double,
  div1wheelson double,
  div1totalgtime double,
  div1longestgtime double,
  div1wheelsoff double,
  div1tailnum string,
  div2airport double,
  div2wheelson double,
  div2totalgtime double,
  div2longestgtime double,
  div2wheelsoff double,
  div2tailnum string 
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
) LOCATION 's3://cs598project/data/raw/scrubbed/'
TBLPROPERTIES ('has_encrypted_data'='false','skip.header.line.count'='1');
