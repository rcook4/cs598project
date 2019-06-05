CREATE TABLE g2q3
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g2q3/'
) 
AS
SELECT concat('(', origin, '=>', dest, '):', uniquecarrier) AS flighthop_airline, origin AS airport, dest AS destination, uniquecarrier AS airline, fifteen_minutes_late_percentage, arrival_performance_rank AS flighthop_airline_best_arrival_performance_rank
FROM
(
      SELECT origin, dest, uniquecarrier, RANK() OVER (PARTITION BY origin, dest ORDER BY fifteen_minutes_late_percentage ASC) as arrival_performance_rank, fifteen_minutes_late_percentage
      FROM
      (
            SELECT origin, dest, uniquecarrier, ROUND(100.0*SUM(arrdel15)/COUNT(*), 2) AS fifteen_minutes_late_percentage
            FROM completedflights
            WHERE origin = 'CMI' AND dest = 'ORD'
            OR origin = 'IND' AND dest = 'CMH'
            OR origin = 'DFW' AND dest = 'IAH'
            OR origin = 'LAX' AND dest = 'SFO'
            OR origin = 'JFK' AND dest = 'LAX'
            OR origin = 'ATL' AND dest = 'PHX'
            GROUP BY 1, 2, 3
      )
)
WHERE arrival_performance_rank <= 10
ORDER BY 2, 3, 6;