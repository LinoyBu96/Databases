SELECT DISTINCT name
FROM members NATURAL JOIN memberInKnesset 
WHERE gender = 'female' and occupation != 'politician' and uid IN (
    SELECT DISTINCT uid
    FROM members A NATURAL JOIN memberInKnesset B
    WHERE number = 23
) and uid IN (
    SELECT DISTINCT uid
    FROM members A NATURAL JOIN memberInKnesset B
    WHERE number = 24
)
ORDER BY name;