SELECT*
FROM Test..TheWorldsMostPowerfulPeople


--Organization of participant 
SELECT DISTINCT ORGANİZATİON
FROM Test..TheWorldsMostPowerfulPeople

--Total individual involved
SELECT COUNT(NAME)
FROM Test..TheWorldsMostPowerfulPeople

--Number of participant
SELECT COUNT(RANK) As participant
FROM Test..TheWorldsMostPowerfulPeople

--Avgerage Age
SELECT NAME,ORGANİZATİON,AVG(AGE) OVER () AS AVGAGE
FROM Test..TheWorldsMostPowerfulPeople

--Age Classification
SELECT NAME,ORGANİZATİON,AGE,
CASE
	WHEN AGE < 30 THEN 'YOUNG'
	WHEN AGE > 30 AND AGE < 50 THEN 'AVERAGE'
	ELSE 'OLD'
END
FROM Test..TheWorldsMostPowerfulPeople

--Number of old class
WITH AGECLASS (NAME,ORGANIZATION,AGE,AGECLASS)
AS (
SELECT NAME,ORGANİZATİON,AGE,
CASE
	WHEN AGE < 30 THEN 'YOUNG'
	WHEN AGE > 30 AND AGE < 50 THEN 'AVERAGE'
	ELSE 'OLD'
END AGECLASS
FROM Test..TheWorldsMostPowerfulPeople
)
SELECT COUNT(AGECLASS) AS NUMBEROFOLDMEN
FROM AGECLASS
WHERE AGECLASS = 'OLD'

--Number of Avg age class
WITH AGECLASS (NAME,ORGANIZATION,AGE,AGECLASS)
AS (
SELECT NAME,ORGANİZATİON,AGE,
CASE
	WHEN AGE < 30 THEN 'YOUNG'
	WHEN AGE > 30 AND AGE < 50 THEN 'AVERAGE'
	ELSE 'OLD'
END AGECLASS
FROM Test..TheWorldsMostPowerfulPeople
)
SELECT COUNT(AGECLASS) AS NUMBEROFAVGMEN
FROM AGECLASS
WHERE AGECLASS = 'AVERAGE'

--Oldest in the list
SELECT NAME, ORGANİZATİON
FROM Test..TheWorldsMostPowerfulPeople
WHERE AGE = (SELECT MAX(AGE) FROM Test..TheWorldsMostPowerfulPeople)

--Youngest in the list
SELECT NAME, ORGANİZATİON
FROM Test..TheWorldsMostPowerfulPeople
WHERE AGE = (SELECT MIN(AGE) FROM Test..TheWorldsMostPowerfulPeople)