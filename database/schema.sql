CREATE TABLE parametre(
   id_parametre VARCHAR(50) ,
   nom VARCHAR(100) ,
   PRIMARY KEY(id_parametre)
);

CREATE TABLE patient(
   id_patient VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   date_naissance DATE NOT NULL,
   PRIMARY KEY(id_patient)
);

CREATE TABLE medicament(
   id_medicament VARCHAR(50) ,
   nom VARCHAR(50)  NOT NULL,
   prix DOUBLE PRECISION NOT NULL,
   PRIMARY KEY(id_medicament)
);

CREATE TABLE generation(
   id_generation VARCHAR(50) ,
   nom VARCHAR(50)  NOT NULL,
   debut INTEGER NOT NULL,
   fin INTEGER NOT NULL,
   PRIMARY KEY(id_generation)
);

CREATE TABLE prescription(
   id_parametre VARCHAR(50) ,
   id_medicament VARCHAR(50) ,
   effet DOUBLE PRECISION NOT NULL,
   PRIMARY KEY(id_parametre, id_medicament),
   FOREIGN KEY(id_parametre) REFERENCES parametre(id_parametre),
   FOREIGN KEY(id_medicament) REFERENCES medicament(id_medicament)
);

CREATE TABLE symptome(
   id_parametre VARCHAR(50) ,
   id_medicament VARCHAR(50) ,
   id_generation VARCHAR(50) ,
   debut INTEGER NOT NULL,
   fin INTEGER NOT NULL,
   PRIMARY KEY(id_parametre, id_medicament, id_generation),
   FOREIGN KEY(id_parametre) REFERENCES parametre(id_parametre),
   FOREIGN KEY(id_medicament) REFERENCES medicament(id_medicament),
   FOREIGN KEY(id_generation) REFERENCES generation(id_generation)
);
