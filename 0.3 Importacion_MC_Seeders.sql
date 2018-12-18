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