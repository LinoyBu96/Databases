with loyalUid(uid) as (
    select uid
    from memberInKnesset
    group by uid
    having count(distinct party) = 1 and count(number) >= 5
)
-- if party == 1, no need for distinct in number, as the three together are primary key.
select name
from loyalUid natural join members
order by name;

-- !! what if there are different members (uid) with the same name?

-- group by uid, name and not group by uid, because then we can't select name ?

-- select name
-- from memberInKnesset natural join members
-- group by uid
-- having count(distinct number) >= 5 and count(distinct party) = 1
-- order by name;