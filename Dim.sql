---

CREATE TABLE [dbo].[Dim_Producto](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[CodigoProducto] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Categoria] [nvarchar](50) NOT NULL,
	[Marca] [nvarchar](50) NOT NULL,
	[PrecioCosto] [decimal](18, 2) NOT NULL,
	[PrecioVentaSugerido] [decimal](18, 2) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Dim_Tienda](
	[IdTienda] [int] IDENTITY(1,1) NOT NULL,
	[CodigoTienda][int]	NOT NULL,
	[Descripcion] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](200) NOT NULL,
	[Localidad] [nvarchar](100) NOT NULL,
	[Provincia] [nvarchar](100) NOT NULL,
	[CP] [nvarchar](10) NOT NULL,
	[TipoTienda] [nvarchar](50) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[IdTienda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Dim_Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[CodCliente][int] NOT NULL,
	[RazonSocial] [nvarchar](100) NOT NULL,
	[Telefono] [nvarchar](20) NOT NULL,
	[Mail] [nvarchar](100) NOT NULL,
	[Direccion] [nvarchar](200) NOT NULL,
	[Localidad] [nvarchar](100) NOT NULL,
	[Provincia] [nvarchar](100) NOT NULL,
	[CP] [nvarchar](10) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Fact_Ventas](
	[FechaVenta] [datetime] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Producto] [nvarchar](50) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioVenta] [decimal](18, 2) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[Cliente] [nvarchar](50) NOT NULL,
	[IdTienda] [int] NOT NULL,
	[Tienda] [nvarchar](50) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
)
GO

CREATE TABLE Dim_Tiempo (
    Tiempo_Key datetime PRIMARY KEY,
    Anio int,
    Mes int,
    Mes_Nombre varchar(20),
    Semestre int,
    Trimestre int,
    Semana_Anio int,
    Semana_Nro_Mes int,
    Dia int,
    Dia_Nombre varchar(20),
    Dia_Semana_Nro int
);

ALTER TABLE [dbo].[Fact_Ventas] WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Dim_Cliente] ([IdCliente])
GO

ALTER TABLE [dbo].[Fact_Ventas] WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Dim_Producto] ([IdProducto])
GO

ALTER TABLE [dbo].[Fact_Ventas] WITH CHECK ADD FOREIGN KEY([IdTienda])
REFERENCES [dbo].[Dim_Tienda] ([IdTienda])
GO

ALTER TABLE [dbo].[Fact_Ventas] WITH CHECK ADD FOREIGN KEY([FechaVenta])
REFERENCES [dbo].[Dim_Tiempo] ([Tiempo_Key])
GO

