--SEMANA 3.2
--LEFT JOIN
--trabajador (LI) --PREVALECE
--asignacion (LD)
--3.6
select
t.usuario as USUARIO,
t.idtrabajador as ID_ENCUESTADOR1,
--a.idencuestador as ID_ENCUESTADOR2
ISNULL(a.idmanzana,0) as ID_MANZANA,
ISNULL(a.fecinicio,'9999-12-31') as FEC_INICIO,
ISNULL(a.fecfin,'9999-12-31') as FEC_FIN,
t.estado,
t.tipo
from Trabajador t
left join Asignacion a on t.idtrabajador=a.idencuestador --and a.idmanzana=4--and t.estado=1 and t.tipo='E' --[52]
--where t.estado=1 and t.tipo='E' [42]
where a.idmanzana=4--3

--3.7
select 
nombre,
case estado when 1 then 'ACTIVO' when 0 then 'INACTIVO' END AS ESTADO,
idsector,
ISNULL(idencuestador,0) AS IDENCUESTADOR
from 
Manzana m --TI (PREVALECER)
left join Asignacion a --TD
on m.idmanzana=a.idmanzana
order by idencuestador desc

--3.8

select
t.usuario as USUARIO,
t.idtrabajador as ID_ENCUESTADOR,
CONCAT(p.nombres,' ',p.apellidos) AS NOMBRE_COMPLETO,
ISNULL(a.idmanzana,0) as ID_MANZANA,
ISNULL(a.fecinicio,'9999-12-31') as FEC_INICIO,
ISNULL(a.fecfin,'9999-12-31') as FEC_FIN,
t.estado,
t.tipo
from Trabajador t
inner join Persona p on t.idpersona=p.idpersona
left join Asignacion a on t.idtrabajador=a.idencuestador
where t.estado=1 and t.tipo='E'

--3.9
select 
usuario,
p.nombres+''+p.apellidos as NOMBRE_COMPLETO,
ISNULL(m.nombre,'0000') as MANZANA,
ISNULL(a.fecinicio,'9999-12-31') as FEC_INICIO,
ISNULL(a.fecfin,'9999-12-31') as FEC_FIN
from Trabajador t --TI (PREVALECE)
left join Asignacion a on t.idtrabajador=a.idencuestador --TD
--NOMBRE_COMPLETO
left join Persona p on p.idpersona=t.idpersona
--MANZANA
left join Manzana m on m.idmanzana=a.idmanzana
where t.estado=1 and t.tipo='E'
order by usuario desc

select * from Trabajador t
where t.estado=1 and t.tipo='E'

--3.10
--Trabajador (TI)
--Asignacion (TD) (PREVALECE)

select
isnull(t.usuario,'-') as USUARIO,
case when t.idpersona is null then '-' else concat('P',t.idpersona) end as ID_PERSONA,
--t.idtrabajador,
a.idencuestador,
a.idmanzana,
ISNULL(a.fecinicio,'9999-12-31') as FEC_INICIO,
ISNULL(a.fecfin,'9999-12-31') as FEC_FIN
from Trabajador t
right join Asignacion a on t.idtrabajador=a.idencuestador
