
--07.01
--TN=T1+(N-1) *R
--1,3,5...T5
--A
create procedure usp_calcula_tn--usp(Estándar)
(@t1 int,@r int,@n int)--parametros de entrada
as
begin
	select 'TN'=@t1+(@n-1)*@r
end

execute usp_calcula_tn @t1=1,@r=2,@n=5
execute usp_calcula_tn 1,2,5
exec usp_calcula_tn @t1=1,@r=2,@n=5

--B
alter function uf_calcula_tn--uf(Estándar)
(@t1 int,@r int,@n int)--parametros de entrada
returns table--Función de valor tabla
as
	return select 'TN'=@t1+(@n-1)*@r,getdate() as fechoraconsulta

select TN,fechoraconsulta from uf_calcula_tn(1,2,5)

--C
alter function uf_calcula_tn_escalar
(@t1 int,@r int,@n int)
returns int
as 
begin
	declare @tn int=(select @t1+(@n-1)*@r)
	return @tn
end

select dbo.uf_calcula_tn_escalar(1,2,5)
--select *,dbo.uf_calcula_tn_escalar(idmanzana,numhabitantes,idencuestador) as TN 
--from Ficha