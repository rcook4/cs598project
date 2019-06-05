CREATE TABLE g3q1
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g3q1/'
) 
AS
SELECT rank
,airport
,max_val*(1.0/rank) as lognormal
,max_val*(power(0.9661438097,(rank-1))) as expo966
,ln(airport) ln_airport
,ln(max_val*(1.0/rank)) as ln_lognormal
,ln(max_val*(power(0.9661438097,(rank-1)))) as ln_expo966
,ln(case when (12020931*(power(0.9661438097,(rank-1))))-(floor((exp(rank+32)/(exp(rank+32)+1)))*(floor((exp(rank+32)/(exp(rank+32)+1)))*((4109973.7)+(-85382.325*(rank-2))+(437.3084466*power((rank-2),2))))) > 1 then (12020931*(power(0.9661438097,(rank-1))))-(floor((exp(rank+32)/(exp(rank+32)+1)))*(floor((exp(rank+32)/(exp(rank+32)+1)))*((4109973.7)+(-85382.325*(rank-2))+(437.3084466*power((rank-2),2))))) else 1 end) as ln_expo966_quadhigh
,ln(case when (12020931*(power(0.9661438097,(rank-1))))-(floor((exp(rank+32)/(exp(rank+32)+1)))*(floor((exp(rank+32)/(exp(rank+32)+1)))*((4109973.7)+(-85382.325*(rank-2))+(437.3084466*power((rank-2),2)))))+(floor((exp(rank-79)/(exp(rank-79)+1)))*((8569.03)+(13669.772*(rank-114))+(432.6045928*(power((rank-114),2))))) > 1 then (12020931*(power(0.9661438097,(rank-1))))-(floor((exp(rank+32)/(exp(rank+32)+1)))*(floor((exp(rank+32)/(exp(rank+32)+1)))*((4109973.7)+(-85382.325*(rank-2))+(437.3084466*power((rank-2),2)))))+(floor((exp(rank-79)/(exp(rank-79)+1)))*((8569.03)+(13669.772*(rank-114))+(432.6045928*(power((rank-114),2))))) else 1 end) as ln_expo966_quadhigh_quadlow
FROM
(
	SELECT DENSE_RANK() OVER (ORDER BY total_trips DESC, AIRPORT ASC) AS rank, total_trips AS airport
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
	) AS popularity
) as distro
CROSS JOIN
(
	select min(total_trips) as min_val, avg(total_trips) as avg_val, max(total_trips) as max_val, stddev_pop(total_trips) as sd_val
	from
	(
		  select airport, sum(trips) as total_trips
		  from
		  (
				select origin as airport, count(*) as trips from completedflights group by 1
				union all
				select dest as airport, count(*) as trips from completedflights group by 1
		  ) as flights
		  group by 1
	  )
) AS stats;