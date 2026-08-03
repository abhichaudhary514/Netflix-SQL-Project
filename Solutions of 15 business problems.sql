-- -- 13. Business Problem 
-- 1. Count the number of movies vs TV shows.
select 
      typee,
      count(*) as total_content
from netflix
group by typee

-- 2. List all the movies released in a specific year (e.g.,2020)
select * from 
       netflix
	   WHERE typee = 'Movie' 
	   AND
	   release_year = '2020';

-- 3. Find the top 5 countries with the most content on Netflix
select 
      UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
	  COUNT(show_id) as Total_content
from netflix
GROUP BY 1	
ORDER BY 2 DESC 
LIMIT 5 

-- 4. Identify the longest movie 
select * from netflix
      WHERE typee = 'Movie'
	  AND
	  duration = (select max(duration) from netflix);
	 
-- 5. Find content added int the last five years

SELECT * FROM netflix
WHERE 
TO_DATE(date_added, 'Month DD , YYYY')  >= Current_Date - INTERVAL'7 years'

-- 6. Find all the Movies/TV shows by director 'Rajiv Chilaka'!
	 select * from netflix
     WHERE 
     director LIKE '%Rajiv Chilaka%'

-- 7. Count the number of content items in each genre 
     SELECT genre,
	 COUNT(genre) as Total_Content
	 FROM Netflix
	 GROUP BY genre

-- 8. Find each year and the average numbers of content release by India on Netflix.
--    Return top 5 year with highest  Avg content release !
	 SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;

-- 9. List All Movies that are Documentaries
SELECT * 
FROM netflix
WHERE genre LIKE '%Documentaries';

-- 10. Find All Content Without a Director
SELECT * 
FROM netflix
WHERE director IS NULL;

-- 11. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 12. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 13. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;
