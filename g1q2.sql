/*runtime evidence*/
CREATE TABLE g1q2
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g1q2/'
) 
AS
SELECT uniquecarrier as airline, fifteen_minutes_late_percentage, RANK() OVER (ORDER BY fifteen_minutes_late_percentage ASC) AS airline_best_arrival_performance_rank
FROM
(
      select uniquecarrier, ROUND(100.0*sum(arrdel15)/COUNT(*), 2) as fifteen_minutes_late_percentage
      from completedflights
      group by 1
      order by 2 asc
      limit 10
) AS top_ten;
