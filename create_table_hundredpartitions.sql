CREATE TABLE hundredpartitions
WITH
(
       format = 'TEXTFILE'
      ,field_delimiter = ','
      ,external_location = 's3://cs598project/answers/hundredpartitions/'
      ,partitioned_by = ARRAY['TIER']
) 
AS
SELECT
       NAME as mission
      ,launching_flight
      ,scheduled_launch
      ,landing_flight
      ,scheduled_landing
      ,total_mission_delayed_minutes
      ,CASE
            WHEN NAME BETWEEN '' AND 'ABQ => PHX => SNA (08/07/2008)' THEN 1
            WHEN NAME BETWEEN 'ABQ => PHX => SNA (08/07/2008)~' AND 'ALB => MCO => JFK (17/03/2008)' THEN 2
            WHEN NAME BETWEEN 'ALB => MCO => JFK (17/03/2008)~' AND 'ATL => CLT => PHL (07/10/2008)' THEN 3
            WHEN NAME BETWEEN 'ATL => CLT => PHL (07/10/2008)~' AND 'ATL => ORD => RST (30/06/2008)' THEN 4
            WHEN NAME BETWEEN 'ATL => ORD => RST (30/06/2008)~' AND 'AUS => DEN => GTF (08/10/2008)' THEN 5
            WHEN NAME BETWEEN 'AUS => DEN => GTF (08/10/2008)~' AND 'AVP => DTW => BGM (27/01/2008)' THEN 6
            WHEN NAME BETWEEN 'AVP => DTW => BGM (27/01/2008)~' AND 'BDL => PBI => DCA (30/06/2008)' THEN 7
            WHEN NAME BETWEEN 'BDL => PBI => DCA (30/06/2008)~' AND 'BHM => LGA => FNT (06/06/2008)' THEN 8
            WHEN NAME BETWEEN 'BHM => LGA => FNT (06/06/2008)~' AND 'BNA => DFW => LAX (09/03/2008)' THEN 9
            WHEN NAME BETWEEN 'BNA => DFW => LAX (09/03/2008)~' AND 'BOI => ORD => MEM (04/05/2008)' THEN 10
            WHEN NAME BETWEEN 'BOI => ORD => MEM (04/05/2008)~' AND 'BOS => MDW => SAT (21/07/2008)' THEN 11
            WHEN NAME BETWEEN 'BOS => MDW => SAT (21/07/2008)~' AND 'BTR => MEM => PFN (28/03/2008)' THEN 12
            WHEN NAME BETWEEN 'BTR => MEM => PFN (28/03/2008)~' AND 'BUR => DFW => OGG (18/06/2008)' THEN 13
            WHEN NAME BETWEEN 'BUR => DFW => OGG (18/06/2008)~' AND 'BWI => LIT => LAS (26/09/2008)' THEN 14
            WHEN NAME BETWEEN 'BWI => LIT => LAS (26/09/2008)~' AND 'CAE => EWR => LEX (20/06/2008)' THEN 15
            WHEN NAME BETWEEN 'CAE => EWR => LEX (20/06/2008)~' AND 'CHS => CLT => RSW (12/08/2008)' THEN 16
            WHEN NAME BETWEEN 'CHS => CLT => RSW (12/08/2008)~' AND 'CLE => DEN => MSY (29/03/2008)' THEN 17
            WHEN NAME BETWEEN 'CLE => DEN => MSY (29/03/2008)~' AND 'CLT => ATL => JAN (14/03/2008)' THEN 18
            WHEN NAME BETWEEN 'CLT => ATL => JAN (14/03/2008)~' AND 'CLT => PHX => DRO (24/08/2008)' THEN 19
            WHEN NAME BETWEEN 'CLT => PHX => DRO (24/08/2008)~' AND 'CMH => PHX => OMA (19/10/2008)' THEN 20
            WHEN NAME BETWEEN 'CMH => PHX => OMA (19/10/2008)~' AND 'CRP => DFW => ABI (19/08/2008)' THEN 21
            WHEN NAME BETWEEN 'CRP => DFW => ABI (19/08/2008)~' AND 'CVG => LAS => BOS (25/10/2008)' THEN 22
            WHEN NAME BETWEEN 'CVG => LAS => BOS (25/10/2008)~' AND 'DAL => LBB => ABQ (08/10/2008)' THEN 23
            WHEN NAME BETWEEN 'DAL => LBB => ABQ (08/10/2008)~' AND 'DAL => LBB => ABQ (08/10/2008)' THEN 23
            WHEN NAME BETWEEN 'DAL => LBB => ABQ (08/10/2008)~' AND 'DCA => CVG => EWR (20/02/2008)' THEN 24
            WHEN NAME BETWEEN 'DCA => CVG => EWR (20/02/2008)~' AND 'DEN => BOS => PHF (06/10/2008)' THEN 25
            WHEN NAME BETWEEN 'DEN => BOS => PHF (06/10/2008)~' AND 'DEN => BOS => PHF (06/10/2008)' THEN 25
            WHEN NAME BETWEEN 'DEN => BOS => PHF (06/10/2008)~' AND 'DEN => ORD => RSW (17/10/2008)' THEN 26
            WHEN NAME BETWEEN 'DEN => ORD => RSW (17/10/2008)~' AND 'DFW => GSO => DFW (17/09/2008)' THEN 27
            WHEN NAME BETWEEN 'DFW => GSO => DFW (17/09/2008)~' AND 'DFW => TPA => DCA (16/05/2008)' THEN 28
            WHEN NAME BETWEEN 'DFW => TPA => DCA (16/05/2008)~' AND 'DTW => BNA => AUS (27/01/2008)' THEN 29
            WHEN NAME BETWEEN 'DTW => BNA => AUS (27/01/2008)~' AND 'DTW => PHX => CLE (15/03/2008)' THEN 30
            WHEN NAME BETWEEN 'DTW => PHX => CLE (15/03/2008)~' AND 'ELP => SAT => SAN (22/02/2008)' THEN 31
            WHEN NAME BETWEEN 'ELP => SAT => SAN (22/02/2008)~' AND 'EWR => DFW => OGG (31/05/2008)' THEN 32
            WHEN NAME BETWEEN 'EWR => DFW => OGG (31/05/2008)~' AND 'FAI => MSP => SFO (22/07/2008)' THEN 33
            WHEN NAME BETWEEN 'FAI => MSP => SFO (22/07/2008)~' AND 'FLL => CVG => IAH (12/03/2008)' THEN 34
            WHEN NAME BETWEEN 'FLL => CVG => IAH (12/03/2008)~' AND 'FNT => DTW => PIA (05/04/2008)' THEN 35
            WHEN NAME BETWEEN 'FNT => DTW => PIA (05/04/2008)~' AND 'GEG => MSP => CVG (30/06/2008)' THEN 36
            WHEN NAME BETWEEN 'GEG => MSP => CVG (30/06/2008)~' AND 'GRB => DTW => MEM (11/05/2008)' THEN 37
            WHEN NAME BETWEEN 'GRB => DTW => MEM (11/05/2008)~' AND 'GSO => CVG => CHS (01/08/2008)' THEN 38
            WHEN NAME BETWEEN 'GSO => CVG => CHS (01/08/2008)~' AND 'GTR => ATL => ROC (08/07/2008)' THEN 39
            WHEN NAME BETWEEN 'GTR => ATL => ROC (08/07/2008)~' AND 'HOU => SAN => FAT (21/03/2008)' THEN 40
            WHEN NAME BETWEEN 'HOU => SAN => FAT (21/03/2008)~' AND 'IAD => CLT => IAH (17/01/2008)' THEN 41
            WHEN NAME BETWEEN 'IAD => CLT => IAH (17/01/2008)~' AND 'IAH => BHM => MEM (02/08/2008)' THEN 42
            WHEN NAME BETWEEN 'IAH => BHM => MEM (02/08/2008)~' AND 'IAH => PDX => ATL (14/04/2008)' THEN 43
            WHEN NAME BETWEEN 'IAH => PDX => ATL (14/04/2008)~' AND 'IDA => SLC => LWS (22/07/2008)' THEN 44
            WHEN NAME BETWEEN 'IDA => SLC => LWS (22/07/2008)~' AND 'IND => PHL => MDW (30/01/2008)' THEN 45
            WHEN NAME BETWEEN 'IND => PHL => MDW (30/01/2008)~' AND 'JAN => MCO => TLH (20/09/2008)' THEN 46
            WHEN NAME BETWEEN 'JAN => MCO => TLH (20/09/2008)~' AND 'JFK => CLT => PBI (11/06/2008)' THEN 47
            WHEN NAME BETWEEN 'JFK => CLT => PBI (11/06/2008)~' AND 'LAN => CVG => RIC (05/05/2008)' THEN 48
            WHEN NAME BETWEEN 'LAN => CVG => RIC (05/05/2008)~' AND 'LAS => MSP => HLN (10/02/2008)' THEN 49
            WHEN NAME BETWEEN 'LAS => MSP => HLN (10/02/2008)~' AND 'LGA => CLT => RIC (29/08/2008)' THEN 52
            WHEN NAME BETWEEN 'LGA => CLT => RIC (29/08/2008)~' AND 'LGB => SJC => ONT (17/06/2008)' THEN 53
            WHEN NAME BETWEEN 'LGB => SJC => ONT (17/06/2008)~' AND 'MAF => AUS => ONT (29/02/2008)' THEN 54
            WHEN NAME BETWEEN 'MAF => AUS => ONT (29/02/2008)~' AND 'MCI => MEM => RDU (05/05/2008)' THEN 55
            WHEN NAME BETWEEN 'MCI => MEM => RDU (05/05/2008)~' AND 'MCO => EWR => TPA (03/05/2008)' THEN 56
            WHEN NAME BETWEEN 'MCO => EWR => TPA (03/05/2008)~' AND 'MDT => DFW => PDX (05/08/2008)' THEN 57
            WHEN NAME BETWEEN 'MDT => DFW => PDX (05/08/2008)~' AND 'MDW => RSW => DCA (05/02/2008)' THEN 58
            WHEN NAME BETWEEN 'MDW => RSW => DCA (05/02/2008)~' AND 'MEM => LAX => SAN (23/09/2008)' THEN 59
            WHEN NAME BETWEEN 'MEM => LAX => SAN (23/09/2008)~' AND 'MHT => BWI => PIT (20/06/2008)' THEN 60
            WHEN NAME BETWEEN 'MHT => BWI => PIT (20/06/2008)~' AND 'MIA => MCO => JFK (21/10/2008)' THEN 61
            WHEN NAME BETWEEN 'MIA => MCO => JFK (21/10/2008)~' AND 'MKE => ORD => MOB (19/04/2008)' THEN 62
            WHEN NAME BETWEEN 'MKE => ORD => MOB (19/04/2008)~' AND 'MOT => MSP => MCO (25/03/2008)' THEN 63
            WHEN NAME BETWEEN 'MOT => MSP => MCO (25/03/2008)~' AND 'MSP => CLT => ALB (04/07/2008)' THEN 64
            WHEN NAME BETWEEN 'MSP => CLT => ALB (04/07/2008)~' AND 'MSP => SJC => ORD (03/01/2008)' THEN 65
            WHEN NAME BETWEEN 'MSP => SJC => ORD (03/01/2008)~' AND 'MSY => TPA => DTW (09/01/2008)' THEN 66
            WHEN NAME BETWEEN 'MSY => TPA => DTW (09/01/2008)~' AND 'OMA => DTW => FLL (13/10/2008)' THEN 68
            WHEN NAME BETWEEN 'OMA => DTW => FLL (13/10/2008)~' AND 'ONT => SLC => FCA (13/09/2008)' THEN 69
            WHEN NAME BETWEEN 'ONT => SLC => FCA (13/09/2008)~' AND 'ORD => LAX => TUS (03/01/2008)' THEN 70
            WHEN NAME BETWEEN 'ORD => LAX => TUS (03/01/2008)~' AND 'ORF => DFW => SJC (24/01/2008)' THEN 71
            WHEN NAME BETWEEN 'ORF => DFW => SJC (24/01/2008)~' AND 'PDX => ATL => MEI (05/01/2008)' THEN 72
            WHEN NAME BETWEEN 'PDX => ATL => MEI (05/01/2008)~' AND 'PFN => MEM => DSM (15/02/2008)' THEN 73
            WHEN NAME BETWEEN 'PFN => MEM => DSM (15/02/2008)~' AND 'PHL => ORD => DTW (02/06/2008)' THEN 74
            WHEN NAME BETWEEN 'PHL => ORD => DTW (02/06/2008)~' AND 'PHX => IAH => CRP (16/06/2008)' THEN 75
            WHEN NAME BETWEEN 'PHX => IAH => CRP (16/06/2008)~' AND 'PIA => DFW => ATL (09/05/2008)' THEN 76
            WHEN NAME BETWEEN 'PIA => DFW => ATL (09/05/2008)~' AND 'PIT => ORD => FWA (14/03/2008)' THEN 77
            WHEN NAME BETWEEN 'PIT => ORD => FWA (14/03/2008)~' AND 'PSP => SLC => PIT (02/02/2008)' THEN 78
            WHEN NAME BETWEEN 'PSP => SLC => PIT (02/02/2008)~' AND 'RDM => PDX => MFR (07/04/2008)' THEN 79
            WHEN NAME BETWEEN 'RDM => PDX => MFR (07/04/2008)~' AND 'RDU => ORD => RAP (11/09/2008)' THEN 80
            WHEN NAME BETWEEN 'RDU => ORD => RAP (11/09/2008)~' AND 'RNO => DFW => TXK (19/06/2008)' THEN 81
            WHEN NAME BETWEEN 'RNO => DFW => TXK (19/06/2008)~' AND 'ROC => ORD => TYS (16/03/2008)' THEN 82
            WHEN NAME BETWEEN 'ROC => ORD => TYS (16/03/2008)~' AND 'SAN => BWI => MHT (11/04/2008)' THEN 83
            WHEN NAME BETWEEN 'SAN => BWI => MHT (11/04/2008)~' AND 'SAT => ATL => LIT (13/04/2008)' THEN 84
            WHEN NAME BETWEEN 'SAT => ATL => LIT (13/04/2008)~' AND 'SCE => ATL => BMI (25/04/2008)' THEN 85
            WHEN NAME BETWEEN 'SCE => ATL => BMI (25/04/2008)~' AND 'SEA => DEN => PIA (23/09/2008)' THEN 86
            WHEN NAME BETWEEN 'SEA => DEN => PIA (23/09/2008)~' AND 'SFO => BOS => PDX (07/04/2008)' THEN 87
            WHEN NAME BETWEEN 'SFO => BOS => PDX (07/04/2008)~' AND 'SGF => ATL => MLB (28/05/2008)' THEN 88
            WHEN NAME BETWEEN 'SGF => ATL => MLB (28/05/2008)~' AND 'SJC => LAX => AUS (22/09/2008)' THEN 89
            WHEN NAME BETWEEN 'SJC => LAX => AUS (22/09/2008)~' AND 'SLC => BNA => MCO (11/01/2008)' THEN 90
            WHEN NAME BETWEEN 'SLC => BNA => MCO (11/01/2008)~' AND 'SLC => SEA => PSP (21/05/2008)' THEN 91
            WHEN NAME BETWEEN 'SLC => SEA => PSP (21/05/2008)~' AND 'SMX => LAX => LAS (02/10/2008)' THEN 92
            WHEN NAME BETWEEN 'SMX => LAX => LAS (02/10/2008)~' AND 'SRQ => EWR => SLC (30/08/2008)' THEN 93
            WHEN NAME BETWEEN 'SRQ => EWR => SLC (30/08/2008)~' AND 'STL => PHX => OAK (21/04/2008)' THEN 94
            WHEN NAME BETWEEN 'STL => PHX => OAK (21/04/2008)~' AND 'TLH => MCO => PDX (16/06/2008)' THEN 95
            WHEN NAME BETWEEN 'TLH => MCO => PDX (16/06/2008)~' AND 'TPA => MEM => DFW (09/03/2008)' THEN 96
            WHEN NAME BETWEEN 'TPA => MEM => DFW (09/03/2008)~' AND 'TUL => ORD => LGB (25/09/2008)' THEN 97
            WHEN NAME BETWEEN 'TUL => ORD => LGB (25/09/2008)~' AND 'TWF => SLC => LAX (18/05/2008)' THEN 98
            WHEN NAME BETWEEN 'TWF => SLC => LAX (18/05/2008)~' AND 'XNA => ATL => ALB (15/05/2008)' THEN 99
            WHEN NAME BETWEEN 'XNA => ATL => ALB (15/05/2008)~' AND '~' THEN 100
      END AS TIER
FROM
(
      SELECT
             NAME
            ,launching_flight
            ,scheduled_launch
            ,landing_flight
            ,scheduled_landing
            ,total_mission_delayed_minutes
            ,RANK() OVER (PARTITION BY NAME ORDER BY total_mission_delayed_minutes ASC) AS route_best_match_rank
            ,LAUNCH_DAY
      FROM
      (
            SELECT
                   MISSIONS.NAME
                  ,concat(LAUNCHING.uniquecarrier, ' ', LAUNCHING.flightnum) AS launching_flight
                  ,LAUNCHING.crsdep_ts AS scheduled_launch
                  ,concat(LANDING.uniquecarrier, ' ', LANDING.flightnum) as landing_flight
                  ,LANDING.crsarr_ts AS scheduled_landing
                  ,(date_diff('minute', LAUNCHING.crsarr_ts, LAUNCHING.arr_ts) + date_diff('minute', LANDING.crsarr_ts, LANDING.arr_ts)) as total_mission_delayed_minutes
                  ,LAUNCH_DAY
            FROM MISSIONS
            JOIN completedflights AS LAUNCHING
                  ON  LAUNCHING.year = 2008
                  AND LAUNCHING.year = MISSIONS.YEAR
                  AND LAUNCHING.origin = MISSIONS.LAUNCH
                  AND LAUNCHING.dest = MISSIONS.RENDEZVOUS
                  AND LAUNCHING.crsdep_ts BETWEEN MISSIONS.LAUNCH_EARLIEST AND MISSIONS.LAUNCH_LATEST
                  AND day(LAUNCHING.crsdep_ts) = MISSIONS.LAUNCH_DAY
            JOIN completedflights AS LANDING
                  ON  LANDING.year = 2008
                  AND LANDING.year = MISSIONS.YEAR
                  AND LANDING.origin = MISSIONS.RENDEZVOUS
                  AND LANDING.dest = MISSIONS.LAND
                  AND LANDING.crsarr_ts BETWEEN MISSIONS.LAND_EARLIEST AND MISSIONS.LAND_LATEST
                  AND day(date_add('day', -2, LANDING.crsarr_ts)) = MISSIONS.LAUNCH_DAY
      ) AS MISSION_ROUTES
) AS MISSION_RESULT
WHERE route_best_match_rank = 1;