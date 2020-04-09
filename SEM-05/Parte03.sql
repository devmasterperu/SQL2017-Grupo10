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