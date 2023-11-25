USE PROYECTO_HOSPITAL

--CREACION DE TABLA NUEVA
CREATE TABLE PERSONAS_NUEVAS (
[DNI] [varchar](13) NOT NULL,
	[p_nombre] [varchar](50) NULL,
	[s_nombre] [varchar](50) NULL,
	[p_apellido] [varchar](50) NULL,
	[s_apellido] [varchar](50) NULL,
	[telefono] [varchar](20) NULL,
	[id_colonia] [int] NULL,
	[direccion] [varchar](100) NULL,
	[genero] [char](1) NULL,
	[correo] [varchar](30) NULL,
	[fecha_nacimiento] [date] NULL,
 CONSTRAINT [PK_PERSONAS_NUEVAS] PRIMARY KEY CLUSTERED 
(
	[DNI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PERSONAS_NUEVAS] WITH CHECK ADD  CONSTRAINT [FK_COLONIASN] FOREIGN KEY([id_colonia])
REFERENCES [dbo].[Colonias] ([id_colonia])
GO

ALTER TABLE [dbo].[PERSONAS_NUEVAS] CHECK CONSTRAINT [FK_COLONIASN]
GO
--INSERSION DE DATOS ALA TABLA PERSONAS NUEVAS
--PERSONAS CON DATOS A ACTUALIZAR(TELEFONO,ID_COLONIA Y DIRECCION)
INSERT INTO PERSONAS_NUEVAS(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES ( '0101199700123','Jose', 'Roberto','Torres','Zabala','98521478',1, 'Avenida 5, casa 23','H', 'torresjose@gmail.com', '1997/12/04'),
( '0107198800554','Gerson', 'Dagoberto','Perez','Cayuela','99347865',2, 'Calle principal enfrente farmacia siman','H', 'gersoncayuela34@hootmail.com', '1988/03/11'),
( '0107199400098','Maria', '','Herrera','','99456789',3, 'Dos cuadras a la derecha de Pulperia Elizabeth','M', '', '1994/08/31')
--INFORMACION DE LAS  PERSONAS NUEVAS QUE SE VAN A INGRESAR A LA TABLA PERSONAS
INSERT INTO PERSONAS_NUEVAS(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES ( '0801198500152','Sandra', 'Patricia','Cantarero','OLIVA','95697841',4, 'Calle la rosa, Frente a farmacia Siman','M', 'SandraPatricia@hotmail.com', '1989/11/01'),
( '080119692356','Anderson', 'Alberto','Garcia','Chavez','33524715',2, 'bloque 2,calle principal','H', 'andersongarcia8@gmail.com', '1969/01/21')


--MERGE ENTRE TABLA PERSONAS Y PERSONAS NUEVAS
MERGE [dbo].[Personas] AS tgt
USING
(
	SELECT  PS.DNI,PS.p_nombre,PS.s_nombre,PS.p_apellido,PS.s_apellido,PS.telefono,PS.id_colonia,PS.direccion,
PS.genero,PS.correo,PS.fecha_nacimiento 
FROM
PERSONAS_NUEVAS AS PS
) AS src
ON
(
	src.DNI = tgt.DNI
)
-- ACTUALIZACION DE DATOS
WHEN MATCHED THEN
	UPDATE 
		SET
			tgt.telefono = src.telefono
			,tgt.id_colonia = src.id_colonia
			,tgt.direccion = src.direccion

-- INGRESO DE DATOS
WHEN NOT MATCHED THEN
	INSERT
	(
		DNI,p_nombre,s_nombre,p_apellido,s_apellido,telefono,id_colonia,direccion,
genero,correo,fecha_nacimiento 
	)
	VALUES
	(
		src.DNI,src.p_nombre,src.s_nombre,src.p_apellido,src.s_apellido,src.telefono,src.id_colonia,src.direccion,
src.genero,src.correo,src.fecha_nacimiento 
	);

	