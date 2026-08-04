/** EJERCICIOS DE CONSULTAS SQL**/

/** 2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.**/

select 
	f.title,
	f.rating 
from film f 
where f.rating  = 'R';


/** 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40. **/

select
	a.actor_id ,
	concat(a.first_name , ' ' , a.last_name ) as nombre_actor
from actor a 
where a.actor_id between 30 and 40;


/** 4. Obtén las películas cuyo idioma coincide con el idioma original. **/

select 
	f.title 
from film f  
where f.original_language_id = f.language_id ;


/** 5. Ordena las películas por duración de forma ascendente. **/

select f.title, f.length 
from film f 
	order by f.length; 


/** 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido. **/

select 
	concat(a.first_name , ' ' , a.last_name ) as nombre_actor
from actor a
where a.last_name = 'ALLEN'; 


/** 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento. **/

select 
	count(f.film_id ) as conteo_peliculas,
	f.rating as clasificación
from film f 
group by f.rating ;


/** 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film. **/

select 
	f.title,
	f.rating,
	f.length 
from film f 
where f.rating = 'PG-13' or f.length > 180;


/** 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.**/

select concat(round(variance(f.replacement_cost ),2), '$')
from film f ;


/** 10. Encuentra la mayor y menor duración de una película de nuestra BBDD. **/

select 
	MIN(f.length ) as pelicula_menos_duracion,
	MAX(f.length ) as pelicula_mas_duracion
from film f ;


/** 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.**/

select 
	r.rental_date ,
	p.amount 
from rental r 
inner join payment p 
	on r.rental_id = p.rental_id 
order by r.rental_date desc 
limit 1 --con limit limitamos a uno los resultados
offset 2; -- con offset excluimos los 2 primeros resultados de forma que nos muestra el antepenultimo alquiler


/** 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación. **/

select 
	f.title ,
	f.rating 
from film f
where f.rating not in ('NC-17', 'G'); 


/** 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.**/

select 
	f.rating, 
	round(AVG(f.length )) as duracion_promedio
from film f
group by f.rating ; 


/** 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos. **/

select 
	f.title,
	f.length 
from film f 
where f.length > 180;


/** 15. ¿Cuánto dinero ha generado en total la empresa? **/

select 
sum(amount) as total_recaudado
from payment p ;


/** 16. Muestra los 10 clientes con mayor valor de id. **/

select 
	c.customer_id ,
	concat(c.first_name , ' ', c.last_name ) as nombre_cliente
from customer c
order by c.customer_id desc --ordenamos por id de forma descendente
limit 10; --limitamos a 10 resultados


/** 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’. **/

select concat(a.first_name , ' ', a.last_name ) as nombre_actor 
from actor a 
inner join  film_actor fa 
	on a.actor_id = fa.actor_id 
		inner join film f 
			 on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

/** 18. Selecciona todos los nombres de las películas únicos. **/

select 
	distinct f.title  
from film f ;


/** 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”. **/

select 
	f.title as pelicula,
	c."name" as categoria,
	f.length as duracion
from category c
inner join film_category fc --inner join para unir las tablas category y film_category
	on c.category_id = fc.category_id 
		inner join film f  -- inner join para unir las tablas film_category y film
			on fc.film_id = f.film_id
where c."name" = 'Comedy' and f.length > 180; -- usamos and para poner dos restricciones


/** 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.**/

select 
	c."name" as categoria,
	round(AVG(f.length )) as duracion_media 
from film f  
inner join film_category fc 
	 on f.film_id = fc.film_id
		inner join category c 
			on fc.category_id = c.category_id 
group by c."name" 
having AVG(f.length ) > 110;



/** 21. ¿Cuál es la media de duración del alquiler de las películas? **/

select round(AVG(f.rental_duration )) as media_alquiler 
from film f ;


/** 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices. **/

select 
	concat(a.first_name , ' ', a.last_name ) as nombre_completo
from actor a ;


/** 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente. **/

select 
		count(r.rental_date ) as cantidad_alquiler,
		r.rental_date::date
from rental r 
group by r.rental_date::date
order by count(r.rental_date ) desc;




/** 24. Encuentra las películas con una duración superior al promedio.**/

select f.title 
from film f 
where f.length > (select AVG(f.length ) 
		from film f );


/** 25. Averigua el número de alquileres registrados por mes. **/

select 
		count(DATE_TRUNC('month', r.rental_date)) as alquileres_por_mes,
		DATE_TRUNC('month', r.rental_date)::date as mes
from rental r 
group by DATE_TRUNC('month', r.rental_date)::date ;



/** 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado. **/

select 
	AVG(p.amount ) as promedio,
	stddev(p.amount ) as desviacion_estandar,
	variance(p.amount ) as varianza
from payment p ;


/** 27. ¿Qué películas se alquilan por encima del precio medio?**/

select f.title 
from film f 
where f.rental_rate > 
		(select AVG(f.rental_rate )
			from film f );


/** 28. Muestra el id de los actores que hayan participado en más de 40
películas. **/

select 
	a.actor_id	
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
	group by a.actor_id 
	having  (count(fa.film_id)) > 40;



 /** 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible. **/

select 
	f.film_id ,
	count(i.store_id ) as cantidad_disponible 
from film f 
left join inventory i 
	on f.film_id = i.film_id 
group by (f.film_id )
order by f.film_id ;


/** 30. Obtener los actores y el número de películas en las que ha actuado. **/

select 
	concat(a.first_name , ' ', a.last_name ) as nombre_actor ,
	count(fa.film_id ) as cantidad_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id  ;

/** 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.**/

select 
	f.title,
	concat(a.first_name , ' ', a.last_name ) as nombre_actor 
from film f 
left join film_actor fa 
	on f.film_id = fa.film_id 
left join actor a 
	on fa.actor_id = a.actor_id
order by f.film_id  ;

/** 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.**/

select 
	f.title,
	concat(a.first_name , ' ', a.last_name ) as nombre_actor 
from film f 
right join film_actor fa 
	on f.film_id = fa.film_id 
right join actor a 
	on fa.actor_id = a.actor_id
order by a.actor_id ;

select 
	f.title,
	concat(a.first_name , ' ', a.last_name ) as nombre_actor 
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
left join film f 
	on fa.film_id = f.film_id 
order by a.actor_id ;


/** 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.**/

select 
	f.title ,	
	r.customer_id,
	r.rental_date ,
	r.return_date 
from film f 
left join inventory i 
	on f.film_id = i.film_id
left join rental r 
	on i.inventory_id = r.inventory_id ;


/** 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.**/

select 
	c.customer_id ,
	sum(p.amount) as cantidad_total
from customer c 
inner join payment p 
	on c.customer_id = p.customer_id
group by c.customer_id 
order by cantidad_total  desc 
limit 5;

/** 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.**/

select 
	concat(a.first_name , ' ', a.last_name ) as nombre_actor
from actor a 
where a.first_name = 'JOHNNY';


/**36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.**/

select 
	a.first_name as "Nombre",
	a.last_name as "Apellido"
from actor a ;

/** 37. Encuentra el ID del actor más bajo y más alto en la tabla actor. **/

select 
	MAX(a.actor_id ) as id_max,
	MIN(a.actor_id ) as id_min
from actor a; 


/** 38. Cuenta cuántos actores hay en la tabla “actor”. **/

select count(a.actor_id ) as numero_actores
from actor a ;


/** 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente. **/

select 
	a.actor_id,
	a.last_name 
from actor a 
order by a.last_name ;

/** Selecciona las primeras 5 películas de la tabla “film”. **/

select *
from film f 
order by f.film_id 
limit 5;


/** 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido? **/

select 
	a.first_name ,
	count(a.first_name) as cantidad_nombre 
from actor a 
group by a.first_name 
order by cantidad_nombre desc
limit 1; 


/** 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron. **/

select 
	r.rental_id ,
	c.first_name 
from rental r 
left join customer c 
	on r.customer_id = c.customer_id;


/** 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres. **/

select 
	c.customer_id,
	r.rental_id 
from customer c 
left join rental r 
	on c.customer_id = r.customer_id ;

/** 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación. **/

select *
from film f 
cross join category c;


/** no aporta ningún valor ya que mezcla los resgistros de una tabla con otra, en este caso asigna todas las categorias a todas las películas lo que resultaria confuso a la hora de clasificar
 las paliculas, por eso cada pelicula tiene su propio category_id. al hacer el cross join nos encontramos con 16 resultados de categorias distintas para una misma pelicula**/


/** 45. Encuentra los actores que han participado en películas de la categoría
'Action'. **/

select 
	a.actor_id ,
	c."name" 
from actor a 
inner  join film_actor fa 
	on a.actor_id = fa.actor_id 
inner join film f 
	on fa.film_id = f.film_id 
inner join film_category fc 
	on f.film_id = fc.film_id 
inner join category c 
	on fc.category_id = c.category_id
where c.name = 'Action';


/** 46. Encuentra todos los actores que no han participado en películas. **/

select a.actor_id 
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
where fa.film_id is null ; 


/** 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.**/

select 	
	concat(a.first_name , ' ', a.last_name ) as nombre_actor,
	count(fa.film_id) as numero_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id ;


/** 49. Calcula el número total de alquileres realizados por cada cliente.**/

select 
	c.customer_id ,
	count(r.rental_id ) as total_alquileres	
from customer c  
left join rental r  
	on c.customer_id = r.customer_id
group by c.customer_id 
order by c.customer_id ;


/** 50. Calcula la duración total de las películas en la categoría 'Action'.**/

select SUM(f.length) as duracion_total
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id 
		inner join category c 
			on fc.category_id = c.category_id 
where c."name" = 'Action';



























