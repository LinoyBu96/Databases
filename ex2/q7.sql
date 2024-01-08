SELECT DISTINCT number, name
FROM members A NATURAL JOIN memberInKnesset B
WHERE birthYear = (
    SELECT MIN(C.birthYear)
    FROM members C NATURAL JOIN memberInKnesset D
    WHERE B.number = D.number)
ORDER BY number, name;