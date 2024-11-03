USE [DW_DataShop]
GO
/****** Objects StoreProcedure [dbo].[SP_Carga_Int_Dim_Producto]	Script Date: 25/10/2024 21:24:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Carga_Int_Dim_Producto]
	@Proceso_ID bigint
AS
BEGIN

TRUNCATE TABLE INT_Dim_Producto

INSERT INTO [dbo].[INT_Dim_Producto]
			(
			 [CodigoProducto] -- INT NOT NULL,
			,[Descripcion] --NVARCHAR(100) NOT NULL,
			,[Categoria] --NVARCHAR(50) NOT NULL,
			,[Marca] --NVARCHAR(50) NOT NULL,
			,[PrecioCosto] --DECIMAL(18, 2) NOT NULL,
			,[PrecioVentaSugerido] --DECIMAL(18, 2) NOT NULL,
			,[FechaRegistro] --Datetime NOT NULL
			)

SELECT distinct
		CAST(CodigoProducto AS int) AS [CodigoProducto]
		,[Descripcion] as Descripcion
		,[Categoria] as Categoria
		,[Marca] as Marca
		,CAST([PrecioCosto] AS DECIMAL(18, 2)) AS PrecioCosto
		,CAST([PrecioVentaSugerido] AS DECIMAL(18, 2)) AS PrecioVentaSugerido
		,GETDATE() AS [FechaRegistro]
	FROM STG_Dim_Producto

END