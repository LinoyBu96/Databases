with femaleCount(party, number, fCount) as (
    select party, number, count(*)
    from members natural join memberInKnesset
    where gender = 'female'
    group by party, number
),
allCount(party, number, aCount) as (
    select party, number, count(*)
    from memberInKnesset
    group by party, number
)
select party, number, fCount * 100 / aCount as femalePercent
from femaleCount natural join allCount
where fCount * 100 / aCount >= 30
order by party, number;
