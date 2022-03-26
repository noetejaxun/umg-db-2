--============================================================================
--                                Comandos DDL
--============================================================================
CREATE DATABASE [Actividad-clase]

USE [Actividad-clase]

--DDL
--CREATE
CREATE TABLE alumnos
  (
     dpi      VARCHAR(15),
     nombre   VARCHAR(100),
     apellido VARCHAR(100)
  )

--DROP
DROP TABLE alumnos

USE bancos

DROP DATABASE [Actividad-clase]

--ALTER
ALTER TABLE alumnos
  ADD edad INT

-- Convertir la futura clave primaria en notnull
ALTER TABLE alumnos
  ALTER COLUMN dpi VARCHAR(15) NOT NULL

-- Creamos la clave primaria
--https://docs.microsoft.com/en-us/sql/relational-databases/tables/create-primary-keys?view=sql-server-ver15
ALTER TABLE alumnos
  ADD CONSTRAINT pk_dpi PRIMARY KEY CLUSTERED (dpi);

-- Agregar not null a los campos
ALTER TABLE alumnos
  ALTER COLUMN nombre VARCHAR(100) NOT NULL

ALTER TABLE alumnos
  ALTER COLUMN apellido VARCHAR(100) NOT NULL

ALTER TABLE alumnos
  ALTER COLUMN edad INT NOT NULL

--TRUCATE
--Elimina todos los registros de la tabla y reinicia los campos autoincrementables (identity)
TRUNCATE TABLE alumnos

--Consultar particiones del sistema
SELECT *
FROM   sys.partitions

--Truncate: https://docs.microsoft.com/en-us/sql/t-sql/statements/truncate-table-transact-sql?view=sql-server-ver15
SELECT *
FROM   alumnos

--============================================================================
--                                Comandos DML
--============================================================================
--INSERT
USE [Actividad-clase]

INSERT INTO alumnos
            (dpi,
             nombre,
             apellido,
             edad)
VALUES      ('1122222',
             'Haroldo',
             'Turcios',
             25),
            ('123133',
             'Hugo',
             'BB',
             20),
            ('123123',
             'Hugo',
             'BB',
             20),
            ('1231543',
             'Hugo',
             'BB',
             20),
            ('123138',
             'Hugo',
             'BB',
             20),
            ('1231883',
             'Hugo',
             'BB',
             20);

-- Tips: Otra forma de ingresar varios registros
INSERT INTO alumnos
VALUES      ('50',
             'pedro',
             'perez',
             19),
            ('51',
             'pablo',
             'lopez',
             33),
            ('52',
             'juan',
             'cruz',
             34),
            ('53',
             'luis',
             'solly',
             21),
            ('54',
             'carlos',
             'leal',
             19);

--UPDATE
--Actualiza los campos seleccionados (si no colocamos un where se actualizaran todas las filas de la tabla)
UPDATE alumnos
SET    edad = 25
WHERE  dpi = '11223344';

UPDATE alumnos
SET    nombre = 'Carlos',
       apellido = 'Garcia'
WHERE  dpi = '1122222';

SELECT *
FROM   alumnos

--DELETE
--Eliminar el objeto especificado (Recordar selccionar correctamente la tabla y columna a eliminar)
DELETE FROM alumnos
WHERE  dpi = '52';

--Realizar copia de tabla Alumnos
SELECT *
INTO   copia_alumnos
FROM   alumnos;

SELECT *
FROM   copia_alumnos

--Si no utilizamos where se eliminaran todos los registros
DELETE FROM copia_alumnos

--Drop: elimina el objeto (DDL)
DROP TABLE copia_alumnos

--Truncate: borra e inicializa la tabla (DDL)
TRUNCATE TABLE copia_alumnos

--============================================================================
--                                Comandos Select
--============================================================================
--Select permite consultar la informacion de la base de datos combinado con otros comandos
SELECT *
INTO   copia_alumnos
FROM   alumnos;

SELECT *
FROM   copia_alumnos 