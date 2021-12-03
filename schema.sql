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

ALTER table animals ADD CONSTRAINT r_species foreign key (species_id) references species (id);
ALTER table animals ADD CONSTRAINT r_owners foreign key (owner_id) references owners (id);


