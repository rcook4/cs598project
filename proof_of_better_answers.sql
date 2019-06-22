select flightdate, crsarrtime, arrtime, uniquecarrier, flightnum, arrdelay
from scrubbed
where
(year=2008 and month=3 and dayofmonth=6 and origin='ORD' and dest='LAX' and flightnum in ('1247','607'))

/*
flightdate	crsarrtime	arrtime	uniquecarrier	flightnum	arrdelay
3/6/2008		2220				2156		AA						607				-24
3/6/2008		1330				1304		AA						1247			-26
*/
