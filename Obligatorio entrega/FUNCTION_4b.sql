CREATE FUNCTION dbo.obtenerNombreEstacion(@inicio date, @fin date)  
RETURNS varchar(200)   
AS   
-- dado un rango de fechas, retornar el nombre de la estaci�n por la
-- que pasaron m�s trenes en dicho rango  
BEGIN  
    DECLARE @ret varchar(200);
	
	DECLARE @IdEstacion int;

	SELECT top 1 @IdEstacion = CodigoEstacion
  FROM [dbo].[TrenEstacionLineaMetro]
  where fecha > @inicio and fecha < @fin 
  group by CodigoEstacion order by count(NumeroTren) desc

    select @ret = Descripcion from dbo.Estacion where Codigo = @IdEstacion

    RETURN @ret;  
END; 