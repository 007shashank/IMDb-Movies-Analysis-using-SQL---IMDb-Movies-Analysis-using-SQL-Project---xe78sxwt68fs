Segment 6: Broader Understanding of Data
--	Classify thriller movies based on average ratings into different categories.
select * from imdb_genre;
select * from imdb_ratings;
select * from imdb_movies;
----------------------------------------------------------------------------------------------------------
select  m.id , m.title, g.genre, r.avg_rating ,
case
 when r.avg_rating>8 then 'Superhit'
 when r.avg_rating=8 then 'Hit'
 when r.avg_rating<8 then 'Average'
 when r.avg_rating<4 then 'Flop'
end as category
from imdb_movies m left join imdb_ratings r on m.id=r.movie_id
left join imdb_genre g on  r.movie_id=g.movie_id
where g.genre='thriller';
------------------------------------------------------------------------------------------------------
--	analyse the genre-wise running total and moving average of the average movie duration.
Select * from imdb_genre;
select * from imdb_movies;
--------------------------------------------------------------------------------------------------------
select m.id , m.title , g.genre ,
sum(m.duration) over(partition by g.genre  order by m.id desc) as running_total ,
avg(m.duration) over(partition by g.genre  order by m.id desc) as movie_average
from imdb_movies m left join imdb_genre g 
on g.movie_id=m.id;
------------------------------------------------------------------------------------------------------

--	Identify the five highest-grossing movies of each year that belong to the top three genres.
select * from imdb_genre;
select * from imdb_movies;
---------------------------------------------------------------------------------------------------------

with cte as (select * from (select genre,count(id) as movie_count, 
row_number() over (order by count(id) desc) as ranks from imdb_movies m
left join imdb_genre g on m.id=g.movie_id
group by genre) a where ranks<=3)
(select * from (select id, title, genre, year, concat('$',worlwide_gross_income) as worldwide_income,
row_number() over (partition by year order by worlwide_gross_income desc) as income_rank
from imdb_movies left join imdb_genre on movie_id=id
where genre in (select genre from cte)) a where income_rank<=5);

----------------------------------------------------------------------------------------------------------------------
--	Determine the top two production houses that have produced the highest number of hits among multilingual movies.
select * from imdb_movies;
select * from imdb_ratings;
------------------------------------------------------------------------------------------------------------
select * from (select production_company, count(id) as movie_count,
row_number() over (order by count(id) desc) as ranks
from imdb_movies  left join imdb_ratings  on id=movie_id
where languages like '%,%' and avg_rating>=6 and production_company is not null
group by production_company) a where ranks<=2;

------------------------------------------------------------------------------------------------------------

--	Identify the top three actresses based on the number of Super Hit movies (average rating > 8) in the drama genre.
select * from imdb_movies;
select * from imdb_genre;
select * from imdb_role_mapping;
select * from imdb_names;
select * from imdb_ratings;

---------------------------------------------------------------------------------------------------------
select * from (select name_id,name as actress_name, count(m.id) as movie_count,
row_number() over (order by count(m.id) desc) as ranks
from  imdb_movies m
join imdb_role_mapping r on m.id=r.movie_id
join imdb_genre g on m.id=g.movie_id
join imdb_ratings a on m.id=a.movie_id
join imdb_names n on n.id=r.name_id
where category='actress' and avg_rating>8 and genre='drama'
group by name_id,name) a where ranks<=3;

---------------------------------------------------------------------------------------------------

--	Retrieve details for the top nine directors based on the number of movies, including average inter-movie duration, ratings, and more.


select * from imdb_movies;
select * from imdb_director_mapping;
select * from imdb_names;

-----------------------------------------------------------------------------------------------------

select * from (select n.id as director_id, n.name as director_name, count(m.id) as movie_count,
avg(duration) as average_duration, avg(avg_rating) as average_rating,
row_number() over (order by count(m.id) desc) as ranks
from imdb_movies m join imdb_ratings r on m.id=r.movie_id
join imdb_director_mapping d on d.movie_id=r.movie_id
join imdb_names n on n.id=d.name_id
group by n.id,n.name) a where ranks<=9;