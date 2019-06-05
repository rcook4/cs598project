CREATE TABLE completedflights
WITH
(
     format = 'TEXTFILE',  
     external_location = 's3://cs598project/data/derived/completedflights/',
     partitioned_by = ARRAY['year']
) 
AS
SELECT
       date_parse(flightdate,'%Y-%m-%d') flight_ts
      ,uniquecarrier
      ,carrier
      ,flightnum
      ,origin
      ,dest
      ,CASE
            WHEN crsdeptime='2400'
            THEN date_parse(concat(flightdate,'235959'), '%Y-%m-%d%H%i%s')
            ELSE date_parse(concat(flightdate,crsdeptime), '%Y-%m-%d%H%i')
       END as crsdep_ts
      ,CASE
            WHEN crsdeptime='2400'
            THEN date_add('minute', depdelay, date_parse(concat(flightdate,'235959'), '%Y-%m-%d%H%i%s'))
            ELSE date_add('minute', depdelay, date_parse(concat(flightdate,crsdeptime), '%Y-%m-%d%H%i'))
       END as dep_ts
      ,depdel15
      ,CASE
            WHEN crsdeptime='2400'
            THEN date_add('minute', crselapsedtime, date_parse(concat(flightdate,'235959'), '%Y-%m-%d%H%i%s'))
            ELSE date_add('minute', crselapsedtime, date_parse(concat(flightdate,crsdeptime), '%Y-%m-%d%H%i'))
       END as crsarr_ts
      ,CASE
            WHEN crsdeptime='2400'
            THEN date_add('minute', actualelapsedtime, date_add('minute', depdelay, date_parse(concat(flightdate,'235959'), '%Y-%m-%d%H%i%s')))
            ELSE date_add('minute', actualelapsedtime, date_add('minute', depdelay, date_parse(concat(flightdate,crsdeptime), '%Y-%m-%d%H%i')))
       END as arr_ts
      ,arrdel15
      ,dayofweek
      ,year
FROM "cs598athena"."scrubbed"
WHERE (diverted = 0 or diverted is null)
AND (cancelled = 0 or cancelled is null);