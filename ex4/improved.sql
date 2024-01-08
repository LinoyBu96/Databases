with max_estimated(year, max_estimated) as (
    select year, max(students5_estimated)
    from enrollment
    group by year
)
select distinct e1.year, e1.eng_name
from enrollment e1 natural join max_estimated
where students5_estimated = max_estimated
order by year, eng_name;