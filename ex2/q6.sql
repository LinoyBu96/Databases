SELECT DISTINCT name
FROM members A
WHERE NOT EXISTS (
    SELECT D.number 
    FROM members C NATURAL JOIN memberInKnesset D
    WHERE C.name = 'David Ben-Gurion' and D.party = 'Mapai'
    EXCEPT
    SELECT F.number 
    FROM members E NATURAL JOIN memberInKnesset F
    WHERE E.uid = A.uid and F.party = 'Mapai'
    )
ORDER BY name;
