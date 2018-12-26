USE [MilenioCloud]
GO
/****** Object:  StoredProcedure [dbo].[sp_mc_insert_intercep]    Script Date: 23/12/2018 1:09:00 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_mc_insert_intercep]
   @TABLA_INTER       sysname,
   @PARAMETROS  sysname 
AS
  
SET NOCOUNT ON 

DECLARE @CAMPOS		NVARCHAR(500);
DECLARE @DATOS		NVARCHAR(500);
DECLARE @QUERY		NVARCHAR(500);
DECLARE @CANTIDAD_PARAMETROS	INT;
DECLARE @CANTIDAD_CAMPOS     	INT;
DECLARE @ret_code			    INT=0;

BEGIN
SELECT @CAMPOS = COALESCE(@CAMPOS + ', ', '') + COLUMN_NAME FROM  INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TABLA_INTER

SET @CANTIDAD_PARAMETROS =  (SELECT COUNT(VALUE) FROM STRING_SPLIT(@PARAMETROS, ','))
SET @CANTIDAD_CAMPOS =  (SELECT COUNT(VALUE) - 1 FROM STRING_SPLIT(@CAMPOS, ','))

IF @CAMPOS IS NULL
	BEGIN
	RAISERROR ('La tabla no existe', 16, 1);
	RETURN (1)
	END

ELSE 
	IF @CANTIDAD_PARAMETROS = @CANTIDAD_CAMPOS
		BEGIN
		SET @DATOS = ( SELECT STUFF(
					(	SELECT
						CAST(', ' AS VARCHAR(MAX)) + 
						CASE 
						WHEN ISNUMERIC(value) = 1 THEN  value
						WHEN ISDATE(value) = 1 THEN 'CAST('+''''+value+''''+' AS DATETIME )'
						ELSE ''''+value+''''
						END
						FROM STRING_SPLIT(@PARAMETROS, ',')
						FOR XML PATH('')
					), 1, 1, '') as DATOS
				 )
		
		SET @QUERY = N'INSERT INTO '+@TABLA_INTER+' ( '+@CAMPOS +' ) VALUES ( NEWID(), '+@DATOS+' )';
		BEGIN TRY  
			EXECUTE sp_executesql @QUERY;
			RETURN (0);
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
		RETURN (1); 
		END	  
END

