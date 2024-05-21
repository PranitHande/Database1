-- QUESTION 1

SELECT locations.location_name AS [Country Name(CN)],
       'D' || (ROW_NUMBER() OVER (PARTITION BY vaccination.iso_code ORDER BY vaccination.date) - 1) AS [Administered Vaccine on Day Number (DN)],
       SUM(COALESCE(vaccination.people_vaccinated, 0) + COALESCE(vaccination.people_fully_vaccinated, 0) + COALESCE(vaccination.total_boosters, 0) ) OVER (PARTITION BY vaccination.iso_code ORDER BY vaccination.date) AS [ Total Injected People]
  FROM vaccination
       JOIN
       locations ON locations.iso_code = vaccination.iso_code
 ORDER BY locations.location_name,
          vaccination.date;
;

          
-- QUESTION 2

SELECT locations.location_name AS Country,
       SUM(COALESCE(vaccination.people_vaccinated, 0) + COALESCE(vaccination.people_fully_vaccinated, 0) + COALESCE(vaccination.total_boosters, 0) ) AS [Cumulative Doses]
  FROM vaccination
       JOIN
       locations ON vaccination.iso_code = locations.iso_code
 GROUP BY locations.location_name
 ORDER BY [Cumulative Doses] DESC;

-- QUESTION 3
SELECT DISTINCT country_vaccine.vaccine AS "Vaccine Type", locations.location_name AS "Country"
FROM country_vaccine
JOIN locations ON country_vaccine.iso_code = locations.iso_code
ORDER BY country_vaccine.vaccine;
       
-- QUESTION 4

SELECT source.source_name AS [Source Name (URL)],
       MAX(COALESCE(vaccination.people_vaccinated, 0) + COALESCE(vaccination.people_fully_vaccinated, 0) + COALESCE(vaccination.total_boosters, 0) ) AS [Largest total Administered Vaccines]
  FROM vaccination
       JOIN
       source ON vaccination.source_name = source.source_name
 GROUP BY source.source_url
 order by [Largest total Administered Vaccines] DESC ;
 
-- QUESTION 5

SELECT date.month AS Date,
       SUM(CASE WHEN iso_code = 'AUS' THEN people_fully_vaccinated END) AS Australia,
       SUM(CASE WHEN iso_code = 'USA' THEN people_fully_vaccinated END) AS [United States],
       SUM(CASE WHEN iso_code = 'OWID_ENG' THEN people_fully_vaccinated END) AS England,
       SUM(CASE WHEN iso_code = 'NZL' THEN people_fully_vaccinated END) AS [New Zealand]
  FROM country_vaccinations
       JOIN
       date ON country_vaccinations.date = date.date
 WHERE date.year = 2022
 GROUP BY date.month;
