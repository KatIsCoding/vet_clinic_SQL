/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals where name LIKE concat('%','mon');
SELECT name from animals where date_of_birth between '2016-01-01' and '2019-01-01';
SELECT name from animals where neutered = true and escape_attempts < 3;
SELECT date_of_birth from animals where name = 'Agumon' or name = 'Pickachu';
SELECT name, escape_attempts from animals where weight_kg > 10.5;
SELECT * from animals where neutered = true;
SELECT * from animals where weight_kg between 10.4 and 17.3;

/* Second Excercise Queries */

/* UPDATE the animals table by setting the species column to unspecified, then roll back the change. */
/*BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;*/

/*UPDATE the animals table by setting the species column to digimon for all animals that have a name ending in mon.*/
/*BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;*/

/*  Inside a transaction delete all records in the animals table, then roll back the transaction. */
BEGIN;
DELETE FROM animals;
ROLLBACK;

/* DELETE all animals born after Jan 1st, 2022. */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT animals_deleted;

/*  UPDATE all animals' weight to be their weight multiplied by -1. */
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals_deleted;

/* UPDATE all animals' weights that are negative to be their weight multiplied by -1.*/

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


/* Answer to questions at the end of the excercise */

SELECT count(*) as total_animals from animals;
SELECT count(*) as no_escape_animals from animals where escape_attempts = 0;
SELECT avg(weight_kg) as average_weight from animals;
SELECT neutered, avg(escape_attempts) as escapes_average from animals group by neutered;
/*SELECT species as type, max(weight_kg) as max_weight, min(weight_kg) as min_weight from animals group by species;
SELECT species as type, avg(escape_attempts) as escapes_average from animals where date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' group by type;*/



/* Queries for the third exercise */

/* What animals belong to Melody Pond? */
select name from animals join owners on animals.owner_id = owners.id where owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
select animals.name as Pokemons from animals join species on animals.species_id = species.id where species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
select owners.full_name as owners, animals.name as animals from owners left join animals on owners.id = animals.owner_id;

/* How many animals are there per species? */
select species.name as specie_names, count(*) as animals_count from animals join species on animals.species_id = species.id group by species.name;

/* List all Digimon owned by Jennifer Orwell. */
select animals.name from animals join owners on animals.owner_id = owners.id where owners.full_name = 'Jennifer Orwell' and animals.species_id = (select id from species where species.name = 'Digimon');

/* List all animals owned by Dean Winchester that haven't tried to escape. */
select animals.name from animals join owners on animals.owner_id = owners.id where owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

/* Who owns the most animals? */
select owners.full_name as owners, count(animals) as animals_count from owners left join animals on owners.id = animals.owner_id group by owners.full_name;

/* Third Excercise Queries */

/* Who was the last animal seen by William Tatcher? */

select animals.name as animal_name, vets.name as vet, visit_date from visits join vets on visits.vets_id = vets.id join animals on animals_id = animals.id where vets.name = 'William Tatcher' order by visit_date desc limit 1;

/* How many different animals did Stephanie Mendez see? */

select count(*) from visits join vets on visits.vets_id = vets.id join animals on animals_id = animals.id where vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties. */

select vets.name as vet, species.name as specie from vets left join specializations on specializations.vets_id = vets.id left join species on specializations.species_id = species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */

select animals.name as animal_name, visits.visit_date as visit_date from visits join vets on visits.vets_id = vets.id join animals on animals_id = animals.id where vets.name = 'Stephanie Mendez' and visits.visit_date between '2020-04-01' and '2020-08-30';

/* What animal has the most visits to vets? */

select count(*) as visits_count, animals.name as animal_name from visits join vets on visits.vets_id = vets.id join animals on animals_id = animals.id group by animals.name order by visits_count desc limit 1;

/* Who was Maisy Smith's first visit? */

select animals.name as animal, visit_date from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id where vets.name = 'Maisy Smith' order by visit_date limit 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */

select animals.name as animal_name, animals.date_of_birth as animal_date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, species.name as specie, owners.full_name as animals_owner, vets.name as vet_name, vets.age as vet_age, visit_date from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id join species on animals.species_id = species.id join owners on animals.owner_id = owners.id order by visit_date desc limit 1;

/* How many visits were with a vet that did not specialize in that animal's species? */

select count(*) as visits_count from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id join species on animals.species_id = species.id where vets.id not in (select specializations.vets_id from specializations join species on specializations.species_id = species.id);

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */

select species.name as most_requested_specie from visits join vets on visits.vets_id = vets.id join animals on visits.animals_id = animals.id join species on animals.species_id = species.id where vets.id not in (select specializations.vets_id from specializations join species on specializations.species_id = species.id) group by species.name order by count(*) desc limit 1;

