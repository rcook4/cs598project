select * from
(
  select 'CMI' as g2q1, 'SFO' as g2q2, 'CMI=>ORD' as g2q3, 'LAX => ORD => JFK (01/01/2008)' as g3q2
  union all
  select 'BWI' as g2q1, 'IAH' as g2q2, 'IND=>CMH' as g2q3, 'DFW => ORD => DFW (10/06/2008)' as g3q2
  union all
  select 'MIA' as g2q1, 'LAX' as g2q2, 'DFW=>IAH' as g2q3, 'LAX => SFO => PHX (12/07/2008)' as g3q2
  union all
  select 'LAX' as g2q1, 'MIA' as g2q2, 'LAX=>SFO' as g2q3, 'SLC => BFL => LAX (01/04/2008)' as g3q2
  union all
  select 'IAH' as g2q1, 'BWI' as g2q2, 'JFK=>LAX' as g2q3, 'JAX => DFW => CRP (09/09/2008)' as g3q2
  union all
  select 'SFO' as g2q1, 'CMI' as g2q2, 'ATL=>PHX' as g2q3, 'CMI => ORD => LAX (04/03/2008)' as g3q2
) as demo
TABLESAMPLE BERNOULLI(34)
