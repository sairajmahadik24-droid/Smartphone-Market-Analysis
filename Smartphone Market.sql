CREATE DATABASE smartphone_analysis;

USE smartphone_analysis;

CREATE TABLE smartphones (
Phone_Rank INT,
Manufacturer VARCHAR(100),
Model VARCHAR(100),
Form_Factor VARCHAR(50),
Smartphone VARCHAR(10),
Year INT,
Units_Sold_Million DOUBLE
);

SHOW TABLES;

DESCRIBE smartphones;

# Total Number of Smartphones 
SELECT COUNT(*) AS total_models
FROM smartphones;

# Total Smartphones Sold (Global)
SELECT SUM(Units_Sold_Million) AS total_units_sold_million
FROM smartphones; 

# Top 10 Best Selling Smartphones
SELECT Model, Manufacturer, Units_Sold_Million
FROM smartphones
ORDER BY Units_Sold_Million DESC
LIMIT 10;

# Brand Market Share by Units Sold
SELECT Manufacturer,
SUM(Units_Sold_Million) AS total_sales
FROM smartphones
GROUP BY Manufacturer
ORDER BY total_sales DESC;

# Number of Smartphone Models by Brand
SELECT Manufacturer,
COUNT(*) AS number_of_models
FROM smartphones
GROUP BY Manufacturer
ORDER BY number_of_models DESC;

# Sales Trend by Year
SELECT Year,
SUM(Units_Sold_Million) AS yearly_sales
FROM smartphones
GROUP BY Year
ORDER BY Year;

# Best Selling Smartphone Each Year
SELECT Year, Model, Units_Sold_Million
FROM smartphones s
WHERE Units_Sold_Million = (
SELECT MAX(Units_Sold_Million)
FROM smartphones
WHERE Year = s.Year
);

# Sales by Form Factor
SELECT Form_Factor,
SUM(Units_Sold_Million) AS total_sales
FROM smartphones
GROUP BY Form_Factor
ORDER BY total_sales DESC;

# Smartphone vs Non-Smartphone Sales
SELECT Smartphone,
SUM(Units_Sold_Million) AS total_sales
FROM smartphones
GROUP BY Smartphone;

# Top 5 Brands with Highest Average Sales per Model
SELECT Manufacturer,
AVG(Units_Sold_Million) AS avg_sales_per_model
FROM smartphones
GROUP BY Manufacturer
ORDER BY avg_sales_per_model DESC
LIMIT 5;

# Brand with Highest Selling Model
SELECT Manufacturer, Model, Units_Sold_Million
FROM smartphones
ORDER BY Units_Sold_Million DESC
LIMIT 1;

# Number of Smartphones Released Each Year
SELECT Year,
COUNT(*) AS models_released
FROM smartphones
GROUP BY Year
ORDER BY Year;

# Market Share Percentage by Brand
SELECT Manufacturer,
ROUND(100 * SUM(Units_Sold_Million) /
(SELECT SUM(Units_Sold_Million) FROM smartphones),2)
AS market_share_percent
FROM smartphones
GROUP BY Manufacturer
ORDER BY market_share_percent DESC;

# Phones Sold Above Average Sales
SELECT Model, Manufacturer, Units_Sold_Million
FROM smartphones
WHERE Units_Sold_Million >
(
SELECT AVG(Units_Sold_Million)
FROM smartphones
)
ORDER BY Units_Sold_Million DESC;

# Top 3 Models per Brand
SELECT Manufacturer, Model, Units_Sold_Million
FROM (
SELECT Manufacturer,
Model,
Units_Sold_Million,
RANK() OVER (PARTITION BY Manufacturer
ORDER BY Units_Sold_Million DESC) AS rank_num
FROM smartphones
) ranked
WHERE rank_num <= 3;