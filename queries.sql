/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2020-01-01'; /* includes 2019 */
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered IS TRUE AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg
 SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered IS TRUE;
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.3 and 17.4; /* includes 10.4 and 17.3 */

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) FROM animals
GROUP BY species;
SELECT species, MAX(weight_kg) FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT
owners.full_name,
animals.name
FROM animals
INNER JOIN owners
ON owners.id = owner_id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
animals.name,
species.name
FROM animals
INNER JOIN species
ON species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
owners.full_name,
animals.name
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(species_id)
FROM animals
JOIN species ON species.id = species_id
GROUP BY species.name;


-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, animals.species_id, owners.full_name
FROM animals
JOIN owners ON owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, animals.escape_attempts, owners.full_name
FROM animals
JOIN owners ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, COUNT (owner_id) FROM animals
FULL JOIN owners ON owners.id = owner_id
GROUP BY owners.full_name;

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, date_of_visit FROM visits
JOIN animals ON visits.animal_id = animals.id
WHERE visits.vet_id = 1
ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal_id) as number_of_visits FROM visits
WHERE visits.vet_id = 3;

-- List all vets and their specialties, including vets with no specialties.
SELECT
vets.name as vet, species.name as species FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits ON visits.animal_id = animals.id
WHERE visits.vet_id = 3 AND
visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.*) as visits FROM animals
FULL JOIN visits on animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit as first_visit FROM animals
FULL JOIN visits on animals.id = visits.animal_id
WHERE visits.vet_id = 2
ORDER BY date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT *
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.date_of_visit) AS number_of_visits
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE visits.vet_id NOT IN (SELECT species_id FROM specializations WHERE vet_id = vets.id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.date_of_visit)
FROM species
JOIN specializations ON species.id = specializations.species_id
JOIN visits ON visits.vet_id = specializations.vet_id
GROUP BY species.name
ORDER BY COUNT(visits.date_of_visit) DESC LIMIT 1;

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';
