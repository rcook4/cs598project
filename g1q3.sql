/*timings*/
CREATE TABLE g1q3
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g1q3/'
) 
AS
SELECT day_of_week, fifteen_minutes_late_percentage, RANK() OVER (ORDER BY fifteen_minutes_late_percentage ASC) AS dayofweek_best_arrival_performance_rank
FROM
(
      select date_format(flight_ts, '%a') as day_of_week, ROUND(100.0*SUM(arrdel15)/COUNT(*), 2) AS fifteen_minutes_late_percentage
      from completedflights
      group by 1
      order by 2 ASC
) AS g1q3;
