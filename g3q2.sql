CREATE TABLE g3q2
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g3q2/'
) 
AS
with MISSION as (
      SELECT
             1 AS ID
            ,'CMI => ORD => LAX, 04/03/2008' AS NAME
            ,'CMI' AS LAUNCH
            ,'ORD' AS RENDEZVOUS
            ,'LAX' AS LANDING
            ,2008 AS YEAR
            ,date_parse('2008-03-04 00:00:00', '%Y-%m-%d %H:%i:%s') AS LAUNCH_EARLIEST
            ,date_parse('2008-03-04 11:59:59', '%Y-%m-%d %H:%i:%s') AS LAUNCH_LATEST
            ,date_parse('2008-03-06 12:00:00', '%Y-%m-%d %H:%i:%s') AS LANDING_EARLIEST
            ,date_parse('2008-03-06 23:59:59', '%Y-%m-%d %H:%i:%s') AS LANDING_LATEST
      UNION ALL
      SELECT
             2 AS ID
            , 'JAX => DFW => CRP, 09/09/2008' AS NAME
            ,'JAX' AS LAUNCH
            ,'DFW' AS RENDEZVOUS
            ,'CRP' AS LANDING
            ,2008 AS YEAR
            ,date_parse('2008-09-09 00:00:00', '%Y-%m-%d %H:%i:%s') AS LAUNCH_EARLIEST
            ,date_parse('2008-09-09 11:59:59', '%Y-%m-%d %H:%i:%s') AS LAUNCH_LATEST
            ,date_parse('2008-09-11 12:00:00', '%Y-%m-%d %H:%i:%s') AS LANDING_EARLIEST
            ,date_parse('2008-09-11 23:59:59', '%Y-%m-%d %H:%i:%s') AS LANDING_LATEST
      UNION ALL
      SELECT
             3 AS ID
            ,'SLC => BFL => LAX, 01/04/2008' AS NAME
            ,'SLC' AS LAUNCH
            ,'BFL' AS RENDEZVOUS
            ,'LAX' AS LANDING
            ,2008 AS YEAR
            ,date_parse('2008-04-01 00:00:00', '%Y-%m-%d %H:%i:%s') AS LAUNCH_EARLIEST
            ,date_parse('2008-04-01 11:59:59', '%Y-%m-%d %H:%i:%s') AS LAUNCH_LATEST
            ,date_parse('2008-04-03 12:00:00', '%Y-%m-%d %H:%i:%s') AS LANDING_EARLIEST
            ,date_parse('2008-04-03 23:59:59', '%Y-%m-%d %H:%i:%s') AS LANDING_LATEST
      UNION ALL
      SELECT
             4 AS ID
            ,'LAX => SFO => PHX, 12/07/2008' AS NAME
            ,'LAX' AS LAUNCH
            ,'SFO' AS RENDEZVOUS
            ,'PHX' AS LANDING
            ,2008 AS YEAR
            ,date_parse('2008-07-12 00:00:00', '%Y-%m-%d %H:%i:%s') AS LAUNCH_EARLIEST
            ,date_parse('2008-07-12 11:59:59', '%Y-%m-%d %H:%i:%s') AS LAUNCH_LATEST
            ,date_parse('2008-07-14 12:00:00', '%Y-%m-%d %H:%i:%s') AS LANDING_EARLIEST
            ,date_parse('2008-07-14 23:59:59', '%Y-%m-%d %H:%i:%s') AS LANDING_LATEST
      UNION ALL
      SELECT
             5 AS ID
            ,'DFW => ORD => DFW, 10/06/2008' AS NAME
            ,'DFW' AS LAUNCH
            ,'ORD' AS RENDEZVOUS
            ,'DFW' AS LANDING
            ,2008 AS YEAR
            ,date_parse('2008-06-10 00:00:00', '%Y-%m-%d %H:%i:%s') AS LAUNCH_EARLIEST
            ,date_parse('2008-06-10 11:59:59', '%Y-%m-%d %H:%i:%s') AS LAUNCH_LATEST
            ,date_parse('2008-06-12 12:00:00', '%Y-%m-%d %H:%i:%s') AS LANDING_EARLIEST
            ,date_parse('2008-06-12 23:59:59', '%Y-%m-%d %H:%i:%s') AS LANDING_LATEST
      UNION ALL
      SELECT
             6 AS ID
            ,'LAX => ORD => JFK, 01/01/2008' AS NAME
            ,'LAX' AS LAUNCH
            ,'ORD' AS RENDEZVOUS
            ,'JFK' AS LANDING
            ,2008 AS YEAR
            ,date_parse('2008-01-01 00:00:00', '%Y-%m-%d %H:%i:%s') AS LAUNCH_EARLIEST
            ,date_parse('2008-01-01 11:59:59', '%Y-%m-%d %H:%i:%s') AS LAUNCH_LATEST
            ,date_parse('2008-01-03 12:00:00', '%Y-%m-%d %H:%i:%s') AS LANDING_EARLIEST
            ,date_parse('2008-01-03 23:59:59', '%Y-%m-%d %H:%i:%s') AS LANDING_LATEST
)

SELECT
       ID
      ,NAME as mission
      ,launch_flight
      ,scheduled_launch
      ,landing_flight
      ,scheduled_landing
      ,total_mission_delayed_minutes
FROM
(
      SELECT ID, NAME, launch_flight, scheduled_launch, landing_flight, scheduled_landing, total_mission_delayed_minutes, RANK() OVER (PARTITION BY ID ORDER BY total_mission_delayed_minutes ASC) AS route_best_match_rank
      FROM
      (
            SELECT MISSION.ID, MISSION.NAME, concat(LAUNCH.uniquecarrier, ' ', LAUNCH.flightnum) AS launch_flight, LAUNCH.crsdep_ts AS scheduled_launch, concat(LANDING.uniquecarrier, ' ', LANDING.flightnum) as landing_flight, LANDING.crsarr_ts AS scheduled_landing, (LAUNCH.delay_minutes + LANDING.delay_minutes) as total_mission_delayed_minutes
            FROM MISSION
            JOIN
            (
                  SELECT MISSION.ID, uniquecarrier, flightnum, origin, dest, crsdep_ts, date_diff('minute', crsarr_ts, arr_ts) as delay_minutes
                  FROM MISSION
                  JOIN completedflights
                  ON completedflights.year=MISSION.YEAR
                  AND completedflights.origin = MISSION.LAUNCH
                  AND completedflights.dest = MISSION.RENDEZVOUS
                  AND completedflights.crsdep_ts BETWEEN MISSION.LAUNCH_EARLIEST AND MISSION.LAUNCH_LATEST
            ) AS LAUNCH ON LAUNCH.ID = MISSION.ID
            JOIN
            (
                  SELECT MISSION.ID, uniquecarrier, flightnum, origin, dest, crsarr_ts, date_diff('minute', crsarr_ts, arr_ts) as delay_minutes
                  FROM MISSION
                  JOIN completedflights
                  ON completedflights.year=MISSION.YEAR
                  AND completedflights.origin = MISSION.RENDEZVOUS
                  AND completedflights.dest = MISSION.LANDING
                  AND completedflights.crsdep_ts BETWEEN MISSION.LANDING_EARLIEST AND MISSION.LANDING_LATEST
            ) AS LANDING ON LANDING.ID = MISSION.ID
      ) AS MISSION_ROUTES
) AS MISSION_RESULT
WHERE route_best_match_rank = 1
ORDER BY 1;