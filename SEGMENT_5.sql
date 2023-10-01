-- Segment 5: Crew Analysis
--	Identify the columns in the names table that have null values.
select * from imdb_names;
----------------------------------------------------------------------------------------------------------
select sum(case when id = '' then 1 else 0 end) as id_nulls,
sum(case when name = '' then 1 else 0 end) as name_nulls,
sum(case when height ='' then 1 else 0 end) as height_nulls,
sum(case when date_of_birth ='' then 1 else 0 end) as date_of_birth_nulls,
sum(case when known_for_movies = '' then 1 else 0 end) as known_for_movies_nulls
from imdb_names;

-----------------------------------------------------------------------------------------------------------
--	Determine the top three directors in the top three genres with movies having an average rating > 8.
select * from imdb_director_mapping;
select *  from imdb_names;
select *  from imdb_genre;
select *  from imdb_movies;
select *  from imdb_ratings;
------------------------------------------------------------------------------------------------------------
with ff as
(select g.genre,d.name_id as director_id, n.name as director_name, count(m.id) as movie_count,
row_number() over (partition by g.genre order by count(m.id) desc) as ranks from imdb_movies m
left join imdb_genre g on m.id=g.movie_id
left join imdb_director_mapping d on d.movie_id=m.id
left join imdb_names n on n.id=d.name_id
where d.name_id is not null
group by genre,name_id,n.name),
 gg as
(select * from 
(select g.genre , count(m.id) as movie_count , row_number() over (order by count(m.id)desc) as rnk
from imdb_movies m left join imdb_genre g on g.movie_id=m.id
left join imdb_ratings r on g.movie_id=r.movie_id
where avg_rating>8
group by 1) l where rnk<=3)
select * from ff where genre in (select genre from gg) and ranks<=3;
-----------------------------------------------------------------------------------------------------------
--	Find the top two actors whose movies have a median rating >= 8.
select * from imdb_names;
select * from imdb_role_mapping;
select * from imdb_movies;
select * from imdb_ratings;
-------------------------------------------------------------------------------------------------------
select * from
(select n.id , n.name , count(m.id) as movie_count , row_number() over(order by count(m.id) desc) as rnk
from imdb_names n left join imdb_role_mapping r on n.id=r.name_id
left join imdb_movies m on m.id=r.movie_id
left join imdb_ratings rs on rs.movie_id=m.id
where rs.median_rating>=8 and r.category="actor"
group by 1,2) a where rnk<=2;
-----------------------------------------------------------------------------------------------------------
--	Identify the top three production houses based on the number of votes received by their movies.
select * from imdb_movies;
select * from imdb_ratings;
---------------------------------------------------------------------------------------------------------
select * from
(select m.production_company , sum(r.total_votes) as total_votes ,
row_number() over(order by sum(r.total_votes) desc) as ranks
from imdb_movies m left join imdb_ratings r on m.id=r.movie_id
group by 1) a where ranks<=3;
---------------------------------------------------------------------------------------------------------
--	Rank actors based on their average ratings in Indian movies released in India.
select * from imdb_movies;
select * from imdb_ratings;
select * from imdb_role_mapping;
select * from imdb_names;
------------------------------------------------------------------------------------------------------------
select n.id , n.name ,avg(rs.avg_rating), row_number() over( order by avg(rs.avg_rating) desc) as rnk
from imdb_names n left join imdb_role_mapping r on n.id=r.name_id
left join imdb_movies m on m.id=r.movie_id
left join imdb_ratings rs on rs.movie_id=m.id
where m.country="India" and r.category="actor"
group by 1,2;
-----------------------------------------------------------------------------------------------------------

--	Identify the top five actresses in Hindi movies released in India based on their average ratings.
select * from imdb_movies;
select * from imdb_ratings;
select * from imdb_role_mapping;
select * from imdb_names;
---------------------------------------------------------------------------------------------------------
select * from
(select n.id , n.name ,avg(rs.avg_rating), row_number() over( order by avg(rs.avg_rating) desc) as rnk
from imdb_names n left join imdb_role_mapping r on n.id=r.name_id
left join imdb_movies m on m.id=r.movie_id
left join imdb_ratings rs on rs.movie_id=m.id
where m.country="India" and r.category="actress" and m.languages="hindi"
group by 1,2) d 
where rnk<=5;