--Table review
SELECT *
FROM Test..Independence100


--Selecting the columns to work with
SELECT Restaurant,Sales,Meals_Served
FROM Test..Independence100 


--list of Restaurance and number of meals_served
SELECT Restaurant, Meals_Served
FROM Independence100

--Total Meals Served
SELECT SUM(Meals_Served) TotalMealServed
FROM Independence100

--Checking for Restaurant with the hightest sales 
SELECT City,Restaurant,SUM(sales) sales
FROM Independence100
GROUP BY City, Restaurant
ORDER BY sales DESC

--Checking for Restaurant with the hightest MealServed 
SELECT City,Restaurant,SUM(Meals_Served) MealServed
FROM Independence100
GROUP BY City, Restaurant
ORDER BY MealServed DESC

--Checking for Average check greater than 100
SELECT Restaurant, Average_Check
FROM Independence100
WHERE Average_Check > 100

WITH summary (AvgSales,AvgMealServed,SumOfCheck)
AS (
SELECT City, AVG(Sales) OVER (PARTITION BY Restaurant) AS AvgSales, 
 AVG(Meals_Served) OVER (PARTITION BY Restaurant) AS AvgMealServed,
  SUM(Average_Check) OVER (PARTITION BY Restaurant) AS SumOfCheck, 
FROM Independence100
)
SELECT *
FROM summary