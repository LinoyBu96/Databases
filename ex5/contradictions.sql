SELECT DISTINCT A.Name, A.Author, A.Year
FROM bestsellers A, bestsellers B
WHERE A.Name = B.Name and (
    A.Author != B.Author or
    A.User_Rating != B.User_Rating or
    A.Reviews != B.Reviews or
    A.Price != B.Price OR
    A.Genre != B.Genre)
ORDER BY Name, Year;