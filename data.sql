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
