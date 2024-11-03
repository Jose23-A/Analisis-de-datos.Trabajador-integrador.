USE [DW_DataShop]
GO
/****** Objects: StoreProcedure [dbo].[SP_Carga_Fact_Ventas]	Script Date: 28/10/2024 15:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Carga_Fact_Ventas]
	@Proceso_ID bigint
as
BEGIN

	--Se limpian los clientes con NULL en el ID.
	DELETE
	FROM INT_Fact_Ventas
	WHERE CodigoProducto is null;

	-----Actualizo campos del Producto si existe
	UPDATE C
		SET FechaVenta = GETDATE(),
		IdProducto = D.CodigoProducto,
		Producto = D.Producto,
		Cantidad =D.Cantidad,
		PrecioVenta=D.PrecioVenta,
		IdCliente = D.CodigoCliente,
		Cliente = D.Cliente,
		IdTienda = D.CodigoTienda,
		Tienda = D.Tienda,
		FechaRegistro = GETDATE()
	FROM Fact_Ventas C
		INNER JOIN INT_Fact_Ventas D
		ON C.IdProducto=D.CodigoProducto;

		--Inserto los nuevos Registros

	INSERT INTO Fact_Ventas
	 ([FechaVenta],
	 [IdProducto],
	 [Producto],
	 [Cantidad],
	 [PrecioVenta],
	 [IdCliente],
	 [Cliente],
	 [IdTienda],
	 [Tienda],
	 [FechaRegistro])
	SELECT distinct
		I.FechaVenta
		,I.CodigoProducto
		,I.Producto
		,I.Cantidad
		,I.PrecioVenta
		,I.CodigoCliente
		,I.Cliente
		,I.CodigoTienda
		,I.Tienda
		,GETDATE() as FechaRegistro
	FROM [INT_Fact_Ventas] I
		left join [Fact_Ventas] D
			ON I.CodigoProducto=D.IdProducto
	WHERE D.IdProducto IS NULL;

END