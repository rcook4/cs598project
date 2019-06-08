CREATE TABLE missions
WITH (
       format = 'TEXTFILE'
      ,field_delimiter = ','
      ,external_location = 's3://cs598project/data/derived/missions/'
      ,partitioned_by = ARRAY['LAUNCH_DAY']
      ,bucketed_by = ARRAY['LAUNCH_MONTH']
      ,bucket_count = 12
)
AS
SELECT
       2008 AS YEAR
      ,concat(LAUNCH, ' => ', LANDING.RENDEZVOUS, ' => ', LAND, ' (', date_format(LAUNCH_EARLIEST, '%d/%m/%Y'), ')') AS NAME
      ,LAUNCH
      ,LAUNCH_EARLIEST
      ,LAUNCH_LATEST
      ,LANDING.RENDEZVOUS
      ,LAND
      ,LAND_EARLIEST
      ,LAND_LATEST
      ,month(LAUNCH_EARLIEST) AS LAUNCH_MONTH
      ,day(LAUNCH_EARLIEST) AS LAUNCH_DAY
FROM
(
      select distinct origin as LAUNCH, dest as RENDEZVOUS, date_add('second', 0, flight_ts) as LAUNCH_EARLIEST, date_add('second', 0+43199, flight_ts) as LAUNCH_LATEST from completed where year(flight_ts) = 2008 and hour(crsdep_ts) < 12
) AS LAUNCHING
JOIN
(
      select distinct origin as RENDEZVOUS, dest as LAND, date_add('second', 43200, flight_ts) as LAND_EARLIEST, date_add('second', 43200+43199, flight_ts) as LAND_LATEST from completed where year(flight_ts) = 2008 and hour(crsarr_ts) >= 12
) as LANDING
ON LAUNCHING.RENDEZVOUS = LANDING.RENDEZVOUS
AND date_diff('day', LAUNCH_EARLIEST, LAND_EARLIEST) = 2
