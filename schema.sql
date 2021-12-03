/* Database schema to keep the structure of entire database. */
/* createdb vet_clinic */
/* psql vet_clinic */

CREATE TABLE animals (
    id integer NOT NULL,
    name text NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg decimal NOT NULL,
    PRIMARY KEY (id)
);

/* Second Excercise Queries */

ALTER TABLE animals ADD species text;