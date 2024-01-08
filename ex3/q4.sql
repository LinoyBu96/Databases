with numberPartyCount(number, party, memberCount) as (
    select number, party, count(uid)
    -- for the same reason, no need count(distinct uid)
    from memberInKnesset
    group by number, party
)
select number, party, memberCount
-- as memberCount?
from numberPartyCount A
where memberCount = (
    select max(memberCount)
    from numberPartyCount B
    where A.number = B.number
)
order by number, party;

-- select number, party, memberCount
-- -- as memberCount?
-- from numberPartyCount A
-- group by number party -- actualy number party are kind of keys in numberPartyCount, so every group is 1 row
-- having 