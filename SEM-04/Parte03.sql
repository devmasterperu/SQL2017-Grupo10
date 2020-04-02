--VALIDAR RESULTADOS
BEGIN TRAN
	DELETE FROM UnidadUso
	--WHERE (OBLIGATORIO)
ROLLBACK

--4.9
begin tran
	delete from UnidadUso 
	where idficha=100
rollback

--4.10
begin tran
	delete u 
	from UnidadUso u inner join
	Ficha f on u.idficha=f.idficha
	where f.idencuestador=23
rollback

select u.* 
from UnidadUso u inner join
Ficha f on u.idficha=f.idficha
where f.idencuestador=23

--4.11
create table UnidadUsoDel
(
idunidaduso int
)

delete top(5) u
--output deleted.idunidaduso into UnidadUsoDel
from UnidadUso u 
inner join Ficha f on u.idficha=f.idficha
inner join Manzana m on f.idmanzana=m.idmanzana
where m.idsector=1

select u.*,FLOOR(RAND()*(5-1+1))+1 as posicion
from UnidadUso u 
inner join Ficha f on u.idficha=f.idficha
inner join Manzana m on f.idmanzana=m.idmanzana
where m.idsector=1

select * from UnidadUsoDel

--4.13

select * from Persona where idpersona=100

create table Persona_Upd
(
idpersona int,
direccion_ant varchar(300),
direccion_nueva varchar(300),
fecnacimiento_ant date,
fecnacimiento_nuevo date
)
begin tran
	update p
	--Campos a modificar
	set  p.idubigeo=3,
		 p.direccion='URB. LOS CIPRESES M-25',
		 p.numdoc='22064382',
		 p.sexo='F',
		 p.fecnacimiento='1969-04-11'
	output inserted.idpersona,deleted.direccion,inserted.direccion,
	       deleted.fecnacimiento,inserted.fecnacimiento
	into Persona_Upd 
	from Persona p --Tabla actualizo
	where idpersona=100 --Condición
rollback

select * from Persona where idpersona=101
select * from Persona_Upd

