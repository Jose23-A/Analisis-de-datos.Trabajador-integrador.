-- INT

CREATE TABLE [dbo].[INT_Dim_Producto](
	[CodigoProducto] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Categoria] [nvarchar](50) NOT NULL,
	[Marca] [nvarchar](50) NOT NULL,
	[PrecioCosto] [decimal](18 ,2) NOT NULL,
	[PrecioVentaSugerido] [decimal](18, 2) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[INT_Dim_Tienda](
	[CodigoTienda] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](200) NOT NULL,
	[Localidad] [nvarchar](100) NOT NULL,
	[Provincia] [nvarchar](100) NOT NULL,
	[CP] [nvarchar](10) NOT NULL,
	[TipoTienda] [nvarchar](255) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[INT_Dim_Cliente](
	[CodCliente] [int] NOT NULL,
	[RazonSocial] [nvarchar](100) NOT NULL,
	[Telefono] [nvarchar](20) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](200) NOT NULL,
	[Localidad] [nvarchar](100) NOT NULL,
	[Provincia] [nvarchar](100) NOT NULL,
	[CP] [nvarchar](10) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[INT_Fact_Ventas](
	[FechaVenta] [datetime] NOT NULL,
	[CodigoProducto] [int] NOT NULL,
	[Producto] [nvarchar](50) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioVenta] [decimal](18, 2) NOT NULL,
	[CodigoCliente] [int] NOT NULL,
	[Cliente] [nvarchar](50) NOT NULL,
	[CodigoTienda] [int] NOT NULL,
	[Tienda] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
