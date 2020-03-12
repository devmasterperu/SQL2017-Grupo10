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