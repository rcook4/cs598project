CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("airline" VARCHAR(6), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         "uniquecarrier" AS "airline"
        ,AVG(1.00-"arrdel15") AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
    GROUP BY "uniquecarrier", STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '1' HOUR)
;
