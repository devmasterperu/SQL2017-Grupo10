--SEMANA 01 (COMENTARIO SIMPLE)
/*
SEMANA 01 (COMENTARIO MULTIPLE)
*/

--1.1 Carga de tipos de documento
--Aumentando longitud de columna
ALTER TABLE TipoDocumento ALTER COLUMN nombre varchar(50)
--Guardando valores

truncate table TipoDocumento--Limpiar una tabla

--Guardar los valores
INSERT INTO TipoDocumento VALUES ('LIBRETA ELECTORAL O DNI')
go 
INSERT INTO TipoDocumento VALUES ('CARNET DE EXTRANJERIA')
go 
INSERT INTO TipoDocumento VALUES ('REG. UNICO DE CONTRIBUYENTES')
go 
INSERT INTO TipoDocumento VALUES ('PASAPORTE')
go 
INSERT INTO TipoDocumento VALUES ('PART. DE NACIMIENTO-IDENTIDAD')
go 
INSERT INTO TipoDocumento VALUES ('OTROS')
go 

select * from TipoDocumento

--1.2 Carga de Ubigeo

insert into ubigeo values ('15','LIMA','08','HUAURA','01','HUACHO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','02','AMBAR') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','03','CALETA DE CARQUIN') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','04','CHECRAS') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','05','HUALMAY') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','06','HUAURA') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','07','LEONCIO PRADO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','08','PACCHO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','09','SANTA LEONOR') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','10','SANTA MARÍA') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','11','SAYAN') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','12','VEGUETA') 
go

select * from Ubigeo

--1.3 Carga de Sectores
insert into sector values ('SECTOR_NOROESTE','-',1)
go
insert into sector values ('SECTOR_NORESTE','-',1)
go
insert into sector values ('SECTOR_SUROESTE','-',1)
go
insert into sector values ('SECTOR_SURESTE','-',1)
go

select * from sector
--1.4 Carga de Manzanas
insert into manzana(nombre,idsector,estado) values ('0001',1,0)
go
insert into manzana(nombre,idsector,estado) values ('0002',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0003',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0004',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0005',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0006',2,0)
go
insert into manzana(nombre,idsector,estado) values ('0007',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0008',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0009',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0010',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0011',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0012',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0013',4,1)
go
insert into manzana(nombre,idsector,estado) values ('0014',4,1)
go
insert into manzana(nombre,idsector,estado) values ('0015',4,0)
go
insert into manzana(nombre,idsector,estado) values ('0016',4,1)
go

select * from Manzana

--1.5 Lógica de procesamiento
--Cuantas manzanas activas tiene cada sector.
--Presentar los resultados de mayor a menos manzanas activas.
SELECT idsector,count(idsector) as total--,total+1
--SELECT idsector,count(idsector) as total,count(idsector)+1
FROM Manzana
WHERE estado=1
--WHERE total>1
GROUP BY idsector
HAVING count(idsector)>1
ORDER BY total desc

--1.6 Uso de operadores
declare @num1 int=100
declare @num2 int=6

select 'suma'=@num1+@num2,
        @num1-@num2 as resta,
		@num1*@num2 as multiplica,
		@num1/@num2 as division,
		@num1%@num2 as modulo

declare @num3 varchar(3)=100
declare @num4 varchar(3)=6

select 'concatenar'=@num3+@num4






