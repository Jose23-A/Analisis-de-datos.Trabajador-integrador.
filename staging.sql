-- Staging

CREATE TABLE [dbo].[STG_Dim_Producto](
	[CodigoProducto] [nvarchar](255) NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Categoria] [nvarchar](255) NULL,
	[Marca] [nvarchar](255) NULL,
	[PrecioCosto] [nvarchar](255) NULL,
	[PrecioVentaSugerido] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Dim_Tienda](
	[CodigoTienda] [nvarchar](255) NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Localidad] [nvarchar](255) NULL,
	[Provincia] [nvarchar](255) NULL,
	[CP] [nvarchar](255) NULL,
	[TipoTienda] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Dim_Cliente](
	[CodCliente] [nvarchar](255) NULL,
	[RazonSocial] [nvarchar](255) NULL,
	[Telefono] [nvarchar](255) NULL,
	[Mail] [nvarchar](255) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Localidad] [nvarchar](255) NULL,
	[Provincia] [nvarchar](255) NULL,
	[CP] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Fact_Ventas](
	[FechaVenta] [nvarchar](255) NULL,
	[CodigoProducto] [nvarchar](255) NULL,
	[Producto] [nvarchar](255) NULL,
	[Cantidad] [nvarchar](255) NULL,
	[PrecioVenta] [nvarchar](255) NULL,
	[CodigoCliente] [nvarchar](255) NULL,
	[Cliente] [nvarchar](255) NULL,
	[CodigoTienda] [nvarchar](255) NULL,
	[Tienda] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Dim_Tiempo] (
    [Tiempo_Key] [nvarchar](255) NULL,
    [Anio] [nvarchar](255) NULL,
    [Mes] [nvarchar](255) NULL,
    [Mes_Nombre] [nvarchar](255) NULL,
    [Semestre] [nvarchar](255) NULL,
    [Trimestre] [nvarchar](255) NULL,
    [Semana_Anio] [nvarchar](255) NULL,
    [Semana_Nro_Mes] [nvarchar](255) NULL,
    [Dia] [nvarchar](255) NULL,
    [Dia_Nombre] [nvarchar](255) NULL,
    [Dia_Semana_Nro] [nvarchar](255) NULL,
)ON [PRIMARY]

GO


CREATE TABLE [dbo].[STG_Dim_Producto_Datos_Faltantes](
	[CodigoProducto] [nvarchar](255) NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Categoria] [nvarchar](255) NULL,
	[Marca] [nvarchar](255) NULL,
	[PrecioCosto] [nvarchar](255) NULL,
	[PrecioVetnaSugerido] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Dim_Tienda_Datos_Faltantes](
	[CodigoTienda] [nvarchar](255) NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Localidad] [nvarchar](255) NULL,
	[Provincia] [nvarchar](255) NULL,
	[CP] [nvarchar](255) NULL,
	[TipoTienda] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Dim_Cliente_Datos_Faltantes](
	[CodCliente] [nvarchar](255) NULL,
	[RazonSocial] [nvarchar](255) NULL,
	[Telefono] [nvarchar](255) NULL,
	[Mail] [nvarchar](255) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Localidad] [nvarchar](255) NULL,
	[Provincia] [nvarchar](255) NULL,
	[CP] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Fact_Ventas_Datos_Faltantes](
	[FechaVenta] [nvarchar](255) NULL,
	[CodigoProducto] [nvarchar](255) NULL,
	[Producto] [nvarchar](255) NULL,
	[Cantidad] [nvarchar](255) NULL,
	[PrecioVenta] [nvarchar](255) NULL,
	[CodigoCliente] [nvarchar](255) NULL,
	[Cliente] [nvarchar](255) NULL,
	[CodigoTienda] [nvarchar](255) NULL,
	[Tienda] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[STG_Dim_Tiempo_Datos_Faltantes] (
    [Tiempo_Key] [nvarchar](255) NULL,
    [Anio] [nvarchar](255) NULL,
    [Mes] [nvarchar](255) NULL,
    [Mes_Nombre] [nvarchar](255) NULL,
    [Semestre] [nvarchar](255) NULL,
    [Trimestre] [nvarchar](255) NULL,
    [Semana_Anio] [nvarchar](255) NULL,
    [Semana_Nro_Mes] [nvarchar](255) NULL,
    [Dia] [nvarchar](255) NULL,
    [Dia_Nombre] [nvarchar](255) NULL,
    [Dia_Semana_Nro] [nvarchar](255) NULL,
)ON [PRIMARY]

GO

SELECT * FROM STG_Dim_Producto
GO

SELECT * FROM STG_Dim_Producto_Datos_Faltantes
GO

SELECT * FROM INT_Dim_Producto
GO