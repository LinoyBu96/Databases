SELECT name, number
FROM members NATURAL JOIN memberInKnesset NATURAL JOIN knessets
WHERE startYear - birthYear > 70 and (party = 'Meretz' or party = 'Likud')
ORDER BY name, number;