SELECT d1.name AS n1, d2.name AS n2
FROM donors d1, donors d2
WHERE d1.cause = d2.cause and d1.name < d2.name
GROUP BY n1, n2
HAVING COUNT(DISTINCT d1.cause) = (
  select count(distinct A.cause)
  from donors A
  where A.name=d1.name)
  -- means there are no cause for n1 that is not shared with n2
  and COUNT(DISTINCT d2.cause) = (
    select count(distinct A.cause)
    from donors A
    where A.name=d2.name)
ORDER BY n1, n2;
