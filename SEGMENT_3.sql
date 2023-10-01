-- Segment 3: Production Statistics and Genre Analysis

--	Retrieve the unique list of genres present in the dataset.
select * from imdb_movies;
select * from imdb_genre;
---------------------------------------------------------------------------------------
select distinct(g.genre) from imdb_genre g 
left join imdb_movies m 
on m.id=g.movie_id; 
------------------------------------------------------------------------------------------
--	Identify the genre with the highest number of movies produced overall.

select * from imdb_movies;
select * from imdb_genre;
------------------------------------------------------------------------------------------
with ab as
(select distinct(g.genre), count(m.id) as movie_produced , 
row_number() over(order by count(m.id)desc) as rnk from imdb_movies m 
left join imdb_genre g 
on m.id=g.movie_id 
group by 1)
select * from ab where rnk=1;
------------------------------------------------------------------------------
--	Determine the count of movies that belong to only one genre.
select * from imdb_movies;
select * from imdb_genre;
-------------------------------------------------------------------------------------------------------------
with dd as 
(select m.id ,count(g.genre) from imdb_movies m left join 
imdb_genre g on m.id=g.movie_id group by 1 having count(g.genre)=1 )
select count(*) from dd;
--------------------------------------------------------------------------------------------------------
--	Calculate the average duration of movies in each genre.
select * from imdb_movies;
select * from imdb_genre;
-----------------------------------------------------------------------------------------------------------
select g.genre , avg(m.duration) as avg_duration from imdb_movies m 
left join imdb_genre g on m.id=g.movie_id group by 1;
-------------------------------------------------------------------------------------------------------
--	Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
select * from imdb_movies;
select * from imdb_genre;
---------------------------------------------------------------------------------------------------------
with ee as 
( select  g.genre , count(m.id) as movie_produced , row_number() over(order by count(id) desc) as rank_n
from imdb_movies m left join imdb_genre g on m.id=g.movie_id group by 1) 
select  genre , rank_n from ee where genre="Thriller";
