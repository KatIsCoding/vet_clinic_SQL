/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  (1, 'Agumon', '2020-02-03', 0, true, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, true, 8),
  (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
  (4, 'Devimon', '2017-05-12', 5, true, 11),
  (5, 'Charmander', '2020-02-08', 0, false, -11 ),
  (6, 'Plantmon', '2022-11-15', 2, true, -5.7 ),
  (7, 'Squirtle', '1993-04-02', 3, false, -12.13 ),
  (8, 'Angemon', '2005-01-12', 1, true, -45 ),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4 ),
  (10, 'Blossom', '1998-10-13', 3, true, 17 );


INSERT into owners (full_name, age)
VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Wittaker', 38);

INSERT into species (name) 
VALUES 
('Pokemon'), ('Digimon');


/* Assigns the specie ID to the animal. */
update animals set species_id = (select id from species where name = 'Digimon') where name like '%mon';
update animals set species_id = (select id from species where name = 'Pokemon') where species_id is null;

/* Assigns owners to the Animals */ 
update animals set owner_id = (select id from owners where full_name = 'Sam Smith') where name = 'Agumon';
update animals set owner_id = (select id from owners where full_name = 'Jennifer Orwell') where name = 'Gabumon' or name = 'Pikachu';
update animals set owner_id = (select id from owners where full_name = 'Bob') where name = 'Devimon' or name = 'Plantmon';
update animals set owner_id = (select id from owners where full_name = 'Melody Pond') where name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';
update animals set owner_id = (select id from owners where full_name = 'Dean Winchester') where name = 'Angemon' or name = 'Boarmon';


/* Vets Data */ 
/*
Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/

INSERT INTO vets (name, age, date_of_graduation)
VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

/* Specializations Data */
/*
Vet William Tatcher is specialized in Pokemon.
Vet Stephanie Mendez is specialized in Digimon and Pokemon.
Vet Jack Harkness is specialized in Digimon.
*/

INSERT INTO specializations (species_id, vets_id)
VALUES
((select id from species where name = 'Pokemon'), (select id from vets where name = 'William Tatcher')),
((select id from species where name = 'Digimon'), (select id from vets where name = 'Stephanie Mendez')),
((select id from species where name = 'Pokemon'), (select id from vets where name = 'Stephanie Mendez')),
((select id from species where name = 'Digimon'), (select id from vets where name = 'Jack Harkness'));

/* Visits Data */
/*
Agumon visited William Tatcher on May 24th, 2020.
Agumon visited Stephanie Mendez on Jul 22th, 2020.
Gabumon visited Jack Harkness on Feb 2nd, 2021.
Pikachu visited Maisy Smith on Jan 5th, 2020.
Pikachu visited Maisy Smith on Mar 8th, 2020.
Pikachu visited Maisy Smith on May 14th, 2020.
Devimon visited Stephanie Mendez on May 4th, 2021.
Charmander visited Jack Harkness on Feb 24th, 2021.
Plantmon visited Maisy Smith on Dec 21st, 2019.
Plantmon visited William Tatcher on Aug 10th, 2020.
Plantmon visited Maisy Smith on Apr 7th, 2021.
Squirtle visited Stephanie Mendez on Sep 29th, 2019.
Angemon visited Jack Harkness on Oct 3rd, 2020.
Angemon visited Jack Harkness on Nov 4th, 2020.
Boarmon visited Maisy Smith on Jan 24th, 2019.
Boarmon visited Maisy Smith on May 15th, 2019.
Boarmon visited Maisy Smith on Feb 27th, 2020.
Boarmon visited Maisy Smith on Aug 3rd, 2020.
Blossom visited Stephanie Mendez on May 24th, 2020.
Blossom visited William Tatcher on Jan 11th, 2021.
*/

INSERT INTO visits (animals_id, vets_id, visit_date)
VALUES
((select id from animals where name = 'Agumon'), (select id from vets where name = 'William Tatcher'), '2020-05-24'),
((select id from animals where name = 'Agumon'), (select id from vets where name = 'Stephanie Mendez'), '2020-07-22'),
((select id from animals where name = 'Gabumon'), (select id from vets where name = 'Jack Harkness'), '2021-02-02'),
((select id from animals where name = 'Pikachu'), (select id from vets where name = 'Maisy Smith'), '2020-01-05'),
((select id from animals where name = 'Pikachu'), (select id from vets where name = 'Maisy Smith'), '2020-03-08'),
((select id from animals where name = 'Pikachu'), (select id from vets where name = 'Maisy Smith'), '2020-05-14'),
((select id from animals where name = 'Devimon'), (select id from vets where name = 'Stephanie Mendez'), '2021-05-04'),
((select id from animals where name = 'Charmander'), (select id from vets where name = 'Jack Harkness'), '2021-02-24'),
((select id from animals where name = 'Plantmon'), (select id from vets where name = 'Maisy Smith'), '2019-12-21'),
((select id from animals where name = 'Plantmon'), (select id from vets where name = 'William Tatcher'), '2020-08-10'),
((select id from animals where name = 'Plantmon'), (select id from vets where name = 'Maisy Smith'), '2021-04-07'),
((select id from animals where name = 'Squirtle'), (select id from vets where name = 'Stephanie Mendez'), '2019-09-29'),
((select id from animals where name = 'Angemon'), (select id from vets where name = 'Jack Harkness'), '2020-10-03'),
((select id from animals where name = 'Angemon'), (select id from vets where name = 'Jack Harkness'), '2021-11-04'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2019-01-24'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2020-05-15'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2020-02-27'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2020-08-03'),
((select id from animals where name = 'Blossom'), (select id from vets where name = 'Stephanie Mendez'), '2020-05-24'),
((select id from animals where name = 'Blossom'), (select id from vets where name = 'William Tatcher'), '2020-01-11');
