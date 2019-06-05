CREATE TABLE g1q1
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g1q1/'
) 
AS
SELECT airport, total_trips, RANK() OVER (ORDER BY total_trips DESC) AS airport_most_popular_rank
FROM
(
      select airport, sum(trips) as total_trips
      from
      (
            select origin as airport, count(*) as trips from completedflights group by 1
            union all
            select dest as airport, count(*) as trips from completedflights group by 1
      ) as flights
      group by 1
      order by 2 desc
      limit 10
) AS top_ten;