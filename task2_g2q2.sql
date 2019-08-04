CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("airport" VARCHAR(3), "destination" VARCHAR(4), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         "origin" AS "airport"
        ,"dest" AS "destination"
        ,(1.00-(AVG("arrdel15") OVER (PARTITION BY "origin" || ':' || "dest" RANGE INTERVAL '12' HOUR PRECEDING))) AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
;
