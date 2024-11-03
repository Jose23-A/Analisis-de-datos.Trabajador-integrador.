USE [DW_DataShop]
GO
/****** Objects StoreProcedure [dbo].[SP_Carga_Int_Dim_Cliente]	Script Date: 26/10/2024 00:52:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Carga_Int_Dim_Cliente]
	@Proceso_ID bigint
AS
BEGIN

TRUNCATE TABLE INT_Dim_Cliente

INSERT INTO [dbo].[INT_Dim_Cliente]
			(
			 [CodCliente] -- INT NOT NULL,
			,[RazonSocial] --NVARCHAR(100) NOT NULL,
			,[Telefono] --NVARCHAR(20) NOT NULL,
			,[Mail] --NVARCHAR(100) NOT NULL,
			,[Direccion] --NVARCHAR(200) NOT NULL,
			,[Localidad] --NVARCHAR(100) NOT NULL,
			,[Provincia] --NVARCHAR(100) NOT NULL,
			,[CP] --NVARCHAR(10) NOT NULL,
			,[FechaRegistro] --Datetime NOT NULL
			)

SELECT distinct
		CAST(CodCliente AS int) AS [CodCliente]
		,[RazonSocial] as RazonSocial
		,[Telefono] as Telefono
		,[Mail] as Mail
		,[Direccion] as Direccion
		,[Localidad] as Localidad
		,[Provincia] as Provincia
		,[CP] as CP
		,GETDATE() AS [FechaRegistro]
	FROM STG_Dim_Cliente

END