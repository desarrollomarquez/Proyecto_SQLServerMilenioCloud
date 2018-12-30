USE [MilenioCloud]
GO
/****** Object:  StoredProcedure [dbo].[sp_mc_insert_entidad]    Script Date: 29/12/2018 12:09:23 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_mc_insert_entidad]
      @Nit INT,
	  @Nombre VARCHAR(200),
	  @CodigoEntidad INT,
	  @CodigoDane	 INT,
      @FiniFiscal	 DATETIME,
	  @FfinFiscal	 DATETIME,
      @Entidad_Padre UNIQUEIDENTIFIER,
	  @Ubicacion_Id  UNIQUEIDENTIFIER
AS
 
BEGIN

SET NOCOUNT ON 

			IF (SELECT E.Nit FROM dbo.Entidad E WHERE E.Nit = @Nit AND E.Entidad_Padre IS NULL) IS NULL 
					BEGIN TRY 
							INSERT INTO [dbo].[Entidad]
							([Codigo_Id],[Nit],[Nombre],[CodigoEntidad],[CodigoDane],[FiniFiscal],[FfinFiscal],[Entidad_Padre],[Ubicacion_Id])
							VALUES
							(NEWID(), @Nit, @Nombre, @CodigoEntidad, @CodigoDane, @FiniFiscal, @FfinFiscal, NULL, @Ubicacion_Id)
							BEGIN
								SELECT  'Se Registro Correctamente la Entidad: '+@Nombre AS Msg  FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;
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
						   ([Codigo_Id],[Nit],[Nombre],[CodigoEntidad],[CodigoDane],[FiniFiscal],[FfinFiscal],[Entidad_Padre],[Ubicacion_Id])
							VALUES
						   (NEWID(), @Nit, @Nombre, @CodigoEntidad, @CodigoDane, @FiniFiscal, @FfinFiscal, @Entidad_Padre, @Ubicacion_Id)
							BEGIN
								SELECT  'Se Registro Correctamente la Sede: '+@Nombre AS Msg  FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;
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
								SELECT  'Verificar los Parametros Ingresados para la Entidad : '+@Nombre AS Msg  FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;
					END
		
END
GO
