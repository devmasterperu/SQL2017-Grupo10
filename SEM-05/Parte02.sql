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

--05.04
select m.nombre,
(select count(1) from Ficha f where f.idmanzana=m.idmanzana) as TOTAL,
CASE 
WHEN (select count(1) from Ficha f where f.idmanzana=m.idmanzana) between 1 and 59 then 'Manzana con poco recorrido.'--MENSAJE
WHEN (select count(1) from Ficha f where f.idmanzana=m.idmanzana) between 60 and 99 then 'Manzana medianamente recorrida.'
WHEN (select count(1) from Ficha f where f.idmanzana=m.idmanzana)>=100 then 'Manzana con gran recorrido.'
else 'Sin fichas' end as MENSAJE
from Manzana m --CE
order by TOTAL desc

--05.05
select
t.usuario,
(select count(1) from Ficha f where f.idencuestador=t.idtrabajador) as TOTAL_U,
(select count(1) from Ficha) as TOTAL,
--ROUND(COLUMNA,REDONDEO)=>MILESIMO | => CENTESIMO
cast(round((select count(1) from Ficha f where f.idencuestador=t.idtrabajador)*100.000/(select count(1) from Ficha),2) as decimal(3,2))
as PORCENTAJE
from Trabajador as t 
where t.tipo='E'--CE

--05.07

--SUBCONSULTAS EN LA CLAUSULA SELECT
select
m.idmanzana as ID,
m.nombre as MANZANA,
--CI
(select count(1) from Ficha f where f.idmanzana=m.idmanzana) as TOTAL_FICHAS,
ISNULL((select MAX(f.montopago) from Ficha f where f.idmanzana=m.idmanzana),0.00) as MAXIMO_MOTPAGO,
ISNULL((select MIN(f.montopago) from Ficha f where f.idmanzana=m.idmanzana),0.00) as MINIMO_MOTPAGO,
ISNULL((select AVG(f.montopago) from Ficha f where f.idmanzana=m.idmanzana),0.00) as PROMEDIO_MOTPAGO
from Manzana as m --CE

--SUBCONSULTAS EN LA CLAUSULA FROM
select
m.idmanzana as ID,
m.nombre as MANZANA,
isnull(rm.TOTAL_FICHAS,0) as TOTAL_FICHAS,
isnull(rm.MAXIMO_MOTPAGO,0) as MAXIMO_MOTPAGO,
isnull(rm.MINIMO_MOTPAGO,0) as MINIMO_MOTPAGO,
isnull(rm.PROMEDIO_MOTPAGO,0) as PROMEDIO_MOTPAGO
from Manzana as m --CE
left join
--CI (TABLA DERIVADA)
(
select f.idmanzana,count(1) as TOTAL_FICHAS,MAX(f.montopago) MAXIMO_MOTPAGO,MIN(f.montopago) as MINIMO_MOTPAGO,
AVG(f.montopago) as PROMEDIO_MOTPAGO from Ficha as f
group by f.idmanzana
) as rm on m.idmanzana=rm.idmanzana




