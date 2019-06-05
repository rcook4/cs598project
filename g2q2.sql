CREATE TABLE g2q2
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g2q2/'
) 
AS
SELECT concat(origin, ':', dest) AS airport_destination, origin AS airport, dest AS destination, fifteen_minutes_late_percentage, departure_performance_rank AS airport_destination_best_departure_performance_rank
FROM
(
      SELECT origin, dest, RANK() OVER (PARTITION BY origin ORDER BY fifteen_minutes_late_percentage ASC) as departure_performance_rank, fifteen_minutes_late_percentage
      FROM
      (
            SELECT origin, dest, ROUND(100.0*SUM(depdel15)/COUNT(*), 2) AS fifteen_minutes_late_percentage
            FROM completedflights
            WHERE origin IN ('CMI','BWI','MIA','LAX','IAH','SFO')
            GROUP BY 1, 2
      )
)
WHERE departure_performance_rank <= 10
ORDER BY 2, 5;