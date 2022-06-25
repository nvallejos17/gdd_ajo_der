--- Mejor tiempo de vuelta de cada escudería por circuito por año.
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra
--realizar una vuelta de un circuito.
CREATE OR ALTER FUNCTION AJO_DER.mejor_tiempo_de_vuelta_de_cada_escudería()
RETURNS @Result TABLE ( tiempo_vuelta decimal(18,10), escuderia_nombre nvarchar(255),circuito_nombre nvarchar(255), año nvarchar(255) )
AS
BEGIN
	Insert into @Result (medicion.tiempo_vuelta,escuderia_nombre,circuito_nombre,año)
	select 
	medicion.tiempo_vuelta,
	escuderia.nombre,
	circuito.nombre,
	year(carrera.fecha)
	from 
	AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.escuderia escuderia on escuderia.id=auto.id_escuderia
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	group by auto.numero_auto, medicion.tiempo_vuelta,escuderia.nombre,circuito.nombre,carrera.fecha
	order by medicion.tiempo_vuelta
RETURN 
END



--- Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. (agrupar por sector y decorar un poco el resultado)
CREATE OR ALTER FUNCTION AJO_DER.máxima_velocidad_alcanzada_por_cada_auto()
RETURNS @Result TABLE ( velocidad decimal(18,10), sector int,circuito_nombre nvarchar(255), id_tipo_sector int,  numero_auto int)
AS
BEGIN
	Insert into @Result (velocidad,sector,circuito_nombre,id_tipo_sector,numero_auto)
	select
	medicion.velocidad,
	medicion.id_sector,
	circuito.nombre,
	sector.id_tipo_sector,
	auto.numero_auto	
	from 
	AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	inner join AJO_DER.sector sector on circuito.id=medicion.id_carrera
	group by auto.numero_auto, medicion.velocidad,sector.id_tipo_sector,medicion.id_sector,circuito.nombre
	order by medicion.velocidad desc
RETURN 
END


--- Cantidad de paradas por circuito por escudería por año.
CREATE OR ALTER FUNCTION AJO_DER.cantidad_de_paradas_por_circuito()
RETURNS @Result TABLE ( paradas int, circuito_nombre nvarchar(255), escuderia_nombre nvarchar(255), año nvarchar(255))
AS
BEGIN
	Insert into @Result (paradas,circuito_nombre,escuderia_nombre,año)
	select	
	count(parada.id),
	circuito.nombre,
	escuderia.nombre,
	year(carrera.fecha)
	from 
	AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.escuderia escuderia on escuderia.id=auto.id_escuderia
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	inner join AJO_DER.parada_box parada on parada.id_carrera=carrera.id
	group by parada.id, circuito.nombre,escuderia.nombre,carrera.fecha
RETURN 
END

select * from AJO_DER.cantidad_de_paradas_por_circuito()	
select * from AJO_DER.máxima_velocidad_alcanzada_por_cada_auto()
select * from AJO_DER.mejor_tiempo_de_vuelta_de_cada_escudería()