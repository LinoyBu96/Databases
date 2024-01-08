SELECT DISTINCT name, party
FROM members NATURAL JOIN memberInKnesset
WHERE number=1
ORDER BY name, party;