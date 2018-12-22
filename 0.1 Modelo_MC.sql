
IF object_id('dbo.Entidad_Usuario') is not null
   DROP TABLE dbo.Entidad_Usuario;
IF object_id('dbo.Usuario_Rol') is not null
   DROP TABLE dbo.Usuario_Rol;
IF object_id('dbo.Entidad') is not null
   DROP TABLE dbo.Entidad;
IF object_id('dbo.Usuario') is not null
   DROP TABLE dbo.Usuario;
IF object_id('dbo.Rol') is not null
   DROP TABLE dbo.Rol;
IF object_id('dbo.Poblado') is not null
   DROP TABLE dbo.Poblado;
IF object_id('dbo.Municipio') is not null
   DROP TABLE dbo.Municipio;
IF object_id('dbo.Departamento') is not null
   DROP TABLE dbo.Departamento;

  
  
    
 CREATE TABLE dbo.Entidad(
  Codigo_Id		 UNIQUEIDENTIFIER NOT NULL ,
  Nit			 INT  NOT NULL,
  Nombre		 VARCHAR(200) NOT NULL,
  CodigoEntidad  INT NOT NULL,
  CodigoDane  	 INT NOT NULL,
  Direccion      VARCHAR(100) NOT NULL,
  Telefono       VARCHAR(20) NOT NULL,
  FiniFiscal     DATETIME NOT NULL,
  FfinFiscal     DATETIME NOT NULL,
  UbicacionGeo   VARCHAR(100) NOT NULL,
  Foto           VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Entidad primary key (Codigo_Id)
 );

  CREATE TABLE dbo.Usuario(
  Codigo_Id		  UNIQUEIDENTIFIER NOT NULL,
  Email		      VARCHAR(100) NOT NULL,
  Password		  VARCHAR(100)  NOT NULL,
  PasswordDecrip  VARCHAR(100) NOT NULL,
  Estado          INT NOT NULL,
  CONSTRAINT PK_Usuario primary key (Codigo_Id)
 );

   
  CREATE TABLE dbo.Rol(
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Nombre		  VARCHAR(200)  NOT NULL,
  Estado          BIT,
  Descripcion     VARCHAR(200)  NOT NULL,
  CONSTRAINT PK_Rol primary key (Codigo_Id)
 );

 CREATE TABLE dbo.Departamento (
  Codigo_Id	     UNIQUEIDENTIFIER NOT NULL,
  Dane_Id		 VARCHAR(50) NOT NULL,
  Nombre    	 VARCHAR(300) NOT NULL,
  Latitud   	 VARCHAR(50),	
  Longitud  	 VARCHAR(50),
  CONSTRAINT PK_Departamento primary key (Dane_Id)
);


 CREATE TABLE dbo.Municipio (
  Codigo_Id	      UNIQUEIDENTIFIER NOT NULL,
  Departamento_Id VARCHAR(50) NOT NULL,
  Dane_Id		  VARCHAR(50) NOT NULL,
  Nombre          VARCHAR(200) NOT NULL,
  Latitud   	  VARCHAR(50),	
  Longitud  	  VARCHAR(50),
  CONSTRAINT PK_Municipio primary key (Dane_Id),
  CONSTRAINT FK_MDepartamento FOREIGN KEY (Departamento_Id) REFERENCES Departamento (Dane_Id) ON DELETE CASCADE
);


CREATE TABLE dbo.Poblado (
  Codigo_Id	      UNIQUEIDENTIFIER DEFAULT NEWID(),
  Municipio_Id    VARCHAR(50) NOT NULL,
  Poblado_Id	  VARCHAR(50) NOT NULL,
  Nombre          VARCHAR(200) NOT NULL,
  Tipo      	  VARCHAR(50) NOT NULL,
  Latitud   	  VARCHAR(50),	
  Longitud  	  VARCHAR(50),
  CONSTRAINT PK_Poblado primary key (Poblado_Id),
  CONSTRAINT FK_PMunicipio FOREIGN KEY (Municipio_Id) REFERENCES Municipio (Dane_Id) ON DELETE CASCADE
);

  CREATE TABLE dbo.Usuario_Rol(
  Usuario_Id		UNIQUEIDENTIFIER NOT NULL,
  Rol_Id			UNIQUEIDENTIFIER NOT NULL,
  fecha_caducidad	DATETIME  NOT NULL,
  Estado            BIT,
  Descripcion       VARCHAR(200)  NOT NULL,
  CONSTRAINT PK_usuario_rol primary key (Usuario_Id, Rol_Id),
  CONSTRAINT FK_usuario FOREIGN KEY (Usuario_Id) REFERENCES Usuario (Codigo_Id) ON DELETE CASCADE,
  CONSTRAINT FK_rol FOREIGN KEY (Rol_Id) REFERENCES Rol (Codigo_Id) ON DELETE CASCADE
 );

 
  CREATE TABLE dbo.Entidad_Usuario(
  Entidad_Id		UNIQUEIDENTIFIER NOT NULL,
  Usuario_Id		UNIQUEIDENTIFIER NOT NULL,
  fecha_caducidad	DATETIME  NOT NULL,
  Estado			BIT,
  Descripcion		VARCHAR(200)  NOT NULL,
  CONSTRAINT PK_entidad_usuario primary key (Entidad_Id, Usuario_Id),
  CONSTRAINT FK_uentidad FOREIGN KEY (Entidad_Id) REFERENCES Entidad (Codigo_Id) ON DELETE CASCADE,
  CONSTRAINT FK_cusuario FOREIGN KEY (Usuario_Id) REFERENCES Usuario (Codigo_Id) ON DELETE CASCADE
 );



