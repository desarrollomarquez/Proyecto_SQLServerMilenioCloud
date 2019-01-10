USE [MilenioCloud]
GO
/****** Object:  StoredProcedure [dbo].[sp_mc_select_persona]    Script Date: 3/01/2019 11:55:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_mc_select_persona]
		@CAMPOS			sysname,
		@PARAMETROS		sysname
AS
 
BEGIN

SET NOCOUNT ON 
DECLARE @TABLA					NVARCHAR(500)= 'Persona',
		@QUERY					NVARCHAR(500),
		@NOMBRE					NVARCHAR(500),
		@STRING				    NVARCHAR(500)

SET @STRING = ( SELECT STUFF(
					(	SELECT
						CAST(', ' AS VARCHAR(MAX)) + 
					    CASE
						WHEN VALUE =' Nombre' THEN 'TI.Nombre AS TipoIdentificacion, E.Nombre AS Entidad'
						ELSE VALUE
						END
						FROM STRING_SPLIT(@CAMPOS, ',')
						FOR XML PATH('')
					), 1, 1, '') as DATOS
				 )

IF @CAMPOS IS NULL OR @CAMPOS =''
	BEGIN
	SET @QUERY = N' SELECT TI.Nombre as TipoIdentificacion, P.NumeroIdentificacion, P.Nombres, P.Apellidos, P.Sexo, P.FNacimiento, P.Nacionalidad, P.LibretaMilitar, P.TipoSangre, P.Estado_Persona, E.Nit, E.Nombre FROM Persona P INNER JOIN Entidad_Persona_Rol EPR ON P.Codigo_Id = EPR.Persona_Id INNER JOIN Entidad E ON E.Codigo_Id = EPR.Entidad_Id INNER JOIN Rol R ON R.Codigo_Id = EPR.Rol_Id INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id';
	END

ELSE IF @PARAMETROS IS NULL OR @PARAMETROS =''
		BEGIN
		SET @QUERY = N' SELECT '+@CAMPOS+' FROM Persona P INNER JOIN Entidad_Persona_Rol EPR ON P.Codigo_Id = EPR.Persona_Id INNER JOIN Entidad E ON E.Codigo_Id = EPR.Entidad_Id INNER JOIN Rol R ON R.Codigo_Id = EPR.Rol_Id INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id';
		END
ELSE 
		BEGIN
		SET @QUERY = N' SELECT TI.Nombre as TipoIdentificacion, P.NumeroIdentificacion, P.Nombres, P.Apellidos, P.Sexo, P.FNacimiento, P.Nacionalidad, P.LibretaMilitar, P.TipoSangre, P.Estado_Persona, E.Nit, E.Nombre FROM Persona P INNER JOIN Entidad_Persona_Rol EPR ON P.Codigo_Id = EPR.Persona_Id INNER JOIN Entidad E ON E.Codigo_Id = EPR.Entidad_Id INNER JOIN Rol R ON R.Codigo_Id = EPR.Rol_Id INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id WHERE '+@CAMPOS+' = '+@PARAMETROS;
		END
	
BEGIN TRY  
	EXECUTE sp_executesql @QUERY;
END TRY
BEGIN CATCH  
SELECT   
	ERROR_NUMBER() AS ErrorNumber,   
	ERROR_PROCEDURE() AS ErrorProcedure,  
	ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

END
