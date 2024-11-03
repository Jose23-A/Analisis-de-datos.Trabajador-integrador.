USE [DW_DataShop]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Carga_Fact_Ventas]
    @Proceso_ID bigint
AS
BEGIN

    -- Se limpian los clientes con NULL en el ID.
    DELETE FROM INT_Fact_Ventas
    WHERE CodigoProducto IS NULL;

    -- Actualizo campos del Producto si existe
    UPDATE C
    SET C.FechaVenta = D.FechaVenta,
        C.IdProducto = P.IdProducto,  -- Obtener IdProducto de Dim_Producto
        C.Producto = D.Producto,
        C.Cantidad = D.Cantidad,
        C.PrecioVenta = D.PrecioVenta,
        C.IdCliente = CL.IdCliente,  -- Obtener IdCliente de Dim_Cliente
        C.Cliente = D.Cliente,
        C.IdTienda = T.IdTienda,  -- Obtener IdTienda de Dim_Tienda
        C.Tienda = D.Tienda,
        C.FechaRegistro = GETDATE()
    FROM Fact_Ventas C
    INNER JOIN INT_Fact_Ventas D ON C.IdProducto = D.CodigoProducto
    INNER JOIN Dim_Producto P ON D.CodigoProducto = P.IdProducto  -- Relacionar con Dim_Producto
    INNER JOIN Dim_Cliente CL ON D.CodigoCliente = CL.IdCliente  -- Relacionar con Dim_Cliente
    INNER JOIN Dim_Tienda T ON D.CodigoTienda = T.IdTienda;  -- Relacionar con Dim_Tienda

    -- Inserto los nuevos Registros
    INSERT INTO Fact_Ventas
    (
        [FechaVenta],
        [IdProducto],
        [Producto],
        [Cantidad],
        [PrecioVenta],
        [IdCliente],
        [Cliente],
        [IdTienda],
        [Tienda],
        [FechaRegistro]
    )
    SELECT DISTINCT
        I.FechaVenta,
        P.IdProducto,  -- Obtener IdProducto de Dim_Producto
        I.Producto,
        I.Cantidad,
        I.PrecioVenta,
        CL.IdCliente,  -- Obtener IdCliente de Dim_Cliente
        I.Cliente,
        T.IdTienda,  -- Obtener IdTienda de Dim_Tienda
        I.Tienda,
        GETDATE() AS FechaRegistro
    FROM [INT_Fact_Ventas] I
    LEFT JOIN [Fact_Ventas] D ON I.CodigoProducto = D.IdProducto
    LEFT JOIN Dim_Producto P ON I.CodigoProducto = P.IdProducto  -- Relacionar con Dim_Producto
    LEFT JOIN Dim_Cliente CL ON I.CodigoCliente = CL.IdCliente  -- Relacionar con Dim_Cliente
    LEFT JOIN Dim_Tienda T ON I.CodigoTienda = T.IdTienda  -- Relacionar con Dim_Tienda
    WHERE D.IdProducto IS NULL
    AND P.IdProducto IS NOT NULL  -- Asegurarse de que el producto existe
    AND CL.IdCliente IS NOT NULL  -- Asegurarse de que el cliente existe
    AND T.IdTienda IS NOT NULL;  -- Asegurarse de que la tienda existe

END
