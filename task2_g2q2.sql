CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("airport" VARCHAR(3), "destination" VARCHAR(4), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         "origin" AS "airport"
        ,"dest" AS "destination"
        ,AVG(1.0-"arrdel15") AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
	GROUP BY "origin", "dest", STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '1' HOUR)
;
