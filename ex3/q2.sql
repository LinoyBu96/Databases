select number, avg(startYear - birthYear) as avgAge
from knessets natural join memberInKnesset natural join members
group by number
order by number;