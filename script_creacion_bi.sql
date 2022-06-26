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
	DROP FUNCTION AJO_DER.promedio_incidentes_escuderia_anio_tipo_de_sector

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