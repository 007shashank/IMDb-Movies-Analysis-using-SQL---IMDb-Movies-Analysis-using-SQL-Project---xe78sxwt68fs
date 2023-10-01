-- Project 1: IMDb Movies Analysis using SQL

-- Bolly Movies, an Indian film production company, 
-- has a successful track record of producing numerous blockbuster films. 
-- While primarily catering to the Indian audience, they have decided to venture into the global market with their upcoming project scheduled for release in 2022.

-- Objective:
-- Recognizing the value of data-driven decision-making, Bolly Movies has enlisted your expertise as a data analyst and SQL specialist. The objective of this case study is to analyse the movie dataset using SQL queries and extract valuable insights to guide Bolly Movies in planning their new project. The analysis will cover various aspects such as table exploration, movie release trends, production statistics, genre popularity, ratings analysis, crew members, and more.
use imdb_project;
select * from imdb_genre;
select * from imdb_movies;
select * from imdb_names;
select * from imdb_ratings;
select * from imdb_role_mapping;
select * from imdb_director_mapping;
-- Segment 1: Database - Tables, Columns, Relationships
--	What are the different tables in the database and how are they connected to each other in the database?

--	Find the total number of rows in each table of the schema.
-----------------------------------------------------------------------------------------------------------
select count(*) from imdb_genre;
select count(*) from imdb_movies;
select count(*) from imdb_names;
select count(*) from imdb_ratings;
select count(*) from imdb_role_mapping;
select count(*) from imdb_director_mapping;
--------------------------------------------------------------------------------------------------------
--	Identify which columns in the movie table have null values.
select * from imdb_movies;
-------------------------------------------------------------------------------------------------------------
select sum(case when id is null then 1 else 0 end) as id_nulls,
sum(case when title is null then 1 else 0 end) as title_nulls,
sum(case when year is null then 1 else 0 end) as year_nulls,
sum(case when date_published is null then 1 else 0 end) as date_published_nulls,
sum(case when duration is null then 1 else 0 end) as duration_nulls,
sum(case when country is null then 1 else 0 end) as country_nulls,
sum(case when worlwide_gross_income is null then 1 else 0 end) as worlwide_gross_income_nulls,
sum(case when languages is null then 1 else 0 end) as languages_nulls,
sum(case when production_company is null then 1 else 0 end) as production_company_nulls
from imdb_movies;

-------------------------------------------------------------------------------------------------------