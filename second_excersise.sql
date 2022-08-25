-- C Second exercise

-- C.1) Who is the oldest character?

SELECT 
characters_harrypotter.name,
characters_harrypotter.yearofbirth
FROM characters_harrypotter
WHERE characters_harrypotter.yearofbirth IS not NULL
ORDER BY characters_harrypotter.yearofbirth ASC;

-- Answer: The oldest character is Minerva McGonogall who was born in 1925.


-- C.2) Which house has the highest number of human characters? How many are they?

SELECT 
characters_harrypotter.house,
COUNT(*)
FROM characters_harrypotter
WHERE characters_harrypotter.species = 'human'
AND characters_harrypotter.house is NOT NULL
GROUP BY characters_harrypotter.house
ORDER by COUNT(*) DESC;

-- Answer: The house with the highest number of human characters is Slytherin, with 9 humans.


-- C.3) Who is the house founder with a character who has an ancestry "muggleborn"?

SELECT 
houses_harrypotter.founder,
characters_harrypotter.house,
characters_harrypotter.name as character_name,
characters_harrypotter.ancestry
FROM characters_harrypotter
LEFT JOIN houses_harrypotter
ON characters_harrypotter.house = houses_harrypotter.house
WHERE characters_harrypotter.ancestry = 'muggleborn'
;

-- Answer: The house founder with a character who has an ancestry "muggleborn" is Godric Gryffindor. On the other hand, the house name is Gryffindor, and the character who has an ancestry "muggleborn" in Gryffindor is Hermione Granger.