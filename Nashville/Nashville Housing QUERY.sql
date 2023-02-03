SELECT *
FROM [Property Details]

--cleaning data on property details
SELECT DISTINCT LandUse, REPLACE(LandUse,'vacant res land','VACANT RESIDENTIAL LAND') LandUseFixed
FROM [Property Details]


ALTER TABLE Test..[property Details]
ADD LandUseFixed varchar(50)

UPDATE Test..[property Details]
SET LandUseFixed = REPLACE(LandUse,'vacant res land','VACANT RESIDENTIAL LAND')

SELECT SUBSTRING(CAST(SaleDate AS varchar(50)),1,4) AS YEARS
FROM [Property Details]

ALTER TABLE Test..[property Details]
ADD YEARS varchar(50)

UPDATE Test..[property Details]
SET YEARS = SUBSTRING(CAST(SaleDate AS varchar(50)),1,4)

--cleaning data on property details
SELECT  *
FROM [Owner's Details]

--The code below did not work as intended
--SELECT 
--SUBSTRING(OwnerName, 1, CHARINDEX('&',OwnerName)) as MainOwner,
--SUBSTRING(OwnerName, CHARINDEX('&',OwnerName) +1, LEN(OwnerName)) as Co_Owner
--FROM [Owner's Details]

--ALTER TABLE Test..[Owner's Details]
--ADD MainOwner varchar(50)

--UPDATE Test..[Owner's Details]
--SET MainOwner = SUBSTRING(OwnerName, 1, CHARINDEX('&',OwnerName))

--ALTER TABLE Test..[Owner's Details]
--ADD Co_Owner varchar(50)

--UPDATE Test..[Owner's Details]
--SET Co_Owner = SUBSTRING(OwnerName, CHARINDEX('&',OwnerName) +1, LEN(OwnerName))

--creating join for both tables

SELECT *
FROM [Owner's Details]

ALTER TABLE [Owner's Details]
DROP COLUMN MainOwner,Co_Owner

SELECT *
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID

--Number of bedroom and they sales price
SELECT Bedrooms, AVG(SalePrice) AVGPrice
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID
WHERE Bedrooms IS NOT NULL
GROUP BY Bedrooms
ORDER BY Bedrooms DESC


--Number of bed room with the highest sale price
SELECT Bedrooms, AVG(SalePrice) AVGPrice
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID
WHERE Bedrooms IS NOT NULL
GROUP BY Bedrooms
ORDER BY AVGPrice DESC

--period covered with total salesprice 
SELECT DISTINCT YEARS, SUM(SalePrice) SalesPrice
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID
GROUP BY YEARS

--landuses and sum of its value
SELECT DISTINCT LandUse, SUM(LandValue)  SumOfLandValue
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID
GROUP BY LandUse
ORDER BY 2 DESC

--owner with the highest sale price
SELECT OwnerName, SalePrice
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID
WHERE OwnerName IS NOT NULL
ORDER BY 2 DESC

--maximum values 
WITH MaxValues
AS
(
SELECT MAX(Acreage) MaxAcre , MAX(SalePrice) MaxSale, MAX(LandValue) MaxLV
FROM [Property Details] as prop
JOIN [Owner's Details] as own
on prop.UniqueID = own.UniqueID
)

SELECT MaxSale, MaxAcre
FROM MaxValues


