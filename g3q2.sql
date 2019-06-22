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
       NAME as mission
      ,launching_flight
      ,actual_launch
      ,landing_flight
      ,actual_landing
      ,total_mission_delayed_minutes
      ,LAUNCH_DAY
FROM
(
      SELECT
             NAME
            ,launching_flight
            ,actual_launch
            ,landing_flight
            ,actual_landing
            ,total_mission_delayed_minutes
            ,RANK() OVER (PARTITION BY NAME ORDER BY total_mission_delayed_minutes ASC) AS route_best_match_rank
            ,LAUNCH_DAY
      FROM
      (
            SELECT
                   MISSIONS.NAME
                  ,concat(LAUNCHING.uniquecarrier, ' ', LAUNCHING.flightnum) AS launching_flight
                  ,LAUNCHING.dep_ts AS actual_launch
                  ,concat(LANDING.uniquecarrier, ' ', LANDING.flightnum) as landing_flight
                  ,LANDING.arr_ts AS actual_landing
                  ,(date_diff('minute', LAUNCHING.crsarr_ts, LAUNCHING.arr_ts) + date_diff('minute', LANDING.crsarr_ts, LANDING.arr_ts)) as total_mission_delayed_minutes
                  ,LAUNCH_DAY
            FROM MISSIONS
            JOIN completedflights AS LAUNCHING
                  ON  LAUNCHING.year = 2008
                  AND LAUNCHING.year = MISSIONS.YEAR
                  AND LAUNCHING.origin = MISSIONS.LAUNCH
                  AND LAUNCHING.dest = MISSIONS.RENDEZVOUS
                  AND LAUNCHING.dep_ts BETWEEN MISSIONS.LAUNCH_EARLIEST AND MISSIONS.LAUNCH_LATEST
                  AND LAUNCHING.crsdep_ts BETWEEN MISSIONS.LAUNCH_EARLIEST AND MISSIONS.LAUNCH_LATEST
                  AND day(LAUNCHING.dep_ts) = MISSIONS.LAUNCH_DAY
            JOIN completedflights AS LANDING
                  ON  LANDING.year = 2008
                  AND LANDING.year = MISSIONS.YEAR
                  AND LANDING.origin = MISSIONS.RENDEZVOUS
                  AND LANDING.dest = MISSIONS.LAND
                  AND LANDING.arr_ts BETWEEN MISSIONS.LAND_EARLIEST AND MISSIONS.LAND_LATEST
                  AND LANDING.crsarr_ts BETWEEN MISSIONS.LAND_EARLIEST AND MISSIONS.LAND_LATEST
                  AND day(date_add('day', -2, LANDING.arr_ts)) = MISSIONS.LAUNCH_DAY
/*            WHERE NAME IN ('CMI => ORD => LAX (04/03/2008)','JAX => DFW => CRP (09/09/2008)','SLC => BFL => LAX (01/04/2008)','LAX => SFO => PHX (12/07/2008)','DFW => ORD => DFW (10/06/2008)','LAX => ORD => JFK (01/01/2008)') */
      ) AS MISSION_ROUTES
) AS MISSION_RESULT
WHERE route_best_match_rank = 1;
