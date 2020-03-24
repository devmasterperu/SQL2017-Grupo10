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


