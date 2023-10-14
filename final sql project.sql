use sakila;

-- Task-1
-- Display the full names of actors available in the sakila database
select concat( first_name,' ' ,last_name ) as "Full_Name" from actor ;

-- Task-2
-- Display the number of times each first name appears 
select first_name, count(first_name) as "frequency" 
from actor group by first_name order by frequency desc;

-- Task-2.2
-- Display the count of actors that have unique first names in the database, display their first names
select distinct first_name, count(first_name) as "frequency" 
from actor group by first_name  having frequency = 1
order by frequency desc;

-- Task-3.1
-- Display the number of times each last name appeared in the database
select last_name, count(last_name) as "frequency" 
from actor group by last_name order by frequency desc;


-- Task-3.2
-- Display all the unique last names appeared in the database
select last_name, count(last_name) as "Unique_Last_names" 
from actor  group by last_name having count(last_name) = 1 
order by last_name;

-- Task-4.1
-- Display the list of records for the movies with R rating
select * from film where rating = "R" ;

-- Task-4.2
-- Display the list of records for the movies that are not R rated
select * from film where rating != "R" ;

set sql_mode="";

-- Task-4.3
-- Display the records of movies that are suitable for audience below 13 yrs
select * from film where rating in ("G", "PG-13","PG");

-- Display the count of movies on the basis of ratings
select rating, count(title) as "Count_of_movies" from film
group by rating order by Count_of_movies; 

-- Task-5.1
-- Display the records of the movies where replacement cost  upto 11$
select film_id, title, replacement_cost from film where replacement_cost<=11 order by replacement_cost desc;
select replacement_cost , count(title) as "no_of_movies" from film where replacement_cost<=11
group by replacement_cost order by replacement_cost desc;


-- Task-5.2
--  Display the records of the movies where replacement cost  in between 11$ and 20$
select film_id, title, replacement_cost from film where replacement_cost between 11 and 20;

-- Number of movies on the basis of replacement cost between 11-20$. 
select replacement_cost , count(title) as "no_of_movies" from film 
where replacement_cost between 11 and 20
group by replacement_cost order by no_of_movies desc;

-- Task-5.3
-- Display the records of movies on the basis of replacement cost in descending order
select * from film order by replacement_cost desc;
-- Number of movies on the basis of replacement cost of movies. 
select replacement_cost, count(title) as 'no_of_movies' from film 
group by replacement_cost  order by no_of_movies desc;

-- Task-6 Display the names of movies with the greatest number of actors
select  film.film_id, title , count(actor.actor_id) as "Number_of_actors" from actor
join film join film_actor on actor.actor_id=film_actor.actor_id 
and film.film_id=film_actor.film_id 
group by film_id order by Number_of_actors desc limit 10;

-- Task-7 Movies starting with letter K and Q 
select title from film where title like "K%" or title like "Q%";
select left(title ,1) as "starting_letter", count(title) as "no_of_movies" 
from film where title like "K%" or title like "Q%" group by starting_letter;

-- Task-8 Agent Truman has been a great success , display the names of all the actors in it.
select  concat(first_name,"",last_name) as "Name_of_actors" from actor join film  
join film_actor on actor.actor_id=film_actor.actor_id and film.film_id=film_actor.film_id 
where title = "Agent Truman";

-- Task-9  Identify the movies categorized as family movies
select category.name, film.title  from category join film_category join film on film.film_id=film_category.film_id and 
film_category.category_id=category.category_id where category.name="family";

-- Task-10.1 Onthe basis of rating display the avg rental rate.
select rating, max(rental_rate) as "Maximum_rental_rate", min(rental_rate) as "Minimum_rental_rate" , 
avg(rental_rate) as "Average_rental_rate" from film group by rating order by Average_rental_rate desc;

-- Task-10.2 List the movies that have been rented the most
select film.title as "Title", count(rental_id) as "Rental_frequency" from film join inventory join rental 
on film.film_id=inventory.film_id and inventory.inventory_id=rental.inventory_id 
group by film.title order by Rental_frequency desc;

-- Task-11  Display those film categories wher the difference between avg replacemnt cost and avg rental rate is greater than 15$. 
select category.name, avg(replacement_cost) , avg(rental_rate),(avg(replacement_cost) - avg(rental_rate)) as "Difference"   from film
join film_category join category on film.film_id=film_category.film_id and film_category.category_id=category.category_id
group by category.name having Difference > 15;

-- Task-12 Film categories and corresponding no of movies
select category.name, count(film.film_id) as "Number_of_Movies" from film join film_category join category 
on film.film_id=film_category.film_id and film_category.category_id=category.category_id
group by category.name having Number_of_Movies >70;

-- Which actor has appeared in the most films?
SELECT actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name) 
AS "Actor_Name", COUNT(film_actor.film_id) AS "Film_Count"
FROM actor JOIN film_actor  ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id ORDER BY Film_Count DESC;

-- What is the average length of films in each rating category?
SELECT rating, AVG(length) AS "Average Length"
FROM film
GROUP BY rating;




