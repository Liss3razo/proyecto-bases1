USE [PROYECTO_HOSPITAL]

--===============PROCEDIMIENTOS ALMACENADOS======================

-- =====================PA1========================
-- Author:		Los Data Warrios
-- Create date: 11/08/2023
-- Description: Obtener el tipo de sangre por el DNI de Paciente
-- ================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TIPO_SANGRE_PACIENTE]
  @dni VARCHAR(13)

AS
BEGIN
 
    SELECT  PA.DNI, PA.tipo_sangre, PE.genero ,PE.p_nombre, PE.p_apellido
    FROM [dbo].[Personas] PE
	INNER JOIN Pacientes PA ON PE.DNI=PA.DNI
	WHERE PA.DNI = @dni

END
GO

--SELECT *FROM Pacientes
--SELECT *FROM[dbo].[Personas]

---Lamado-----
EXECUTE [dbo].[TIPO_SANGRE_PACIENTE] '0107199400098';


-- =====================PA2========================
-- Author:		Los Data Warrios
-- Create date: 12/08/2023
-- Description: Agregar citas
-- ================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AGREGAR_CITA]
   @id_paciente VARCHAR(10)
 , @id_Sala int
 , @id_preclinica int
 , @id_diagnostico int
 , @mayor_edad bit
 , @id_procedimiento int
 , @id_fecha_inicio date
 , @fecha_fin date

AS
BEGIN

    INSERT INTO[dbo].[Citas] (
	id_paciente 
 , id_Sala 
 , id_preclinica 
 , id_diagnostico
 , mayor_edad 
 , id_procedimiento 
 , id_fecha_inicio
 , fecha_fin 
	)

	VALUES (
	@id_paciente 
 , @id_Sala 
 , @id_preclinica 
 , @id_diagnostico
 , @mayor_edad 
 , @id_procedimiento 
 , @id_fecha_inicio
 , @fecha_fin 
	);

    SELECT 'Cita creada exitosamente' AS mensaje;
END;
GO

--SELECT *FROM [dbo].[Citas]
--DELETE FROM [dbo].[Citas] 
--WHERE  Citas.id_cita=15;
--SELECT*FROM [dbo].[Procedimientos]

---Lamado-----
EXECUTE [dbo].[AGREGAR_CITA]
	@id_paciente='PA1'
 , @id_Sala =2
 , @id_preclinica =4
 , @id_diagnostico=2
 , @mayor_edad =1
 , @id_procedimiento =2
 , @id_fecha_inicio ='2023/07/07'
 , @fecha_fin ='2023/07/08'
	;




-- =====================PA3====================================================================================
-- Author:		Los Data Warrios
-- Create date: 12/08/2023
-- Description: Agregar un Paciente
-- ============================================================================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGREGAR_PACIENTE]
    @dni VARCHAR(13),
	@p_nombre  VARCHAR(50), 
	@s_nombre VARCHAR(50), 
	@p_apellido VARCHAR(50),
	@s_apellido VARCHAR(50),
	@telefono VARCHAR(20), 
	@id_colonia INT, 
	@direccion_Exacta VARCHAR(100), 
	@genero CHAR(1), 
	@correo VARCHAR(30), 
	@fecha_nacimiento DATE,
    @id_paciente VARCHAR(10),
	@tipo_sangre VARCHAR(50),
	@paciente_interno BIT

AS
BEGIN
 
    INSERT INTO[dbo].[Personas](DNI, p_nombre , s_nombre , p_apellido, s_apellido 
	, telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)

	VALUES (@dni, @p_nombre, @s_nombre,@p_apellido, @s_apellido, @telefono, @id_colonia,@direccion_Exacta,@genero,@correo, @fecha_nacimiento);

    INSERT INTO[dbo].[Pacientes] (id_paciente,DNI,tipo_sangre ,paciente_interno)

	VALUES (@id_paciente,@dni,@tipo_sangre,@paciente_interno);

    SELECT 'Paciente Agregado exitosamente' AS mensaje;
END;
GO


--SELECT *FROM[dbo].[Pacientes]
--DELETE FROM [dbo].[Citas] 
--WHERE  Citas.id_cita=11 ;
--SELECT*FROM [dbo].[Procedimientos]

---Lamado-----
EXECUTE [dbo].[AGREGAR_PACIENTE]    
    @dni= '0814200088665',
	@p_nombre= 'Ana' , 
	@s_nombre= 'Maria', 
	@p_apellido='Hernandez' ,
	@s_apellido='Chavez' ,
	@telefono= '98882233', 
	@id_colonia='1' , 
	@direccion_Exacta= 'hato de enmedio', 
	@genero= 'F' , 
	@correo= 'ana@gmai.com', 
	@fecha_nacimiento= '2000/09/08',
    @id_paciente='PA7' ,
	@tipo_sangre='A+',
	@paciente_interno= 0;


-- =====================PA4========================
-- Author:		Los Data Warrios
-- Create date: 11/08/2023
-- Description: HISTORIAL 
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Agregar_Historial]

    @id_paciente varchar(10),
	@id_padecimiento int, 
	@fechainicioP date, 
	@id_recetas int,
	@observaciones VARCHAR(100), 
	@id_enfBaseA INT, 
	@fechaInicioE date, 
	@gradoAvance varchar(20), 
	@descripcion VARCHAR(100)
	

AS
BEGIN
     DECLARE @id_historial int
	 

    INSERT INTO [dbo].[Historial_Clinico](id_paciente)

	VALUES (@id_paciente);
	SET @id_historial=SCOPE_IDENTITY()

    INSERT INTO[dbo].[Padecimientos_Pacientes](id_padecimiento, id_historial_clinico, fecha_inicio)
	VALUES (@id_padecimiento, @id_historial, @fechainicioP);

	INSERT INTO [dbo].[EnfermedadesBA_Historial](id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
	VALUES (@id_enfBaseA, @id_historial, @fechaInicioE, @gradoAvance, @descripcion);

	INSERT INTO [dbo].[recetasHistorial](id_historial_clinico, id_recetas, observaciones )
	 VALUES (@id_historial, @id_recetas, @observaciones);

    SELECT 'Historial' AS mensaje;
END;
GO


--------Llamado----------
EXECUTE [dbo].[Agregar_Historial]
    @id_paciente='PA1',
	@id_padecimiento=4, 
	@fechainicioP ='2023/07/10', 
	@id_recetas= 1,
	@observaciones='suspendidas', 
	@id_enfBaseA= 5, 
	@fechaInicioE='2020/09/08', 
	@gradoAvance='Alto', 
	@descripcion='n se'




-- =====================PA6==========================================================
-- Author:		Los Data Warrios
-- Create date: 12/08/2023
-- Description: Obtener el tipo de Empleado por el dni
-- =======================================================================================
--NO VA

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TipoEmpleado]
  @dni VARCHAR(50)

AS
BEGIN
 
    SELECT  E.id_empleado, TE.descripcion, (PE.p_nombre+' '+PE.s_nombre+' '+PE.p_apellido+' '+PE.s_apellido) As Nombre_Empleado
    FROM  [dbo].[Personas] PE
	INNER JOIN Empleados E ON E.DNI=PE.DNI
	INNER JOIN Tipo_Empleado TE ON E.id_tipo_empleado=TE.id_tipo_empleado
	WHERE E.DNI = @dni

END
GO

--SELECT *FROM [dbo].[Personas]
--SELECT *FROM [dbo].[Empleados]
--SELECT *FROM[dbo].[Tipo_Empleado]

---Lamado-----
EXECUTE [dbo].[TipoEmpleado] '0545199200345';




-- =============================================
-- Author:		Los Data Warrios
-- Create date: 12/08/2023
-- Description: Actualizar citas
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE ActualizarCita
 
    @id_cita int,
	@id_paciente varchar(10),
	@id_Sala int, 
	@id_preclinica int, 
	@id_diagnostico int, 
	@mayor_edad bit, 
	@id_procedimiento int, 
	@fecha_inicio date, 
	@fecha_fin date

AS
BEGIN
    UPDATE Citas
    SET 
	id_Sala=@id_Sala, 
	id_paciente=@id_paciente,
	id_preclinica=@id_preclinica, 
	id_diagnostico=@id_diagnostico, 
	mayor_edad=@mayor_edad, 
	id_procedimiento=@id_procedimiento, 
	fecha_inicio=@fecha_inicio, 
	fecha_fin=@fecha_fin
    WHERE id_cita= @id_cita;
END;

EXECUTE ActualizarCita
    @id_cita=6,
	@id_paciente='PA2',
	@id_Sala=5, 
	@id_preclinica=4, 
	@id_diagnostico=3, 
	@mayor_edad =1, 
	@id_procedimiento =4, 
	@fecha_inicio ='2023-04-09', 
	@fecha_fin ='1900-01-01'


-- =============================================
-- Author:		Los Data Warrios
-- Create date: 12/08/2023
-- Description: Eliminar citas
-- =============================================

CREATE PROCEDURE EliminarCitas
    @id_cita int
AS
BEGIN
    DELETE FROM Citas WHERE
      id_cita = @id_cita;

END;

EXECUTE EliminarCitas
     @id_cita=2