SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;

------------------------- NIVEL 1---------------------------
-- MISSION 1
-- ¿Cuáles son las primeras 10 observaciones registradas?
-- Utiliza LIMIT para mostrar solo una parte de la tabla;

SELECT * 
FROM observations 
LIMIT 10;

-- MISSION 2
-- ¿Qué identificadores de región (region_id) aparecen en los datos?
-- Usa SELECT DISTINCT para evitar repeticiones.;

SELECT DISTINCT region_id AS Region 
FROM observations;

-- MISSION 3
-- ¿Cuántas especies distintas (species_id) se han observado?
-- Combina COUNT con DISTINCT para no contar duplicados;

SELECT COUNT(DISTINCT species_id) AS Numero_Especies 
FROM observations;

-- MISSION 4
-- ¿Cuántas observaciones hay para la región con region_id = 2?
-- Aplica una condición con WHERE.;

SELECT COUNT(*) AS Numero_Observaciones 
FROM observations 
WHERE region_id = 2;

-- MISSION 5
-- ¿Cuántas observaciones se registraron el día 1998-08-08?
-- Filtra por fecha exacta usando igualdad;

SELECT COUNT(*) AS Numero_Observaciones_1998_08_08 
FROM observations 
WHERE observation_date = '1998-08-08';


-------------------------- NIVEL 2--------------------------

-- MISSION 6
-- ¿Cuál es el region_id con más observaciones?
-- Agrupa por región y cuenta cuántas veces aparece cada una;

SELECT region_id AS Region, COUNT(*) AS Numero_Observaciones 
FROM observations 
GROUP BY region_id 
ORDER BY COUNT(*) 
DESC LIMIT 1;


-- MISSION 7
-- ¿Cuáles son los 5 species_id más frecuentes?
-- Agrupa, ordena por cantidad descendente y limita el resultado;

SELECT species_id AS Especie, COUNT(*) AS Numero_Observaciones 
FROM observations 
GROUP BY species_id 
ORDER BY COUNT(*) 
DESC LIMIT 5;

-- MISSION 8
-- ¿Qué especies (species_id) tienen menos de 5 registros?
-- Agrupa por especie y usa HAVING para aplicar una condición;

SELECT species_id AS Especie, COUNT(*) AS registros
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5
ORDER BY COUNT(*) DESC;

-- MISSION 9
-- ¿Qué observadores (observer) registraron más observaciones?
-- Agrupa por el nombre del observador y cuenta los registros.;

SELECT observer AS Observador, COUNT(*) AS Numero_Observaciones
FROM observations
GROUP BY observer
ORDER BY COUNT(*) DESC;

-------------------------- NIVEL 3--------------------------

-- MISSION 10
-- Muestra el nombre de la región (regions.name) para cada observación.
-- Relaciona observations con regions usando region_id.;

SELECT o.* , r.* 
FROM observations AS o
JOIN regions AS r ON o.region_id = r.id; 

-- MISSION 11
-- Muestra el nombre científico de cada especie registrada (species.scientific_name).
-- Relaciona observations con species usando species_id.;

SELECT s.scientific_name AS Nombre_Cientifico, o.*
FROM observations AS o
JOIN species AS s ON o.species_id = s.id; 

-- MISSION 12
-- ¿Cuál es la especie más observada por cada región?
-- Agrupa por región y especie, y ordena por cantidad;
-- OJO: La Consulta no es del todo correcta, tengo entendido que lo recomendado es una funcion
-- de ventana, pero eso no lo se aun, esta consulta da el resultado esperado pero "por casualidad";
SELECT t.* FROM (
    SELECT r.name AS Region, s.scientific_name AS Especie,COUNT(*) AS Numero_Observaciones
    FROM observations AS o
    JOIN species AS s ON o.species_id = s.id
    JOIN regions AS r ON o.region_id = r.id
    GROUP BY o.region_id,o.species_id
    ORDER BY COUNT(*) DESC
) AS t
GROUP BY t.Region
ORDER BY t.Numero_Observaciones DESC;


-------------------------- NIVEL 4--------------------------

-- MISSION 13
-- Inserta una nueva observación ficticia en la tabla observations.
-- Asegúrate de incluir todos los campos requeridos por el esquema.;
INSERT INTO observations 
(species_id, region_id, observer, observation_date, latitude, longitude, count) 
VALUES 
(230, 2, 'obsr453532', '1995-02-11', -42.882034, -54.45171, 9);


-- MISSION 14
-- Corrige el nombre científico de una especie con error tipográfico.
-- Busca primero el nombre incorrecto y luego actualízalo.;
-- Ojo: Se que no tiene un error typografico como tal, pero son muchas especies :(;

UPDATE species
SET scientific_name = 'Donacobius Atricapilla'
WHERE id = 798;

SELECT * 
FROM species 
WHERE id = 798;

-- MISSION 15
-- Elimina una observación de prueba (usa su id).
-- Asegúrate de no borrar datos importantes.;
-- last_insert_rowid devuelve elultimo id generado;

DELETE 
FROM observations 
WHERE id=
    (SELECT last_insert_rowid());

