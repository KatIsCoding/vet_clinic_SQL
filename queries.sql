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