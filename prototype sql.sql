CREATE DATABASE library;
USE library;

CREATE TABLE rayon (
    rayon_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- =====================
-- TABLE AUTEUR
-- =====================
CREATE TABLE auteur (
    auteur_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL
);

-- =====================
-- TABLE LECTEUR
-- =====================
CREATE TABLE lecteur (
    lecteur_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    tel VARCHAR(15) NOT NULL UNIQUE,
    cin VARCHAR(8) NOT NULL UNIQUE
);

-- =====================
-- TABLE OUVRAGE
-- =====================
CREATE TABLE ouvrage (
    ouvrage_id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    annee_publication YEAR NOT NULL,
    rayon_id INT NOT NULL,
    FOREIGN KEY (rayon_id) REFERENCES rayon(rayon_id)
);

-- =====================
-- TABLE ASSOCIATION OUVRAGE / AUTEUR
-- =====================
CREATE TABLE ouvrage_auteur (
    ouvrage_id INT,
    auteur_id INT,
    PRIMARY KEY (ouvrage_id, auteur_id),
    FOREIGN KEY (ouvrage_id) REFERENCES ouvrage(ouvrage_id),
    FOREIGN KEY (auteur_id) REFERENCES auteur(auteur_id)
);

-- =====================
-- TABLE EMPRUNT
-- =====================
CREATE TABLE emprunt (
    emprunt_id INT AUTO_INCREMENT PRIMARY KEY,
   date_emprunt DATE NOT NULL DEFAULT (CURRENT_DATE),
    date_retour_prevue DATE NOT NULL,
    date_retour_effective DATE NULL,
    lecteur_id INT NOT NULL,
    ouvrage_id INT NOT NULL,
    FOREIGN KEY (lecteur_id) REFERENCES lecteur(lecteur_id),
    FOREIGN KEY (ouvrage_id) REFERENCES ouvrage(ouvrage_id)
);

-- =====================
-- TABLE PERSONNEL
-- =====================
CREATE TABLE personnel (
    personnel_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    tel VARCHAR(15) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    chef_id INT NULL,
    FOREIGN KEY (chef_id) REFERENCES personnel(personnel_id)
);

-- Insertion dans RAYON
INSERT INTO rayon (nom) VALUES 
('Informatique'), 
('Science-Fiction'), 
('Développement Personnel');

-- Insertion dans AUTEUR
INSERT INTO auteur (nom, prenom) VALUES 
('Martin', 'Robert'), 
('Herbert', 'Frank'), 
('Clear', 'James');

-- Insertion dans LECTEUR
INSERT INTO lecteur (nom, prenom, email, tel, cin) VALUES 
('Alaoui', 'Ahmed', 'ahmed@email.com', '0601020304', 'AB12345'),
('Dupont', 'Marie', 'marie@email.com', '0611223344', 'CD67890');
INSERT INTO lecteur (nom, prenom, email, tel, cin) 
VALUES ('oumayma', 'uhhabi', 'oumamaa@email.com', '0603090704', 'AZ2345');


-- Insertion dans OUVRAGE (Lié au rayon_id)
INSERT INTO ouvrage (titre, annee_publication, rayon_id) VALUES 
('Clean Code', 2008, 1),      -- 1 = Informatique
('Dune', 1965, 2),            -- 2 = Science-Fiction
('Atomic Habits', 2018, 3);   -- 3 = Dév Personnel

select * from ouvrage where ouvrage_id=1;
delete from ouvrage where ouvrage_id=1;
INSERT IGNORE INTO ouvrage_auteur (ouvrage_id, auteur_id) VALUES (1, 1), (2, 2), (3, 3), (4, 1);
select * from ouvrage_auteur;

INSERT INTO emprunt (date_emprunt, date_retour_prevue, lecteur_id, ouvrage_id) VALUES 
('2026-01-05', '2026-01-19', 1, 1),('2026-02-05', '2028-01-19', 2, 2);
INSERT INTO emprunt (date_emprunt, date_retour_prevue, lecteur_id, ouvrage_id) VALUES 
('2026-02-05', '2028-01-19', 2, 2);


INSERT INTO personnel (nom, email, tel, mot_de_passe, chef_id) VALUES 
('Admin Principal', 'admin@library.com', '0522001122', 'hash_mdp_123', NULL);


INSERT INTO personnel (nom, email, tel, mot_de_passe, chef_id) VALUES 
('Agent Accueil', 'accueil@library.com', '0522445566', 'hash_mdp_456', 1);
show tables;

SELECT * FROM rayon;
SELECT nom, prenom FROM auteur;
SELECT titre, annee_publication FROM ouvrage;

SELECT *
FROM ouvrage
WHERE annee_publication > 1950;

SELECT *
FROM lecteur
WHERE nom LIKE 'M%';

SELECT *
FROM ouvrage
ORDER BY annee_publication DESC;

SELECT *
FROM emprunt
WHERE date_retour_effective IS NULL;

SELECT o.titre, r.nom
FROM ouvrage o
JOIN rayon r ON o.rayon_id = r.rayon_id;

SELECT DISTINCT l.*
FROM lecteur l
JOIN emprunt e ON l.lecteur_id = e.lecteur_id;

SELECT r.nom, COUNT(o.ouvrage_id) AS nombre_ouvrages
FROM rayon r
LEFT JOIN ouvrage o ON r.rayon_id = o.rayon_id
GROUP BY r.nom;



UPDATE lecteur
SET email = 'newmail@email.com'
WHERE lecteur_id = 1;

UPDATE lecteur
SET tel = '0612345678'
WHERE cin = 'AB12345';

UPDATE ouvrage
SET rayon_id = 2
WHERE ouvrage_id = 3;

UPDATE emprunt
SET date_retour_effective = CURRENT_DATE
WHERE emprunt_id = 1;

UPDATE personnel
SET chef_id = 1
WHERE personnel_id = 2;

DELETE FROM emprunt
WHERE emprunt_id = 2;

DELETE FROM ouvrage
WHERE ouvrage_id = 4;


