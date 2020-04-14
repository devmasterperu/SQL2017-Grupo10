--6.3

select idficha,numhabitantes,m.nombre as NOM_MZA,
count(idficha) OVER(PARTITION BY m.nombre) as MZA_NUM_FICHAS,
sum(numhabitantes) OVER(PARTITION BY m.nombre) as MZA_TOT_HABITANTES
from ficha f inner join Manzana m on f.idmanzana=m.idmanzana
order by m.nombre