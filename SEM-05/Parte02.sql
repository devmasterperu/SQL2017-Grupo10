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


--05.02

select COUNT(1) TOTAL_E_S,
(select count(1) from Trabajador where tipo='E') TOTAL_E,
(select count(1) from Trabajador where tipo='S') TOTAL_S
from Trabajador

--05.03
--INFORMACIÓN EN MAYUSCULA
select t.usuario,
REPLACE(UPPER(RTRIM(LTRIM(p.nombres))),' ','_') as NOMBRES,
REPLACE(UPPER(RTRIM(LTRIM(p.apellidos))),' ','_') as APELLIDOS,
(select count(1) from Ficha f where f.idencuestador=t.idtrabajador)as TOTAL,--CI
CASE 
WHEN (select count(1) from Ficha f where f.idencuestador=t.idtrabajador) between 0 and 19 then 'Baja productividad'--MENSAJE
WHEN (select count(1) from Ficha f where f.idencuestador=t.idtrabajador) between 20 and 29 then 'Mediana productividad'
WHEN (select count(1) from Ficha f where f.idencuestador=t.idtrabajador)>=30 then 'Alta productividad'
else 'Sin fichas' end as MENSAJE
from Trabajador as t inner join persona as p on t.idpersona=p.idpersona--CE
where t.tipo='E'

--INFORMACIÓN EN MINUSCULA
select t.usuario,
REPLACE(LOWER(RTRIM(LTRIM(p.nombres))),' ','_') as NOMBRES,
REPLACE(LOWER(RTRIM(LTRIM(p.apellidos))),' ','_') as APELLIDOS,
(select count(1) from Ficha f where f.idencuestador=t.idtrabajador)as TOTAL,--CI
CASE 
WHEN (select count(1) from Ficha f where f.idencuestador=t.idtrabajador) between 0 and 19 then 'Baja productividad'--MENSAJE
WHEN (select count(1) from Ficha f where f.idencuestador=t.idtrabajador) between 20 and 29 then 'Mediana productividad'
WHEN (select count(1) from Ficha f where f.idencuestador=t.idtrabajador)>=30 then 'Alta productividad'
else 'Sin fichas' end as MENSAJE
from Trabajador as t inner join persona as p on t.idpersona=p.idpersona--CE
where t.tipo='E'
