--06.03
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

--06.05
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

--06.06
alter function F_REPORTE_X_TIPOCONSUMIDOR(@tipoconsumidor varchar(1)) returns table
as 
return
	select f.tipoconsumidor,f.idficha,f.numhabitantes,f.montopago,
		ROW_NUMBER() OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) as RN,
		RANK() OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) as RK,
		DENSE_RANK() OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) as DRK,
		NTILE(5) OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) as NTILE5,
		NTILE(10) OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) as NTILE10,
		NTILE(15) OVER(PARTITION BY f.tipoconsumidor ORDER BY f.montopago DESC) as NTILE15
	from Ficha f 
	where f.tipoconsumidor=case when @tipoconsumidor='T' then f.tipoconsumidor else @tipoconsumidor end


select * from F_REPORTE_X_TIPOCONSUMIDOR('T') ORDER BY tipoconsumidor,montopago DESC

--06.08
create function F_REPORTE_SECTOR(@idsector int) returns table
as return
	select idsector,nombre as MANZANA,rm.total,
	row_number() over (partition by m.idsector order by rm.total asc) as RN,
	lag(rm.total,1,0) over (partition by m.idsector order by rm.total asc) as LAG,
	lead(rm.total,1,0) over (partition by m.idsector order by rm.total asc) as LEAD,
	FIRST_VALUE(rm.total) over (partition by m.idsector order by rm.total asc) as FV,
	LAST_VALUE(rm.total) over (partition by m.idsector order by rm.total asc) as LV,
	LAST_VALUE(m.nombre) over (partition by m.idsector order by rm.total asc) as LVM
	from Manzana m
	left join
	(select idmanzana,count(1) as total from Ficha 
	group by idmanzana) rm on m.idmanzana=rm.idmanzana
	where rm.total>0 and idsector=case when @idsector=0 then idsector else @idsector end

	select * from F_REPORTE_SECTOR(4)
	order by  idsector,total asc
--06.09
  select SUBSTRING(nombres,1,10) --(CAMPO, POS_INICIO,LONGITUD)
  from Persona