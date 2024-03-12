with recursive maxThree(uid, dist) as (
    select uid, 0
    from members
    where name = 'Menachem Begin'
    union
    select A.uid, dist + 1
    from memberInKnesset A, maxThree B natural join memberInKnesset C
    where dist < 3 and A.uid != B.uid and A.party = C.party and A.number=C.number
)
select name
from members
where uid in (select uid
    from members
    except
    select uid
    from maxThree)
order by name;
