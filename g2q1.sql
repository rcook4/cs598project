/*timings*/
CREATE TABLE g2q1
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g2q1/'
) 
AS
SELECT origin as airport, uniquecarrier as airline, fifteen_minutes_late_percentage, departure_performance_rank AS airport_airline_best_departure_performance_rank
FROM
(
      SELECT origin, uniquecarrier, RANK() OVER (PARTITION BY origin ORDER BY fifteen_minutes_late_percentage, uniquecarrier) as departure_performance_rank, fifteen_minutes_late_percentage
      FROM
      (
            SELECT origin, uniquecarrier, ROUND(100.0*SUM(depdel15)/COUNT(*), 2) AS fifteen_minutes_late_percentage
            FROM completedflights
/*            WHERE origin IN ('CMI','BWI','MIA','LAX','IAH','SFO') */
            GROUP BY 1, 2
      ) AS performance
) AS g2q1
WHERE departure_performance_rank <= 10;
