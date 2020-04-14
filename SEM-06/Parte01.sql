--USO DE UNION
select 1,2,3,5 --123
union
select 1,2,3,'ABC' --123
union
select 1,2,3,'DEF' --123
union 
select 1,2,4,null --124

--USO DE UNION ALL
select 1,2,3 --123
union all
select 1,2,3 --123
union all
select 1,2,3 --123
union all
select 1,2,4 --124

--06.01
--A
--Creación de VISTA utilizando CTE
alter view V_PERSONA_C 
as
WITH CTE_PERSONA_C AS
(
	select idtipo,numdoc,nombres,apellidos from Persona --997
	union all --combinaciones duplicadas
	select idtipo,numdoc,nombres,apellidos from PersonaCarga --505
)
select t.nombre,p.idtipo,p.numdoc,p.nombres,p.apellidos from CTE_PERSONA_C p
inner join TipoDocumento t on p.idtipo=t.idtipo
--order by p.idtipo,numdoc,nombres,apellidos
--Consulta a VISTA
select * from V_PERSONA_C
order by idtipo,numdoc,nombres,apellidos

--B
create view V_PERSONA_IR
as
WITH CTE_PERSONA_C AS
(
	select idtipo,numdoc,nombres,apellidos from Persona --997
	union  --combinaciones irrepetibles
	select idtipo,numdoc,nombres,apellidos from PersonaCarga --505
)
select t.nombre,p.idtipo,p.numdoc,p.nombres,p.apellidos from CTE_PERSONA_C p
inner join TipoDocumento t on p.idtipo=t.idtipo

select * from V_PERSONA_IR --930
order by idtipo,numdoc,nombres,apellidos

--C
--create function F_PERSONA_DETALLE
alter function F_PERSONA_DETALLE
(@idtipo int,@numdoc varchar(15)) returns table
as
return
	WITH CTE_PERSONA_C AS
	(
		select idtipo,numdoc,nombres,apellidos from Persona --997
		union  all
		select idtipo,numdoc,nombres,apellidos from PersonaCarga --505
	)
	select t.nombre,p.idtipo,p.numdoc,p.nombres,p.apellidos from CTE_PERSONA_C p
	inner join TipoDocumento t on p.idtipo=t.idtipo
	where p.idtipo=@idtipo and p.numdoc=@numdoc

	select * from F_PERSONA_DETALLE(1,'00488191')

--D
create function F_PERSONA_I() returns table
as
return
	WITH CTE_PERSONA_I AS
	(
		select idtipo,numdoc,nombres,apellidos from Persona --997
		intersect --común
		select idtipo,numdoc,nombres,apellidos from PersonaCarga --505
	)
	select t.nombre,p.idtipo,p.numdoc,p.nombres,p.apellidos from CTE_PERSONA_I p
	inner join TipoDocumento t on p.idtipo=t.idtipo

select * from F_PERSONA_I() --493

--Uso de JOIN x INTERSECT
select distinct p.idtipo,p.numdoc,p.nombres,p.apellidos from Persona p
inner join PersonaCarga pc on p.idtipo=pc.idtipo and p.numdoc=pc.numdoc and
p.nombres=pc.nombres and p.apellidos=pc.apellidos --493

--E
select idtipo,numdoc,nombres,apellidos from Persona --997
except --Quienes están en Persona pero no en PersonaCarga
select idtipo,numdoc,nombres,apellidos from PersonaCarga --505
		
create function F_PERSONA_E() returns table
as
return
	WITH CTE_PERSONA_E AS
	(
		select idtipo,numdoc,nombres,apellidos from PersonaCarga --505
		except --Quienes están en PersonaCarga pero no en Persona
		select idtipo,numdoc,nombres,apellidos from Persona --997
	)
	select t.nombre,p.idtipo,p.numdoc,p.nombres,p.apellidos from CTE_PERSONA_E p
	inner join TipoDocumento t on p.idtipo=t.idtipo

select * from F_PERSONA_E()

--06.02
--A
create view CTE_UBIGEO_C 
as
WITH CTE_UBIGEO_C AS
(
	select departamento,provincia,distrito from UbigeoCarga --1664
	union  --combinaciones irrepetibles
	select nom_dpto,nom_prov,nom_dto from Ubigeo --12
)
select departamento,provincia,distrito from CTE_UBIGEO_C 

select * from CTE_UBIGEO_C
order by departamento,provincia,distrito

--B

alter function F_UBIGEO_DETALLE
(@distrito varchar(100)) returns table
as
return
	WITH CTE_UBIGEO_C AS
	(
		select id,departamento,provincia,distrito from UbigeoCarga --1664
		union all --Incluye combinaciones duplicadas
		select idubigeo,nom_dpto,nom_prov,nom_dto from Ubigeo --12
	)
	select u.id,u.departamento,u.provincia,u.distrito from CTE_UBIGEO_C u
	where u.distrito=@distrito

	select * from F_UBIGEO_DETALLE('HUALMAY')

	select id,departamento,provincia,distrito from UbigeoCarga
	where distrito='HUALMAY'

