USE GD1C2022
GO

-- Eliminacion de tablas
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

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tipo_sector')
	DROP TABLE AJO_DER.BI_DIM_tipo_sector

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tiempo')
	DROP TABLE AJO_DER.BI_DIM_tiempo

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_medicion')
	DROP TABLE AJO_DER.BI_FACT_medicion

-- Eliminacion de funciones si existen
IF OBJECT_ID('AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia') IS NOT NULL
	DROP FUNCTION AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia

IF OBJECT_ID('AJO_DER.circuitos_con_mayor_consumo_de_combustible_promedio') IS NOT NULL
	DROP FUNCTION AJO_DER.circuitos_con_mayor_consumo_de_combustible_promedio

IF OBJECT_ID('AJO_DER.maxima_velocidad_alcanzada_por_cada_auto') IS NOT NULL
	DROP FUNCTION AJO_DER.maxima_velocidad_alcanzada_por_cada_auto

IF OBJECT_ID('AJO_DER.tiempo_promedio_que_tardo_cada_escuderia') IS NOT NULL
	DROP FUNCTION AJO_DER.tiempo_promedio_que_tardo_cada_escuderia

IF OBJECT_ID('AJO_DER.cantidad_de_paradas_por_circuito') IS NOT NULL
	DROP FUNCTION AJO_DER.cantidad_de_paradas_por_circuito

IF OBJECT_ID('AJO_DER.circuitos_con_mayor_tiempo_en_paradas') IS NOT NULL
	DROP FUNCTION AJO_DER.circuitos_con_mayor_tiempo_en_paradas

IF OBJECT_ID('AJO_DER.circuitos_mas_peligrosos_del_anio') IS NOT NULL
	DROP FUNCTION AJO_DER.circuitos_mas_peligrosos_del_anio

IF OBJECT_ID('AJO_DER.promedio_incidentes_escuderia_anio_tipo_de_sector') IS NOT NULL
	DROP FUNCTION AJO_DER.promedio_incidentes_escuderia_anio_tipo_de_sector}

IF OBJECT_ID('AJO_DER.BI_obtener_cuatrimestre') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_cuatrimestre

IF OBJECT_ID('AJO_DER.BI_obtener_desgaste_promedio_neumaticos') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_desgaste_promedio_neumaticos

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
	codigo INT,
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

CREATE TABLE AJO_DER.BI_DIM_tipo_sector (
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
	id_tipo_sector INT REFERENCES AJO_DER.BI_DIM_tipo_sector, -- FK
	codigo_medicion DECIMAL(18,0),
	nro_vuelta DECIMAL(18,0),
	tiempo_vuelta DECIMAL(18,10),
	velocidad DECIMAL(18,2),
	cant_combustible DECIMAL(18,2),

	potencia_motor DECIMAL(18,6),
	desgaste_caja_de_cambios DECIMAL(18,2),

	grosor_pastilla_freno_1 DECIMAL(18,2),
	grosor_pastilla_freno_2 DECIMAL(18,2),
	grosor_pastilla_freno_3 DECIMAL(18,2),
	grosor_pastilla_freno_4 DECIMAL(18,2),

	profundidad_neumatico_1 DECIMAL(18,6),
	profundidad_neumatico_2 DECIMAL(18,6),
	profundidad_neumatico_3 DECIMAL(18,6),
	profundidad_neumatico_4 DECIMAL(18,6),

	id_tipo_neumatico_1 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_2 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_3 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_4 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
);
GO

--Funciones

CREATE FUNCTION AJO_DER.BI_obtener_cuatrimestre(@fecha DATE)
RETURNS INT
AS
BEGIN
	IF(MONTH(@fecha) BETWEEN 1 AND 4)
	BEGIN
		RETURN 1
	END
	IF(MONTH(@fecha) BETWEEN 5 AND 8)
	BEGIN
		RETURN 2
	END
	IF(MONTH(@fecha) BETWEEN 9 AND 12)
	BEGIN
		RETURN 3
	END
	    RETURN NULL
END
GO

CREATE TABLE #combustible_max_min(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_auto INT,
	nro_vuelta DECIMAL(18,0),
	id_circuito INT,
	combustible_max DECIMAL(18,2),
	combustible_min DECIMAL(18,2)
);
go

INSERT INTO #combustible_max_min
SELECT id_auto, nro_vuelta, id_circuito, MAX(cant_combustible) combustible_max, 
MIN(cant_combustible) combustible_min
FROM AJO_DER.BI_FACT_medicion
GROUP BY id_auto, nro_vuelta, id_circuito
ORDER BY id_circuito, nro_vuelta, id_auto
GO

CREATE FUNCTION AJO_DER.BI_obtener_desgaste_promedio_neumaticos(@auto INT, @nro_vuelta DECIMAL(18,0),
																	@circuito INT)
RETURNS INT
AS
BEGIN
	RETURN(
		SELECT profundidad_neumatico_1 profundidad_inicial FROM AJO_DER.BI_FACT_medicion
		WHERE codigo_medicion = (SELECT codigo_medicion FROM AJO_DER.BI_FACT_medicion
								WHERE cant_combustible = (SELECT combustible_max FROM #combustible_max_min
														WHERE id_auto = @auto AND nro_vuelta = @nro_vuelta 
														AND id_circuito = @circuito
														)
								AND id_auto = @auto AND nro_vuelta = @nro_vuelta AND id_circuito = @circuito
								)
		@diferencia_1 = profundidad_inicial - profundidad_final
		)
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
SELECT codigo, nombre
FROM AJO_DER.circuito

-- Carga de datos de tipo_neumatico

INSERT INTO AJO_DER.BI_DIM_tipo_neumatico
SELECT tipo
FROM AJO_DER.tipo_neumatico

-- Carga de datos de tipo_incidente

INSERT INTO AJO_DER.BI_DIM_tipo_incidente
SELECT tipo
FROM AJO_DER.tipo_incidente

-- Carga de datos de tipo_sector

INSERT INTO AJO_DER.BI_DIM_tipo_sector
SELECT tipo
FROM AJO_DER.tipo_sector

-- Carga de datos de tiempo

INSERT INTO AJO_DER.BI_DIM_tiempo
SELECT DISTINCT YEAR(fecha), 
	AJO_DER.BI_obtener_cuatrimestre(fecha) 
FROM AJO_DER.carrera

-- Carga de datos de medicion

CREATE TABLE #medicion_aux(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	codigo_medicion DECIMAL(18,0),
	profundidad_neumatico_1 DECIMAL(18,6),
	profundidad_neumatico_2 DECIMAL(18,6),
	profundidad_neumatico_3 DECIMAL(18,6),
	profundidad_neumatico_4 DECIMAL(18,6),
	id_tipo_neumatico_1 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_2 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_3 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_4 INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
);
go

INSERT INTO #medicion_aux
SELECT codigo_medicion,
estado_neumatico_1.profundidad AS 'profundidad_neumatico_1',
estado_neumatico_2.profundidad AS 'profundidad_neumatico_2',
estado_neumatico_3.profundidad AS 'profundidad_neumatico_3',
estado_neumatico_4.profundidad AS 'profundidad_neumatico_4',
neumatico_1.id_tipo_neumatico AS 'id_tipo_neumatico_1',
neumatico_2.id_tipo_neumatico AS 'id_tipo_neumatico_2',
neumatico_3.id_tipo_neumatico AS 'id_tipo_neumatico_3',
neumatico_4.id_tipo_neumatico AS 'id_tipo_neumatico_4'
FROM AJO_DER.medicion
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

INSERT INTO AJO_DER.BI_FACT_medicion
SELECT BI_DIM_tiempo.id AS 'id_tiempo', medicion.id_auto, auto.id_piloto, auto.id_escuderia, 
carrera.id_circuito, sector.id_tipo_sector, medicion.codigo_medicion , nro_vuelta, tiempo_vuelta, velocidad, 
cant_combustible, estado_de_motor.potencia AS 'potencia_motor',
estado_de_caja_de_cambios.desgaste AS 'desgaste_caja_de_cambios',
estado_freno_1.grosor_pastilla AS 'grosor_pastilla_freno_1',
estado_freno_2.grosor_pastilla AS 'grosor_pastilla_freno_2',
estado_freno_3.grosor_pastilla AS 'grosor_pastilla_freno_3',
estado_freno_4.grosor_pastilla AS 'grosor_pastilla_freno_4', 
#medicion_aux.profundidad_neumatico_1, #medicion_aux.profundidad_neumatico_2,
#medicion_aux.profundidad_neumatico_3, #medicion_aux.profundidad_neumatico_4,
#medicion_aux.id_tipo_neumatico_1, #medicion_aux.id_tipo_neumatico_2, #medicion_aux.id_tipo_neumatico_3,
#medicion_aux.id_tipo_neumatico_4
FROM AJO_DER.medicion
	JOIN AJO_DER.carrera ON id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo ON YEAR(carrera.fecha) = BI_DIM_tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = BI_DIM_tiempo.cuatrimestre
	JOIN AJO_DER.auto ON id_auto = auto.id
	JOIN AJO_DER.sector ON id_sector = sector.id
	JOIN AJO_DER.estado_de_motor ON estado_de_motor.id_medicion = medicion.id
	JOIN AJO_DER.estado_de_caja_de_cambios ON estado_de_caja_de_cambios.id_medicion = medicion.id

	JOIN AJO_DER.freno freno_1 ON freno_1.id_auto = auto.id 
		AND freno_1.id_posicion = 1
	JOIN AJO_DER.estado_freno estado_freno_1 ON estado_freno_1.id_medicion = medicion.id 
		AND estado_freno_1.id_freno = freno_1.id

	JOIN AJO_DER.freno freno_2 ON freno_2.id_auto = auto.id 
		AND freno_2.id_posicion = 2
	JOIN AJO_DER.estado_freno estado_freno_2 ON estado_freno_2.id_medicion = medicion.id 
		AND estado_freno_2.id_freno = freno_2.id

	JOIN AJO_DER.freno freno_3 ON freno_3.id_auto = auto.id 
		AND freno_3.id_posicion = 3
	JOIN AJO_DER.estado_freno estado_freno_3 ON estado_freno_3.id_medicion = medicion.id 
		AND estado_freno_3.id_freno = freno_3.id

	JOIN AJO_DER.freno freno_4 ON freno_4.id_auto = auto.id 
		AND freno_4.id_posicion = 4
	JOIN AJO_DER.estado_freno estado_freno_4 ON estado_freno_4.id_medicion = medicion.id 
		AND estado_freno_4.id_freno = freno_4.id
	JOIN #medicion_aux ON medicion.codigo_medicion = #medicion_aux.codigo_medicion

DROP TABLE #medicion_aux
GO


-- Desgaste promedio de cada componente de cada auto por vuelta por circuito.
CREATE VIEW AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito AS
SELECT
	AVG() 'Desgaste Promedio',
	() 'Componente', 
	id_auto, BI_DIM_auto.modelo 'Modelo del auto', nro_vuelta, BI_DIM_circuito.nombre 'Circuito'
FROM AJO_DER.BI_FACT_medicion
	JOIN AJO_DER.BI_DIM_auto ON id_auto = BI_DIM_auto.id
	JOIN AJO_DER.BI_DIM_circuito ON id_circuito = BI_DIM_circuito.id
GROUP BY id_auto, nro_vuelta, id_circuito
GO

DROP TABLE #combustible_max_min
GO

-- Mejor tiempo de vuelta de cada escudería por circuito por año.
-- El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito.
CREATE FUNCTION AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia()
RETURNS @Result TABLE ( tiempo_vuelta DECIMAL(18,10), escuderia_nombre NVARCHAR(255),circuito_nombre NVARCHAR(255), año NVARCHAR(255) )
AS
BEGIN
	INSERT INTO @Result (medicion.tiempo_vuelta,escuderia_nombre,circuito_nombre,año)
	SELECT 
	medicion.tiempo_vuelta,
	escuderia.nombre,
	circuito.nombre,
	year(carrera.fecha)
	FROM 
	AJO_DER.medicion medicion
	INNER JOIN AJO_DER.auto auto ON auto.id=medicion.id_auto
	INNER JOIN AJO_DER.escuderia escuderia ON escuderia.id=auto.id_escuderia
	INNER JOIN AJO_DER.carrera  carrera ON carrera.id=medicion.id_carrera
	INNER JOIN AJO_DER.circuito  circuito ON circuito.id=medicion.id_carrera
	GROUP BY medicion.tiempo_vuelta,escuderia.nombre,circuito.nombre,carrera.fecha
	ORDER BY medicion.tiempo_vuelta
RETURN 
END
GO

-- Los 3 de circuitos con mayor consumo de combustible promedio
CREATE FUNCTION AJO_DER.circuitos_con_mayor_consumo_de_combustible_promedio()
RETURNS @Result TABLE (id_circuito INT, id_carrera INT, combustible_gastado_promedio DECIMAL(18,2))
AS
BEGIN
	DECLARE @ConsumoPorAuto TABLE (id_circuito INT, id_carrera INT, id_auto INT, combustible_gastado_auto DECIMAL(18,2))

	INSERT INTO @ConsumoPorAuto (id_circuito, id_carrera, id_auto, combustible_gastado_auto)
	SELECT
		id_circuito,
		id_carrera,
		id_auto,
		MAX(cant_combustible) - MIN(cant_combustible)
	FROM AJO_DER.medicion
	JOIN AJO_DER.carrera ON AJO_DER.medicion.id_carrera = AJO_DER.carrera.id
	GROUP BY id_circuito, id_carrera, id_auto

	INSERT INTO @Result (id_circuito, id_carrera, combustible_gastado_promedio)
	SELECT TOP 3
		id_circuito,
		id_carrera,
		SUM(combustible_gastado_auto) / COUNT(id_auto) AS 'Combustible gastado promedio'
	FROM @ConsumoPorAuto
	GROUP BY id_circuito, id_carrera
	ORDER BY 'Combustible gastado promedio' DESC
RETURN 
END
GO

-- Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. (agrupar por sector y decorar un poco el resultado)
CREATE FUNCTION AJO_DER.maxima_velocidad_alcanzada_por_cada_auto()
RETURNS @Result TABLE ( velocidad DECIMAL(18,10), sector INT,circuito_nombre NVARCHAR(255), id_tipo_sector INT,  numero_auto INT)
AS
BEGIN
	INSERT INTO @Result (velocidad,sector,circuito_nombre,id_tipo_sector,numero_auto)
	SELECT
	medicion.velocidad,
	medicion.id_sector,
	circuito.nombre,
	sector.id_tipo_sector,
	auto.numero_auto	
	FROM 
	AJO_DER.medicion medicion
	INNER JOIN AJO_DER.auto auto ON auto.id=medicion.id_auto
	INNER JOIN AJO_DER.carrera  carrera ON carrera.id=medicion.id_carrera
	INNER JOIN AJO_DER.circuito  circuito ON circuito.id=medicion.id_carrera
	INNER JOIN AJO_DER.sector sector ON circuito.id=medicion.id_carrera
	GROUP BY auto.numero_auto, medicion.velocidad,sector.id_tipo_sector,medicion.id_sector,circuito.nombre
	ORDER BY medicion.velocidad DESC
RETURN 
END
GO

-- Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre
CREATE FUNCTION AJO_DER.tiempo_promedio_que_tardo_cada_escuderia()
RETURNS @Result TABLE (escuderia_nombre NVARCHAR(255),promedio_tiempo_parada DECIMAL(18,10), cuatrimestre INT )
AS
BEGIN
	INSERT INTO @Result (escuderia_nombre,promedio_tiempo_parada,cuatrimestre)
	SELECT
	escuderia.nombre,
	AVG(parada.tiempo_parada),
	DATENAME(quarter,carrera.fecha)
	FROM AJO_DER.medicion medicion
	INNER JOIN AJO_DER.auto auto ON auto.id=medicion.id_auto
	INNER JOIN AJO_DER.escuderia escuderia ON escuderia.id=auto.id_escuderia
	INNER JOIN AJO_DER.carrera  carrera ON carrera.id=medicion.id_carrera
	INNER JOIN AJO_DER.circuito  circuito ON circuito.id=medicion.id_carrera
	INNER JOIN AJO_DER.parada_box parada ON parada.id_carrera=carrera.id
	GROUP BY escuderia.nombre,DATENAME(quarter,carrera.fecha)
RETURN 
END
GO

-- Cantidad de paradas por circuito por escudería por año.
CREATE FUNCTION AJO_DER.cantidad_de_paradas_por_circuito()
RETURNS @Result TABLE ( paradas INT, circuito_nombre NVARCHAR(255), escuderia_nombre NVARCHAR(255), año NVARCHAR(255))
AS
BEGIN
	INSERT INTO @Result (paradas,circuito_nombre,escuderia_nombre,año)
	SELECT	
	count(parada.id) [cantida de paradas],
	circuito.nombre,
	escuderia.nombre,
	year(carrera.fecha) [fecha]
	FROM 
	AJO_DER.medicion medicion
	INNER JOIN AJO_DER.auto auto ON auto.id=medicion.id_auto
	INNER JOIN AJO_DER.escuderia escuderia ON escuderia.id=auto.id_escuderia
	INNER JOIN AJO_DER.carrera  carrera ON carrera.id=medicion.id_carrera
	INNER JOIN AJO_DER.circuito  circuito ON circuito.id=medicion.id_carrera
	INNER JOIN AJO_DER.parada_box parada ON parada.id_carrera=carrera.id
	GROUP BY circuito.nombre,escuderia.nombre,carrera.fecha
RETURN 
END
GO

-- Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
CREATE FUNCTION AJO_DER.circuitos_con_mayor_tiempo_en_paradas()
RETURNS @Result TABLE (id_circuito INT, id_carrera INT, tiempo_total_paradas INT)
AS
BEGIN
	INSERT INTO @Result (id_circuito, id_carrera, tiempo_total_paradas)
	SELECT TOP 3
		id_circuito,
		id_carrera,
		SUM(tiempo_parada) AS 'Tiempo total en paradas'
	FROM AJO_DER.parada_box
	JOIN AJO_DER.carrera ON AJO_DER.parada_box.id_carrera = AJO_DER.carrera.id
	GROUP BY id_circuito, id_carrera
	ORDER BY 'Tiempo total en paradas' DESC
RETURN 
END
GO

-- Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes
CREATE FUNCTION AJO_DER.circuitos_mas_peligrosos_del_anio()
RETURNS @Result TABLE (id_circuito INT, id_carrera INT, anio INT, cant_incidentes INT)
AS
BEGIN
	DECLARE @IncidentesPorCircuito TABLE (id_circuito INT, id_carrera INT, anio INT, cant_incidentes INT)

	INSERT INTO @IncidentesPorCircuito (id_circuito, id_carrera, anio, cant_incidentes)
	SELECT 
		id_circuito,
		id_carrera,
		YEAR(fecha),
		COUNT(incidente.id) AS 'Cantidad de incidentes'
	FROM AJO_DER.incidente
	JOIN AJO_DER.carrera ON AJO_DER.incidente.id_carrera = AJO_DER.carrera.id
	GROUP BY id_circuito, id_carrera, YEAR(fecha)
	ORDER BY 'Cantidad de incidentes' DESC

	INSERT INTO @Result (id_circuito, id_carrera, anio, cant_incidentes)
	SELECT
		id_circuito,
		id_carrera,
		anio,
		cant_incidentes
	FROM (
		SELECT *, ROW_NUMBER() OVER (PARTITION BY anio ORDER BY cant_incidentes DESC) AS RN FROM @IncidentesPorCircuito
	) AS TOP_3_ANUAL
	WHERE RN <= 3
RETURN 
END
GO

-- Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores
CREATE FUNCTION AJO_DER.promedio_incidentes_escuderia_anio_tipo_de_sector()
RETURNS @Result TABLE (sector_codigo INT,carrera_fecha NVARCHAR(255), escuderia_nombre varchar(255),promedio_incidentes DECIMAL(18,2) )
AS
BEGIN
	INSERT INTO @Result (sector_codigo,carrera_fecha,escuderia_nombre,promedio_incidentes)
	SELECT
	sector.codigo,	
	year(carrera.fecha),
	escuderia.nombre,
	(count(*)/(	
						SELECT COUNT(*) 
						FROM  AJO_DER.incidente i
						WHERE i.id_sector =sector.codigo)
	) AS promedio
	FROM AJO_DER.medicion medicion
	INNER JOIN AJO_DER.auto auto ON auto.id=medicion.id_auto
	INNER JOIN AJO_DER.escuderia escuderia ON escuderia.id=auto.id_escuderia
	INNER JOIN AJO_DER.carrera  carrera ON carrera.id=medicion.id_carrera
	INNER JOIN AJO_DER.circuito  circuito ON circuito.id=medicion.id_carrera
	INNER JOIN AJO_DER.sector sector ON sector.id=medicion.id_sector
	INNER JOIN AJO_DER.incidente incidente ON incidente.id_sector=sector.id
	GROUP BY escuderia.nombre,carrera.fecha,sector.codigo
RETURN 
END
GO

SELECT * FROM AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia()
SELECT * FROM AJO_DER.circuitos_con_mayor_consumo_de_combustible_promedio()
SELECT * FROM AJO_DER.maxima_velocidad_alcanzada_por_cada_auto()
SELECT * FROM AJO_DER.tiempo_promedio_que_tardo_cada_escuderia()
SELECT * FROM AJO_DER.cantidad_de_paradas_por_circuito()
SELECT * FROM AJO_DER.circuitos_con_mayor_tiempo_en_paradas()
SELECT * FROM AJO_DER.circuitos_mas_peligrosos_del_anio()
SELECT * FROM AJO_DER.promedio_incidentes_escuderia_anio_tipo_de_sector()