select flightdate, crsdeptime, deptime, crsarrtime, arrtime, uniquecarrier, flightnum, arrdelay
from scrubbed
where
(year=2008 and month=3 and dayofmonth=6 and origin='ORD' and dest='LAX' and flightnum in ('1247','607'))
or
(year=2008 and month=1 and dayofmonth=3 and origin='ORD' and dest='JFK' and flightnum in ('904','918'))

/*
flightdate  crsdeptime  deptime crsarrtime  arrtime uniquecarrier flightnum arrdelay
2008-03-06  1950  1952  2220  2156  AA  607 -24
2008-03-06  1105  1059  1330  1304  AA  1247  -26
2008-01-03  0925  0920  1235  1226  B6  904 -9
2008-01-03  1900  1853  2219  2212  B6  918 -7
*/
