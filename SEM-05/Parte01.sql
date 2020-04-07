--4.14

--Costo Calculado: 10.00+ N° Habitantes * 20.00

begin tran
	update f
	set costo=10.00+numhabitantes* 20.00
	from Ficha f
rollback

--Elaboración de reporte
select 
concat(p.nombres,' ',p.apellidos)as nombre_completo,
f.montopago,f.costo,
case when f.montopago>=f.costo then 'cliente genera ganancia'
else 'cliente genera pérdida' end as mensaje
from Ficha f inner join cliente c on f.idcliente=c.idcliente
inner join persona p on c.idpersona=p.idpersona
order by nombre_completo asc

select * from Ficha

--4.15
--P 10.00+ N° Habitantes * 20.00
--M 15.00+ N° Habitantes * 25.00
--G 20.00+ N° Habitantes * 30.00
begin tran
	update f
	set costo=case when tipoconsumidor='P' then 10.00+numhabitantes* 20.00
				   when tipoconsumidor='M' then 15.00+numhabitantes* 25.00
				   when tipoconsumidor='G' then 20.00+numhabitantes* 30.00
			  end
	from Ficha f
rollback

select tipoconsumidor,numhabitantes,costo from Ficha
order by tipoconsumidor

--Elaboración de reporte
select 
concat(p.nombres,' ',p.apellidos)as nombre_completo,
f.tipoconsumidor,
f.numhabitantes,
f.montopago,f.costo,
case when f.montopago>=f.costo then 'cliente genera ganancia'
else 'cliente genera pérdida' end as mensaje
from Ficha f inner join cliente c on f.idcliente=c.idcliente
inner join persona p on c.idpersona=p.idpersona
order by nombre_completo asc