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


























