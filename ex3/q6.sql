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


-- with MenachemsBegins(uid) as (
--     select uid
--     from members
--     where name = 'Menachem Begin'
-- )
-- with recursive maxThree(uid, dist) as (
--     select uid, value(0)
--     from MenachemsBegins
--     union
--     select uid, dist + 1
--     from memberInKnesset A
--     where dist < 3 and exists (
--         select *
--         from memberInKnesset natural join maxThree B
--         where A.party = B.party and A.number = B.number and A.uid <> B.uid
--     )
-- )
-- select name
-- from members
-- where name uid not in maxThree