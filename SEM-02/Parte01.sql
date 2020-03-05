--SEMANA 02
--2.0
--Entradas
declare @t1 int=1
declare @r int=2
declare @n int=6
--Salida
select 'tn'=@t1+(@n-1)*@r

create schema gmv

create table gmv.entrada
(
num1 int,
num2 int
)
--Inserción masiva con 1 INSERT INTO
insert into gmv.entrada
values (1,3),(5,7),(9,11)

select 
num1,num2,
num1+num2,
num2-num1,
num2*num1,
num2/num1,
num2%num1,
power(num1,2) as [Cuadrado],--Elevar al cuadrado
power(num1,3) as [Cubo],--Elevar al cubo
sqrt(num2) as [raiz_cuadrada],
PI() as [PI]
from gmv.entrada

--Uso de DISTINCT
select nom_dpto,nom_prov,nom_dto from Ubigeo
--select distinct nom_dpto,nom_prov from Ubigeo
select distinct nom_dpto,nom_prov,nom_dto from Ubigeo

--Uso de alias de columnas
select 
nom_dpto as DPTO,
nom_prov PROV,
'DTO'=nom_dto,
nom_dto [MI-DISTRITO]
from Ubigeo

--Uso de alias de tablas
select 
u.nom_dpto as DPTO,
u.nom_prov PROV,
'DTO'=nom_dto,
u.nom_dto [MI-DISTRITO]
--from Ubigeo u
from Ubigeo as u

--2.1
select nombre as MANZANA, 
case 
when estado=1 
	then 'Manzana activa' 
else
	'Manzana inactiva' 
end as ESTADO,
case idsector
when 1 then 'SECTOR_NOROESTE'
when 2 then 'SECTOR_NORESTE'
when 3 then 'SECTOR_SUROESTE'
when 4 then 'SECTOR_SURESTE'
end as SECTOR
from Manzana

--2.2

select nomsector as SECTOR,
estado,
case when estado=1 then 'El '+nomsector+' se encuentra activo'
else 'El '+nomsector+' se encuentra inactivo'
end as MENSAJE
from Sector

--Uso de ORDER BY
select idubigeo,idpersona from Persona
--order by idpersona desc
--order by 1 desc
--order by idubigeo desc, idpersona asc
order by nombres

--2.3
--select idubigeo,nom_dto from Ubigeo
select 
case when p.idtipo=1 then 'DNI' else 'OTRO' end as TIPO,
p.numdoc as NUMERO,
RTRIM(LTRIM(p.nombres)) as NOMBRES,
RTRIM(LTRIM(p.apellidos))	as APELLIDOS,
case 
when idubigeo=1 then 'HUACHO'
when idubigeo=2	then 'AMBAR'
when idubigeo=3	then 'CALETA DE CARQUIN'
when idubigeo=4	then 'CHECRAS'
when idubigeo=5	then 'HUALMAY'
when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO'
when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR'
when idubigeo=10 then 'SANTA MARÍA'
when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else 'OTRO' end as UBIGEO,
fecnacimiento
from Persona p
--order by LTRIM(nombres) ASC
--order by RTRIM(LTRIM(apellidos)) DESC
--order by RTRIM(LTRIM(nombres)) ASC,RTRIM(LTRIM(apellidos)) DESC
order by fecnacimiento ASC

--2.4
select 
case when p.idtipo=1 then 'DNI' else 'OTRO' end as TIPO,
p.numdoc as NUMERO,
RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) as NOMBRE_COMPLETO,
direccion,
case 
when idubigeo=1 then 'HUACHO'
when idubigeo=2	then 'AMBAR'
when idubigeo=3	then 'CALETA DE CARQUIN'
when idubigeo=4	then 'CHECRAS'
when idubigeo=5	then 'HUALMAY'
when idubigeo=6	then 'HUAURA'
when idubigeo=7	then 'LEONCIO PRADO'
when idubigeo=8	then 'PACCHO'
when idubigeo=9	then 'SANTA LEONOR'
when idubigeo=10 then 'SANTA MARÍA'
when idubigeo=11 then 'SAYAN'
when idubigeo=12 then 'VEGUETA'
else 'OTRO' end as UBIGEO,
idubigeo,
fecnacimiento
from Persona p
--Uso de IN
--where idubigeo=1 or idubigeo=3 or idubigeo=5
--where idubigeo in (1,3,5)
--Uso de BETWEEN
--where fecnacimiento>='1970-01-01' and fecnacimiento<='1970-12-31'
--where fecnacimiento NOT BETWEEN '1970-01-01' and '1970-12-31'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE 'A%'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '%ABA%'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '%AN'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE 'O%O'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '______ABA%'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '%M__'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '_E%E_'
--where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '[aeiou]%[aeiou]'
where RTRIM(LTRIM(p.nombres))+' '+RTRIM(LTRIM(p.apellidos)) LIKE '[^aeiou]%[^aeiou]'
order by idubigeo desc

