					----------------------------------------------------------------
							# Video Game Industry Analysis (1980–2016)
					# Global Sales, Market Trends, Publishers & Platform Performance
		 	-------------------------------------------------------------------------------
			#BUSINESS OBJECTIVE
  -- The goal is to understand =>
								-- Which publishers dominate the gaming market?
                                -- Which genres perform best globally?
                                -- How do regional preferences differ?
                                -- What factors are associated with blockbuster games?
-- ----------------------------------------------------------------------------------------------------
# 1 - DATA CLEANING
-- ----------------

#Missing years
SELECT *
FROM vg_sales
WHERE `year` IS NULL;

#Check duplicates
SELECT Name, Platform, `year`, COUNT(*)
FROM vg_sales
GROUP BY Name, Platform, `year`
HAVING COUNT(*) > 1;

# 2 - AGREGATION
-- ----------------
SELECT Genre,
       ROUND(SUM(Global_Sales),2) AS Total_Sales
FROM vg_sales
GROUP BY Genre
ORDER BY Total_Sales DESC;


# 3 - WINDOW FUNCTIONS
-- -------------------
#Top games per genre:

WITH ranked_games AS
					(
					SELECT
					`Name`,
					Genre,
					Global_Sales,
					DENSE_RANK() OVER(
					PARTITION BY Genre
					ORDER BY Global_Sales DESC
					) AS ranking
					FROM vg_sales
)

SELECT *
FROM ranked_games
WHERE ranking <= 5;

# 4 - CTEs 'COMMON TABLE EXPRESSIONS'
-- ----------------------------------
#Top publishers:
WITH publisher_sales AS
						(
						SELECT
						Publisher,
						SUM(Global_Sales) AS total_sales
						FROM vg_sales
						GROUP BY Publisher
)

SELECT *
FROM publisher_sales
ORDER BY total_sales DESC;
-- ----------------------------------------------------------------------------------------------------