ALTER PROCEDURE [dbo].[SP_Genera_Dim_Tiempo] 
@anio Int 
AS 
BEGIN
    SET NOCOUNT ON;
    SET ARITHABORT OFF;
    SET ARITHIGNORE ON;
    SET DATEFIRST 1;

    /**************/
    /* Variables */
    /**************/
    DECLARE @dia smallint;
    DECLARE @mes smallint;
    DECLARE @fecha datetime;
    DECLARE @fin int;

    -- Inicializamos variables
    SET @dia = 1;
    SET @mes = 1;

    -- Convertimos el año, mes y día en formato smalldatetime directamente
    SET @fecha = TRY_CAST(CONCAT(@anio, '-', RIGHT('0' + LTRIM(@mes), 2), '-', RIGHT('0' + LTRIM(@dia), 2)) AS datetime);
    
    IF @fecha IS NULL
    BEGIN
        PRINT 'Error al convertir la fecha inicial a smalldatetime';
        RETURN;
    END;

    -- Condición de control de año ya existente en la tabla
    IF (SELECT Count(*) FROM Dim_Tiempo WHERE anio = @anio) > 0 
    BEGIN
        PRINT 'El año que ingresó ya existe en la tabla';
        PRINT 'Procedimiento CANCELADO.';
        RETURN;
    END;

    -- Límite del ciclo
    SET @fin = @anio + 1;

    PRINT 'Generando datos para el año: ' + CAST(@anio AS VARCHAR);

    -- Bucle para insertar registros día a día
    WHILE (Year(@fecha) < @fin) 
    BEGIN
        PRINT 'Insertando fecha: ' + CONVERT(varchar, @fecha, 121);

        -- Inserto el registro
        INSERT INTO Dim_Tiempo (Tiempo_Key, Anio, Mes, Mes_Nombre, Semestre, Trimestre, Semana_Anio ,Semana_Nro_Mes, Dia, Dia_Nombre, Dia_Semana_Nro)
        SELECT 
            tiempo_key = @fecha,
            anio = Datepart(yyyy, @fecha),
            mes = Datepart(mm, @fecha),
            mes_nombre = CASE Datename(mm, @fecha)
                WHEN 'January' THEN 'Enero'
                WHEN 'February' THEN 'Febrero'
                -- Completar los nombres de los meses restantes
                ELSE Datename(mm, @fecha)
            END,
            semestre = CASE WHEN Datepart(mm, @fecha) BETWEEN 1 AND 6 THEN 1 ELSE 2 END,
            trimestre = Datepart(qq, @fecha),
            semana_anio = Datepart(wk, @fecha),
            semana_nro_mes = Datepart(wk, @fecha) - Datepart(week, Dateadd(dd, -Day(@fecha)+1, @fecha)) + 1,
            dia = Datepart(dd, @fecha),
            dia_nombre = CASE Datename(dw, @fecha)
                WHEN 'Monday' THEN 'Lunes'
                WHEN 'Tuesday' THEN 'Martes'
                -- Completar los nombres de los días restantes
                ELSE Datename(dw, @fecha)
            END,
            dia_semana_nro = Datepart(dw, @fecha);
        
        -- Incremento de la fecha
        SET @fecha = Dateadd(dd, 1, @fecha);
    END;

    PRINT 'Finalización del procedimiento.';
END;
