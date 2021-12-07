/* Database schema to keep the structure of entire database. */
/* createdb vet_clinic */
/* psql vet_clinic */

CREATE TABLE animals (
    id SERIAL,
    name text NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg decimal NOT NULL,
    species_id integer,
    owner_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE owners (
    id SERIAL,
    full_name text NOT NULL,
    age integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id SERIAL,
    name text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE vets (
    id SERIAL,
    name text NOT NULL,
    age integer NOT NULL,
    date_of_graduation date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
  id SERIAL,
  species_id integer,
  vets_id integer,
  PRIMARY KEY(id)
);

CREATE TABLE visits (
    id SERIAL,
    animals_id integer,
    vets_id integer,
    visit_date date NOT NULL,
    PRIMARY KEY(id)
);




ALTER table specializations ADD CONSTRAINT r_species foreign key (species_id) references species(id);
ALTER table specializations ADD CONSTRAINT r_vets foreign key (vets_id) references vets(id);

ALTER table visits ADD CONSTRAINT r_vets foreign key (vets_id) references vets(id);
ALTER table visits ADD CONSTRAINT r_animals foreign key (animals_id) references animals(id);




ALTER table animals ADD CONSTRAINT r_species foreign key (species_id) references species (id);
ALTER table animals ADD CONSTRAINT r_owners foreign key (owner_id) references owners (id);


