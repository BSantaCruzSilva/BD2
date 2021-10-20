-- Mostrar los datos del/los trene/s que pasaron por �ltima vez por una l�nea-estaci�n
SELECT t.*,[Fecha],[Hora]
  FROM [ObligatorioBD2_GestionMetro].[dbo].[TrenEstacionLineaMetro]
  join [ObligatorioBD2_GestionMetro].[dbo].Tren t on t.Numero = NumeroTren


/*
  Mostrar los datos de las estaciones por las que pasaron m�s trenes este a�o que la
cantidad promedio de trenes que pasaron en el a�o anterior.

c. Mostrar numero de l�nea, descripci�n, nombre de la estaci�n inicio, nombre de la estaci�n
destino y cantidad de estaciones que la componen.
d. Mostrar los datos de la l�nea que recorre la distancia m�s larga
e. Mostrar los datos de las estaciones que est�n incluidas en l�neas de color rojo pero no
est�n incluidas en l�neas de color amarillo.
f. Mostrar los datos de los trenes que pasaron por todas las estaciones existentes.

  */