USE GD1C2022
GO

-- Eliminacion de tablas
	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'parada_box')
		DROP TABLE parada_box

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'cambio_neumaticos')
		DROP TABLE cambio_neumaticos

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'auto')
		DROP TABLE auto

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'posicion')
		DROP TABLE posicion

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'escuderia')
		DROP TABLE escuderia

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'piloto')
		DROP TABLE piloto

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'motor')
		DROP TABLE motor

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'caja_de_cambios')
		DROP TABLE caja_de_cambios

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'freno')
		DROP TABLE freno

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'neumatico')
		DROP TABLE neumatico

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'tipo_neumatico')
		DROP TABLE tipo_neumatico

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_de_motor')
		DROP TABLE estado_de_motor

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_de_caja_de_cambios')
		DROP TABLE estado_de_caja_de_cambios

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'bandera')
		DROP TABLE bandera

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'tipo_incidente')
		DROP TABLE tipo_incidente

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'incidente')
		DROP TABLE incidente

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'incidente_auto')
		DROP TABLE incidente_auto

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'sector')
		DROP TABLE sector

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'tipo_sector')
		DROP TABLE tipo_sector

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'pais')
		DROP TABLE pais

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'circuito')
		DROP TABLE circuito

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'medicion')
		DROP TABLE medicion

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'carrera')
		DROP TABLE carrera

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_freno')
		DROP TABLE estado_freno

	IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'estado_neumatico')
		DROP TABLE estado_neumatico


-- Eliminacion de store procedure
	IF OBJECT_ID('migrar_tipo_sector', 'P') IS NOT NULL
		DROP PROCEDURE migrar_tipo_sector

	IF OBJECT_ID('migrar_pais', 'P') IS NOT NULL
		DROP PROCEDURE migrar_pais
	
	IF OBJECT_ID('migrar_circuito', 'P') IS NOT NULL
		DROP PROCEDURE migrar_circuito

	IF OBJECT_ID('migrar_sector', 'P') IS NOT NULL
		DROP PROCEDURE migrar_sector

	IF OBJECT_ID('migrar_carrera', 'P') IS NOT NULL
		DROP PROCEDURE migrar_carrera

	IF OBJECT_ID('migrar_medicion', 'P') IS NOT NULL
		DROP PROCEDURE migrar_medicion

	IF OBJECT_ID('migrar_parada_box', 'P') IS NOT NULL
		DROP PROCEDURE migrar_parada_box

	IF OBJECT_ID('migrar_motores', 'P') IS NOT NULL
		DROP PROCEDURE migrar_motores

	IF OBJECT_ID('migrar_estado_de_motor', 'P') IS NOT NULL
		DROP PROCEDURE migrar_estado_de_motor

	IF OBJECT_ID('migrar_caja_de_cambios', 'P') IS NOT NULL
		DROP PROCEDURE migrar_caja_de_cambios

	IF OBJECT_ID('migrar_estado_de_caja_de_cambios', 'P') IS NOT NULL
		DROP PROCEDURE migrar_estado_de_caja_de_cambios

	IF OBJECT_ID('migrar_frenos', 'P') IS NOT NULL
		DROP PROCEDURE migrar_frenos

	IF OBJECT_ID('migrar_estado_de_freno_1', 'P') IS NOT NULL
		DROP PROCEDURE migrar_estado_de_freno_1

	IF OBJECT_ID('migrar_estado_de_freno_2', 'P') IS NOT NULL
		DROP PROCEDURE migrar_estado_de_freno_2

	IF OBJECT_ID('migrar_estado_de_freno_3', 'P') IS NOT NULL
		DROP PROCEDURE migrar_estado_de_freno_3

	IF OBJECT_ID('migrar_estado_de_freno_4', 'P') IS NOT NULL
		DROP PROCEDURE migrar_estado_de_freno_4

	IF OBJECT_ID('migrar_tipo_neumatico', 'P') IS NOT NULL
		DROP PROCEDURE migrar_tipo_neumatico

	IF OBJECT_ID('migrar_neumaticos_1', 'P') IS NOT NULL
		DROP PROCEDURE migrar_neumaticos_1

	IF OBJECT_ID('migrar_neumaticos_2', 'P') IS NOT NULL
		DROP PROCEDURE migrar_neumaticos_2

	IF OBJECT_ID('migrar_neumaticos_3', 'P') IS NOT NULL
		DROP PROCEDURE migrar_neumaticos_3

	IF OBJECT_ID('migrar_neumaticos_4', 'P') IS NOT NULL
		DROP PROCEDURE migrar_neumaticos_4


	IF OBJECT_ID('migrar_tablas', 'P') IS NOT NULL
		DROP PROCEDURE migrar_tablas


-- Eliminacion de esquema
IF EXISTS (SELECT name FROM sys.schemas WHERE name LIKE 'AJO_DER')
    DROP SCHEMA AJO_DER
GO

-- Creacion de esquema
CREATE SCHEMA AJO_DER
GO

-- Creacion de tablas
  CREATE TABLE parada_box (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_carrera INT, -- FK
      id_auto INT, -- FK
      numero_vuelta DECIMAL(18,0),
    tiempo_parada DECIMAL(18,2)
  );

  CREATE TABLE cambio_neumaticos (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_parada_box INT, -- FK
      id_neumatico_anterior INT, -- FK
      id_neumatico_nuevo INT, -- FK
    id_posicion INT -- FK
  );

  CREATE TABLE auto (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      id_escuderia INT, -- FK
      id_piloto INT, -- FK
      numero_auto INT,
    modelo VARCHAR(10)
  );

  CREATE TABLE posicion (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    descripcion VARCHAR(10)
  );

  CREATE TABLE escuderia (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      nombre VARCHAR(10),
      id_nacionalidad INT -- FK
  );

  CREATE TABLE piloto (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      id_nacionalidad INT, -- FK
      nombre VARCHAR(10),
    apellido VARCHAR(10),
    fecha_nacimiento DATETIME
  );

  CREATE TABLE nacionalidad (
      id INT NOT NULL IDENTITY PRIMARY KEY,
      nombre VARCHAR(50)
  );

  CREATE TABLE motor (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    modelo NVARCHAR(255),
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE caja_de_cambios (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    modelo NVARCHAR(255),
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE freno (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE neumatico (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_auto INT, -- FK
    id_tipo_neumatico INT, -- FK
    numero_serie NVARCHAR(255)
  );

  CREATE TABLE tipo_neumatico (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    tipo VARCHAR(10)
  );

  CREATE TABLE estado_de_motor (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_motor INT, -- FK
    potencia DECIMAL,
    temperatura_aceite DECIMAL,
    temperatura_agua DECIMAL,
    rpm INT
  );

  CREATE TABLE estado_de_caja_de_cambios (
      id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_caja_de_cambios INT, -- FK
    temperatura_aceite DECIMAL,
    temperatura_agua DECIMAL,
    rpm INT,
    desgaste DECIMAL
  );

  CREATE TABLE bandera (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    color VARCHAR
  );

  CREATE TABLE tipo_incidente (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    tipo VARCHAR
  );

  CREATE TABLE incidente (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_carrera INT, -- FK
    id_sector INT, -- FK
    id_bandera INT, -- FK
    tiempo DECIMAL,
    fecha DATETIME
  );

  CREATE TABLE incidente_auto (
    id_incidente INT, -- FK
    id_auto INT, -- FK
    id_tipo_incidente INT, -- FK
    numero_vuelta INT
  );

  CREATE TABLE sector (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_circuito INT, -- FK
    id_tipo_sector INT, -- FK
    distancia DECIMAL(18,2),
    codigo INT
  );

  CREATE TABLE tipo_sector (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    tipo VARCHAR(255)
  );

  CREATE TABLE pais (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nombre VARCHAR(255)
  );

  CREATE TABLE circuito (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_pais INT, -- FK
    codigo INT,
    nombre VARCHAR(255)
  );

  CREATE TABLE medicion (
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

  CREATE TABLE carrera (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_circuito INT, -- FK
    cant_vueltas INT,
    fecha DATE,
    codigo INT,
    clima VARCHAR(100),
    total_carrera DECIMAL(18,2)
  );

  CREATE TABLE estado_freno (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_freno INT, -- FK
    id_posicion INT, -- FK
    grosor_pastilla DECIMAL,
    temperatura DECIMAL
  );

  CREATE TABLE estado_neumatico (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_medicion INT, -- FK
    id_neumatico INT, -- FK
    id_posicion INT, -- FK
    profundidad DECIMAL,
    presion DECIMAL,
    temperatura DECIMAL
  );


	-- FKs de parada_box
	ALTER TABLE parada_box ADD FOREIGN KEY(id_carrera) REFERENCES carrera(id);
	ALTER TABLE parada_box ADD FOREIGN KEY(id_auto) REFERENCES auto(id);

	-- FKs de cambio_neumaticos
	ALTER TABLE cambio_neumaticos ADD FOREIGN KEY(id_parada_box) REFERENCES parada_box(id);
	ALTER TABLE cambio_neumaticos ADD FOREIGN KEY(id_neumatico_anterior) REFERENCES neumatico(id);
	ALTER TABLE cambio_neumaticos ADD FOREIGN KEY(id_neumatico_nuevo) REFERENCES neumatico(id);
	ALTER TABLE cambio_neumaticos ADD FOREIGN KEY(id_posicion) REFERENCES posicion(id);

	-- FKs de auto
	ALTER TABLE auto ADD FOREIGN KEY(id_escuderia) REFERENCES escuderia(id);
	ALTER TABLE auto ADD FOREIGN KEY(id_piloto) REFERENCES piloto(id);

	-- FKs de posicion
	-- N/A

	-- FKs de escuderia
	ALTER TABLE escuderia ADD FOREIGN KEY(id_nacionalidad) REFERENCES nacionalidad(id);

	-- FKs de piloto
	ALTER TABLE piloto ADD FOREIGN KEY(id_nacionalidad) REFERENCES nacionalidad(id);

	-- FKs de nacionalidad
	-- N/A

	-- FKs de motor
	ALTER TABLE motor ADD FOREIGN KEY(id_auto) REFERENCES auto(id);

	-- FKs de caja_de_cambios
	ALTER TABLE caja_de_cambios ADD FOREIGN KEY(id_auto) REFERENCES auto(id);

	-- FKs de freno
	ALTER TABLE freno ADD FOREIGN KEY(id_auto) REFERENCES auto(id);

	-- FKs de neumatico
	ALTER TABLE neumatico ADD FOREIGN KEY(id_auto) REFERENCES auto(id);
	ALTER TABLE neumatico ADD FOREIGN KEY(id_tipo_neumatico) REFERENCES tipo_neumatico(id);

	-- FKs de tipo_neumatico
	-- N/A

	-- FKs de estado_de_motor
	ALTER TABLE estado_de_motor ADD FOREIGN KEY(id_medicion) REFERENCES medicion(id);
	ALTER TABLE estado_de_motor ADD FOREIGN KEY(id_motor) REFERENCES motor(id);

	-- FKs de estado_de_caja_de_cambios
	ALTER TABLE estado_de_caja_de_cambios ADD FOREIGN KEY(id_medicion) REFERENCES medicion(id);
	ALTER TABLE estado_de_caja_de_cambios ADD FOREIGN KEY(id_caja_de_cambios) REFERENCES caja_de_cambios(id);

	-- FKs de bandera
	-- N/A

	-- FKs de tipo_incidente
	-- N/A

	-- FKs de incidente
	ALTER TABLE incidente ADD FOREIGN KEY(id_carrera) REFERENCES carrera(id);
	ALTER TABLE incidente ADD FOREIGN KEY(id_sector) REFERENCES sector(id);
	ALTER TABLE incidente ADD FOREIGN KEY(id_bandera) REFERENCES bandera(id);

	-- FKs de incidente_auto
	ALTER TABLE incidente_auto ADD FOREIGN KEY(id_incidente) REFERENCES incidente(id);
	ALTER TABLE incidente_auto ADD FOREIGN KEY(id_auto) REFERENCES auto(id);
	ALTER TABLE incidente_auto ADD FOREIGN KEY(id_tipo_incidente) REFERENCES tipo_incidente(id);

	-- FKs de sector
	ALTER TABLE sector ADD FOREIGN KEY(id_circuito) REFERENCES circuito(id);
	ALTER TABLE sector ADD FOREIGN KEY(id_tipo_sector) REFERENCES tipo_sector(id);

	-- FKs de tipo_sector
	-- N/A

	-- FKs de pais
	-- N/A

	-- FKs de circuito
	ALTER TABLE circuito ADD FOREIGN KEY(id_pais) REFERENCES pais(id);

	-- FKs de medicion
	ALTER TABLE medicion ADD FOREIGN KEY(id_auto) REFERENCES auto(id);
	ALTER TABLE medicion ADD FOREIGN KEY(id_carrera) REFERENCES carrera(id);
	ALTER TABLE medicion ADD FOREIGN KEY(id_sector) REFERENCES sector(id);

	-- FKs de carrera
	ALTER TABLE carrera ADD FOREIGN KEY(id_circuito) REFERENCES circuito(id);

	-- FKs de estado_freno
	ALTER TABLE estado_freno ADD FOREIGN KEY(id_medicion) REFERENCES medicion(id);
	ALTER TABLE estado_freno ADD FOREIGN KEY(id_freno) REFERENCES freno(id);
	ALTER TABLE estado_freno ADD FOREIGN KEY(id_posicion) REFERENCES posicion(id);

	-- FKs de estado_neumatico
	ALTER TABLE estado_neumatico ADD FOREIGN KEY(id_medicion) REFERENCES medicion(id);
	ALTER TABLE estado_neumatico ADD FOREIGN KEY(id_neumatico) REFERENCES neumatico(id);
	ALTER TABLE estado_neumatico ADD FOREIGN KEY(id_posicion) REFERENCES posicion(id);

GO
-- Migrar tipo_sector
CREATE PROCEDURE migrar_tipo_sector
AS
	BEGIN
		INSERT INTO tipo_sector
		SELECT DISTINCT SECTO_TIPO FROM GD1C2022.gd_esquema.Maestra
		WHERE SECTO_TIPO IS NOT NULL
	END
GO

-- Migrar pais
CREATE PROCEDURE migrar_pais
AS
BEGIN
	INSERT INTO pais
	SELECT DISTINCT CIRCUITO_PAIS FROM GD1C2022.gd_esquema.Maestra
		WHERE CIRCUITO_PAIS IS NOT NULL
END
GO

-- Migrar circuito
CREATE PROCEDURE migrar_circuito
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
CREATE PROCEDURE migrar_sector
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
CREATE PROCEDURE migrar_carrera
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
CREATE PROCEDURE migrar_medicion
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
CREATE PROCEDURE migrar_parada_box
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
CREATE PROCEDURE migrar_motores
AS
BEGIN 	
		INSERT INTO motor(
			modelo,
			numero_serie
		)
		SELECT DISTINCT TELE_MOTOR_MODELO,TELE_MOTOR_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] 
		where TELE_MOTOR_NRO_SERIE is not null
END
GO
CREATE PROCEDURE migrar_estado_de_motor
AS
BEGIN 	
		INSERT INTO estado_de_motor(
			id_motor,
			potencia,
			temperatura_aceite,
			temperatura_agua,
			rpm
		)
		SELECT id,TELE_MOTOR_POTENCIA,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_RPM from [GD1C2022].[gd_esquema].[Maestra]
		JOIN motor ON [GD1C2022].[gd_esquema].[Maestra].TELE_MOTOR_NRO_SERIE = motor.numero_serie
		group by id,TELE_MOTOR_POTENCIA,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_RPM
END
GO
CREATE PROCEDURE migrar_caja_de_cambios
AS
BEGIN 	
		INSERT INTO caja_de_cambios(
			modelo,numero_serie
		)
		Select DISTINCT TELE_CAJA_MODELO,TELE_CAJA_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] where TELE_CAJA_NRO_SERIE is not null
END
GO
CREATE PROCEDURE migrar_estado_de_caja_de_cambios
AS
BEGIN 	
		INSERT INTO estado_de_caja_de_cambios(
			id_caja_de_cambios,
			temperatura_aceite,
			rpm,
			desgaste
		)
		Select id,TELE_CAJA_TEMP_ACEITE,TELE_CAJA_RPM,TELE_CAJA_DESGASTE from [GD1C2022].[gd_esquema].[Maestra]
		JOIN caja_de_cambios ON [GD1C2022].[gd_esquema].[Maestra].TELE_CAJA_NRO_SERIE = caja_de_cambios.numero_serie
		group by id,TELE_CAJA_DESGASTE,TELE_CAJA_RPM,TELE_CAJA_TEMP_ACEITE
END
GO
CREATE PROCEDURE migrar_frenos
AS
BEGIN 	
		INSERT INTO freno(
			numero_serie
		)
		SELECT DISTINCT TELE_FRENO1_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO1_NRO_SERIE is not null

		INSERT INTO freno(
			numero_serie
		)
		SELECT DISTINCT TELE_FRENO2_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO3_NRO_SERIE is not null

		INSERT INTO freno(
			numero_serie
		)
		SELECT DISTINCT TELE_FRENO3_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO3_NRO_SERIE is not null

		INSERT INTO freno(
			numero_serie
		)
		SELECT DISTINCT TELE_FRENO4_NRO_SERIE from [GD1C2022].[gd_esquema].[Maestra] where TELE_FRENO4_NRO_SERIE is not null
END
GO
CREATE PROCEDURE migrar_estado_de_freno_1
AS
BEGIN 	
		INSERT INTO estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
			)
		SELECT freno.id,TELE_FRENO1_GROSOR_PASTILLA,TELE_FRENO1_POSICION,TELE_FRENO1_TAMANIO_DISCO,TELE_FRENO1_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO1_NRO_SERIE = freno.numero_serie
		group by freno.id,TELE_FRENO1_GROSOR_PASTILLA,TELE_FRENO1_POSICION,TELE_FRENO1_TAMANIO_DISCO,TELE_FRENO1_TEMPERATURA
END
GO
CREATE PROCEDURE migrar_estado_de_freno_2
AS
BEGIN 	
		INSERT INTO estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
		)
		Select freno.id,TELE_FRENO2_GROSOR_PASTILLA,TELE_FRENO2_POSICION,TELE_FRENO2_TAMANIO_DISCO,TELE_FRENO2_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO2_NRO_SERIE = freno.numero_serie
		group by freno.id,TELE_FRENO2_GROSOR_PASTILLA,TELE_FRENO2_POSICION,TELE_FRENO2_TAMANIO_DISCO,TELE_FRENO2_TEMPERATURA
END
GO
CREATE PROCEDURE migrar_estado_de_freno_3
AS
BEGIN 	
		INSERT INTO estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
		)
		SELECT freno.id,TELE_FRENO3_GROSOR_PASTILLA,TELE_FRENO3_POSICION,TELE_FRENO3_TAMANIO_DISCO,TELE_FRENO3_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO3_NRO_SERIE = freno.numero_serie
		group by freno.id,TELE_FRENO3_GROSOR_PASTILLA,TELE_FRENO3_POSICION,TELE_FRENO3_TAMANIO_DISCO,TELE_FRENO3_TEMPERATURA
END
GO
CREATE PROCEDURE migrar_estado_de_freno_4
AS
BEGIN 	
		INSERT INTO estado_freno(
			id_freno,
			grosor_pastilla,
			posicion,
			tamanio_disco,
			temperatura
		)
		SELECT freno.id,TELE_FRENO4_GROSOR_PASTILLA,TELE_FRENO4_POSICION,TELE_FRENO4_TAMANIO_DISCO,TELE_FRENO4_TEMPERATURA from [GD1C2022].[gd_esquema].[Maestra]
		JOIN freno ON [GD1C2022].[gd_esquema].[Maestra].TELE_FRENO4_NRO_SERIE = freno.numero_serie
		group by freno.id,TELE_FRENO4_GROSOR_PASTILLA,TELE_FRENO4_POSICION,TELE_FRENO4_TAMANIO_DISCO,TELE_FRENO4_TEMPERATURA
END
GO
CREATE PROCEDURE migrar_tipo_neumatico
AS
BEGIN 	
		INSERT INTO tipo_neumatico(
			tipo
		)
		SELECT DISTINCT NEUMATICO1_TIPO_NUEVO from [GD1C2022].[gd_esquema].[Maestra]
		WHERE NEUMATICO1_TIPO_VIEJO is not null 
END
GO
CREATE PROCEDURE migrar_neumaticos_1
AS
BEGIN 	
		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO1_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO1_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO1_NRO_SERIE_NUEVO,tipo_neumatico.id

		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO1_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO1_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO1_NRO_SERIE_VIEJO,tipo_neumatico.id
END
GO
CREATE PROCEDURE migrar_neumaticos_2
AS
BEGIN 	
		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO2_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO2_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO2_NRO_SERIE_NUEVO,tipo_neumatico.id

		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO2_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO2_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO2_NRO_SERIE_VIEJO,tipo_neumatico.id
END
GO
CREATE PROCEDURE migrar_neumaticos_3
AS
BEGIN 	
		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO3_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO3_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO3_NRO_SERIE_NUEVO,tipo_neumatico.id

		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO3_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO3_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO3_NRO_SERIE_VIEJO,tipo_neumatico.id
END
GO
CREATE PROCEDURE migrar_neumaticos_4
AS
BEGIN 	
		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO4_NRO_SERIE_NUEVO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO4_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO4_NRO_SERIE_NUEVO,tipo_neumatico.id

		INSERT INTO neumatico(
			numero_serie,
			id_tipo_neumatico
		)
		SELECT DISTINCT NEUMATICO4_NRO_SERIE_VIEJO,tipo_neumatico.id from [GD1C2022].[gd_esquema].[Maestra]
		JOIN tipo_neumatico ON [GD1C2022].[gd_esquema].[Maestra].NEUMATICO4_TIPO_NUEVO = tipo_neumatico.tipo
		group by NEUMATICO4_NRO_SERIE_VIEJO,tipo_neumatico.id
END
GO

-- Migrar cambio_neumaticos
-- Pendiente

-- Ejecutar migraciones
CREATE PROCEDURE migrar_tablas
AS
BEGIN
	EXEC migrar_tipo_sector
	EXEC migrar_pais
	EXEC migrar_circuito
	EXEC migrar_sector
	EXEC migrar_carrera
	EXEC migrar_medicion
	EXEC migrar_parada_box
	EXEC migrar_motores;
	EXEC migrar_estado_de_motor;
	EXEC migrar_caja_de_cambios;
	EXEC migrar_estado_de_caja_de_cambios;
	EXEC migrar_frenos;
	EXEC migrar_estado_de_freno_1;
	EXEC migrar_estado_de_freno_2;
	EXEC migrar_estado_de_freno_3;
	EXEC migrar_estado_de_freno_4;
	EXEC migrar_tipo_neumatico;
	EXEC migrar_neumaticos_1;
	EXEC migrar_neumaticos_2;
	EXEC migrar_neumaticos_3;
	EXEC migrar_neumaticos_4;
END
GO


---------------
-- EJECUCION --
---------------

EXEC migrar_tablas

DROP PROCEDURE migrar_tablas

