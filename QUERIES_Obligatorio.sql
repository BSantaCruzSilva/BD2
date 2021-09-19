USE [ObligatorioBD2_GestionMetro]
GO
--a.Mostrar los datos del/los trene/s que pasaron por �ltima vez por una l�nea-estaci�n
SELECT * 
FROM Tren t1
WHERE t1.Numero IN (
	SELECT telm1.NumeroTren
	FROM TrenEstacionLineaMetro telm1
	GROUP BY telm1.NumeroTren
	HAVING MAX(telm1.Fecha) <= GETDATE()
	)


--b.Mostrar los datos de las estaciones por las que pasaron m�s trenes este a�o que la cantidad promedio de trenes que pasaron en el a�o anterior.
SELECT *
FROM Estacion e1
WHERE e1.Codigo IN (
	SELECT telm.CodigoEstacion
	FROM TrenEstacionLineaMetro telm
	WHERE (telm.fecha BETWEEN '2020-01-01' AND '2020-12-31')
	GROUP BY telm.CodigoEstacion
	HAVING COUNT(telm.NumeroTren) > (
	SELECT COUNT(telm2.NumeroTren)
	FROM TrenEstacionLineaMetro telm2
	WHERE (telm2.fecha BETWEEN '2021-01-01' AND GETDATE()))
	)

--c.Mostrar numero de l�nea, descripci�n, nombre de la estaci�n inicio, nombre de la estaci�n destino y cantidad de estaciones que la componen.
SELECT l1.numero, l1.descripcion, MIN(e1.CodigoEstacion) AS estacionInicio, MAX(e1.CodigoEstacion) AS estacionDestino, COUNT(e1.CodigoEstacion) AS numEstaciones
FROM LineaMetro l1, EstacionLineaMetro e1
WHERE l1.Numero = e1.NumeroLinea
GROUP BY l1.numero, l1.descripcion

--d.Mostrar los datos de la l�nea que recorre la distancia m�s larga
SELECT l1.*
FROM LineaMetro l1
WHERE l1.longitud = (
	SELECT MAX(l2.longitud)
	FROM LineaMetro l2
	)

--e.Mostrar los datos de las estaciones que est�n incluidas en l�neas de color rojo pero no est�n incluidas en l�neas de color amarillo.
SELECT e1.*
FROM Estacion e1
WHERE (
e1.Codigo IN (
		SELECT e2.CodigoEstacion
		FROM EstacionLineaMetro e2, LineaMetro l1
		WHERE e2.NumeroLinea = l1.Numero AND l1.CodigoColor = 'ROJO')
AND e1.codigo NOT IN (SELECT e2.CodigoEstacion
		FROM EstacionLineaMetro e2, LineaMetro l1
		WHERE e2.NumeroLinea = l1.Numero AND l1.CodigoColor = 'AMARILLO')
		)

--f.Mostrar los datos de los trenes que pasaron por todas las estaciones existentes.
SELECT t1.*
FROM Tren t1
WHERE t1.Numero IN (
	SELECT telm1.NumeroTren
	FROM TrenEstacionLineaMetro telm1
	GROUP BY telm1.NumeroTren
	HAVING COUNT(telm1.CodigoEstacion) = (
		SELECT COUNT(e1.Codigo)
		FROM Estacion e1
		)
	)
	