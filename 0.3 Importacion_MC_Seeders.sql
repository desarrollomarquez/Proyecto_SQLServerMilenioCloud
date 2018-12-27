--EXECUTE master.sys.sp_MSforeachdb 'USE [?]; SELECT i.table_catalog, * FROM information_schema.tables i, sys.tables t where t.name = i.TABLE_NAME and t.TYPE="U" and t.name like "%Cuota%"' 

USE [MilenioCloud];
GO
BULK INSERT [dbo].[Poblado] FROM 'C:\Users\DFmarquezB\Documents\Proyecto_.Net\Modelo_MilenioCloud\poblados.csv'
   WITH (
      FIELDTERMINATOR = ';',
      ROWTERMINATOR = '\n'
);
GO


BULK
INSERT Poblado
FROM 'C:\Users\DFmarquezB\Documents\Proyecto_.Net\Modelo_MilenioCloud\poblados.csv'
WITH
(
-- seteamos el separador de campos
FIELDTERMINATOR = ';',
--seteamos el separador de registro
ROWTERMINATOR = '\n'
);
GO










SELECT * FROM Entidad -- 800123654
SELECT * FROM Usuario -- johan@unal.edu.co
SELECT * FROM Entidad_Usuario





DECLARE @TABLA_INTER NVARCHAR(100) = 'Entidad';
DECLARE @PARAMETROS NVARCHAR(500)= '800123654, LA CAYENA, 110, 255, 2018-04-25T15:50:59.997,2018-04-26T15:50:59.997, UNIQUEIDENTIFIER, UNIQUEIDENTIFIER'; 
DECLARE @CAMPOS		NVARCHAR(500);
DECLARE @DATOS		NVARCHAR(500);
DECLARE @QUERY		NVARCHAR(500);
DECLARE @CANTIDAD_PARAMETROS	INT;
DECLARE @CANTIDAD_CAMPOS     	INT;
DECLARE @ret_code			    INT=0;

						SELECT
						CASE 
						WHEN ISNUMERIC(value) = 1 THEN  value
						WHEN ISDATE(value) = 1 THEN 'CAST('+''''+value+''''+' AS DATETIME )' --'CAST('+''''+substring(TRIM(value),0,12)+''''+' AS DATETIME )'
						--WHEN value = 'UNIQUEIDENTIFIER'  THEN 'CAST(0x00 AS UNIQUEIDENTIFIER )'
						ELSE  ''''+value+''''
						END
						FROM STRING_SPLIT(@PARAMETROS, ',')


BEGIN

SELECT @CAMPOS = COALESCE(@CAMPOS + ', ', '') + COLUMN_NAME FROM  INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TABLA_INTER --11

SET @CANTIDAD_PARAMETROS =  (SELECT COUNT(VALUE) FROM STRING_SPLIT(@PARAMETROS, ','))
SET @CANTIDAD_CAMPOS =  (SELECT COUNT(VALUE) -3 FROM STRING_SPLIT(@CAMPOS, ','))

IF @CAMPOS IS NULL
	BEGIN
	RAISERROR ('La tabla no existe', 16, 1);
	--RETURN (1)
	END

ELSE 
	IF @CANTIDAD_PARAMETROS = @CANTIDAD_CAMPOS
		BEGIN
		SET @DATOS = ( SELECT STUFF(
					(	SELECT
						CAST(', ' AS VARCHAR(MAX)) + 
						CASE 
						WHEN ISNUMERIC(value) = 1 THEN  value
						WHEN ISDATE(value) = 1 THEN 'CAST('+''''+value+''''+' AS DATETIME )' --'CAST('+''''+substring(TRIM(value),0,12)+''''+' AS DATETIME )'
						WHEN value = '0x00' THEN 'CAST('+''''+value+''''+' AS UNIQUEIDENTIFIER )'
						ELSE  ''''+value+''''
						END
						FROM STRING_SPLIT(@PARAMETROS, ',')
						FOR XML PATH('')
					), 1, 1, '') as DATOS
				 )
		
		SET @QUERY = N'INSERT INTO '+@TABLA_INTER+' ( '+@CAMPOS +' ) VALUES ( NEWID(), '+@DATOS+', GETDATE(), NULL)';
		--SET @QUERY = N' SELECT '+@CAMPOS+' FROM '+@TABLA_INTER;
		SELECT @QUERY
		
		END
	ELSE
		BEGIN
		RAISERROR ('Los parametros de entrada no coinciden con los campos de la tabla a insertar ', 16, 1);
		--RETURN (1); 
		END

END



	


		BEGIN TRY  
			EXECUTE sp_executesql @QUERY;
			--RETURN (0);
		END TRY
		BEGIN CATCH  
		SELECT   
			ERROR_NUMBER() AS ErrorNumber,   
			ERROR_PROCEDURE() AS ErrorProcedure,  
			ERROR_MESSAGE() AS ErrorMessage;
		END CATCH;




		SELECT VALUE FROM STRING_SPLIT(@PARAMETROS, ',')

	DECLARE @value UNIQUEIDENTIFIER= 0x00
	SELECT CAST(@value AS UNIQUEIDENTIFIER)

	SELECT 
	CASE
	WHEN ISNULL(@value,0) = 0 THEN '1'
	ELSE '2' 
	END;

	





SELECT * FROM Entidad

select * from sys.messages
where text like '%table exists%'



--'Entidad', '800123654, LA CAYENA, 110, 255, 2018-04-25T15:50:59.997,2018-04-26T15:50:59.997'; 
--'Usuario','johan@unal.edu.co, 123, 123, 1';
--'Rol', 'Director Academico, 1, Encargado de Docentes';

--'Departamento', '16, PUERTO OSCURO';
--'Municipio', '16, 22222, ESCONDITE';
--'Poblado', '22222, 44,  A PESO, MC';
--'Telefono', '16, PUERTO OSCURO';


DECLARE @ret_code INT;
EXECUTE @ret_code = sp_mc_insert 'Entidad', '800123654, LA CAYENA, 110, 255, 2018-04-25T15:50:59.997,2018-04-26T15:50:59.997, 0x0, 0x0';
SELECT @ret_code;


SELECT * FROM Entidad
SELECT * FROM Usuario
SELECT * FROM Rol
SELECT * FROM Telefono
SELECT * FROM Departamento
SELECT * FROM Municipio WHERE Dane_Id=22222





DELETE FROM Entidad
WHERE Codigo_Id IN ('EA5F5C66-6E47-41D8-BE43-10761FDA599E',
'4D30A61D-3531-4750-AC7A-279141603053',
'608A2862-F3E8-4188-A191-43FE130928D4',
'EFE496C6-CBB1-44CC-9766-CFCD95905D2E',
'954FB448-3F98-4EBA-AAAE-E0453EA031B7');













--0	Successful execution.
--1	Required parameter value is not specified.
--2	Specified parameter value is not valid.
--3	Error has occurred getting sales value.
--4	NULL sales value found for the salesperson.








BEGIN

DECLARE @Iteration Integer = 0;
DECLARE @CAMPO   VARCHAR(300);
DECLARE @CANTIDAD VARCHAR(100);

SET @CANTIDAD = (SELECT COUNT(*)  FROM  INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Municipio' )

	WHILE @Iteration < @CANTIDAD  
	BEGIN  
		SET @CAMPO = (             SELECT 
									CASE
									WHEN COLUMN_NAME = 'Codigo_Id' THEN ''
									ELSE COLUMN_NAME
									END COLUMN_NAME
									FROM  INFORMATION_SCHEMA.COLUMNS
									WHERE TABLE_NAME = 'Municipio'
									FOR XML PATH ('')
									 )
	SET @Iteration += 1  
	END;
SELECT @CAMPO;
END 


SELECT 
@DATOS = COALESCE( 
(SELECT
CASE 
WHEN ISNUMERIC(value) = 1 THEN value
ELSE 'CAST( '+value+' AS VARCHAR(150))'
END 
FROM STRING_SPLIT(@PARAMETROS, ',')) + ', ', '' )  ;	






















--0	Successful execution.
--1	Required parameter value is not specified.
--2	Specified parameter value is not valid.
--3	Error has occurred getting sales value.
--4	NULL sales value found for the salesperson.








BEGIN

DECLARE @Iteration Integer = 0;
DECLARE @CAMPO   VARCHAR(300);
DECLARE @CANTIDAD VARCHAR(100);

SET @CANTIDAD = (SELECT COUNT(*)  FROM  INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Municipio' )

	WHILE @Iteration < @CANTIDAD  
	BEGIN  
		SET @CAMPO = (             SELECT 
									CASE
									WHEN COLUMN_NAME = 'Codigo_Id' THEN ''
									ELSE COLUMN_NAME
									END COLUMN_NAME
									FROM  INFORMATION_SCHEMA.COLUMNS
									WHERE TABLE_NAME = 'Municipio'
									FOR XML PATH ('')
									 )
	SET @Iteration += 1  
	END;
SELECT @CAMPO;
END 


SELECT 
@DATOS = COALESCE( 
(SELECT
CASE 
WHEN ISNUMERIC(value) = 1 THEN value
ELSE 'CAST( '+value+' AS VARCHAR(150))'
END 
FROM STRING_SPLIT(@PARAMETROS, ',')) + ', ', '' )  ;	