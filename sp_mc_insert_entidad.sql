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

	   BEGIN TRY  
			
			INSERT INTO [dbo].[Entidad]
					   ([Codigo_Id],[Nit],[Nombre],[CodigoEntidad],[CodigoDane],[FiniFiscal],[FfinFiscal],[Entidad_Padre],[Ubicacion_Id],[Created_At],[Updated_At])
				   VALUES
					   (NEWID(), @Nit, @Nombre, @CodigoEntidad, @CodigoDane, @FiniFiscal, @FfinFiscal, @Entidad_Padre, @Ubicacion_Id,GETDATE(), NULL);
		
			SELECT   
			'Inserto Correctamente' AS Result 
			FOR JSON PATH , WITHOUT_ARRAY_WRAPPER;

		END TRY
		BEGIN CATCH
			SELECT   
			ERROR_NUMBER() AS ErrorNumber,   
			ERROR_PROCEDURE() AS ErrorProcedure,  
			ERROR_MESSAGE() AS ErrorMessage
			FOR JSON PATH;
		END CATCH;

END

GO
