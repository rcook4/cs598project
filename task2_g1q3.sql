CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("dayofweek" VARCHAR(3), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         CASE
            WHEN "dayofweek"=1 THEN 'MON'
            WHEN "dayofweek"=2 THEN 'TUE'
            WHEN "dayofweek"=3 THEN 'WED'
            WHEN "dayofweek"=4 THEN 'THU'
            WHEN "dayofweek"=5 THEN 'FRI'
            WHEN "dayofweek"=6 THEN 'SAT'
            WHEN "dayofweek"=7 THEN 'SUN'
        END AS "dayofweek"
        ,AVG(1.0-"arrdel15") AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
    GROUP BY "dayofweek", STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '1' HOUR)
;
