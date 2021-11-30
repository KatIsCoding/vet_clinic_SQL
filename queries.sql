/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals where name LIKE concat('%','mon');
SELECT name from animals where date_of_birth between '2016-01-01' and '2019-01-01';
SELECT name from animals where neutered = true and escape_attempts < 3;
SELECT date_of_birth from animals where name = 'Agumon' or name = 'Pickachu';
SELECT name, escape_attempts from animals where weight_kg > 10.5;
SELECT * from animals where neutered = true;
SELECT * from animals where weight_kg between 10.4 and 17.3;

/* Second Excercise Queries */

SELECT count(*) from animals;
SELECT count(*) from animals where escape_attempts = 0;
SELECT avg(weight_kg) from animals;
SELECT neutered, avg(escape_attempts) as escapes_average from animals group by neutered;
SELECT species as type, max(weight_kg) as max_weight, min(weight_kg) as min_weight from animals group by species;
SELECT species as type, avg(escape_attempts) as escapes_average from animals where date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' group by type;
