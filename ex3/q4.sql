with numberPartyCount(number, party, memberCount) as (
    select number, party, count(uid)
    from memberInKnesset
    group by number, party
)
select number, party, memberCount
from numberPartyCount A
where memberCount = (
    select max(memberCount)
    from numberPartyCount B
    where A.number = B.number
)
order by number, party;
