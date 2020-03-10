--2.4
--Uso de AND
select direccion,idubigeo from Persona
where 
direccion like 'A%' --EXP1
and
idubigeo in (7,8,9,10)--EXP2
--Uso de OR
select concat(ltrim(nombres),' ',ltrim(apellidos)) as ncompleto,
idubigeo from Persona
where 
concat(ltrim(nombres),' ',ltrim(apellidos))  like 'E%' --EXP1
or
idubigeo in (8,9,10)--EXP2
order by ncompleto
--Uso AND y OR
select concat(ltrim(nombres),' ',ltrim(apellidos))  as ncompleto,
direccion,idubigeo
from Persona
where
(
direccion like 'A%' and idubigeo in (7,8,9,10)
) --EXP1 -V
and
(
concat(ltrim(nombres),' ',ltrim(apellidos))  like 'E%' or idubigeo in (8,9,10)
) --EXP2 -V

--Uso AND y OR
select concat(ltrim(nombres),' ',ltrim(apellidos))  as ncompleto,
direccion,idubigeo
from Persona
where
(
direccion like 'A%' and idubigeo in (7,8,9,10)
) --EXP1 -F
or
(
concat(ltrim(nombres),' ',ltrim(apellidos))  like 'E%' or idubigeo in (8,9,10)
) --EXP2 -V

--Uso de NOT
select direccion,idubigeo from Persona
where 
NOT
(
direccion like 'A%' --EXP1
and
idubigeo in (7,8,9,10)--EXP2
)

--NOT forma 2
select direccion,idubigeo from Persona
where direccion NOT LIKE 'A%' OR idubigeo NOT in (7,8,9,10)

--2.5

select
idubigeo,
count(idpersona) as total,
max(fecnacimiento) as maxfecnac,
min(fecnacimiento) as minfecnac
from Persona
group by idubigeo
order by idubigeo

--2.6
select idsector,
count(idmanzana) as [TOTAL-M],
max(idmanzana) as [MAX-ID-M],
min(idmanzana) as [MIN-ID-M]
from Manzana
where estado=1
group by idsector

select estado,
count(idmanzana) as [TOTAL-M],
max(idmanzana) as [MAX-ID-M],
min(idmanzana) as [MIN-ID-M]
from Manzana
--where estado=1
group by estado

--2.7
select 
isnull(sexo,'-') as sexo,
idubigeo,
count(idpersona) as TOTAL,
max(fecnacimiento) as MAXFECNAC,
min(fecnacimiento) as MINFECNAC
from Persona
group by sexo,idubigeo
order by sexo,idubigeo
--2.9
select top(6) nombres, count(idpersona) as total
from Persona
group by nombres
order by total desc
--select count(1) from Persona--997

--select nombres, count(idpersona) as total
--from Persona
--group by nombres --614


select top(6) percent --36.84
nombres, count(idpersona) as total
from Persona
group by nombres
order by total desc

--2.10
select top(6) with ties --36.84
nombres, count(idpersona) as total
from Persona
group by nombres
order by total desc

select top(6) percent with ties --36.84
nombres, count(idpersona) as total
from Persona
group by nombres
order by total desc

--2.11 
select top 2 idsector,count(idmanzana) as total,
'El sector '+cast(idsector as varchar(50))+' tiene '+
cast(count(idmanzana) as varchar(50))+' manzanas' as mensaje
from Manzana
where estado=1
group by idsector
order by total desc
--2.12
select top 2 with ties idsector,count(idmanzana) as total,
'El sector '+cast(idsector as varchar(50))+' tiene '+
cast(count(idmanzana) as varchar(50))+' manzanas' as mensaje
from Manzana
where estado=1
group by idsector
order by total desc

--2.13
select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY

select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET 20 ROWS
FETCH NEXT 10 ROWS ONLY
--1 a la 100 (Página 1)
select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET 0 ROWS
FETCH NEXT 100 ROWS ONLY
--101 a 200 (Página 2)
select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET 100 ROWS
FETCH NEXT 100 ROWS ONLY

--201 a la 300 (Página 3)
select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET 200 ROWS--(@n-1)*@m
FETCH NEXT 100 ROWS ONLY--@m

--Genérico
declare @n int=3 --Pagina n
declare @m int=100 --Tamaño de página m

select ltrim(nombres)+' '+ltrim(apellidos) as ncompleto
from Persona
order by ltrim(nombres)+' '+ltrim(apellidos) asc
OFFSET (@n-1)*@m ROWS
FETCH NEXT @m ROWS ONLY
from Persona

