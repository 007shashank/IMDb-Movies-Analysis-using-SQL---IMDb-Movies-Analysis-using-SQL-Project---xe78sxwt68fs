
-- Segment 2: Movie Release Trends

--	Determine the total number of movies released each year and analyse the month-wise trend.
Select * from imdb_movies;
Desc imdb_movies;
--------------------------------------------------------------------------------------------------------------
Select year , substr(date_published,4,2) as month , count(id) 
from imdb_movies 
group by year , month
order by year , month;
------------------------------------------------------------------------------------------------------------
-- Calculate the number of movies produced in the USA or India in the year 2019.
------------------------------------------------------------------------------------------------------------
select count(id) from imdb_movies where country in ("USA","India") and year=2019;
