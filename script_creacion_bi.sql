USE GD1C2022
GO

-- Eliminacion de tablas
IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_medicion')
	DROP TABLE AJO_DER.BI_FACT_medicion

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_parada_box')
	DROP TABLE AJO_DER.BI_FACT_parada_box

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_incidente_auto')
	DROP TABLE AJO_DER.BI_FACT_incidente_auto

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_auto')
	DROP TABLE AJO_DER.BI_DIM_auto

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_piloto')
	DROP TABLE AJO_DER.BI_DIM_piloto

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_escuderia')
	DROP TABLE AJO_DER.BI_DIM_escuderia

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_circuito')
	DROP TABLE AJO_DER.BI_DIM_circuito

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tipo_neumatico')
	DROP TABLE AJO_DER.BI_DIM_tipo_neumatico

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tipo_incidente')
	DROP TABLE AJO_DER.BI_DIM_tipo_incidente

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_sector')
	DROP TABLE AJO_DER.BI_DIM_sector

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tiempo')
	DROP TABLE AJO_DER.BI_DIM_tiempo
GO

-- Eliminacion de vistas si existen
IF OBJECT_ID('AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito') IS NOT NULL
	DROP VIEW AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito

IF OBJECT_ID('AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia') IS NOT NULL
	DROP VIEW AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia

IF OBJECT_ID('AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio') IS NOT NULL
	DROP VIEW AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio

IF OBJECT_ID('AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto') IS NOT NULL
	DROP VIEW AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto

IF OBJECT_ID('AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia') IS NOT NULL
	DROP VIEW AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia

IF OBJECT_ID('AJO_DER.BI_cantidad_de_paradas_por_circuito') IS NOT NULL
	DROP VIEW AJO_DER.BI_cantidad_de_paradas_por_circuito

IF OBJECT_ID('AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas') IS NOT NULL
	DROP VIEW AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas

IF OBJECT_ID('AJO_DER.BI_circuitos_mas_peligrosos_del_anio') IS NOT NULL
	DROP VIEW AJO_DER.BI_circuitos_mas_peligrosos_del_anio

IF OBJECT_ID('AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector') IS NOT NULL
	DROP VIEW AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector

-- Eliminacion de funciones si existen
IF OBJECT_ID('AJO_DER.BI_obtener_cuatrimestre') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_cuatrimestre

IF OBJECT_ID('AJO_DER.BI_obtener_desgaste_promedio_frenos') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_desgaste_promedio_frenos

IF OBJECT_ID('AJO_DER.BI_obtener_desgaste_promedio_neumaticos') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_desgaste_promedio_neumaticos

IF OBJECT_ID('AJO_DER.BI_obtener_tiempos_de_vuelta') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_tiempos_de_vuelta

IF OBJECT_ID('AJO_DER.BI_obtener_Consumo_x_Auto') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_Consumo_x_Auto
GO

IF OBJECT_ID('AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio
GO

--Creacion de tablas
CREATE TABLE AJO_DER.BI_DIM_auto (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	modelo NVARCHAR(255),
	numero_auto INT
);

CREATE TABLE AJO_DER.BI_DIM_piloto(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	nombre NVARCHAR(50),
	apellido NVARCHAR(50),
);

CREATE TABLE AJO_DER.BI_DIM_escuderia(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	nombre NVARCHAR(255),
);

CREATE TABLE AJO_DER.BI_DIM_circuito(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	nombre NVARCHAR(255),
);

CREATE TABLE AJO_DER.BI_DIM_tipo_neumatico (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255)
);

CREATE TABLE AJO_DER.BI_DIM_tipo_incidente (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255)
);

CREATE TABLE AJO_DER.BI_DIM_sector (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255)
);

CREATE TABLE AJO_DER.BI_DIM_tiempo(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	anio INT,
	cuatrimestre INT,
);

CREATE TABLE AJO_DER.BI_FACT_medicion (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_tiempo INT REFERENCES AJO_DER.BI_DIM_tiempo, -- FK
	id_auto INT REFERENCES AJO_DER.BI_DIM_auto, -- FK
	id_piloto INT REFERENCES AJO_DER.BI_DIM_piloto, -- FK
	id_escuderia INT REFERENCES AJO_DER.BI_DIM_escuderia, -- FK
	id_circuito INT REFERENCES AJO_DER.BI_DIM_circuito, -- FK
	id_sector INT REFERENCES AJO_DER.BI_DIM_sector, -- FK

	nro_vuelta DECIMAL(18,0),

	tiempo_vuelta_total DECIMAL(18,10),
	velocidad_maxima_sector DECIMAL(18,2),
	consumo_combustible_circuito DECIMAL(18,2),

	desgaste_promedio_motor_vuelta DECIMAL(18,6),
	desgaste_promedio_caja_vuelta DECIMAL(18,4),
	desgaste_promedio_frenos_vuelta DECIMAL(18,4),
	desgaste_promedio_neumaticos_vuelta DECIMAL(18,6)

	--id_tipo_neumatico_1 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	--id_tipo_neumatico_2 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	--id_tipo_neumatico_3 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	--id_tipo_neumatico_4 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
);

CREATE TABLE AJO_DER.BI_FACT_parada_box (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_tiempo INT REFERENCES AJO_DER.BI_DIM_tiempo, -- FK
	id_circuito INT REFERENCES AJO_DER.BI_DIM_circuito, -- FK
	id_escuderia INT REFERENCES AJO_DER.BI_DIM_escuderia, -- FK
	tiempo_parada DECIMAL(18,2)
);

CREATE TABLE AJO_DER.BI_FACT_incidente_auto (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_tiempo INT REFERENCES AJO_DER.BI_DIM_tiempo, -- FK
	id_circuito INT REFERENCES AJO_DER.BI_DIM_circuito, -- FK
	id_escuderia INT REFERENCES AJO_DER.BI_DIM_escuderia, -- FK
	id_sector INT REFERENCES AJO_DER.BI_DIM_sector, -- FK
	id_tipo_incidente INT REFERENCES AJO_DER.BI_DIM_tipo_incidente -- FK
);
GO

--Funciones

CREATE FUNCTION AJO_DER.BI_obtener_cuatrimestre(@fecha DATE)
	RETURNS INT
	AS
	BEGIN
		RETURN CASE
			WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1 
			WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
			WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3
			ELSE NULL
		END
	END
GO

/*
CREATE FUNCTION AJO_DER.BI_obtener_tiempos_de_vuelta()
	RETURNS @Result TABLE (
		tiempo_vuelta DECIMAL(18,10), 
		nro_vuelta DECIMAL(18,0),
		id_auto INT,
		escuderia NVARCHAR(255), 
		circuito NVARCHAR(255), 
		anio INT 
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			MAX(medicion.tiempo_vuelta),
			medicion.nro_vuelta,
			medicion.id_auto,
			escuderia.nombre,
			circuito.nombre,
			tiempo.anio
		FROM AJO_DER.BI_FACT_medicion medicion
			JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = medicion.id_escuderia
			JOIN AJO_DER.BI_DIM_circuito circuito on circuito.id = medicion.id_circuito
			JOIN AJO_DER.BI_DIM_tiempo tiempo on tiempo.id = medicion.id_tiempo
		GROUP BY medicion.nro_vuelta, medicion.id_auto, escuderia.nombre, circuito.nombre, tiempo.anio
		HAVING MAX(medicion.tiempo_vuelta) != 0
		ORDER BY tiempo.anio, circuito.nombre, escuderia.nombre, medicion.id_auto, medicion.nro_vuelta
	RETURN
	END
GO

CREATE FUNCTION AJO_DER.BI_obtener_Consumo_x_Auto()
	RETURNS @Result TABLE (
		id_circuito INT, 
		id_auto INT,
		consumo_combustible DECIMAL(18,3)
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			id_circuito,
			id_auto,
			MAX(cant_combustible) - MIN(cant_combustible)
		FROM AJO_DER.BI_FACT_medicion medicion
			JOIN AJO_DER.BI_DIM_circuito circuito ON medicion.id_circuito = circuito.id
		GROUP BY id_circuito, id_auto
		ORDER BY id_circuito
	RETURN
	END
GO
*/

CREATE FUNCTION AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio()
	RETURNS @Result TABLE (
		circuito NVARCHAR(255), 
		anio INT,
		cantidad_incidentes INT,
		ranking INT
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			circuito.nombre,
			fecha.anio,
			COUNT(*),
			ROW_NUMBER() OVER (PARTITION BY fecha.anio ORDER BY COUNT(*) DESC)
		FROM AJO_DER.BI_FACT_incidente_auto incidente_auto
			JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = incidente_auto.id_circuito
			JOIN AJO_DER.BI_DIM_tiempo fecha ON fecha.id = incidente_auto.id_tiempo
		GROUP BY circuito.nombre, fecha.anio
	RETURN
	END
GO

-- Carga de datos de auto
INSERT INTO AJO_DER.BI_DIM_auto
SELECT modelo, numero_auto
FROM AJO_DER.auto

-- Carga de datos de piloto

INSERT INTO AJO_DER.BI_DIM_piloto
SELECT nombre, apellido
FROM AJO_DER.piloto

-- Carga de datos de escuderia

INSERT INTO AJO_DER.BI_DIM_escuderia
SELECT nombre
FROM AJO_DER.escuderia

-- Carga de datos de circuito

INSERT INTO AJO_DER.BI_DIM_circuito
SELECT nombre
FROM AJO_DER.circuito

-- Carga de datos de tipo_neumatico

INSERT INTO AJO_DER.BI_DIM_tipo_neumatico
SELECT tipo
FROM AJO_DER.tipo_neumatico

-- Carga de datos de tipo_incidente

INSERT INTO AJO_DER.BI_DIM_tipo_incidente
SELECT tipo
FROM AJO_DER.tipo_incidente

-- Carga de datos de sector

INSERT INTO AJO_DER.BI_DIM_sector
SELECT tipo
FROM AJO_DER.sector s
	JOIN AJO_DER.tipo_sector t ON s.id_tipo_sector = t.id 

-- Carga de datos de tiempo

INSERT INTO AJO_DER.BI_DIM_tiempo
SELECT DISTINCT 
	YEAR(fecha), 
	AJO_DER.BI_obtener_cuatrimestre(fecha) 
FROM AJO_DER.carrera

-- Carga de datos de medicion

CREATE TABLE #BI_medicion_aux(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_tiempo INT, -- FK
	id_auto INT, -- FK
	id_circuito INT, -- FK
	nro_vuelta DECIMAL(18,0),

	desgaste_promedio_motor_vuelta DECIMAL(18,6),
	desgaste_promedio_caja_vuelta DECIMAL(18,4),
	desgaste_promedio_frenos_vuelta DECIMAL(18,4)
);
GO

CREATE TABLE #BI_medicion_aux_2(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_tiempo INT, -- FK
	id_auto INT, -- FK
	id_circuito INT, -- FK
	nro_vuelta DECIMAL(18,0),

	desgaste_promedio_neumaticos_vuelta DECIMAL(18,6)
	--id_tipo_neumatico_1 INT,
	--id_tipo_neumatico_2 INT,
	--id_tipo_neumatico_3 INT,
	--id_tipo_neumatico_4 INT
);
GO

CREATE TABLE #BI_medicion_aux_3(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_tiempo INT, -- FK
	id_auto INT, -- FK
	id_circuito INT, -- FK

	consumo_combustible_circuito DECIMAL(18,2)
);
GO

INSERT INTO #BI_medicion_aux
SELECT
	tiempo.id,
	medicion.id_auto, 
	carrera.id_circuito,
	nro_vuelta,

	MAX(estado_de_motor.potencia) - MIN(estado_de_motor.potencia),
	MAX(estado_de_caja_de_cambios.desgaste) - MIN(estado_de_caja_de_cambios.desgaste),
	(MAX(estado_freno_1.grosor_pastilla) - MIN(estado_freno_1.grosor_pastilla) +
	 MAX(estado_freno_2.grosor_pastilla) - MIN(estado_freno_2.grosor_pastilla) +
	 MAX(estado_freno_3.grosor_pastilla) - MIN(estado_freno_3.grosor_pastilla) +
	 MAX(estado_freno_4.grosor_pastilla) - MIN(estado_freno_4.grosor_pastilla)
	 ) / 4
FROM AJO_DER.medicion
	JOIN AJO_DER.carrera ON id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre


	JOIN AJO_DER.estado_de_motor ON estado_de_motor.id_medicion = medicion.id
	JOIN AJO_DER.estado_de_caja_de_cambios ON estado_de_caja_de_cambios.id_medicion = medicion.id

	JOIN AJO_DER.freno freno_1 ON freno_1.id_auto = medicion.id_auto
		AND freno_1.id_posicion = 1
	JOIN AJO_DER.estado_freno estado_freno_1 ON estado_freno_1.id_medicion = medicion.id 
		AND estado_freno_1.id_freno = freno_1.id

	JOIN AJO_DER.freno freno_2 ON freno_2.id_auto = medicion.id_auto 
		AND freno_2.id_posicion = 2
	JOIN AJO_DER.estado_freno estado_freno_2 ON estado_freno_2.id_medicion = medicion.id 
		AND estado_freno_2.id_freno = freno_2.id

	JOIN AJO_DER.freno freno_3 ON freno_3.id_auto = medicion.id_auto 
		AND freno_3.id_posicion = 3
	JOIN AJO_DER.estado_freno estado_freno_3 ON estado_freno_3.id_medicion = medicion.id 
		AND estado_freno_3.id_freno = freno_3.id

	JOIN AJO_DER.freno freno_4 ON freno_4.id_auto = medicion.id_auto 
		AND freno_4.id_posicion = 4
	JOIN AJO_DER.estado_freno estado_freno_4 ON estado_freno_4.id_medicion = medicion.id 
		AND estado_freno_4.id_freno = freno_4.id

GROUP BY medicion.id_auto, medicion.nro_vuelta, carrera.id_circuito, tiempo.id

INSERT INTO #BI_medicion_aux_2
SELECT
	tiempo.id,
	medicion.id_auto, 
	carrera.id_circuito,
	nro_vuelta,

	(MAX(estado_neumatico_1.profundidad) - MIN(estado_neumatico_1.profundidad) +
	 MAX(estado_neumatico_2.profundidad) - MIN(estado_neumatico_2.profundidad) +
	 MAX(estado_neumatico_3.profundidad) - MIN(estado_neumatico_3.profundidad) +
	 MAX(estado_neumatico_4.profundidad) - MIN(estado_neumatico_4.profundidad) 
	 ) / 4

	--neumatico_1.id_tipo_neumatico,
	--neumatico_2.id_tipo_neumatico,
	--neumatico_3.id_tipo_neumatico,
	--neumatico_4.id_tipo_neumatico
FROM AJO_DER.medicion
	JOIN AJO_DER.carrera ON id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre

	JOIN AJO_DER.neumatico neumatico_1 ON neumatico_1.id_auto = medicion.id_auto
		AND neumatico_1.id_posicion = 1
	JOIN AJO_DER.estado_neumatico estado_neumatico_1 ON estado_neumatico_1.id_medicion = medicion.id 
		AND estado_neumatico_1.id_neumatico = neumatico_1.id

	JOIN AJO_DER.neumatico neumatico_2 ON neumatico_2.id_auto = medicion.id_auto 
		AND neumatico_2.id_posicion = 2
	JOIN AJO_DER.estado_neumatico estado_neumatico_2 ON estado_neumatico_2.id_medicion = medicion.id 
		AND estado_neumatico_2.id_neumatico = neumatico_2.id

	JOIN AJO_DER.neumatico neumatico_3 ON neumatico_3.id_auto = medicion.id_auto
		AND neumatico_3.id_posicion = 3
	JOIN AJO_DER.estado_neumatico estado_neumatico_3 ON estado_neumatico_3.id_medicion = medicion.id 
		AND estado_neumatico_3.id_neumatico = neumatico_3.id

	JOIN AJO_DER.neumatico neumatico_4 ON neumatico_4.id_auto = medicion.id_auto
		AND neumatico_4.id_posicion = 4
	JOIN AJO_DER.estado_neumatico estado_neumatico_4 ON estado_neumatico_4.id_medicion = medicion.id 
		AND estado_neumatico_4.id_neumatico = neumatico_4.id
GROUP BY medicion.id_auto, medicion.nro_vuelta, carrera.id_circuito, tiempo.id


INSERT INTO #BI_medicion_aux_3
SELECT
	tiempo.id,
	medicion.id_auto, 
	carrera.id_circuito,
	MAX(cant_combustible) - MIN(cant_combustible)
FROM AJO_DER.medicion
	JOIN AJO_DER.carrera ON id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
GROUP BY medicion.id_auto, carrera.id_circuito, tiempo.id


INSERT INTO AJO_DER.BI_FACT_medicion
SELECT DISTINCT
	tiempo.id,
	medicion.id_auto,
	auto.id_piloto,
	auto.id_escuderia, 
	carrera.id_circuito,
	id_sector,
	
	medicion.nro_vuelta,

	MAX(medicion.tiempo_vuelta) OVER (PARTITION BY medicion.id_auto, medicion.nro_vuelta, carrera.id_circuito, tiempo.anio), -- puede dar 0...
	MAX(medicion.velocidad) OVER (PARTITION BY medicion.id_auto, id_sector, carrera.id_circuito, tiempo.anio),
	#BI_medicion_aux_3.consumo_combustible_circuito,

	#BI_medicion_aux.desgaste_promedio_motor_vuelta,
	#BI_medicion_aux.desgaste_promedio_caja_vuelta,
	#BI_medicion_aux.desgaste_promedio_frenos_vuelta,
	#BI_medicion_aux_2.desgaste_promedio_neumaticos_vuelta

	--#BI_medicion_aux_2.id_tipo_neumatico_1,
	--#BI_medicion_aux_2.id_tipo_neumatico_2,
	--#BI_medicion_aux_2.id_tipo_neumatico_3,
	--#BI_medicion_aux_2.id_tipo_neumatico_4
FROM AJO_DER.medicion
	JOIN AJO_DER.carrera ON id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
	JOIN AJO_DER.auto ON id_auto = auto.id

	JOIN #BI_medicion_aux ON 
		tiempo.id = #BI_medicion_aux.id_tiempo AND
		medicion.id_auto = #BI_medicion_aux.id_auto AND
		carrera.id_circuito = #BI_medicion_aux.id_circuito AND
		medicion.nro_vuelta = #BI_medicion_aux.nro_vuelta
	JOIN #BI_medicion_aux_2 ON
		tiempo.id = #BI_medicion_aux_2.id_tiempo AND
		medicion.id_auto = #BI_medicion_aux_2.id_auto AND
		carrera.id_circuito = #BI_medicion_aux_2.id_circuito AND
		medicion.nro_vuelta = #BI_medicion_aux_2.nro_vuelta
	JOIN #BI_medicion_aux_3 ON
		tiempo.id = #BI_medicion_aux_3.id_tiempo AND
		medicion.id_auto = #BI_medicion_aux_3.id_auto AND
		carrera.id_circuito = #BI_medicion_aux_3.id_circuito

DROP TABLE #BI_medicion_aux
GO
DROP TABLE #BI_medicion_aux_2
GO
DROP TABLE #BI_medicion_aux_3
GO

-- Carga de datos de parada_box

INSERT INTO AJO_DER.BI_FACT_parada_box
SELECT 
	tiempo.id,
	carrera.id_circuito,
	auto.id_escuderia,
	tiempo_parada
FROM AJO_DER.parada_box
	JOIN AJO_DER.carrera ON parada_box.id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
	JOIN AJO_DER.auto ON parada_box.id_auto = auto.id

-- Carga de datos de incidente_auto

INSERT INTO AJO_DER.BI_FACT_incidente_auto
SELECT
	tiempo.id,
	carrera.id_circuito,
	auto.id_escuderia,
	incidente.id_sector,
	id_tipo_incidente
FROM AJO_DER.incidente_auto
	JOIN AJO_DER.incidente ON incidente_auto.id_incidente = incidente.id
	JOIN AJO_DER.carrera ON incidente.id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
	JOIN AJO_DER.auto ON incidente_auto.id_auto = auto.id
GO



-- Desgaste promedio de cada componente de cada auto por vuelta por circuito.
CREATE VIEW AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito AS
	SELECT
		desgaste_promedio_motor_vuelta 'Desgaste Promedio de Motor',
		desgaste_promedio_caja_vuelta 'Desgaste Promedio de Caja de Cambios',
		desgaste_promedio_frenos_vuelta 'Desgaste Promedio de Frenos',
		desgaste_promedio_neumaticos_vuelta 'Desgaste Promedio de Neumaticos',
		auto.modelo AS 'Modelo del Auto', 
		auto.numero_auto AS 'Numero del Auto de su Escuderia',
		medicion.nro_vuelta AS 'Numero de Vuelta', 
		circuito.nombre AS 'Circuito'
	FROM AJO_DER.BI_FACT_medicion medicion
		JOIN AJO_DER.BI_DIM_auto auto ON auto.id = medicion.id_auto
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = medicion.id_circuito
	GROUP BY medicion.id_auto, auto.modelo, auto.numero_auto, medicion.nro_vuelta, medicion.id_circuito, circuito.nombre,
		desgaste_promedio_motor_vuelta,
		desgaste_promedio_caja_vuelta,
		desgaste_promedio_frenos_vuelta,
		desgaste_promedio_neumaticos_vuelta
	--GROUP BY medicion.id_auto, auto.modelo, auto.numero_auto, medicion.nro_vuelta, medicion.id_circuito, circuito.nombre
GO

-- Mejor tiempo de vuelta de cada escudería por circuito por año.
-- El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito.
CREATE VIEW AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia AS
	SELECT
		MIN(tiempo_vuelta_total) AS 'Mejor Tiempo de Vuelta',
		escuderia.nombre AS 'Escuderia',
		circuito.nombre AS 'Circuito',
		tiempo.anio AS 'Año'
	FROM AJO_DER.BI_FACT_medicion medicion
		JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = medicion.id_escuderia
		JOIN AJO_DER.BI_DIM_circuito circuito on circuito.id = medicion.id_circuito
		JOIN AJO_DER.BI_DIM_tiempo tiempo on tiempo.id = medicion.id_tiempo
	WHERE tiempo_vuelta_total != 0
	GROUP BY escuderia.nombre, circuito.nombre, tiempo.anio
GO

-- Los 3 de circuitos con mayor consumo de combustible promedio
CREATE VIEW AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio AS
	SELECT TOP 3
		id_circuito AS 'Circuito',
		AVG(DISTINCT consumo_combustible_circuito) AS 'Consumo de Combustible Promedio'
	FROM AJO_DER.BI_FACT_medicion
	GROUP BY id_circuito, id_tiempo
	ORDER BY 2 DESC
GO

-- Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito.
CREATE VIEW AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto AS
	SELECT
		MAX(medicion.velocidad_maxima_sector) AS 'Maxima Velocidad Alcanzada',
		auto.modelo AS 'Modelo del Auto',
		auto.numero_auto AS 'Numero del Auto de su Escuderia',
		sector.tipo AS 'Tipo Sector',
		circuito.nombre AS 'Circuito'
	FROM AJO_DER.BI_FACT_medicion medicion
		JOIN AJO_DER.BI_DIM_auto auto ON auto.id = medicion.id_auto
		JOIN AJO_DER.BI_DIM_sector sector ON sector.id = medicion.id_sector
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = medicion.id_circuito
	GROUP BY auto.modelo, auto.numero_auto, sector.tipo, circuito.nombre
GO

-- Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre
CREATE VIEW AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia AS
	SELECT
		AVG(parada_box.tiempo_parada) AS 'Tiempo Promedio en Paradas',
		escuderia.nombre AS 'Escuderia',
		tiempo.cuatrimestre AS 'Cuatrimestre'
	FROM AJO_DER.BI_FACT_parada_box parada_box
		JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = parada_box.id_escuderia
		JOIN AJO_DER.BI_DIM_tiempo tiempo ON tiempo.id = parada_box.id_tiempo
	GROUP BY escuderia.nombre, tiempo.cuatrimestre
GO

-- Cantidad de paradas por circuito por escudería por año.
CREATE VIEW AJO_DER.BI_cantidad_de_paradas_por_circuito AS
	SELECT
		count(*) AS 'Cantidad de Paradas',
		circuito.nombre AS 'Circuito',
		escuderia.nombre AS 'Escuderia',
		tiempo.anio AS 'Año'
	FROM AJO_DER.BI_FACT_parada_box parada_box
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = parada_box.id_circuito
		JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = parada_box.id_escuderia
		JOIN AJO_DER.BI_DIM_tiempo tiempo ON tiempo.id = parada_box.id_tiempo
	GROUP BY circuito.nombre, escuderia.nombre, tiempo.anio
GO

-- Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
CREATE VIEW AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas AS
	SELECT TOP 3
		circuito.nombre AS 'Circuito',
		SUM(parada_box.tiempo_parada) AS 'Tiempo total en paradas'
	FROM AJO_DER.BI_FACT_parada_box parada_box
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = parada_box.id_circuito
	GROUP BY circuito.nombre
	ORDER BY 2 DESC
GO

-- Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes
CREATE VIEW AJO_DER.BI_circuitos_mas_peligrosos_del_anio AS
	SELECT
		circuito AS 'Circuito',
		anio AS 'Año',
		cantidad_incidentes AS 'Cantidad de Incidentes'
	FROM AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio()
	WHERE ranking <= 3
GO

-- Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores
CREATE VIEW AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector AS
	SELECT
		SUM(CASE WHEN sector.tipo = 'Frenada' THEN 1.0 ELSE 0.0 END)
		AS 'Promedio de incidentes en Frenada',
		SUM(CASE WHEN sector.tipo = 'Recta' THEN 1.0 ELSE 0.0 END)
		AS 'Promedio de incidentes en Recta',
		SUM(CASE WHEN sector.tipo = 'Curva' THEN 1.0 ELSE 0.0 END)
		AS 'Promedio de incidentes en Curva',
		escuderia.nombre AS 'Escuderia',
		fecha.anio AS 'Año'
	FROM AJO_DER.BI_FACT_incidente_auto incidente_auto
		JOIN AJO_DER.BI_DIM_sector sector ON sector.id = incidente_auto.id_sector
		JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = incidente_auto.id_escuderia
		JOIN AJO_DER.BI_DIM_tiempo fecha ON fecha.id = incidente_auto.id_tiempo
	GROUP BY escuderia.nombre, fecha.anio
GO

SELECT * FROM AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito
ORDER BY Circuito, [Numero de Vuelta], [Modelo del Auto], [Numero del Auto de su Escuderia]
SELECT * FROM AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia
ORDER BY Año, Circuito, Escuderia
SELECT * FROM AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio

SELECT * FROM AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto
ORDER BY Circuito, [Tipo Sector], [Modelo del Auto], [Numero del Auto de su Escuderia]
SELECT * FROM AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia
ORDER BY Cuatrimestre, Escuderia
SELECT * FROM AJO_DER.BI_cantidad_de_paradas_por_circuito
ORDER BY Año, Circuito, Escuderia

SELECT * FROM AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas
SELECT * FROM AJO_DER.BI_circuitos_mas_peligrosos_del_anio
SELECT * FROM AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector
ORDER BY Año, Escuderia