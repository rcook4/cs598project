/*timings*/
CREATE TABLE g2q4
WITH
(
     format = 'JSON',  
     external_location = 's3://cs598project/answers/g2q4/'
) 
AS
SELECT concat(origin, '=>', dest) AS flighthop, origin AS airport, dest AS destination, ROUND(1.0*SUM(date_diff('minute', crsarr_ts, arr_ts))/COUNT(*), 2) AS flighthop_mean_arrival_delay_minutes
FROM completedflights
/*
WHERE origin = 'CMI' AND dest = 'ORD'
OR origin = 'IND' AND dest = 'CMH'
OR origin = 'DFW' AND dest = 'IAH'
OR origin = 'LAX' AND dest = 'SFO'
OR origin = 'JFK' AND dest = 'LAX'
OR origin = 'ATL' AND dest = 'PHX'
*/
GROUP BY 2, 3;
