--05.01

select count(1) from Ficha --TOTAL-FICHAS
select count(1) from Ficha where tipoconsumidor='G' --TOTAL-G
select count(1) from Ficha where tipoconsumidor='M' --TOTAL-M
select count(1) from Ficha where tipoconsumidor='P' --TOTAL-P

--CE
select 
count(1) as [TOTAL-FICHAS], --CI
(select count(1) from Ficha where tipoconsumidor='G') as [TOTAL-G],
(select count(1) from Ficha where tipoconsumidor='M') as [TOTAL-M],
(select count(1) from Ficha where tipoconsumidor='P') as [TOTAL-P]
from Ficha  

--SQL (NO) TSQL (SI)
select 
(select count(1) from Ficha) as [TOTAL-FICHAS], --CI
(select count(1) from Ficha where tipoconsumidor='G') as [TOTAL-G],--CI
(select count(1) from Ficha where tipoconsumidor='M') as [TOTAL-M],--CI
(select count(1) from Ficha where tipoconsumidor='P') as [TOTAL-P]--CI
