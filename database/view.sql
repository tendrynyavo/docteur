CREATE OR REPLACE VIEW v_maladie AS
SELECT m.ID_MALADIE , m.NOM AS maladie , g.DEBUT , g.FIN , p.ID_PARAMETRE , p.NOM AS parametre, s.MIN , s.MAX  
FROM symptome s
    JOIN maladie m ON s.id_maladie = m.id_maladie
    JOIN generation g ON s.id_generation = g.id_generation
    JOIN parametre p ON s.id_parametre = p.id_parametre;


CREATE OR REPLACE VIEW v_medicament AS
SELECT m.id_medicament, m.nom, p.id_parametre, effet
FROM prescription p
    JOIN medicament m ON p.id_medicament = m.id_medicament
ORDER BY ID_Parametre;