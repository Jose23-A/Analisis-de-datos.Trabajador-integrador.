USE [DW_DataShop]
GO
/****** Objects: StoreProcedure [dbo].[SP_Carga_Dim_Tienda]	Script Date: 28/10/2024 15:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
AlTER PROCEDURE [dbo].[SP_Carga_Dim_Tienda]
	@Proceso_ID bigint
as
BEGIN

	--Se limpian los clientes con NULL en el ID.
	DELETE
	FROM INT_Dim_Tienda
	WHERE CodigoTienda is null;

	-----Actualizo campos del Producto si existe
	UPDATE C
		SET CodigoTienda=D.CodigoTienda,
		Descripcion=D.Descripcion,
		Direccion=D.Direccion,
		Localidad=D.Localidad,
		Provincia = D.Provincia,
		CP = D.CP,
		TipoTienda = D.TipoTienda,
		FechaActualizacion = GETDATE()
	FROM Dim_Tienda C
		INNER JOIN INT_Dim_Tienda D
		ON C.CodigoTienda = D.CodigoTienda;

		--Inserto los nuevos Registros

	INSERT INTO Dim_Tienda
	 ([CodigoTienda],
	 [Descripcion],
	 [Direccion],
	 [Localidad],
	 [Provincia],
	 [CP],
	 [TipoTienda],
	 [FechaCreacion],
	 [FechaActualizacion])
	SELECT distinct
		I.CodigoTienda
		,I.Descripcion
		,I.Direccion
		,I.Localidad
		,I.Provincia
		,I.CP
		,I.TipoTienda
		,Getdate() as FechaCreacion
		, null as FechaActualizacion
	FROM [INT_Dim_Tienda] I
		left join [Dim_Tienda] D
			ON I.CodigoTienda=D.CodigoTienda
	WHERE D.CodigoTienda IS NULL;

END