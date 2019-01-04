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




select * from sys.messages
where text like '%table exists%'



--'Entidad', '800123654, LA CAYENA, 110, 255, 2018-04-25T15:50:59.997,2018-04-26T15:50:59.997'; 
--'Usuario','johan@unal.edu.co, 123, 123, 1';
--'Rol', 'Director Academico, 1, Encargado de Docentes';

--'Departamento', '16, PUERTO OSCURO';
--'Municipio', '16, 22222, ESCONDITE';
--'Poblado', '22222, 44,  A PESO, MC';
--'Telefono', '16, PUERTO OSCURO';

ALTER TABLE dbo.Entidad  
ADD CONSTRAINT CHK_Entidad_Sede CHECK (dbo.ObtenerEntidad(Nit) = 1 );  
GO

ALTER TABLE dbo.Entidad   
DROP CONSTRAINT CHK_Entidad_Sede;  
GO


DELETE R
FROM dbo.Entidad R;

--DECLARE @ret_code INT;
EXECUTE sp_mc_insert_entidad 900555655, 'LA MOTA', 100, 100, '2018-04-25T15:50:59.997','2018-04-26T15:50:59.997', NULL, NULL;
--SELECT @ret_code;


                

SELECT * FROM Entidad
SELECT * FROM Usuario
SELECT * FROM Rol
SELECT * FROM Telefono
SELECT * FROM Departamento
SELECT * FROM Municipio WHERE Dane_Id=22222



--0	Successful execution.
--1	Required parameter value is not specified.
--2	Specified parameter value is not valid.
--3	Error has occurred getting sales value.
--4	NULL sales value found for the salesperson.

DECLARE @TABLA					NVARCHAR(500)= 'Persona';
DECLARE @CAMPOS					NVARCHAR(500)='NumeroIdentificacion, Sexo, Nacionalidad';
DECLARE @PARAMETROS				NVARCHAR(500);--='8355196';
DECLARE @QUERY					NVARCHAR(500);
DECLARE @NOMBRE					NVARCHAR(500);
DECLARE @STRING					NVARCHAR(500);

DECLARE @CANTIDAD_PARAMETROS	INT;
DECLARE @CANTIDAD_CAMPOS     	INT;
DECLARE @ret_code			    INT=0;

BEGIN

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
	SET @QUERY = N' SELECT TI.Nombre as TipoIdentificacion, P.NumeroIdentificacion, P.Nombres, P.Apellidos, P.Sexo, P.FNacimiento, P.Nacionalidad, P.LibretaMilitar, P.TipoSangre, P.Estado, E.Nit, E.Nombre FROM Persona P INNER JOIN Usuario U ON P.Codigo_Id = U.Persona_Id INNER JOIN Entidad_Usuario EU ON U.Codigo_Id = EU.Usuario_Id INNER JOIN Entidad E ON E.Codigo_Id = EU.Entidad_Id INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id';
	END

ELSE IF @PARAMETROS IS NULL OR @PARAMETROS =''
		BEGIN
		SET @QUERY = N' SELECT '+@STRING+' FROM Persona P INNER JOIN Usuario U ON P.Codigo_Id = U.Persona_Id INNER JOIN Entidad_Usuario EU ON U.Codigo_Id = EU.Usuario_Id INNER JOIN Entidad E ON E.Codigo_Id = EU.Entidad_Id INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id';
		END
	ELSE 
		BEGIN
		SET @QUERY = N' SELECT TI.Nombre as TipoIdentificacion, P.NumeroIdentificacion, P.Nombres, P.Apellidos, P.Sexo, P.FNacimiento, P.Nacionalidad, P.LibretaMilitar, P.TipoSangre, P.Estado, E.Nit, E.Nombre FROM Persona P INNER JOIN Usuario U ON P.Codigo_Id = U.Persona_Id INNER JOIN Entidad_Usuario EU ON U.Codigo_Id = EU.Usuario_Id INNER JOIN Entidad E ON E.Codigo_Id = EU.Entidad_Id INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id';
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


SELECT 
TI.Nombre as TipoIdentificacion, P.NumeroIdentificacion, P.Nombres, P.Apellidos, P.Sexo, P.FNacimiento, P.Nacionalidad, P.LibretaMilitar, P.TipoSangre, P.Estado,
E.Nit, E.Nombre
FROM Persona P
INNER JOIN Usuario U ON P.Codigo_Id = U.Persona_Id
INNER JOIN Entidad_Usuario EU ON U.Codigo_Id = EU.Usuario_Id
INNER JOIN Entidad E ON E.Codigo_Id = EU.Entidad_Id
INNER JOIN TipoIdentificacion TI ON P.TipoIdentificacion_Id = TI.Codigo_Id




SELECT * FROM TipoIdentificacion