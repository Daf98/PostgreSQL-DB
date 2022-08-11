/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id INT GENERATED ALWAYS AS IDENTITY,
name TEXT NOT NULL,
date_of_birth DATE NOT NULL,
escape_attempts INT NOT NULL,
neutered BOOL NOT NULL,
weight_kg DEC NOT NULL
);

ALTER TABLE animals ADD species TEXT;

CREATE TABLE owners(
id INT GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(250) NOT NULL,
age INT,
PRIMARY KEY(id)
);

CREATE TABLE species(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250) NOT NULL,
PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);



