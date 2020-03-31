--3.11
--select * from Asignacion
--where idmanzana=99

--select * from Manzana
--where idmanzana=99

--select Manzana, idsector, idencuestador, fecinicio, fecfin
--from Asignacion A left join Manzana M ON A.
--WHERE M.estado=1

select isnull(m.nombre,'-') as MANZANA, isnull(m.idsector,0) as ID_SECTOR,
a.idencuestador,a.idmanzana,ISNULL(a.fecinicio,'9999-12-31') as FEC_INICIO,
ISNULL(a.fecfin,'9999-12-31') as FEC_FIN
from Manzana m right join Asignacion a on m.idmanzana=a.idmanzana
--where m.estado=1

