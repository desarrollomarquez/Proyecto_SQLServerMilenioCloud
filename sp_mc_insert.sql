USE [MilenioCloud]
GO
/****** Object:  StoredProcedure [dbo].[sp_mc_insert]    Script Date: 22/12/2018 3:18:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_mc_insert]
   @TABLA       sysname,
   @PARAMETROS  sysname 
AS
  
SET NOCOUNT ON 

--DECLARE @TABLA		NVARCHAR(100) = 'Rol';
--DECLARE @PARAMETROS NVARCHAR(500)= 'johan@unal.edu.co, 123, 123, 1';
DECLARE @CAMPOS		NVARCHAR(500);
DECLARE @DATOS		NVARCHAR(500);
DECLARE @QUERY		NVARCHAR(500);
DECLARE @CANTIDAD_PARAMETROS	INT;
DECLARE @CANTIDAD_CAMPOS     	INT;
DECLARE @ret_code			    INT=0;

BEGIN
SELECT @CAMPOS = COALESCE(@CAMPOS + ', ', '') + COLUMN_NAME FROM  INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TABLA

SET @CANTIDAD_PARAMETROS =  (SELECT COUNT(VALUE) FROM STRING_SPLIT(@PARAMETROS, ','))
SET @CANTIDAD_CAMPOS =  (SELECT COUNT(VALUE) - 1 FROM STRING_SPLIT(@CAMPOS, ','))

IF @CAMPOS IS NULL
	BEGIN
	RAISERROR ('La tabla no existe', 16, 1);
	SELECT @ret_code;
	END

ELSE 
	IF @CANTIDAD_PARAMETROS = @CANTIDAD_CAMPOS
		BEGIN
		SET @DATOS = ( SELECT STUFF(
					(	SELECT
						CAST(', ' AS VARCHAR(MAX)) + 
						CASE 
						WHEN ISNUMERIC(value) = 1 THEN  value
						WHEN ISNUMERIC(value) = 1 THEN  value
						ELSE ''''+value+''''
						END
						FROM STRING_SPLIT(@PARAMETROS, ',')
						FOR XML PATH('')
					), 1, 1, '') as DATOS
				 )
		
		SET @QUERY = N'INSERT INTO '+@TABLA+' ( '+@CAMPOS +' ) VALUES ( NEWID(), '+@DATOS+' )';
		--SET @QUERY = N' SELECT '+@CAMPOS+' FROM '+@TABLA;
	

		BEGIN TRY  
			EXECUTE sp_executesql @QUERY;
			SET @ret_code=1 ;
			SELECT @ret_code;
		END TRY
		BEGIN CATCH  
		SELECT   
			ERROR_NUMBER() AS ErrorNumber,   
			ERROR_PROCEDURE() AS ErrorProcedure,  
			ERROR_MESSAGE() AS ErrorMessage;
		END CATCH;
		END
	ELSE
		BEGIN
		RAISERROR ('Los parametros de entrada no coinciden con los campos de la tabla a insertar ', 16, 1);
		SELECT @ret_code; 
		END
	  
END

