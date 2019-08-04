CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("airport" VARCHAR(3), "airline" VARCHAR(6), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         "origin" AS "airport"
        ,"uniquecarrier" AS "airline"
        ,(1.00-(AVG("arrdel15") OVER (PARTITION BY "origin" || ':' || "uniquecarrier" RANGE INTERVAL '12' HOUR PRECEDING))) AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
;
