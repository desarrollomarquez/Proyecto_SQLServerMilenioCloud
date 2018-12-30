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
EXECUTE sp_mc_insert_entidad 800123655, 'LA CAYENA', 110, 255, '2018-04-25T15:50:59.997','2018-04-26T15:50:59.997', NULL, NULL;
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



DECLARE @Nit			INT= 800123655,
	    @Nombre			VARCHAR(200) = 'LA LLANURA - SUR',
	    @CodigoEntidad  INT= 110,
	    @CodigoDane	    INT= 255,
        @FiniFiscal	    DATETIME = '2018-04-25T15:50:59.997',
	    @FfinFiscal	    DATETIME = '2018-04-26T15:50:59.997',
        @Entidad_Padre  UNIQUEIDENTIFIER = 'B9237A48-6303-49A5-A4E0-4E43FB6FCB32',
	    @Ubicacion_Id   UNIQUEIDENTIFIER = NULL,
		@SEDE		    INT


BEGIN

SET NOCOUNT ON 


			IF (SELECT E.Nit FROM dbo.Entidad E WHERE E.Nit = @Nit AND E.Entidad_Padre IS NULL) IS NULL 
					BEGIN TRY 
							INSERT INTO [dbo].[Entidad]
							([Codigo_Id],[Nit],[Nombre],[CodigoEntidad],[CodigoDane],[FiniFiscal],[FfinFiscal],[Entidad_Padre],[Ubicacion_Id],[Created_At],[Updated_At])
							VALUES
							(NEWID(), @Nit, @Nombre, @CodigoEntidad, @CodigoDane, @FiniFiscal, @FfinFiscal, NULL, @Ubicacion_Id,GETDATE(), NULL)
							BEGIN
								SELECT  'Se Registro Correctamente la entidad: '+@Nombre AS Msg  FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;
							END
					END TRY
					BEGIN CATCH
						SELECT   
						ERROR_NUMBER() AS ErrorNumber,   
						ERROR_PROCEDURE() AS ErrorProcedure,  
						ERROR_MESSAGE() AS ErrorMessage
						FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
					END CATCH;
			
			ELSE IF ((SELECT E.Entidad_Padre FROM dbo.Entidad E WHERE E.Nit = @Nit AND E.Entidad_Padre IS NULL ) IS NULL AND @Entidad_Padre IS NOT NULL AND
						(SELECT E.Codigo_Id FROM dbo.Entidad E WHERE E.Nit = @Nit AND E.Entidad_Padre IS NULL)=@Entidad_Padre)
					BEGIN TRY 
							INSERT INTO [dbo].[Entidad]
						   ([Codigo_Id],[Nit],[Nombre],[CodigoEntidad],[CodigoDane],[FiniFiscal],[FfinFiscal],[Entidad_Padre],[Ubicacion_Id],[Created_At],[Updated_At])
							VALUES
						   (NEWID(), @Nit, @Nombre, @CodigoEntidad, @CodigoDane, @FiniFiscal, @FfinFiscal, @Entidad_Padre, @Ubicacion_Id,GETDATE(), NULL)
							BEGIN
								SELECT  'Se Registro Correctamente la sede: '+@Nombre AS Msg  FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;
							END
					END TRY
					BEGIN CATCH
						SELECT   
						ERROR_NUMBER() AS ErrorNumber,   
						ERROR_PROCEDURE() AS ErrorProcedure,  
						ERROR_MESSAGE() AS ErrorMessage
						FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
					END CATCH;
			ELSE	
					BEGIN
								SELECT  'Verificar los parametros ingresados para la sede de la entidad: '+@Nombre AS Msg  FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;
					END
		
END

