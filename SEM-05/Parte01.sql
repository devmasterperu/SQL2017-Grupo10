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