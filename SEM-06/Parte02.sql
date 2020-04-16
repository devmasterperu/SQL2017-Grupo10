--6.3
alter function F_REPORTE() returns table
as
return
select idficha,numhabitantes,m.nombre as NOM_MZA,
count(idficha) OVER(PARTITION BY m.nombre) as MZA_NUM_FICHAS,
sum(numhabitantes) OVER(PARTITION BY m.nombre) as MZA_TOT_HABITANTES,
max(numhabitantes) OVER(PARTITION BY m.nombre) as MAX_TOT_HABITANTES,
min(numhabitantes) OVER(PARTITION BY m.nombre) as MIN_TOT_HABITANTES,
avg(numhabitantes) OVER(PARTITION BY m.nombre) as PROM_TOT_HABITANTES
from ficha f inner join Manzana m on f.idmanzana=m.idmanzana

select * from F_REPORTE() order by NOM_MZA

select idencuestador,count(1),idmanzana from Ficha group by idencuestador,idmanzana

--6.5
create function F_REPORTE_M(@idmanzana int) returns table
as
return
	select m.nombre as MANZANA, f.idficha, f.numhabitantes,
	ROW_NUMBER() OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes) as RN,
	RANK() OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes) as RK,
	DENSE_RANK() OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes) as DRK,
	NTILE(4) OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes) as NTILE4
	from ficha f inner join Manzana m on f.idmanzana=m.idmanzana
	where f.idmanzana=case when @idmanzana=0 then f.idmanzana else @idmanzana end
	--order by MANZANA, numhabitantes

select * from F_REPORTE_M(2)