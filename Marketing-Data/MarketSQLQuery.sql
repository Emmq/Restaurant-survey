SELECT *
FROM Test..market_data

--1. customer’s age that makes more purchase
with cte_age as(
SELECT BirthYear, (2023 - BirthYear) as Age, TotalPurchase
FROM Test..market_data
)
select Age, TotalPurchase
from cte_age
order by 2 desc

--2.	Based on education qualification, calculate the highest purchase
SELECT Education, sum(TotalPurchase) HighestPurchaser
FROM Test..market_data
group by Education
order by 2 desc

--3.	Based on marital status, calculate the highest purchase
SELECT Marital_Status, sum(TotalPurchase) HighestPurchaser
FROM Test..market_data
group by Marital_Status
order by 2 desc

--4.	Based on education qualification, calculate the highest income
SELECT Education, sum(Income) HighestIncome
FROM Test..market_data
group by Education
order by 2 desc

--5.	compare the total purchase of families with kids at home to families with teenagers

SELECT Kidhome, sum(TotalPurchase) purOfFamWithKid
FROM Test..market_data
group by Kidhome


SELECT Teenhome, sum(TotalPurchase) purOfFamWithteen
FROM Test..market_data
group by Teenhome

--6.	what particular year has the highest purchase

CREATE TABLE temp_year(
years varchar(50),
HighestPurchase int
)
INSERT INTO temp_year
SELECT SUBSTRING(CAST(Enrollmentdate AS varchar(50)),1,4) as years, sum(TotalPurchase) HighestPurchase
from Test..market_data
group by Enrollmentdate

select distinct(years),sum(HighestPurchase) TotalPurPerYear
from temp_year
group by years
order by 2

--7.	who is the most frequent customer
SELECT ID, sum(Recency) MostFrequentCus
FROM Test..market_data
group by ID
order by 2 desc

--8.	percentage of purchase through the web
with ctePercent 
as(
SELECT sum(NumWebPurchases) SumOfWebPur, sum(TotalPurchase) SumOfTotalPur
FROM Test..market_data
)
select cast(1.00*SumOfWebPur/SumOfTotalPur as decimal(4,3))*100 WebPurPercentage
from ctePercent

--9.	percentage of purchase through catalog
with ctePercent 
as(
SELECT sum(NumCatalogPurchases) SumOfCatPur, sum(TotalPurchase) SumOfTotalPur
FROM Test..market_data
)
select cast(1.00*SumOfCatPur/SumOfTotalPur as decimal(4,3))*100 CatPurPercentage
from ctePercent

--10.	percentage of purchase through the store
with ctePercent 
as(
SELECT sum(NumStorePurchases) SumOfStorePur, sum(TotalPurchase) SumOfTotalPur
FROM Test..market_data
)
select cast(1.00*SumOfStorePur/SumOfTotalPur as decimal(4,3))*100 StorePurPercentage
from ctePercent

--11.	out of those that visit the web, what percentage really made purchase through the web
with ctePercent 
as(
SELECT sum(NumWebPurchases) SumOfWebPur, sum(NumWebVisitsMonth) SumOfWebVisit
FROM Test..market_data
)
select SumOfWebVisit, cast(1.00*SumOfWebPur/SumOfWebVisit as decimal(4,3))*100 WebPurPercentage
from ctePercent

--12.	percentage of customers that complained
with ctePercent 
as(
SELECT sum(ID) TotalCustomer, count(Complain) ComplainedCust
FROM Test..market_data
where Complain != 0
)
select TotalCustomer,ComplainedCust, cast(1.00*ComplainedCust/TotalCustomer as decimal(6,5))*100 PercentageOfComp
from ctePercent

--13.	Where do customers that makes the highest purchase from, regarding to nationality.
SELECT Country, sum(TotalPurchase) NumPurchase
FROM Test..market_data
group by Country
order by 2 desc
