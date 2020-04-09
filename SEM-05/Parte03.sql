--05.08

--06/04 (min)

--08/04 (max)

--A.SUBCONSULTAS EN SELECT
select
u.nom_dpto as DPTO,
u.nom_prov as PROV,
u.nom_dto as DTO,
(select count(1) from Persona p where p.idubigeo=u.idubigeo) as TOTAL,--CI
--(select max(fecnacimiento) from Persona p where p.idubigeo=u.idubigeo) as NACIMIENTO,
DAY((select max(fecnacimiento) from Persona p where p.idubigeo=u.idubigeo)) as DIA_NACIMIENTO,--CI
MONTH((select max(fecnacimiento) from Persona p where p.idubigeo=u.idubigeo)) as MES_NACIMIENTO,--CI
YEAR((select max(fecnacimiento) from Persona p where p.idubigeo=u.idubigeo)) as AÑO_NACIMIENTO--CI
from Ubigeo u --CE

--B.SUBCONSULTAS EN FROM

select
u.nom_dpto as DPTO,
u.nom_prov as PROV,
u.nom_dto as DTO,
ru.TOTAL as TOTAL,--CI
DAY(ru.MAXFECNACIMIENTO) as DIA_NACIMIENTO,--CI
MONTH(ru.MAXFECNACIMIENTO) as MES_NACIMIENTO,--CI
YEAR(ru.MAXFECNACIMIENTO) as AÑO_NACIMIENTO--CI
from Ubigeo u --CE
left join
(
select idubigeo,count(1) as TOTAL,max(fecnacimiento) as MAXFECNACIMIENTO from Persona
group by idubigeo
) ru on u.idubigeo=ru.idubigeo

--C. CONSULTA CON CTE

WITH CTE_RU --NOMBRE_CTE 
AS
( 
	select idubigeo,count(1) as TOTAL,max(fecnacimiento) as MAXFECNACIMIENTO from Persona
	group by idubigeo --CONSULTA_INTERNA
) --CONSULTA_EXTERNA
select
	u.nom_dpto as DPTO,
	u.nom_prov as PROV,
	u.nom_dto as DTO,
	CTE_RU.TOTAL as TOTAL,--CI
	DAY(CTE_RU.MAXFECNACIMIENTO) as DIA_NACIMIENTO,--CI
	MONTH(CTE_RU.MAXFECNACIMIENTO) as MES_NACIMIENTO,--CI
	YEAR(CTE_RU.MAXFECNACIMIENTO) as AÑO_NACIMIENTO--CI
	from Ubigeo u --CE
left join CTE_RU on u.idubigeo=CTE_RU.idubigeo
--left join CTE_RU ru on u.idubigeo=ru.idubigeo

--05.09
WITH 
CTE_RFM --NOMBRE_CTE
AS (select idmanzana,count(1) as totfichas from Ficha group by idmanzana),--CI
CTE_RAM
AS (select idmanzana,count(1) as totasignaciones from Asignacion group by idmanzana)--CI
select --CE
m.idmanzana as ID,
m.nombre as MANZANA,
(select count(1) from Ficha) as TOTAL_FICHAS,
isnull(rfm.totfichas,0) as TOTAL_FICHAS_MZA,
(select count(1) from Asignacion) as TOTAL_ASIGNA,
isnull(ram.totasignaciones,0) as TOTAL_ASIGNA_MZA
from Manzana m
left join CTE_RFM as rfm on m.idmanzana=rfm.idmanzana
left join CTE_RAM as ram on m.idmanzana=ram.idmanzana

--05.10

--PROMEDIO: 
--1. select AVG(montopago) from Ficha
--2. Relación de clientes

--CE
select 
f.tipoconsumidor as TIPO,
concat(p.nombres,' ',p.apellidos) as CLIENTE,
f.montopago as MTOPAGO,
cast(ROUND((select AVG(montopago) from Ficha),2) as decimal(4,2)) as MTOPAGOPROM
from Ficha f 
inner join Cliente c on f.idcliente=c.idcliente
inner join Persona p on c.idpersona=p.idpersona
where f.montopago>cast(ROUND((select AVG(montopago) from Ficha),2) as decimal(4,2))--CI
--where f.montopago>75.73
order by CLIENTE,montopago desc