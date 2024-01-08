SELECT DISTINCT name
FROM members A
WHERE birthPlace = 'Jerusalem' and 1 = (
    SELECT COUNT(distinct number)
    FROM members B NATURAL JOIN memberInKnesset C
    WHERE A.uid = B.uid
    )
ORDER BY name;

-- SELECT DISTINCT name
-- FROM members NATURAL JOIN memberInKnesset
-- WHERE birthPlace = 'Jerusalem'
-- GROUP BY uid
-- HAVING count(number) = 1
-- ORDER BY name;