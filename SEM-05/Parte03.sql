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

--05.12
--TOTAL POR ENCUESTADOR
	select idencuestador,count(1) as totfichas from Ficha group by idencuestador
--PROMEDIO: 
	select AVG(re.totfichas) 
	from (select idencuestador,count(1) as totfichas from Ficha group by idencuestador) re
--SUBCONSULTAS
select 
t.idtrabajador as ID_ENCUESTADOR,
(select count(1) from Ficha f where f.idencuestador=t.idtrabajador) as TOT_FICHAS,
(	select AVG(re.totfichas) from 
	(select idencuestador,count(1) as totfichas from Ficha group by idencuestador) re
) as TOTAL_PROM
from Trabajador t
where --TOT_FICHAS
	  (select count(1) from Ficha f where f.idencuestador=t.idtrabajador)>
	  --TOTAL_PROM
	  (	select AVG(re.totfichas) from 
		(select idencuestador,count(1) as totfichas from Ficha group by idencuestador) re
	  )
and t.tipo='E'
--CTES
WITH CTE_RE AS
(
	select idencuestador,count(1) as totfichas from Ficha group by idencuestador
)
select 
t.idtrabajador as ID_ENCUESTADOR,
(select count(1) from Ficha f where f.idencuestador=t.idtrabajador) as TOT_FICHAS,
(select AVG(totfichas) from CTE_RE) as TOTAL_PROM
from Trabajador t
where --TOT_FICHAS
	  (select count(1) from Ficha f where f.idencuestador=t.idtrabajador)>
	  --TOTAL_PROM
	  (select AVG(totfichas) from CTE_RE)
and t.tipo='E'

--VISTAS
create view dbo.V_ReporteEncuestador
as
	WITH CTE_RE AS
	(
		select idencuestador,count(1) as totfichas from Ficha group by idencuestador
	)
	select 
	t.idtrabajador as ID_ENCUESTADOR,
	(select count(1) from Ficha f where f.idencuestador=t.idtrabajador) as TOT_FICHAS,
	(select AVG(totfichas) from CTE_RE) as TOTAL_PROM
	from Trabajador t
	where --TOT_FICHAS
		  (select count(1) from Ficha f where f.idencuestador=t.idtrabajador)>
		  --TOTAL_PROM
		  (select AVG(totfichas) from CTE_RE)
	and t.tipo='E'
	--Utilizar una VISTA
	select * from dbo.V_ReporteEncuestador

--FUNCIONES DE VALOR TABLA
--Encapsula una lógica para su reutilización
create function F_TOTFICHAS(@idencuestador int) returns table
as
return 
	select count(1) as totfichas from Ficha f where f.idencuestador=@idencuestador

select * from F_TOTFICHAS(1)
--Modificar vista para incluir función
alter view dbo.V_ReporteEncuestador
as
	WITH CTE_RE AS
	(
		select idencuestador,count(1) as totfichas from Ficha group by idencuestador
	)
	select 
	t.idtrabajador as ID_ENCUESTADOR,
	(select totfichas from F_TOTFICHAS(t.idtrabajador))as TOT_FICHAS,
	(select AVG(totfichas) from CTE_RE) as TOTAL_PROM
	from Trabajador t
	where (select totfichas from F_TOTFICHAS(t.idtrabajador))>
		  (select AVG(totfichas) from CTE_RE)
	and t.tipo='E'
	
	--Utilizar una VISTA (Incluye SUBCONSULTAS|CTE|FUNCION VALOR TABLA)
	select * from dbo.V_ReporteEncuestador
	order by TOT_FICHAS desc

--05.14

select 
t.usuario,
t.contrasena,
t.estado,
EOMONTH(getdate()) as CIERRE
from Trabajador t
where exists (select 1 from Ficha f where f.idencuestador=t.idtrabajador)
