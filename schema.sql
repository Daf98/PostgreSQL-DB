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

CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY,
name TEXT NOT NULL,
age INT NOT NULL,
date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations(
vet_id INT,
species_id INT
);

CREATE TABLE visits(
vet_id INT,
animal_id INT,
date_of_visit DATE
);

INSERT INTO vets(name, age, date_of_graduation) VALUES('William Thatcher', 45, '2000-04-23');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Jack Harness', 38, '2008-06-08');

INSERT INTO specializations(vet_id, species_id) VALUES (1, 1);
INSERT INTO specializations(vet_id, species_id) VALUES (3, 1);
INSERT INTO specializations(vet_id, species_id) VALUES (3, 2);
INSERT INTO specializations(vet_id, species_id) VALUES (4, 2);
