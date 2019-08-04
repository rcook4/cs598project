CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("airline" VARCHAR(6), "good_percentage" REAL);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
    INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM
         "uniquecarrier" as "airline"
        ,(1.00-(AVG("arrdel15") OVER (PARTITION BY "uniquecarrier" RANGE INTERVAL '12' HOUR PRECEDING))) AS good_percentage
    FROM "SOURCE_SQL_STREAM_001"
	WHERE "cancelled" = 0 AND "diverted" = 0
;
