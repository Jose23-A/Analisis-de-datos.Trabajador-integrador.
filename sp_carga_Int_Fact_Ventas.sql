USE [DW_DataShop]
GO
/****** Objects StoreProcedure [dbo].[SP_Carga_Int_Fact_Ventas]	Script Date: 26/10/2024 01:03:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Carga_Int_Fact_Ventas]
	@Proceso_ID bigint
AS
BEGIN

TRUNCATE TABLE INT_Fact_Ventas

INSERT INTO [dbo].[INT_Fact_Ventas]
			(
			 [FechaVenta] --Datetime NOT NULL,
			,[CodigoProducto] --INT NOT NULL,
			,[Producto] --NVARHCAR(50) NOT NULL,
			,[Cantidad] --INT NOT NULL,
			,[PrecioVenta] --DECIMAL(18, 2) NOT NULL,
			,[CodigoCliente] --INT NOT NULL,
			,[Cliente] --NVARCHAR(50), NOT NULL,
			,[CodigoTienda] --INT NOT NULL,
			,[Tienda] --NVARCHAR(50) NOT NULL
			)

SELECT distinct
		CONVERT(DATETIME, [FechaVenta], 120) AS [FechaVenta]
		,CAST([CodigoProducto] AS int) as CodigoProducto
		,[Producto] as Producto
		,CAST([Cantidad] AS int) as Cantidad
		,CAST([PrecioVenta] AS DECIMAL(18, 2)) AS PrecioVenta
		,CAST([CodigoCliente] AS int) AS CodigoCliente
		,[Cliente] as Cliente
		,CAST([CodigoTienda] AS int) AS CodigoTienda
		,[Tienda] as Tienda
	FROM STG_Fact_Ventas

	 -- Actualizar los registros en INT_Fact_Ventas para que correspondan a los IdTienda de Dim_Tienda
    UPDATE I
    SET I.CodigoTienda = D.IdTienda
    FROM dbo.INT_Fact_Ventas I
    JOIN dbo.Dim_Tienda D ON I.CodigoTienda = D.IdTienda;

	-- Actualizar los registros en INT_Fact_Ventas para que correspondan a los IdCliente de Dim_Cliente
    UPDATE I
    SET I.CodigoCliente = C.IdCliente
    FROM dbo.INT_Fact_Ventas I
    JOIN dbo.Dim_Cliente C ON I.CodigoCliente = C.IdCliente

END