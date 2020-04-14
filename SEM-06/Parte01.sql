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