Segment 4: Ratings Analysis and Crew Members

--	Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).

select * from imdb_ratings;
-----------------------------------------------------------------------------------------------------
select max(avg_rating) as maximum_avg_rating , min(avg_rating)as minimum_avg_rating , 
max(total_votes) as maximum_total_votes , min(total_votes)as minimum_total_votes ,
max(median_rating) as maximum_median_rating , min(median_rating)as minimum_median_rating 
from imdb_ratings;
-------------------------------------------------------------------------------------------------------
--	Identify the top 10 movies based on average rating.
select * from imdb_ratings;
select * from imdb_movies;
------------------------------------------------------------------------------------------------------
select * from 
(select r.movie_id ,m.title,r.avg_rating , row_number() over (order by r.avg_rating desc ) as ran_k 
from imdb_movies m left join imdb_ratings r on r.movie_id=m.id) a where ran_k<=10;
-------------------------------------------------------------------------------------------------------
--	Summarise the ratings table based on movie counts by median ratings.
select * from imdb_ratings;
select * from imdb_movies;
----------------------------------------------------------------------------------------------------------
select  r.median_rating , count(m.id) as movie_count from imdb_movies m 
left join imdb_ratings r on m.id=r.movie_id 
group by r.median_rating
order by r.median_rating; 
-----------------------------------------------------------------------------------------------------------

--	Identify the production house that has produced the most number of hit movies (average rating > 8).
select * from imdb_ratings;
select * from imdb_movies;
-----------------------------------------------------------------------------------------------------
select production_company from
(select m.production_company , count(m.id) , row_number() over (order by count(m.id) desc) as rnk 
from imdb_movies m left join imdb_ratings r 
on m.id=r.movie_id where r.avg_rating>8 and m.production_company is not null group by 1) as b 
where rnk=1;
---------------------------------------------------------------------------------------------

--	Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 votes.
select * from imdb_genre;
select * from imdb_movies;
select * from imdb_ratings;
desc imdb_movies;
-----------------------------------------------------------------------------------------------------
select g.genre , count(m.id) as count_movie from imdb_movies m 
left join imdb_genre g on m.id=g.movie_id
left join imdb_ratings r on g.movie_id=r.movie_id
where r.total_votes>1000 and m.country="USA"
and substr(m.date_published,4,2)="03" and year="2017"
group by 1
order by 2 desc; 
-----------------------------------------------------------------------------------------------------------
--	Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.
select * from imdb_genre;
select * from imdb_movies;
select * from imdb_ratings;
------------------------------------------------------------------------------------------------------------
select m.id, m.title, g.genre from imdb_movies m 
left join imdb_genre g on m.id=g.movie_id
left join imdb_ratings r on r.movie_id=g.movie_id
where  m.title like "the%" and r.avg_rating>8
order by genre;