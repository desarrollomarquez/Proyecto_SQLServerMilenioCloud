
IF object_id('dbo.Telefono') is not null
   DROP TABLE dbo.Telefono;
IF object_id('dbo.Imagen') is not null
   DROP TABLE dbo.Imagen;
IF object_id('dbo.Entidad_Usuario') is not null
   DROP TABLE dbo.Entidad_Usuario;
IF object_id('dbo.Usuario_Rol') is not null
   DROP TABLE dbo.Usuario_Rol;
IF object_id('dbo.Rol') is not null
   DROP TABLE dbo.Rol;
IF object_id('dbo.Articulo') is not null
   DROP TABLE dbo.Articulo;
IF object_id('dbo.Subcategoria') is not null
   DROP TABLE dbo.Subcategoria;
IF object_id('dbo.Categoria') is not null
   DROP TABLE dbo.Categoria;
IF object_id('dbo.Usuario') is not null
   DROP TABLE dbo.Usuario;
IF object_id('dbo.Persona') is not null
   DROP TABLE dbo.Persona;
IF object_id('dbo.TipoIdentificacion') is not null
   DROP TABLE dbo.TipoIdentificacion;
IF object_id('dbo.Licencia') is not null
   DROP TABLE dbo.Licencia;
IF object_id('dbo.Curso') is not null
   DROP TABLE dbo.Curso;
IF object_id('dbo.Aula') is not null
   DROP TABLE dbo.Aula;
IF object_id('dbo.Entidad') is not null
   DROP TABLE dbo.Entidad;
IF object_id('dbo.Ubicacion') is not null
   DROP TABLE dbo.Ubicacion;
IF object_id('dbo.Poblado') is not null
   DROP TABLE dbo.Poblado;
IF object_id('dbo.Municipio') is not null
   DROP TABLE dbo.Municipio;
IF object_id('dbo.Departamento') is not null
   DROP TABLE dbo.Departamento;

      
 CREATE TABLE dbo.Departamento (
  Codigo_Id	     UNIQUEIDENTIFIER NOT NULL,
  Dane_Id		 INT NOT NULL,
  Nombre    	 VARCHAR(300) NOT NULL,
  Created_At	 DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	 DATETIME,
  CONSTRAINT PK_Departamento primary key (Dane_Id)
);


 CREATE TABLE dbo.Municipio (
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Departamento_Id INT NOT NULL,
  Dane_Id		  INT NOT NULL,
  Nombre          VARCHAR(200) NOT NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Municipio primary key (Dane_Id),
  CONSTRAINT FK_MDepartamento FOREIGN KEY (Departamento_Id) REFERENCES Departamento (Dane_Id) ON DELETE CASCADE
);


CREATE TABLE dbo.Poblado (
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Municipio_Id    INT NOT NULL,
  Poblado_Id	  INT NOT NULL,
  Nombre          VARCHAR(200) NOT NULL,
  Tipo      	  VARCHAR(50) NOT NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Poblado primary key (Poblado_Id),
  CONSTRAINT FK_PMunicipio FOREIGN KEY (Municipio_Id) REFERENCES Municipio (Dane_Id) ON DELETE CASCADE
);


CREATE TABLE dbo.Ubicacion (
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Poblado_Id	  INT NOT NULL,
  Direccion       VARCHAR(200) NOT NULL,
  Latitud   	  VARCHAR(50),	
  Longitud  	  VARCHAR(50),
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Ubicacion primary key (Codigo_Id),
  CONSTRAINT FK_UPoblado FOREIGN KEY (Poblado_Id) REFERENCES Poblado (Poblado_Id) ON DELETE CASCADE
);

 
 CREATE TABLE dbo.Entidad(
  Codigo_Id		 UNIQUEIDENTIFIER NOT NULL ,
  Nit			 INT  NOT NULL,
  Nombre		 VARCHAR(200) NOT NULL,
  CodigoEntidad  INT NOT NULL,
  CodigoDane  	 INT NOT NULL,
  FiniFiscal     DATETIME NOT NULL,
  FfinFiscal     DATETIME NOT NULL,
  Entidad_Padre  UNIQUEIDENTIFIER NULL,
  Ubicacion_Id   UNIQUEIDENTIFIER NULL,
  Created_At	 DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	 DATETIME,
  CONSTRAINT PK_Entidad primary key (Codigo_Id),
  CONSTRAINT FK_EEntidad_Padre FOREIGN KEY (Entidad_Padre) REFERENCES Entidad (Codigo_Id),
  CONSTRAINT FK_EUbicacion FOREIGN KEY (Ubicacion_Id) REFERENCES Ubicacion (Codigo_Id) ON DELETE CASCADE
 );

  CREATE TABLE dbo.Aula (
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  CodigoAula	  INT NOT NULL,
  Nombre    	  VARCHAR(300) NOT NULL,
  Sede_Id		  UNIQUEIDENTIFIER NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Aula primary key (Codigo_Id),
  CONSTRAINT FK_AEntidad FOREIGN KEY (Sede_Id) REFERENCES Entidad (Codigo_Id) ON DELETE CASCADE
);

  CREATE TABLE dbo.Curso (
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Nivel			  INT NOT NULL,
  Nombre    	  VARCHAR(300) NOT NULL,
  Aula_Id		  UNIQUEIDENTIFIER NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Curso primary key (Codigo_Id),
  CONSTRAINT FK_CAula FOREIGN KEY (Aula_Id) REFERENCES Aula (Codigo_Id) ON DELETE CASCADE
);

  CREATE TABLE dbo.Licencia(
  Codigo_Id			UNIQUEIDENTIFIER NOT NULL ,
  Entidad_Id		UNIQUEIDENTIFIER,
  NumeroLicencia	INT NOT NULL,
  FiniVigencia      DATETIME NOT NULL,
  FfinVigencia      DATETIME NOT NULL,
  Estado			BIT,
  CostoLicencia		VARCHAR(20) NOT NULL,
  Created_At	    DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	    DATETIME,
  CONSTRAINT PK_Licencia primary key (Codigo_Id),
  CONSTRAINT FK_LEntidad FOREIGN KEY (Entidad_Id) REFERENCES Entidad (Codigo_Id) ON DELETE CASCADE
 );


  CREATE TABLE dbo.TipoIdentificacion(
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Nombre		  VARCHAR(200)  NOT NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_TipoIdentificacion primary key (Codigo_Id)
 );

  CREATE TABLE dbo.Persona(
  Codigo_Id				UNIQUEIDENTIFIER NOT NULL,
  NumeroIdentificacion	INT NOT NULL,
  Nombres				VARCHAR(300)  NOT NULL,
  Apellidos				VARCHAR(300)  NOT NULL,
  Sexo				    VARCHAR(20)  NOT NULL,
  FNacimiento		    DATETIME NOT NULL,
  Nacionalidad			VARCHAR(300)  NOT NULL,
  LibretaMilitar		VARCHAR(300)  NOT NULL,
  TipoSangre			VARCHAR(100)  NOT NULL,
  Estado				BIT,
  Ubicacion_Id			UNIQUEIDENTIFIER NULL,
  TipoIdentificacion_Id	UNIQUEIDENTIFIER NOT NULL,
  Created_At			DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At			DATETIME,
  CONSTRAINT AK_Persona UNIQUE(NumeroIdentificacion),
  CONSTRAINT PK_Persona primary key (Codigo_Id),
  CONSTRAINT FK_PUbicacion FOREIGN KEY (Ubicacion_Id) REFERENCES Ubicacion (Codigo_Id) ON DELETE CASCADE,
  CONSTRAINT FK_PTipoIdentificacion FOREIGN KEY (TipoIdentificacion_Id) REFERENCES TipoIdentificacion (Codigo_Id) ON DELETE CASCADE
 );

  CREATE TABLE dbo.Usuario(
  Codigo_Id		  UNIQUEIDENTIFIER NOT NULL,
  Email		      VARCHAR(100) NOT NULL,
  Password		  VARCHAR(100)  NOT NULL,
  PasswordDecrip  VARCHAR(100) NOT NULL,
  Estado          BIT,
  Persona_Id      UNIQUEIDENTIFIER NOT NULL ,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT AK_Email UNIQUE(Email),
  CONSTRAINT PK_Usuario primary key (Codigo_Id),
  CONSTRAINT FK_UPersona FOREIGN KEY (Persona_Id) REFERENCES Persona (Codigo_Id) ON DELETE CASCADE
 );


  CREATE TABLE dbo.Categoria(
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Referencia	  INT NOT NULL,
  Nombre		  VARCHAR(200)  NOT NULL,
  Estado          BIT,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Categoria primary key (Codigo_Id)
 );


 CREATE TABLE dbo.Subcategoria(
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Referencia	  INT NOT NULL,
  Nombre		  VARCHAR(200)  NOT NULL,
  Descripcion     TEXT          NOT NULL,
  Estado          BIT,
  Categoria_Id    UNIQUEIDENTIFIER NOT NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Subcategoria primary key (Codigo_Id),
  CONSTRAINT FK_CSubcategoria FOREIGN KEY (Categoria_Id) REFERENCES Categoria (Codigo_Id) ON DELETE CASCADE,
 );


 CREATE TABLE dbo.Articulo(
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Nombre		  VARCHAR(300)  NOT NULL,
  Referencia	  VARCHAR(200)  NOT NULL,
  Descripcion     TEXT          NOT NULL,
  Marca			  VARCHAR(200)  NOT NULL,
  ValorUnitario	  INT NOT NULL,
  PrecioIn		  INT NOT NULL,
  PrecioOut	      INT NOT NULL,
  Estado          BIT,
  Subcategoria_Id UNIQUEIDENTIFIER NOT NULL,
  Usuario_Id      UNIQUEIDENTIFIER NOT NULL ,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Articulo primary key (Codigo_Id),
  CONSTRAINT FK_USubcategoria FOREIGN KEY (Subcategoria_Id) REFERENCES Subcategoria (Codigo_Id) ON DELETE CASCADE,
  CONSTRAINT FK_AUsuario FOREIGN KEY (Usuario_Id) REFERENCES Usuario (Codigo_Id) ON DELETE CASCADE
 );

   
  CREATE TABLE dbo.Rol(
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Nombre		  VARCHAR(200)  NOT NULL,
  Estado          BIT,
  Descripcion     TEXT          NOT NULL,
  Created_At	  DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	  DATETIME,
  CONSTRAINT PK_Rol primary key (Codigo_Id)
 );

 
  CREATE TABLE dbo.Usuario_Rol(
  Usuario_Id		UNIQUEIDENTIFIER NOT NULL,
  Rol_Id			UNIQUEIDENTIFIER NOT NULL,
  fecha_caducidad	DATETIME  NOT NULL,
  Estado            BIT,
  Descripcion       TEXT          NOT NULL,
  Created_At	    DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	    DATETIME,
  CONSTRAINT PK_usuario_rol primary key (Usuario_Id, Rol_Id),
  CONSTRAINT FK_usuario FOREIGN KEY (Usuario_Id) REFERENCES Usuario (Codigo_Id) ON DELETE CASCADE,
  CONSTRAINT FK_rol FOREIGN KEY (Rol_Id) REFERENCES Rol (Codigo_Id) ON DELETE CASCADE
 );

 
  CREATE TABLE dbo.Entidad_Usuario(
  Entidad_Id        UNIQUEIDENTIFIER NOT NULL,
  Usuario_Id		UNIQUEIDENTIFIER NOT NULL,
  fecha_caducidad	DATETIME  NOT NULL,
  Estado			BIT,
  Descripcion		TEXT          NOT NULL,
  Created_At	  	DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	    DATETIME,
  CONSTRAINT PK_entidad_usuario primary key (Entidad_Id, Usuario_Id),
  CONSTRAINT FK_uentidad FOREIGN KEY (Entidad_Id) REFERENCES Entidad (Codigo_Id),
  CONSTRAINT FK_cusuario FOREIGN KEY (Usuario_Id) REFERENCES Usuario (Codigo_Id) ON DELETE CASCADE
 );

  CREATE TABLE dbo.Imagen(
  Codigo_Id		 UNIQUEIDENTIFIER NOT NULL ,
  Fuente_Id	     UNIQUEIDENTIFIER NOT NULL ,
  RutaImagen	 VARCHAR(20) NOT NULL,
  Created_At	 DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	 DATETIME,
  CONSTRAINT PK_Imagen primary key (Codigo_Id),
  CONSTRAINT FK_IArticulo FOREIGN KEY (Fuente_Id) REFERENCES Articulo (Codigo_Id),
  CONSTRAINT FK_IPersona FOREIGN KEY (Fuente_Id) REFERENCES Persona (Codigo_Id) ON DELETE CASCADE
 );

  CREATE TABLE dbo.Telefono(
  Codigo_Id		 UNIQUEIDENTIFIER NOT NULL ,
  Contacto_Id    UNIQUEIDENTIFIER NOT NULL ,
  Numero		 INT NOT NULL,
  Tipo			 VARCHAR(20) NOT NULL,
  Created_At	 DATETIME NOT NULL DEFAULT (GETDATE()),
  Updated_At	 DATETIME,
  CONSTRAINT PK_Telefono primary key (Codigo_Id),
  CONSTRAINT FK_TEntidad FOREIGN KEY (Contacto_Id) REFERENCES Entidad (Codigo_Id),
  CONSTRAINT FK_TPersona FOREIGN KEY (Contacto_Id) REFERENCES Persona (Codigo_Id) ON DELETE CASCADE
 );