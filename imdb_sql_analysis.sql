-- 1. What are all Directors Names and total count of unique directors in directors’ table?
-- 2. What are all Actors Names and total count of unique Actors in director’s table?
-- 3. What is the colour, languages, country, title_year distribution of movies in the movies table?
-- 4. What is the highest and lowest grossing, highest and lowest budget movies in the Database?
-- 5. Retrieve a list of movie titles along with a column indicating whether the movie duration is above 120 minutes or not.
-- 6. Find the top 5 genres based on the number of movies released in the last 5 years.
-- 7. Retrieve the movie titles directed by a director whose average movie duration is above the overall average duration.
-- 8. Calculate the average budget of movies over the last 3 years, including the average budget for each movie.
-- 9. Retrieve a list of movies with their genres, including only those genres that have more than 5 movies.
-- 10. Find the directors who have directed at least 3 movies and have an average IMDb score above 7.
-- 11. List the top 3 actors who have appeared in the most movies, and for each actor, provide the average IMDb score of the movies they appeared in.
-- 12. For each year, find the movie with the highest gross, and retrieve the second highest gross in the same result set.
-- 13. Create a stored procedure that takes a director's ID as input and returns the average IMDb score of the movies directed by that director.
-- 14. Retrieve the top 3 movies based on IMDb score, and include their ranking.
-- 15. For each director, list their movies along with the IMDb score and the ranking of each movie based on IMDb score.
-- 16. Find the movie with the highest budget in each genre, and include the row number for each movie within its genre.
USE movies;


SELECT * FROM actors;
SELECT * FROM directors;
SELECT * FROM genre;
SELECT * FROM keywords;
SELECT * FROM movies;
SELECT * FROM ratings;


-- 1. What are all Directors Names and total count of unique directors in directors’ table?
SELECT * FROM directors;

SELECT Directors FROM directors;

SELECT COUNT(distinct(Directors)) AS total_no_of_directors
FROM directors;

-- 2. What are all Actors Names and total count of unique Actors in director’s table?

SELECT * FROM actors;

SELECT actor
FROM actors;

SELECT COUNT(distinct(actor))
FROM actors;

-- 3. What is the colour, languages, country, title_year distribution of movies in the movies table?

SELECT * FROM movies;

SELECT color, COUNT(Movie_id) AS number_of_movies
FROM movies
GROUP BY color;

SELECT languages, COUNT(Movie_id) AS number_of_movies
FROM movies
GROUP BY languages
ORDER BY 2 DESC;

-- 4. What is the highest and lowest grossing, highest and lowest budget movies in the Database?
SELECT MAX(gross)
FROM movies;

SELECT *
FROM movies
WHERE gross = (SELECT MAX(gross) FROM movies);

SELECT *
FROM movies
WHERE gross = (SELECT MIN(gross) FROM movies);

SELECT *
FROM movies
WHERE budget = (SELECT MAX(budget) FROM movies);

SELECT *
FROM movies
WHERE budget = (SELECT MIN(budget) FROM movies WHERE budget > 0);

-- 5. Retrieve a list of movie titles along with a column indicating whether the movie duration is above 120 minutes or not.

SELECT movie_title,
       CASE
          WHEN duration > 120 THEN 'above 120 mins'
          ELSE'below 120 mins'
          END AS category
FROM movies;

-- 6. Find the top 5 genres based on the number of movies released in the last 5 years.



SELECT MAX(title_year) FROM movies;

SELECT * FROM movies;

SELECT genres, COUNT(*)
FROM movies
WHERE title_year > (SELECT MAX(title_year) FROM movies) - 5
GROUP BY genres
ORDER BY 2 DESC
LIMIT 5;

SELECT * FROM genre;

-- 7. Retrieve the movie titles directed by a director whose average movie duration is above the overall average duration.

SELECT movie_title
FROM movies
WHERE director_ID IN
(
SELECT Director_ID
FROM movies
GROUP BY Director_ID
HAVING AVG(duration) > (SELECT AVG(duration) FROM movies)
);

-- 8. Calculate the average budget of movies over the last 3 years, including the average budget for each movie.
SELECT movie_title,
     AVG(budget) OVER (ORDER BY title_year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_budget_last_3_years
FROM movies
WHERE title_year IS NOT NULL;

-- 9. Retrieve a list of movies with their genres, including only those genres that have more than 5 movies.

SELECT movie_title, genres
FROM movies
WHERE genres in
(
SELECT genres
FROM movies
GROUP BY genres
HAVING COUNT(*) > 5
)

-- 10. Find the directors who have directed at least 3 movies and have an average IMDb score above 7.
SELECT d.Directors,
       COUNT(*) AS movie_count,
       ROUND(AVG(imdb_score), 2) AS avg_imdb_score
FROM movies m
INNER JOIN directors d
    ON m.Director_ID = d.D_ID
GROUP BY d.Directors
HAVING COUNT(*) >= 3
   AND ROUND(AVG(imdb_score), 2) > 7
ORDER BY 3 DESC;

-- 11. List the top 3 actors who have appeared in the most movies, and for each actor, provide the average IMDb score of the movies they appeared in.
SELECT * FROM movies;

SELECT a.actor, 
       COUNT(*) AS movie_count,
       ROUND(AVG(imdb_score), 2) AS avg_imdb_score
FROM actors a
LEFT JOIN movies m ON CONCAT(' |' , m.actors, '|') LIKE CONCAT('%|' , a.actor,'|%')
GROUP BY a.actor
ORDER BY movie_count DESC
LIMIT 3;

-- 12. For each year, find the movie with the highest gross, and retrieve the second highest gross in the same result set.

WITH RankedMovies AS(

SELECT movie_title, gross,title_year,
    row_number() OVER (PARTITION BY title_year ORDER BY gross DESC) AS new_rank
FROM movies
)

SELECT title_year,
    MAX(CASE WHEN new_rank = 1 THEN movie_title END) AS highest_grossing_movie,
    MAX(CASE WHEN new_rank = 2 THEN movie_title END) AS second_highest_grossing_movie
FROM RankedMovies
WHERE new_rank <=2
GROUP BY title_year
ORDER BY title_year DESC;

-- 13. Create a stored procedure that takes a director's ID as input and returns the average IMDb score of the movies directed by that director.

DELIMITER //

CREATE PROCEDURE Avg_IMDB_SCORE( IN D_ID VARCHAR(255))
BEGIN
    SELECT AVG(imdb_score)
    FROM movies
    WHERE Director_ID = D_ID;
END //

DELIMITER ;

CALL Avg_IMDB_Score('D1002')

-- 14. Retrieve the top 3 movies based on IMDb score, and include their ranking.
SELECT movie_title, imdb_score,
       RANK() OVER (ORDER BY imdb_score DESC) AS ranking
FROM movies
WHERE imdb_score IS NOT NULL
ORDER BY imdb_score DESC
LIMIT 3;

-- 15. For each director, list their movies along with the IMDb score and the ranking of each movie based on IMDb score.

SELECT Director_ID, movie_title, imdb_score,
       RANK() OVER (PARTITION BY Director_ID ORDER BY imdb_score DESC) AS ranking
FROM movies
WHERE imdb_score IS NOT NULL
ORDER BY Director_ID, imdb_score DESC;

-- 16. Find the movie with the highest budget in each genre, and include the row number for each movie within its genre.

WITH RankedMovies AS (
    SELECT movie_title, genres, budget,
           row_number() OVER (PARTITION BY genres ORDER BY budget DESC) AS row_num
    FROM movies
    WHERE budget IS NOT NULL
)
SELECT movie_title, genres, budget, row_num
FROM RankedMovies
WHERE row_num = 1
ORDER BY genres;