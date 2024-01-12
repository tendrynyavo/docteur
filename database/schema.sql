CREATE TABLE client(
   id_client VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   prenom VARCHAR(100)  NOT NULL,
   PRIMARY KEY(id_client)
);

CREATE TABLE prestation(
   id_prestation VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   point INTEGER NOT NULL,
   debut_etat INTEGER,
   fin_etat INTEGER,
   PRIMARY KEY(id_prestation),
   UNIQUE(nom)
);

CREATE TABLE dent(
   numero VARCHAR(50) ,
   priorite INTEGER,
   PRIMARY KEY(numero)
);

CREATE TABLE consultation(
   id_consultation VARCHAR(50) ,
   date_consultation DATE NOT NULL,
   id_client VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_consultation),
   FOREIGN KEY(id_client) REFERENCES client(id_client)
);

CREATE TABLE traitement(
   id_traitement VARCHAR(50) ,
   etat INTEGER,
   id_consultation VARCHAR(50)  NOT NULL,
   numero VARCHAR(50)  NOT NULL,
   id_prestation VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_traitement),
   FOREIGN KEY(id_consultation) REFERENCES consultation(id_consultation),
   FOREIGN KEY(numero) REFERENCES dent(numero),
   FOREIGN KEY(id_prestation) REFERENCES prestation(id_prestation)
);

CREATE TABLE etat_dentaire(
   id_client VARCHAR(50) ,
   numero VARCHAR(50) ,
   etat INTEGER,
   PRIMARY KEY(id_client, numero),
   FOREIGN KEY(id_client) REFERENCES client(id_client),
   FOREIGN KEY(numero) REFERENCES dent(numero)
);

CREATE TABLE cout(
   id_prestation VARCHAR(50) ,
   numero VARCHAR(50) ,
   valeur DOUBLE PRECISION NOT NULL,
   PRIMARY KEY(id_prestation, numero),
   FOREIGN KEY(id_prestation) REFERENCES prestation(id_prestation),
   FOREIGN KEY(numero) REFERENCES dent(numero)
);
