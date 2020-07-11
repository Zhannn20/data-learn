

-- Returned
select coalesce(returned, 'No'), round((sum(o.sales)/(select sum(sales) from orders) * 100),2) as Итого
from orders o left join (select order_id, returned from returns1
group by order_id, returned) as qq
on o.order_id = qq.order_id
group by returned 
order by Итого desc;


-- RegionSales

select region, round(sum(sales)/(select sum(sales) from orders)*100,2)
from orders
group by region
order by region;


-- по штатам
select country, state, sum(sales)
from orders
group by country, state
order by state;

-- Sparklines Pivot

select Extract(year from order_date) as Год, extract(month from order_date) as Месяц , round(sum(sales),2) sales, round(sum(profit),2)
profit , round(sum(profit)/sum(sales)*100,2),round(avg(discount),5) discount
from orders
group by Extract(year from order_date) , extract(month from order_date)
order by Год, Месяц;


--or 

select Extract(year from order_date) as Год, to_char(order_date, 'month' ) as Месяц , sum(sales), sum(profit), avg(discount)
from orders
group by Extract(year from order_date), to_char(order_date, 'month' )
order by Год;

-- Segments Dynamic Pivot

select Extract(year from order_date) as Год, extract(month from order_date) as Месяц, segment, round(sum(sales),0)
from orders
group by Extract(year from order_date), extract(month from order_date), segment
order by Год, Месяц, segment;
 
 --or 

select Extract(year from order_date) as Год, segment, round(sum(sales),0)
from orders
group by Extract(year from order_date), segment
order by Год, segment;


-- Segments Pivot
Select segment, round(sum(sales),0) as sales, round(sum(profit),0) as profit
from orders
group by segment;

--Manager Pivot

select person, round(sum(sales),0) as sales,  round(sum(profit),0) as profit
from people pl inner join orders o
on pl.region = o.region
group by person
order by sales;