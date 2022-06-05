USE GD1C2022
GO

-- Eliminacion de tablas
	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'medicion')
		DROP TABLE AJO_DER.medicion

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_de_motor')
		DROP TABLE AJO_DER.estado_de_motor

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_de_caja_de_cambios')
		DROP TABLE AJO_DER.estado_de_caja_de_cambios

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_freno')
		DROP TABLE AJO_DER.estado_freno

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_neumatico')
		DROP TABLE AJO_DER.estado_neumatico

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'cambio_neumaticos')
		DROP TABLE AJO_DER.cambio_neumaticos

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'parada_box')
		DROP TABLE AJO_DER.parada_box

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'motor')
		DROP TABLE AJO_DER.motor

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'caja_de_cambios')
		DROP TABLE AJO_DER.caja_de_cambios

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'freno')
		DROP TABLE AJO_DER.freno

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'neumatico')
		DROP TABLE AJO_DER.neumatico

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'incidente_auto')
		DROP TABLE AJO_DER.incidente_auto

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'incidente')
		DROP TABLE AJO_DER.incidente

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'carrera')
		DROP TABLE AJO_DER.carrera

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'sector')
		DROP TABLE AJO_DER.sector

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'circuito')
		DROP TABLE AJO_DER.circuito

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'auto')
		DROP TABLE AJO_DER.auto

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'escuderia')
		DROP TABLE AJO_DER.escuderia

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'piloto')
		DROP TABLE AJO_DER.piloto




	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'posicion')
		DROP TABLE AJO_DER.posicion

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'tipo_neumatico')
		DROP TABLE AJO_DER.tipo_neumatico

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'bandera')
		DROP TABLE AJO_DER.bandera

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'tipo_incidente')
		DROP TABLE AJO_DER.tipo_incidente

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'tipo_sector')
		DROP TABLE AJO_DER.tipo_sector

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'pais')
		DROP TABLE AJO_DER.pais

-- Eliminacion de store procedure
	IF OBJECT_ID('AJO_DER.migrar_escuderia', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_escuderia

	IF OBJECT_ID('AJO_DER.migrar_piloto', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_piloto

	IF OBJECT_ID('AJO_DER.migrar_auto', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_auto

	IF OBJECT_ID('AJO_DER.migrar_tipo_incidente', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_tipo_incidente

	IF OBJECT_ID('AJO_DER.migrar_bandera', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_bandera

	IF OBJECT_ID('AJO_DER.migrar_incidente', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_incidente

	IF OBJECT_ID('AJO_DER.migrar_incidente_auto', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_incidente_auto

	IF OBJECT_ID('AJO_DER.migrar_tipo_sector', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_tipo_sector

	IF OBJECT_ID('AJO_DER.migrar_pais', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_pais
	
	IF OBJECT_ID('AJO_DER.migrar_circuito', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_circuito

	IF OBJECT_ID('AJO_DER.migrar_sector', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_sector

	IF OBJECT_ID('AJO_DER.migrar_carrera', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_carrera

	IF OBJECT_ID('AJO_DER.migrar_medicion', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_medicion

	IF OBJECT_ID('AJO_DER.migrar_parada_box', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_parada_box

	IF OBJECT_ID('AJO_DER.migrar_motores', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_motores

	IF OBJECT_ID('AJO_DER.migrar_estado_de_motor', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_estado_de_motor

	IF OBJECT_ID('AJO_DER.migrar_caja_de_cambios', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_caja_de_cambios

	IF OBJECT_ID('AJO_DER.migrar_estado_de_caja_de_cambios', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_estado_de_caja_de_cambios

	IF OBJECT_ID('AJO_DER.migrar_frenos', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_frenos

	IF OBJECT_ID('AJO_DER.migrar_estado_de_freno_1', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_estado_de_freno_1

	IF OBJECT_ID('AJO_DER.migrar_estado_de_freno_2', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_estado_de_freno_2

	IF OBJECT_ID('AJO_DER.migrar_estado_de_freno_3', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_estado_de_freno_3

	IF OBJECT_ID('AJO_DER.migrar_estado_de_freno_4', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_estado_de_freno_4

	IF OBJECT_ID('AJO_DER.migrar_tipo_neumatico', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_tipo_neumatico

	IF OBJECT_ID('AJO_DER.migrar_neumaticos_1', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_neumaticos_1

	IF OBJECT_ID('AJO_DER.migrar_neumaticos_2', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_neumaticos_2

	IF OBJECT_ID('AJO_DER.migrar_neumaticos_3', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_neumaticos_3

	IF OBJECT_ID('AJO_DER.migrar_neumaticos_4', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_neumaticos_4


	IF OBJECT_ID('AJO_DER.migrar_tablas', 'P') IS NOT NULL
		DROP PROCEDURE AJO_DER.migrar_tablas


-- Eliminacion de esquema
IF EXISTS (SELECT name FROM sys.schemas WHERE name LIKE 'AJO_DER')
    DROP SCHEMA AJO_DER
GO

-- Creacion de esquema
CREATE SCHEMA AJO_DER
GO

-- Creacion de tablas
  CREATE TABLE AJO_DER.parada_box (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_carrera INT, -- FK
    id_auto INT, -- FK
    numero_vuelta DECIMAL(18,0),
    tiempo_parada DECIMAL(18,2)
  );

  CREATE TABLE AJO_DER.cambio_neumaticos (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_parada_box INT, -- FK
      id_neumatico_anterior INT, -- FK
      id_neumatico_nuevo INT, -- FK
    id_posicion INT -- FK
  );

  CREATE TABLE AJO_DER.auto (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      id_escuderia INT, -- FK
      id_piloto INT, -- FK
      numero_auto INT,
    modelo VARCHAR(255)
  );

  CREATE TABLE AJO_DER.posicion (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    descripcion VARCHAR(255)
  );

  CREATE TABLE AJO_DER.escuderia (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      nombre VARCHAR(255),
      id_nacionalidad INT -- FK
  );

  CREATE TABLE AJO_DER.piloto (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      id_nacionalidad INT, -- FK
      nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE
  );

  CREATE TABLE AJO_DER.motor (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    modelo NVARCHAR(255),
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE AJO_DER.caja_de_cambios (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    modelo NVARCHAR(255),
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE AJO_DER.freno (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE AJO_DER.neumatico (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    id_tipo_neumatico INT, -- FK
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE AJO_DER.tipo_neumatico (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    tipo VARCHAR(255)
  );

  CREATE TABLE AJO_DER.estado_de_motor (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_motor INT, -- FK
    potencia DECIMAL(18,6),
    temperatura_aceite DECIMAL(18,6),
    temperatura_agua DECIMAL(18,6),
    rpm INT
  );

  CREATE TABLE AJO_DER.estado_de_caja_de_cambios (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_caja_de_cambios INT, -- FK
    temperatura_aceite DECIMAL(18,2),
    rpm INT,
    desgaste DECIMAL(18,2)
  );

  CREATE TABLE AJO_DER.bandera (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    color VARCHAR(255)
  );

  CREATE TABLE AJO_DER.tipo_incidente (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    tipo VARCHAR(255)
  );

  CREATE TABLE AJO_DER.incidente (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_carrera INT, -- FK
    id_sector INT, -- FK
    id_bandera INT, -- FK
    tiempo DECIMAL(18,2),
  );

  CREATE TABLE AJO_DER.incidente_auto (
	id INT NOT NULL IDENTITY PRIMARY KEY,
    id_incidente INT, -- FK
    id_auto INT, -- FK
    id_tipo_incidente INT, -- FK
    numero_vuelta DECIMAL(18,0)
  );

  CREATE TABLE AJO_DER.sector (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_circuito INT, -- FK
    id_tipo_sector INT, -- FK
    distancia DECIMAL(18,2),
    codigo INT
  );

  CREATE TABLE AJO_DER.tipo_sector (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    tipo VARCHAR(255)
  );

  CREATE TABLE AJO_DER.pais (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nombre VARCHAR(255)
  );

  CREATE TABLE AJO_DER.circuito (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_pais INT, -- FK
    codigo INT,
    nombre VARCHAR(255)
  );

  CREATE TABLE AJO_DER.medicion (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    id_carrera INT, -- FK
    id_sector INT, -- FK
    nro_vuelta DECIMAL(18,0),
    distancia_carrera DECIMAL(18,6),
    distancia_vuelta DECIMAL(18,2),
    tiempo_vuelta DECIMAL(18,10),
    posicion DECIMAL(18,0),
    velocidad DECIMAL(18,2),
    cant_combustible DECIMAL(18,2)
  );

  CREATE TABLE AJO_DER.carrera (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_circuito INT, -- FK
    cant_vueltas INT,
    fecha DATE,
    codigo INT,
    clima VARCHAR(100),
    total_carrera DECIMAL(18,2)
  );

  CREATE TABLE AJO_DER.estado_freno (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_freno INT, -- FK
    id_posicion INT, -- FK
    grosor_pastilla DECIMAL(18,2),
    temperatura DECIMAL(18,2)
  );

  CREATE TABLE AJO_DER.estado_neumatico (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_neumatico INT, -- FK
    id_posicion INT, -- FK
    profundidad DECIMAL(18,6),
    presion DECIMAL(18,6),
    temperatura DECIMAL(18,6)
  );


	-- FKs de parada_box
	ALTER TABLE AJO_DER.parada_box ADD FOREIGN KEY(id_carrera) REFERENCES AJO_DER.carrera(id);
	ALTER TABLE AJO_DER.parada_box ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de cambio_neumaticos
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_parada_box) REFERENCES AJO_DER.parada_box(id);
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_neumatico_anterior) REFERENCES AJO_DER.neumatico(id);
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_neumatico_nuevo) REFERENCES AJO_DER.neumatico(id);
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_posicion) REFERENCES AJO_DER.posicion(id);

	-- FKs de auto
	ALTER TABLE AJO_DER.auto ADD FOREIGN KEY(id_escuderia) REFERENCES AJO_DER.escuderia(id);
	ALTER TABLE AJO_DER.auto ADD FOREIGN KEY(id_piloto) REFERENCES AJO_DER.piloto(id);

	-- FKs de posicion
	-- N/A

	-- FKs de escuderia
	ALTER TABLE AJO_DER.escuderia ADD FOREIGN KEY(id_nacionalidad) REFERENCES AJO_DER.pais(id);

	-- FKs de piloto
	ALTER TABLE AJO_DER.piloto ADD FOREIGN KEY(id_nacionalidad) REFERENCES AJO_DER.pais(id);

	-- FKs de motor
	ALTER TABLE AJO_DER.motor ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de caja_de_cambios
	ALTER TABLE AJO_DER.caja_de_cambios ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de freno
	ALTER TABLE AJO_DER.freno ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de neumatico
	ALTER TABLE AJO_DER.neumatico ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);
	ALTER TABLE AJO_DER.neumatico ADD FOREIGN KEY(id_tipo_neumatico) REFERENCES AJO_DER.tipo_neumatico(id);

	-- FKs de tipo_neumatico
	-- N/A

	-- FKs de estado_de_motor
	ALTER TABLE AJO_DER.estado_de_motor ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_de_motor ADD FOREIGN KEY(id_motor) REFERENCES AJO_DER.motor(id);

	-- FKs de estado_de_caja_de_cambios
	ALTER TABLE AJO_DER.estado_de_caja_de_cambios ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_de_caja_de_cambios ADD FOREIGN KEY(id_caja_de_cambios) REFERENCES AJO_DER.caja_de_cambios(id);

	-- FKs de bandera
	-- N/A

	-- FKs de tipo_incidente
	-- N/A

	-- FKs de incidente
	ALTER TABLE AJO_DER.incidente ADD FOREIGN KEY(id_carrera) REFERENCES AJO_DER.carrera(id);
	ALTER TABLE AJO_DER.incidente ADD FOREIGN KEY(id_sector) REFERENCES AJO_DER.sector(id);
	ALTER TABLE AJO_DER.incidente ADD FOREIGN KEY(id_bandera) REFERENCES AJO_DER.bandera(id);

	-- FKs de incidente_auto
	ALTER TABLE AJO_DER.incidente_auto ADD FOREIGN KEY(id_incidente) REFERENCES AJO_DER.incidente(id);
	ALTER TABLE AJO_DER.incidente_auto ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);
	ALTER TABLE AJO_DER.incidente_auto ADD FOREIGN KEY(id_tipo_incidente) REFERENCES AJO_DER.tipo_incidente(id);

	-- FKs de sector
	ALTER TABLE AJO_DER.sector ADD FOREIGN KEY(id_circuito) REFERENCES AJO_DER.circuito(id);
	ALTER TABLE AJO_DER.sector ADD FOREIGN KEY(id_tipo_sector) REFERENCES AJO_DER.tipo_sector(id);

	-- FKs de tipo_sector
	-- N/A

	-- FKs de pais
	-- N/A

	-- FKs de circuito
	ALTER TABLE AJO_DER.circuito ADD FOREIGN KEY(id_pais) REFERENCES AJO_DER.pais(id);

	-- FKs de medicion
	ALTER TABLE AJO_DER.medicion ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);
	ALTER TABLE AJO_DER.medicion ADD FOREIGN KEY(id_carrera) REFERENCES AJO_DER.carrera(id);
	ALTER TABLE AJO_DER.medicion ADD FOREIGN KEY(id_sector) REFERENCES AJO_DER.sector(id);

	-- FKs de carrera
	ALTER TABLE AJO_DER.carrera ADD FOREIGN KEY(id_circuito) REFERENCES AJO_DER.circuito(id);

	-- FKs de estado_freno
	ALTER TABLE AJO_DER.estado_freno ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_freno ADD FOREIGN KEY(id_freno) REFERENCES AJO_DER.freno(id);
	ALTER TABLE AJO_DER.estado_freno ADD FOREIGN KEY(id_posicion) REFERENCES AJO_DER.posicion(id);

	-- FKs de estado_neumatico
	ALTER TABLE AJO_DER.estado_neumatico ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_neumatico ADD FOREIGN KEY(id_neumatico) REFERENCES AJO_DER.neumatico(id);
	ALTER TABLE AJO_DER.estado_neumatico ADD FOREIGN KEY(id_posicion) REFERENCES AJO_DER.posicion(id);

GO
-- Migrar tipo_sector
CREATE PROCEDURE AJO_DER.migrar_tipo_sector
AS
	BEGIN
		INSERT INTO tipo_sector
		SELECT DISTINCT SECTO_TIPO FROM GD1C2022.gd_esquema.Maestra
		WHERE SECTO_TIPO IS NOT NULL
	END
GO

-- Migrar pais
CREATE PROCEDURE AJO_DER.migrar_pais
AS
	BEGIN
		INSERT INTO pais
		SELECT DISTINCT upper(ESCUDERIA_NACIONALIDAD)
		FROM GD1C2022.gd_esquema.Maestra
		WHERE ESCUDERIA_NACIONALIDAD IS NOT NULL

		INSERT INTO pais
		SELECT DISTINCT PILOTO_NACIONALIDAD
		FROM GD1C2022.gd_esquema.Maestra
		WHERE PILOTO_NACIONALIDAD IS NOT NULL 
		AND PILOTO_NACIONALIDAD NOT IN (SELECT nombre FROM pais)

		INSERT INTO pais
		SELECT DISTINCT CIRCUITO_PAIS
		FROM GD1C2022.gd_esquema.Maestra
		WHERE CIRCUITO_PAIS IS NOT NULL 
		AND CIRCUITO_PAIS NOT IN (SELECT nombre FROM pais)
	END
GO

CREATE PROCEDURE AJO_DER.migrar_tipo_incidente
AS
	BEGIN
		INSERT INTO AJO_DER.tipo_incidente 
		SELECT DISTINCT INCIDENTE_TIPO
		FROM GD1C2022.gd_esquema.Maestra
		WHERE INCIDENTE_TIPO IS NOT NULL
	END
GO

CREATE PROCEDURE AJO_DER.migrar_bandera
AS
	BEGIN
		INSERT INTO AJO_DER.bandera 
		SELECT DISTINCT INCIDENTE_BANDERA
		FROM GD1C2022.gd_esquema.Maestra
		WHERE INCIDENTE_BANDERA IS NOT NULL
	END
GO

CREATE PROCEDURE AJO_DER.migrar_escuderia
AS
	BEGIN
		INSERT INTO AJO_DER.escuderia
		SELECT DISTINCT ESCUDERIA_NOMBRE, pais.id
		FROM GD1C2022.gd_esquema.Maestra
		JOIN pais ON upper(ESCUDERIA_NACIONALIDAD) = pais.nombre
		WHERE ESCUDERIA_NOMBRE IS NOT NULL
	END
GO

CREATE PROCEDURE AJO_DER.migrar_piloto
AS
	BEGIN
		INSERT INTO AJO_DER.piloto
		SELECT DISTINCT AJO_DER.pais.id, PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_FECHA_NACIMIENTO
		FROM GD1C2022.gd_esquema.Maestra
		JOIN AJO_DER.pais ON PILOTO_NACIONALIDAD = AJO_DER.pais.nombre
		WHERE PILOTO_NOMBRE IS NOT NULL
	END
GO

CREATE PROCEDURE AJO_DER.migrar_auto
AS
	BEGIN
		INSERT INTO auto
		SELECT DISTINCT escuderia.id, piloto.id, AUTO_NUMERO, AUTO_MODELO
		FROM GD1C2022.gd_esquema.Maestra
		JOIN escuderia ON ESCUDERIA_NOMBRE = escuderia.nombre
		JOIN piloto ON PILOTO_NOMBRE = piloto.nombre AND PILOTO_APELLIDO = piloto.apellido
		WHERE PILOTO_NOMBRE IS NOT NULL
	END
GO

CREATE PROCEDURE AJO_DER.migrar_incidente
AS
	BEGIN
		INSERT INTO incidente
		SELECT DISTINCT carrera.id, sector.id, bandera.id, INCIDENTE_TIEMPO
		FROM GD1C2022.gd_esquema.Maestra
		JOIN carrera ON CODIGO_CARRERA = carrera.codigo
		JOIN sector ON CODIGO_SECTOR = sector.codigo
		JOIN bandera ON INCIDENTE_BANDERA = bandera.color
		WHERE INCIDENTE_TIEMPO IS NOT NULL
	END
GO

CREATE PROCEDURE AJO_DER.migrar_incidente_auto
AS
	BEGIN
		INSERT INTO incidente_auto
		SELECT DISTINCT incidente.id, auto.id, tipo_incidente.id, INCIDENTE_NUMERO_VUELTA
		FROM GD1C2022.gd_esquema.Maestra
		JOIN carrera ON CODIGO_CARRERA = carrera.id
		JOIN incidente ON carrera.id = incidente.id_carrera 
		JOIN piloto ON PILOTO_NOMBRE = piloto.nombre AND PILOTO_APELLIDO = piloto.apellido
		JOIN auto ON piloto.id = auto.id_piloto
		JOIN tipo_incidente ON INCIDENTE_TIPO = tipo_incidente.tipo
		WHERE INCIDENTE_TIEMPO IS NOT NULL
		AND INCIDENTE_TIEMPO = incidente.tiempo
	END
GO

-- Migrar circuito
CREATE PROCEDURE AJO_DER.migrar_circuito
AS
BEGIN
	INSERT INTO circuito
	SELECT DISTINCT pais.id, CIRCUITO_CODIGO, CIRCUITO_NOMBRE FROM GD1C2022.gd_esquema.Maestra
		JOIN pais ON GD1C2022.gd_esquema.Maestra.CIRCUITO_PAIS = pais.nombre
		GROUP BY pais.id, CIRCUITO_CODIGO, CIRCUITO_NOMBRE
		ORDER BY CIRCUITO_CODIGO
END
GO

-- Migrar sector
CREATE PROCEDURE AJO_DER.migrar_sector
AS
BEGIN
	INSERT INTO sector(
		id_circuito,
		id_tipo_sector,
		distancia,
		codigo
	)
	SELECT DISTINCT circuito.id, tipo_sector.id, SECTOR_DISTANCIA, CODIGO_SECTOR FROM GD1C2022.gd_esquema.Maestra
		JOIN circuito ON GD1C2022.gd_esquema.Maestra.CIRCUITO_CODIGO = circuito.codigo
		JOIN tipo_sector ON GD1C2022.gd_esquema.Maestra.SECTO_TIPO = tipo_sector.tipo
		GROUP BY circuito.id, tipo_sector.id, SECTOR_DISTANCIA, CODIGO_SECTOR
		ORDER BY circuito.id, CODIGO_SECTOR, tipo_sector.id
END
GO

-- Migrar carrera
CREATE PROCEDURE AJO_DER.migrar_carrera
AS
BEGIN
	INSERT INTO carrera
	SELECT DISTINCT circuito.id, CARRERA_CANT_VUELTAS, CARRERA_FECHA, CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA FROM GD1C2022.gd_esquema.Maestra
		JOIN circuito ON GD1C2022.gd_esquema.Maestra.CIRCUITO_CODIGO = circuito.codigo
		GROUP BY circuito.id, CARRERA_CANT_VUELTAS, CARRERA_FECHA, CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA
		ORDER BY CODIGO_CARRERA
END
GO

-- Migrar medicion
CREATE PROCEDURE AJO_DER.migrar_medicion
AS
BEGIN
	INSERT INTO medicion(
		id_auto,
		id_carrera,
		id_sector,
		nro_vuelta,
		distancia_carrera,
		distancia_vuelta,
		tiempo_vuelta,
		posicion,
		velocidad,
		cant_combustible
	)
	SELECT DISTINCT auto.id, carrera.id, sector.id, TELE_AUTO_NUMERO_VUELTA, TELE_AUTO_DISTANCIA_CARRERA, TELE_AUTO_DISTANCIA_VUELTA, TELE_AUTO_TIEMPO_VUELTA, TELE_AUTO_POSICION, TELE_AUTO_VELOCIDAD, TELE_AUTO_COMBUSTIBLE FROM GD1C2022.gd_esquema.Maestra
		JOIN escuderia ON GD1C2022.gd_esquema.Maestra.ESCUDERIA_NOMBRE = escuderia.nombre
		JOIN auto ON GD1C2022.gd_esquema.Maestra.AUTO_NUMERO = auto.numero_auto
		JOIN carrera ON GD1C2022.gd_esquema.Maestra.CODIGO_CARRERA = carrera.codigo
		JOIN sector ON GD1C2022.gd_esquema.Maestra.CODIGO_SECTOR = sector.codigo
		GROUP BY auto.id, carrera.id, sector.id, TELE_AUTO_NUMERO_VUELTA, TELE_AUTO_DISTANCIA_CARRERA, TELE_AUTO_DISTANCIA_VUELTA, TELE_AUTO_TIEMPO_VUELTA, TELE_AUTO_POSICION, TELE_AUTO_VELOCIDAD, TELE_AUTO_COMBUSTIBLE
		ORDER BY carrera.id, auto.id, TELE_AUTO_DISTANCIA_CARRERA
END
GO

-- Migrar parada_box
CREATE PROCEDURE AJO_DER.migrar_parada_box
AS
BEGIN
	INSERT INTO parada_box(
		id_carrera,
		id_auto,
		numero_vuelta,
		tiempo_parada
	)
	SELECT DISTINCT carrera.id, auto.id, PARADA_BOX_VUELTA, PARADA_BOX_TIEMPO FROM GD1C2022.gd_esquema.Maestra
		JOIN carrera ON GD1C2022.gd_esquema.Maestra.CODIGO_CARRERA = carrera.codigo
		JOIN escuderia ON GD1C2022.gd_esquema.Maestra.ESCUDERIA_NOMBRE = escuderia.nombre
		JOIN auto ON GD1C2022.gd_esquema.Maestra.AUTO_NUMERO = auto.numero_auto
		GROUP BY carrera.id, auto.id, PARADA_BOX_VUELTA, PARADA_BOX_TIEMPO
		ORDER BY carrera.id, auto.id, PARADA_BOX_VUELTA
END
GO






--migracion de motor-- 
GO
CREATE PROCEDURE AJO_DER.migrar_motores
AS
BEGIN 	
		INSERT INTO AJO_DER.motor(
			modelo,
			id_auto,
			numero_serie
		)
		SELECT DISTINCT TELE_MOTOR_MODELO,TELE_AUTO_CODIGO,TELE_MOTOR_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] 
		where TELE_MOTOR_NRO_SERIE is not null
END
GO
CREATE PROCEDURE AJO_DER.migrar_estado_de_motor
AS
BEGIN 	
		INSERT INTO AJO_DER.estado_de_motor(
			id_motor,
			potencia,
			temperatura_aceite,
			temperatura_agua,
			rpm
		)
		SELECT id,TELE_MOTOR_POTENCIA,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_RPM from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.motor ON [GD1C2022].[gd_esquema].[Maestra].TELE_MOTOR_NRO_SERIE = AJO_DER.motor.numero_serie
		group by id,TELE_MOTOR_POTENCIA,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_RPM
END
GO
CREATE PROCEDURE AJO_DER.migrar_caja_de_cambios
AS
BEGIN 	
		INSERT INTO AJO_DER.caja_de_cambios(
			modelo,
			id_auto,
			numero_serie
		)
		Select DISTINCT TELE_CAJA_MODELO,TELE_AUTO_CODIGO,TELE_CAJA_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] where TELE_CAJA_NRO_SERIE is not null
END
GO
CREATE PROCEDURE AJO_DER.migrar_estado_de_caja_de_cambios
AS
BEGIN 	
		INSERT INTO AJO_DER.estado_de_caja_de_cambios(
			id_caja_de_cambios,
			temperatura_aceite,
			rpm,
			desgaste
		)
		Select id,TELE_CAJA_TEMP_ACEITE,TELE_CAJA_RPM,TELE_CAJA_DESGASTE from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.caja_de_cambios ON [GD1C2022].[gd_esquema].[Maestra].TELE_CAJA_NRO_SERIE = AJO_DER.caja_de_cambios.numero_serie
		group by id,TELE_CAJA_DESGASTE,TELE_CAJA_RPM,TELE_CAJA_TEMP_ACEITE
END
GO
CREATE PROCEDURE AJO_DER.migrar_frenos
AS
BEGIN 	
		INSERT INTO AJO_DER.freno(
			numero_serie,
			id_auto
		)
		SELECT DISTINCT TELE_FRENO1_NRO_SERIE,TELE_AUTO_CODIGO from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO1_NRO_SERIE is not null

		INSERT INTO AJO_DER.freno(
			numero_serie,
			id_auto
		)
		SELECT DISTINCT TELE_FRENO2_NRO_SERIE,TELE_AUTO_CODIGO from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO2_NRO_SERIE is not null

		INSERT INTO AJO_DER.freno(
			numero_serie,
			id_auto
		)
		SELECT DISTINCT TELE_FRENO3_NRO_SERIE,TELE_AUTO_CODIGO from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO3_NRO_SERIE is not null

		INSERT INTO AJO_DER.freno(
			numero_serie,
			id_auto
		)
		SELECT DISTINCT TELE_FRENO4_NRO_SERIE,TELE_AUTO_CODIGO from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO4_NRO_SERIE is not null
END
GO
CREATE PROCEDURE AJO_DER.migrar_estado_de_freno_1
AS
BEGIN 	
		INSERT INTO AJO_DER.estado_freno(
			id_freno,			
			grosor_pastilla,
			id_posicion,
			tamanio_disco,
			temperatura
			)
		SELECT AJO_DER.freno.id,TELE_FRENO1_GROSOR_PASTILLA,TELE_FRENO1_POSICION,TELE_FRENO1_TAMANIO_DISCO,TELE_FRENO1_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO1_NRO_SERIE = AJO_DER.freno.numero_serie
		group by AJO_DER.freno.id,TELE_FRENO1_GROSOR_PASTILLA,TELE_FRENO1_POSICION,TELE_FRENO1_TAMANIO_DISCO,TELE_FRENO1_TEMPERATURA
 END
GO
CREATE PROCEDURE AJO_DER.migrar_estado_de_freno_2
AS
BEGIN 	
		INSERT INTO AJO_DER.estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
		)
		Select AJO_DER.freno.id,TELE_FRENO2_GROSOR_PASTILLA,TELE_FRENO2_POSICION,TELE_FRENO2_TAMANIO_DISCO,TELE_FRENO2_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO2_NRO_SERIE = AJO_DER.freno.numero_serie
		group by AJO_DER.freno.id,TELE_FRENO2_GROSOR_PASTILLA,TELE_FRENO2_POSICION,TELE_FRENO2_TAMANIO_DISCO,TELE_FRENO2_TEMPERATURA
END
GO
CREATE PROCEDURE AJO_DER.migrar_estado_de_freno_3
AS
BEGIN 	
		INSERT INTO AJO_DER.estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
		)
		SELECT AJO_DER.freno.id,TELE_FRENO3_GROSOR_PASTILLA,TELE_FRENO3_POSICION,TELE_FRENO3_TAMANIO_DISCO,TELE_FRENO3_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO3_NRO_SERIE = AJO_DER.freno.numero_serie
		group by AJO_DER.freno.id,TELE_FRENO3_GROSOR_PASTILLA,TELE_FRENO3_POSICION,TELE_FRENO3_TAMANIO_DISCO,TELE_FRENO3_TEMPERATURA
END
GO
CREATE PROCEDURE AJO_DER.migrar_estado_de_freno_4
AS
BEGIN 	
		INSERT INTO AJO_DER.estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
		)
		SELECT AJO_DER.freno.id,TELE_FRENO4_GROSOR_PASTILLA,TELE_FRENO4_POSICION,TELE_FRENO4_TAMANIO_DISCO,TELE_FRENO4_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO4_NRO_SERIE = AJO_DER.freno.numero_serie
		group by AJO_DER.freno.id,TELE_FRENO4_GROSOR_PASTILLA,TELE_FRENO4_POSICION,TELE_FRENO4_TAMANIO_DISCO,TELE_FRENO4_TEMPERATURA
END
GO
CREATE PROCEDURE AJO_DER.migrar_tipo_neumatico
AS
BEGIN 	
		INSERT INTO AJO_DER.tipo_neumatico(
			tipo
		)
		SELECT DISTINCT NEUMATICO1_TIPO_NUEVO from [GD1C2022].[gd_esquema].[Maestra]
		WHERE NEUMATICO1_TIPO_VIEJO is not null 
END
GO
CREATE PROCEDURE AJO_DER.migrar_neumaticos_1
AS
BEGIN 	
		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_auto,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO1_NRO_SERIE_NUEVO,AJO_DER.tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO1_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO1_NRO_SERIE_NUEVO,AJO_DER.tipo_neumatico.id
		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO1_NRO_SERIE_VIEJO,AJO_DER.tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO1_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO1_NRO_SERIE_VIEJO,AJO_DER.tipo_neumatico.id
END
GO
CREATE PROCEDURE AJO_DER.migrar_neumaticos_2
AS
BEGIN 	
		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO2_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO2_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO2_NRO_SERIE_NUEVO,AJO_DER.tipo_neumatico.id

		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO2_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO2_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO2_NRO_SERIE_VIEJO,AJO_DER.tipo_neumatico.id
END
GO
CREATE PROCEDURE AJO_DER.migrar_neumaticos_3
AS
BEGIN 	
		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO3_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO3_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO3_NRO_SERIE_NUEVO,AJO_DER.tipo_neumatico.id

		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO3_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO3_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO3_NRO_SERIE_VIEJO,AJO_DER.tipo_neumatico.id
END
GO
CREATE PROCEDURE AJO_DER.migrar_neumaticos_4
AS
BEGIN 	
		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO4_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO4_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO4_NRO_SERIE_NUEVO,AJO_DER.tipo_neumatico.id

		INSERT INTO AJO_DER.neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO4_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN AJO_DER.tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO4_TIPO_NUEVO = AJO_DER.tipo_neumatico.tipo
		group by NEUMATICO4_NRO_SERIE_VIEJO,AJO_DER.tipo_neumatico.id
END
GO

-- Migrar cambio_neumaticos
-- Pendiente

-- Ejecutar migraciones
CREATE PROCEDURE AJO_DER.migrar_tablas
AS
BEGIN
	EXEC AJO_DER.migrar_tipo_sector
	EXEC AJO_DER.migrar_pais
	EXEC AJO_DER.migrar_tipo_incidente
	EXEC AJO_DER.migrar_bandera
	EXEC AJO_DER.migrar_escuderia
	EXEC AJO_DER.migrar_piloto
	EXEC AJO_DER.migrar_auto
	EXEC AJO_DER.migrar_incidente
	EXEC AJO_DER.migrar_incidente_auto
	EXEC AJO_DER.migrar_circuito
	EXEC AJO_DER.migrar_sector
	EXEC AJO_DER.migrar_carrera
	EXEC AJO_DER.migrar_medicion
	EXEC AJO_DER.migrar_parada_box
	EXEC AJO_DER.migrar_motores;
	EXEC AJO_DER.migrar_estado_de_motor;
	EXEC AJO_DER.migrar_caja_de_cambios;
	EXEC AJO_DER.migrar_estado_de_caja_de_cambios;
	EXEC AJO_DER.migrar_frenos;
	EXEC AJO_DER.migrar_estado_de_freno_1;
	EXEC AJO_DER.migrar_estado_de_freno_2;
	EXEC AJO_DER.migrar_estado_de_freno_3;
	EXEC AJO_DER.migrar_estado_de_freno_4;
	EXEC AJO_DER.migrar_tipo_neumatico;
	EXEC AJO_DER.migrar_neumaticos_1;
	EXEC AJO_DER.migrar_neumaticos_2;
	EXEC AJO_DER.migrar_neumaticos_3;
	EXEC AJO_DER.migrar_neumaticos_4;
END
GO


---------------
-- EJECUCION --
---------------

EXEC AJO_DER.migrar_tablas

DROP PROCEDURE AJO_DER.migrar_tablas

