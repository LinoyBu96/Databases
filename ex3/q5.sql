with femaleCount(party, number, fCount) as (
    select party, number, count(*)
    from members natural join memberInKnesset
    -- group by party, number, gender
    -- having gender = 'female'
    where gender = 'female'
    group by party, number
),
allCount(party, number, aCount) as (
    select party, number, count(*)
    -- count(*) is fine because there are no null in gender column, otherwise count(gender) 
    -- if I did "from members natural join memberInKnesset"
    -- changed to "from memberInKnesset" and uid is key, therefore not nulls.
    from memberInKnesset
    group by party, number
)
select party, number, fCount * 100 / aCount as femalePercent
from femaleCount natural join allCount
where fCount * 100 / aCount >= 30
order by party, number;

-- feels naive, retry!!!
