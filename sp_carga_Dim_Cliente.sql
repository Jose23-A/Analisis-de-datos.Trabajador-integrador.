USE [DW_DataShop]
GO
/****** Objects: StoreProcedure [dbo].[SP_Carga_Dim_Cliente]	Script Date: 28/10/2024 15:29:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Carga_Dim_Cliente]
	@Proceso_ID bigint
as
BEGIN

	--Se limpian los clientes con NULL en el ID.
	DELETE
	FROM INT_Dim_Cliente
	WHERE CodCliente is null;

	-----Actualizo campos del Producto si existe
	UPDATE C
		SET CodCliente=D.CodCliente,
		RazonSocial=D.RazonSocial,
		Telefono=D.Telefono,
		Mail=D.Mail,
		Direccion = D.Direccion,
		Localidad = D.Localidad,
		Provincia = D.Provincia,
		CP = D.CP
	FROM Dim_Cliente C
		INNER JOIN INT_Dim_Cliente D
		ON C.CodCliente=D.CodCliente;

		--Inserto los nuevos Registros

	INSERT INTO Dim_Cliente
	 ([CodCliente],
	 [RazonSocial],
	 [Telefono],
	 [Mail],
	 [Direccion],
	 [Localidad],
	 [Provincia],
	 [CP],
	 [FechaCreacion],
	 [FechaActualizacion])
	SELECT distinct
		I.CodCliente
		,I.RazonSocial
		,I.Telefono
		,I.Mail
		,I.Direccion
		,I.Localidad
		,I.Provincia
		,I.CP
		,Getdate() as FechaCreacion
		, null as FechaActualizacion
	FROM [INT_Dim_Cliente] I
		left join [Dim_Cliente] D
			ON I.CodCliente=D.CodCliente
	WHERE D.CodCliente IS NULL;

END