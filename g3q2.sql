/*timings*/
CREATE TABLE g3q2
WITH
(
       format = 'TEXTFILE'
      ,field_delimiter = ','
      ,external_location = 's3://cs598project/answers/g3q2/'
      ,partitioned_by = ARRAY['LAUNCH_DAY']
) 
AS
SELECT
       mission
      ,launch_flight
      ,scheduled_launch
      ,land_flight
      ,scheduled_land
      ,delay
      ,LAUNCH_DAY
FROM
(
      SELECT
             mission
            ,launch_flight
            ,scheduled_launch
            ,land_flight
            ,scheduled_land
            ,delay
            ,RANK() OVER (PARTITION BY mission ORDER BY delay ASC) AS route_best_match_rank
            ,LAUNCH_DAY
      FROM
      (
            SELECT
                   MISSIONS.NAME as mission
                  ,concat(LAUNCHING.uniquecarrier, ' ', LAUNCHING.flightnum) AS launch_flight
                  ,date_format(LAUNCHING.crsdep_ts, '%d/%m/%Y %H:%i') AS scheduled_launch
                  ,concat(LANDING.uniquecarrier, ' ', LANDING.flightnum) as land_flight
                  ,date_format(LANDING.crsarr_ts, '%d/%m/%Y %H:%i') AS scheduled_land
                  ,(date_diff('minute', LAUNCHING.crsarr_ts, LAUNCHING.arr_ts) + date_diff('minute', LANDING.crsarr_ts, LANDING.arr_ts)) as delay
                  ,LAUNCH_DAY
            FROM MISSIONS
            JOIN completedflights AS LAUNCHING
                  ON  LAUNCHING.year = 2008
                  AND LAUNCHING.year = MISSIONS.YEAR
                  AND LAUNCHING.origin = MISSIONS.LAUNCH
                  AND LAUNCHING.dest = MISSIONS.RENDEZVOUS
                  AND LAUNCHING.dep_ts BETWEEN MISSIONS.LAUNCH_EARLIEST_DEPARTURE AND MISSIONS.LAUNCH_LATEST_DEPARTURE
                  AND LAUNCHING.crsdep_ts BETWEEN MISSIONS.LAUNCH_EARLIEST_DEPARTURE AND MISSIONS.LAUNCH_LATEST_DEPARTURE
                  AND day(LAUNCHING.dep_ts) = MISSIONS.LAUNCH_DAY
            JOIN completedflights AS LANDING
                  ON  LANDING.year = 2008
                  AND LANDING.year = MISSIONS.YEAR
                  AND LANDING.origin = MISSIONS.RENDEZVOUS
                  AND LANDING.dest = MISSIONS.LAND
                  AND LANDING.dep_ts BETWEEN MISSIONS.LAND_EARLIEST_DEPARTURE AND MISSIONS.LAND_LATEST_DEPARTURE
                  AND LANDING.crsdep_ts BETWEEN MISSIONS.LAND_EARLIEST_DEPARTURE AND MISSIONS.LAND_LATEST_DEPARTURE
                  AND day(date_add('day', -2, LANDING.arr_ts)) = MISSIONS.LAUNCH_DAY
/*            WHERE MISSIONS.NAME IN ('CMI => ORD => LAX (04/03/2008)','JAX => DFW => CRP (09/09/2008)','SLC => BFL => LAX (01/04/2008)','LAX => SFO => PHX (12/07/2008)','DFW => ORD => DFW (10/06/2008)','LAX => ORD => JFK (01/01/2008)') */
      ) AS MISSION_ROUTES
) AS MISSION_RESULT
WHERE route_best_match_rank = 1;
