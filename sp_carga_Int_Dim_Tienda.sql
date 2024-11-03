USE [DW_DataShop]
GO
/****** Objects StoreProcedure [dbo].[SP_Carga_Int_Dim_Tienda]	Script Date: 26/10/2024 00:49:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Carga_Int_Dim_Tienda]
	@Proceso_ID bigint
AS
BEGIN

TRUNCATE TABLE INT_Dim_Tienda

INSERT INTO [dbo].[INT_Dim_Tienda]
			(
			 [CodigoTienda] -- INT NOT NULL,
			,[Descripcion] --NVARCHAR(100) NOT NULL,
			,[Direccion] --NVARCHAR(200) NOT NULL,
			,[Localidad] --NVARCHAR(100) NOT NULL,
			,[Provincia] --NVARCHAR(100) NOT NULL,
			,[CP] --NVARCHAR(10) NOT NULL,
			,[TipoTienda] --NVARCHAR(255) NOT NULL,
			,[FechaRegistro] --Datetime NOT NULL
			)

SELECT distinct
		CAST(codigoTienda AS int) AS [CodigoTienda]
		,[Descripcion] as Descripcion
		,[Direccion] as Direccion
		,[Localidad] as Localidad
		,[Provincia] as Provincia
		,[CP] as CP
		,[TipoTienda] as TipoTienda
		,GETDATE() AS [FechaRegistro]
	FROM STG_Dim_Tienda

END