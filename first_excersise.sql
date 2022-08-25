-- A) Creating a table

-- A.1) Creating the first table 

CREATE TABLE communities (
id SERIAL PRIMARY KEY,
 community_name VARCHAR(50),
 capital VARCHAR(60),
 population int,
 density float,
 area_km2 int
  );

-- Inserting values into the first table

INSERT INTO 
communities(community_name, capital, population, density, area_km2)
VALUES ('Andalusia', 'Sevilla', 8472407, 97.05, 87599),
('Catalonia', 'Barcelona', 7763362, 238.84, 32113),
('Community of Madrid', 'Madrid', 6751251, 841.15, 8028),
('Valencian Community', 'Valencia', 5058138, 216.98, 23255),
('Galicia', 'Santiago de Compostela', 2695645, 91.19, 29575),
('Castile and Leon', 'Valladolid', 2383139, 25.34, 94224),
('Basque Country', 'Vitoria', 2213993, 302.13, 7234),
('Castile-La Mancha', 'Toledo', 2049562, 25.79, 79461),
('Murcia', 'Murcia', 1518486, 133.74, 11314),
('Aragon', 'Zaragoza', 1326261, 27.90, 47720),
('Extremadura', 'Merida', 1059501, 25.41, 41634),
('Asturias', 'Oviedo', 1011792, 95.53, 10604),
('Chartered Community of Navarre', 'Pamplona', 661537, 63.30, 10391),
('Cantabria', 'Santander', 584507, 109.74, 5321),
('La Rioja', 'Logrono', 319796, 62.67, 5045),
('Balearic Islands', 'Palma de Mallorca', 1059501, 25.41, 4992),
('Canary Islands', 'Las Palmas de Gran Canaria and Santa Cruz de Tenerife', 2172944, 301.39, 7447),
('Melilla','Melilla', 86261, 7001.58, 12),
('Ceuta', 'Ceuta', 83517, 4175.10, 20)
;

-- Showing the first table

SELECT * 
FROM communities;


-- A.2) Creating the second table

CREATE TABLE about_communities (
 community_name VARCHAR(50),
 community_language VARCHAR(80),
 community_location VARCHAR(30)
  );
  

-- Inserting values into the second table

INSERT INTO
about_communities (community_name, community_language, community_location)
  VALUES ('Andalusia', 'Spanish','Iberian Peninsula'),
('Catalonia',  'Catalan and Occitan co-official with spanish','Iberian Peninsula' ),
('Community of Madrid', 'Spanish', 'Iberian Peninsula'),
('Valencian Community', 'Catalan-Valencian co-official with spanish','Iberian Peninsula'),
('Galicia', 'Galician co-official with spanish', 'Iberian Peninsula'),
('Castile and Leon','Spanish', 'Iberian Peninsula'),
('Basque Country', 'Basque co-official with spanish', 'Iberian Peninsula'),
('Castile-La Mancha', 'Spanish','Iberian Peninsula'),
('Murcia', 'Spanish','Iberian Peninsula'), 
('Aragon', 'Spanish','Iberian Peninsula'),
('Extremadura', 'Spanish','Iberian Peninsula'),
('Asturias','Spanish','Iberian Peninsula'),
('Chartered Community of Navarre', 'Basque co-official with spanish', 'Iberian Peninsula'),
('Cantabria', 'Spanish','Iberian Peninsula'),
('La Rioja', 'Spanish','Iberian Peninsula'),
('Balearic Islands', 'Catalan co-official with spanish', 'In the Mediterranean Sea'),
('Canary Islands', 'Spanish', 'In the Atlantic Ocean'),
('Melilla', 'Spanish', 'On the north coast of Africa'),
('Ceuta', 'Spanish', 'On the north coast of Africa');


-- Showing the second table

 SELECT *
 FROM about_communities;



-- B) Writing queries

-- B.1) Communities' general info

SELECT 
MIN(co.population) as largest_population,
MAX(co.population) AS smallest_population,
MIN(co.density) AS lowest_density,
MAX(co.density) AS highest_density,
MIN(co.area_km2) AS smallest_area_km2,
MAX(co.area_km2) AS largest_area_km2,
COUNT(community_name) AS number_of_communities,
SUM(co.population) as total_pupulation,
ROUND(AVG(co.density)::NUMERIC,2) AS average_density
FROM communities as co;


-- B.2) Top-5 largest communities

SELECT 
co.community_name,
co.area_km2
FROM communities as co
ORDER BY co.area_km2 DESC
LIMIT 5;

-- Answer: Top-5 largest communities are Castile and Leon, Andalusia, Castile-La Mancha, Aragon and Extremadura.


-- B.3) Capitals and community's name of the communities that have the word "Community" in the name.

SELECT
co.capital,
co.community_name
FROM communities AS co
where co.community_name LIKE '%Community%';

-- Answer: Madrid-Community of Madrid; Valencia-Valencian Community; Pamplona-Chartered Community of Navarre


-- B.4) How many languages are there?

SELECT DISTINCT about_communities.community_language
From about_communities;

-- Answer: The languages are: Spanish, Catalan, Occitan, Catalan-Valencian, Galician and Basque.


--B.5) Name and density of autonomous communities/cities that are not located in the Iberian Peninsula and where just Spanish is spoken.

SELECT
co.community_name,
co.density
FROM communities AS co
LEFT JOIN about_communities AS ab 
ON co.community_name = ab.community_name
where ab.community_location <> 'Iberian Peninsula'
and ab.community_language = 'Spanish'
ORDER by co.density;

-- Answer: Were found tree communities/cities: Canary Islands, Ceuta and Melilla.


--B.6) Most common community_location (>1), count and average-population

SELECT
ab.community_location,
COUNT(*),
ROUND(AVG(Population)::NUMERIC,0) as Average_population
FROM communities AS co
LEFT JOIN about_communities AS ab 
ON co.community_name = ab.community_name
GROUP BY ab.community_location
HAVING COUNT(*) > 1;

-- Answer: Most common locations are: Iberian Peninsula (15) with an average population of 2 924 625 people; and on the north coast of Africa (2) with an average populaton of 84 889 people.
