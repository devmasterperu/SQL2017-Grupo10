--3.1 
--select count(1) from Sector--4
--select count(1) from Manzana--16
--a
select 
s.nomsector as SECTOR,
m.nombre as MANZANA,
m.estado
from Sector s cross join Manzana m
--b
--select count(1) from Sector--4
--select count(1) from Manzana where estado=1--13
select 
s.nomsector as SECTOR,
m.nombre as MANZANA,
m.estado
from Sector s cross join Manzana m
where m.estado=1
--c
--select count(1) from Sector--4
--select count(1) from Manzana where estado=1 and nombre like '001%'--6
--select count(1) from Ubigeo --6
select 
s.nomsector as SECTOR,
m.nombre as MANZANA,
m.estado--,
--u.cod_dpto
from Sector s 
cross join Manzana m
--cross join Ubigeo u
where m.estado=1 and m.nombre like '001%'

--3.2

select
p.idtipo as [TIPO-DOC],
p.numdoc as [NUM-DOC],
LTRIM(p.nombres)+' '+LTRIM(p.apellidos) as [NOMBRE-COMPLETO],
u.nom_dto as [UBIGEO]
from Persona p inner join Ubigeo u on p.idubigeo=u.idubigeo

--3.3

select
m.nombre as [NOM-MANZANA],
s.nomsector as [NOM-SECTOR],
concat('Mi ID en la tabla Manzana es ',m.idmanzana) as MENSAJE
from Manzana m
inner join Sector s on m.idsector=s.idsector
where m.estado=1

--3.4

select CONVERT(VARCHAR(8),GETDATE(),112)
select CONVERT(VARCHAR(8),isnull(NULL,getdate()),112)

select
m.nombre as NOMBRE_MANZANA,
concat(ltrim(p.nombres),' ',ltrim(p.apellidos)) as [NOMBRE-COMPLETO-ENCUESTADOR],
a.idsupervisor as 'ID-SUPERVISOR',
CONVERT(VARCHAR(8),fecinicio,112) as FECINICIO,
CONVERT(VARCHAR(8),GETDATE(),112) as FECFIN
from 
--NOMBRE_MANZANA
Asignacion a
inner join Manzana m on a.idmanzana=m.idmanzana
--NOMBRE-COMPLETO-ENCUESTADOR
inner join Trabajador t on a.idencuestador=t.idtrabajador
inner join Persona p on t.idpersona=p.idpersona
where 
CONVERT(VARCHAR(8),GETDATE(),112) --HOY
between CONVERT(VARCHAR(8),fecinicio,112) and --FECINICIO
	    CONVERT(VARCHAR(8),isnull(fecfin,getdate()),112) --FECFIN



