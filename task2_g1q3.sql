CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("dayofweek" VARCHAR(9), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         CASE
            WHEN "dayofweek"=1 THEN 'Monday'
            WHEN "dayofweek"=2 THEN 'Tuesday'
            WHEN "dayofweek"=3 THEN 'Wednesday'
            WHEN "dayofweek"=4 THEN 'Thursday'
            WHEN "dayofweek"=5 THEN 'Friday'
            WHEN "dayofweek"=6 THEN 'Saturday'
            WHEN "dayofweek"=7 THEN 'Sunday'
        END AS "dayofweek"
        ,(1.00-(AVG("arrdel15") OVER (PARTITION BY "dayofweek" RANGE INTERVAL '12' HOUR PRECEDING))) AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
;
