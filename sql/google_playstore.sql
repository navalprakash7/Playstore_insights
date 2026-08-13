-- Creating Database
CREATE DATABASE playstore_db;
USE playstore_db;

-- Creating Table
CREATE TABLE playstore (
    app VARCHAR(255),
    category VARCHAR(100),
    rating DECIMAL(3,2),
    reviews BIGINT,
    size DECIMAL(10,2),
    installs BIGINT,
    type VARCHAR(20),
    price DECIMAL(10,2),
    content_rating VARCHAR(50),
    genres VARCHAR(255),
    last_updated DATE,
    current_ver VARCHAR(100),
    android_ver VARCHAR(100),
    year_updated INT,
    month_updated INT
);

-- Data import in table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_playstore_data.csv'
INTO TABLE playstore
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(app, category, rating, reviews, size, installs,
 type, price, content_rating, genres,
 last_updated, current_ver, android_ver,
 year_updated, month_updated);
 
 -- 1. Top 5 categories by avg rating (min 50 apps) — GROUP BY + HAVING
SELECT Category, ROUND(AVG(Rating),2) AS avg_rating, COUNT(*) AS app_count
FROM playstore_apps
GROUP BY Category
HAVING COUNT(*) >= 50
ORDER BY avg_rating DESC
LIMIT 5;

-- 2. Free vs Paid breakdown per category
SELECT Category,
       SUM(CASE WHEN Type='Free' THEN 1 ELSE 0 END) AS free_apps,
       SUM(CASE WHEN Type='Paid' THEN 1 ELSE 0 END) AS paid_apps,
       ROUND(AVG(Rating),2) AS avg_rating
FROM playstore_apps
GROUP BY Category
ORDER BY free_apps DESC;

-- 3. Top 3 apps by installs within each category — window function
SELECT Category, App, Installs, rnk
FROM (
    SELECT Category, App, Installs,
           RANK() OVER (PARTITION BY Category ORDER BY Installs DESC) AS rnk
    FROM playstore_apps
) t
WHERE rnk <= 3;

-- 4. Categories with avg price above overall avg price — subquery
SELECT Category, ROUND(AVG(Price),2) AS avg_price
FROM playstore_apps
GROUP BY Category
HAVING AVG(Price) > (SELECT AVG(Price) FROM playstore_apps)
ORDER BY avg_price DESC;

-- 5. Apps with reviews above their category's average — correlated subquery
SELECT App, Category, Reviews
FROM playstore_apps p
WHERE Reviews > (
    SELECT AVG(Reviews) FROM playstore_apps p2 WHERE p2.Category = p.Category
)
ORDER BY Reviews DESC
LIMIT 20;

-- 6. Yearly update trend with % share — window SUM() OVER()
SELECT "Year Updated",
       COUNT(*) AS apps_updated,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM playstore_apps
GROUP BY "Year Updated"
ORDER BY "Year Updated";

-- 7. Most expensive app per category — ROW_NUMBER
SELECT Category, App, Price
FROM (
    SELECT Category, App, Price,
           ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS rn
    FROM playstore_apps
    WHERE Type = 'Paid'
) t
WHERE rn = 1;

-- 8. Content Rating distribution with % share
SELECT "Content Rating",
       COUNT(*) AS app_count,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM playstore_apps
GROUP BY "Content Rating"
ORDER BY app_count DESC;

-- 9. Apps rated above their category average — CTE
WITH cat_avg AS (
    SELECT Category, AVG(Rating) AS avg_rating
    FROM playstore_apps
    GROUP BY Category
)
SELECT p.App, p.Category, p.Rating, ROUND(c.avg_rating,2) AS category_avg
FROM playstore_apps p
JOIN cat_avg c ON p.Category = c.Category
WHERE p.Rating > c.avg_rating
ORDER BY p.Rating DESC
LIMIT 20;

-- 10. Cumulative installs by category, ordered by rating — running total
SELECT Category, App, Rating, Installs,
       SUM(Installs) OVER (PARTITION BY Category ORDER BY Rating DESC
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_installs
FROM playstore_apps
ORDER BY Category, Rating DESC;