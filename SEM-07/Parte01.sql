--SEMANA 07
--07.02
--Procedimiento almacenado
alter procedure usp_calcula_TN_MV--usp(Estándar)
(@t1 bigint,@r int,@n int)--parametros de entrada
as
begin
	declare @tn bigint=(select @t1*power(@r,@n-1))
	select @tn as TN

	--select 'TN'=(select @t1*power(@r,@n-1))
end

execute usp_calcula_TN_MV @t1=1,@r=2,@n=20

--07.03
--A. Número de páginas
--Total de personas registradas: conocido=> No es un parámetro
create function uf_num_paginas(@tampag int) returns int
as
begin
    --@resto=@num_personas/@tampag
	declare @resto int=(select count(1) from Persona)%@tampag

	declare @totpag int=(select case when @resto>0 
								then (select count(1) from Persona)/@tampag+1
								else (select count(1) from Persona)/@tampag
								end
						)
	return @totpag

end

select count(1) from Persona --997
select dbo.uf_num_paginas(10)--997/10+1 => 100 páginas

--B. Reporte de personas
create procedure usp_reporte_persona(@tampag int,@numpag int)
as
begin 
    --Generar posiciones.Ejemplo: 947 REGISTROS=> POS: 1,2,3...947 [1 partición]
	--select row_number() over (order by LTRIM(p.nombres)+' '+LTRIM(p.apellidos)) as POSICION,
	--LTRIM(p.nombres)+' '+LTRIM(p.apellidos) as [NOMBRE_COMPLETO]
	--from Persona p
	--order by [NOMBRE_COMPLETO]
	--offset 0 rows
	--fetch next 5 rows only

	--select row_number() over (order by LTRIM(p.nombres)+' '+LTRIM(p.apellidos)) as POSICION,
	--LTRIM(p.nombres)+' '+LTRIM(p.apellidos) as [NOMBRE_COMPLETO]
	--from Persona p
	--order by [NOMBRE_COMPLETO]
	--offset 5 rows
	--fetch next 5 rows only

	--select row_number() over (order by LTRIM(p.nombres)+' '+LTRIM(p.apellidos)) as POSICION,
	--LTRIM(p.nombres)+' '+LTRIM(p.apellidos) as [NOMBRE_COMPLETO]
	--from Persona p
	--order by [NOMBRE_COMPLETO]
	--offset 10 rows
	--fetch next 5 rows only

	select row_number() over (order by LTRIM(p.nombres)+' '+LTRIM(p.apellidos)) as POSICION,
	LTRIM(p.nombres)+' '+LTRIM(p.apellidos) as [NOMBRE_COMPLETO]
	from Persona p
	order by [NOMBRE_COMPLETO]
	offset @tampag*(@numpag-1) rows --@tampag=5|@numpag=1|offset 0-@tampag=5|@numpag=2|offset 5
	fetch next @tampag rows only --@tampag
end

execute usp_reporte_persona @tampag=5,@numpag=1
execute usp_reporte_persona @tampag=5,@numpag=2
execute usp_reporte_persona @tampag=5,@numpag=3
execute usp_reporte_persona @tampag=10,@numpag=2

--07.04
--Parametrizar RUC y RAZON_SOCIAL
create table Parametro
(
variable varchar(100),
valor varchar(max)
)
insert into Parametro values ('RAZON_SOCIAL','DEV MASTER PERU S.A.C'),('RUC','20602275320')

create procedure usp_detalle_ficha(@idficha int)
as
begin
    --DATOS_GENERALES
	select 
	(select valor from Parametro where variable='RAZON_SOCIAL') as RAZON_SOCIAL,
	(select valor from Parametro where variable='RUC') as RUC_EMPRESA,
	getdate() as CONSULTA_AL

	--DATOS_CLIENTE
	select LTRIM(p.nombres)+' '+LTRIM(p.apellidos) as [NOMBRE_COMPLETO],direccion, montopago
	from Ficha f inner join Cliente c on f.idcliente=c.idcliente
	inner join Persona p on c.idpersona=p.idpersona
	where idficha=@idficha

	--UNIDADES_USO
	select ROW_NUMBER() OVER(ORDER BY idunidaduso asc) as #UNIDAD,--III
		   descripcion,
		   categoria,
		   idficha
	from   UnidadUso --I
	where  idficha=@idficha --II

end

execute usp_detalle_ficha @idficha=3

--07.05
--@nombre='0100',@estado=0,@idsector=1 
create procedure usp_insmanzana(@nombre char(4),@estado bit,@idsector int)
as
begin
	declare @idmanzana int, @mensaje varchar(max)
	if not exists(select 1 from Manzana where nombre=@nombre)--0100
	begin
		insert into Manzana(nombre,estado,idsector)
		values(@nombre,@estado,@idsector)

		set @mensaje='Manzana insertada'
		set @idmanzana=IDENT_CURRENT('Manzana')

	end
	else
	begin
		set @mensaje='Manzana con nombre existente'
		set @idmanzana=0
	end

	select @mensaje as MENSAJE, @idmanzana as MANZANA
end

execute usp_insmanzana @nombre='0100',@estado=0,@idsector=1 --OK
execute usp_insmanzana @nombre='0100',@estado=0,@idsector=1 --NO_OK

--07.06

create procedure usp_insuniuso(@desc varchar(40),@categoria char(3),@idficha int)
as
begin
	declare @iduniuso int, @mensaje varchar(max)
	
	if not exists(select 1 from UnidadUso where descripcion=@desc and idficha=@idficha)
	begin
		insert into UnidadUso(descripcion,categoria,idficha)
		values(@desc,@categoria,@idficha)

		set @mensaje='Unidad de uso insertada'
		set @iduniuso=IDENT_CURRENT('UnidadUso')
	end
	else
	begin
		set @mensaje='Unidad de uso con descripción existente en ficha'
		set @iduniuso=0
	end

	select @mensaje as MENSAJE, @iduniuso as MANZANA

end

select * from UnidadUso where idficha=3

execute usp_insuniuso @desc='VIVIENDA 4TO PISO',@categoria='DOM',@idficha=3 --ok

--07.07
--@idencuestador=0,@idmanzana=0,@fecinicio='2020-04-20',@fecfin=null,@idsupervisor=0
create procedure usp_actualiza_asignacion
(
@idencuestador int,@idmanzana int,--Identificar registro o fila
@fecinicio date, @fecfin date, @idsupervisor int --nuevos valores
)
as
begin
	declare @mensaje varchar(max)
	--Si existe asignación
	if exists(select 1 from Asignacion where idencuestador=@idencuestador and idmanzana=@idmanzana)
	begin 
		update a
		set    --Nuevos valores
		       a.fecinicio=@fecinicio,
		       a.fecfin=@fecfin,
			   a.idsupervisor=@idsupervisor
		from  Asignacion a
		where a.idencuestador=@idencuestador and a.idmanzana=@idmanzana --Identificar registro o fila

		set @mensaje='Asignación actualizada'
	end
	--Si no encuentro la asignación	
	else
	begin
		set @mensaje='Asignación no identificada'
	end

	select @mensaje as MENSAJE,@idencuestador as ENCUESTADOR, @idencuestador as MANZANA
end

execute usp_actualiza_asignacion @idencuestador=0,@idmanzana=0,@fecinicio='2020-04-20',@fecfin=null,@idsupervisor=0--no_ok
select * from Asignacion
execute usp_actualiza_asignacion @idencuestador=11,@idmanzana=2,@fecinicio='2020-04-20',@fecfin=null,@idsupervisor=10
select * from Asignacion where idencuestador=11 and idmanzana=2