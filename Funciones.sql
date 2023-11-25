USE PROYECTO_HOSPITAL

--=====================FUNCIONES===========================

-- =================F1============================
-- Author:		Los Data Warrios
-- Create date: 2023/08/14
-- Description:	Tabla Facturas Aplicar descuentos segun la edad del Persona
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CalcularFacturaConDescuento] (
    @id_factura INT,
    @id_descuento INT
	)

RETURNS money	

AS
BEGIN

    DECLARE @total_sin_descuento INT;
    DECLARE @nuevo_total INT;
  
    SELECT @total_sin_descuento = total 
    FROM Facturas FA
    WHERE FA.id_factura =  @id_factura
  
  IF @total_sin_descuento  IS NOT NULL  
    BEGIN
	   IF @id_descuento=1
	        SET @nuevo_total= @total_sin_descuento-(@total_sin_descuento*0.30) ;
		
		
	   ELSE
            SET @nuevo_total= @total_sin_descuento;

	 END

  ELSE
        SET @nuevo_total= 0 ;

 RETURN @nuevo_total
	
   
END
GO


--SELECT*FROM [dbo].[Personas]
--SELECT*FROM [dbo].[Facturas]
--SELECT*FROM Descuentos
--SELECT*FROM [dbo].[Empleados]

-----Llamado--------
DECLARE @RESULTADO money;
SET @RESULTADO = [dbo].[CalcularFacturaConDescuento] (3,1);
SELECT @RESULTADO as Nuevo_Resultado;



---------------------------------------------------------------------------------------------------------------------------------
-- =================F2============================
-- Author:		Los Data Warrios
-- Create date: 2023/08/14
-- Description:	Calcular el sueldo de un medico (Tabla Empleado)
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CalcularSalarioMedico] (
   @id_medico VARCHAR(10)
)
RETURNS MONEY	
AS
BEGIN
    DECLARE @SumaTotalSalario DECIMAL;

    SELECT @SumaTotalSalario = ISNULL(SUM(salario), 0) + ISNULL(SUM(costo), 0)
    FROM Medicos M
    INNER JOIN Empleados EM ON EM.id_empleado = M.id_empleado
    INNER JOIN MedicoEspecialidades ME ON ME.id_medico = M.id_medico
    
   
WHERE M.id_medico = @id_medico;

    RETURN @SumaTotalSalario;
END
GO

--SELECT*FROM[dbo].[Medicos]
--SELECT*FROM [dbo].[MedicoEspecialidades]
--SELECT*FROM [dbo].[Empleados]




-----Llamado--------
DECLARE @id_medico_param VARCHAR(10) = 'M3';
DECLARE @resultado MONEY;
SET @resultado = [dbo].[CalcularSalarioMedico](@id_medico_param);
SELECT @resultado AS Resultado;


-------------------------------------------------------------------------------------------------------------------------------------
-- =================F3============================
-- Author:		Los Data Warrios
-- Create date: 2023/08/14
-- Description:	MOSTRAR SI LA HABITACION DE LA SALA ESTA DISPONIBLE
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION[dbo].[Habitaciones_Disponibles](
    @id_sala INT
	)

RETURNS INT

AS
BEGIN
   DECLARE @CantidadDisponibles INT;


SELECT @CantidadDisponibles = COUNT(*) 
    FROM Habitaciones H
    INNER JOIN SALAS S ON H.id_habitacion = S.id_habitacion
    WHERE H.disponibilidad=1    AND S.ID_SALA =  @id_sala;

    RETURN @CantidadDisponibles;
END
GO


--SELECT *FROM Habitaciones
--SELECT *FROM Salas



------------LLAMADO---------
DECLARE @Resultado INT;
EXEC @Resultado = [dbo].[Habitaciones_Disponibles] 3;
SELECT @Resultado AS HabitacionesDisponibles;

--------------------------------------------------------------------------------------------------------------------------------------
-- =================F4============================
-- Author:		Los Data Warrios
-- Create date: 2023/08/16
-- Description:	MOSTRAR ESPECIALIDAD DE UN MEDICO
--================================================
 SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ObtenerEspecialidadMedico] (
   @id_medico VARCHAR(10)
)
RETURNS VARCHAR(50)

AS
BEGIN
    DECLARE @Especialidad VARCHAR (50);

    SELECT @Especialidad = descripcion 
    FROM Medicos M
    INNER JOIN MedicoEspecialidades ME ON ME.id_medico = M.id_medico
    INNER JOIN Especialidades E ON E.id_especialidad = ME.id_especialidad
    WHERE M.id_medico = @id_medico;

    RETURN @Especialidad;
END
GO


---SELECT*FROM[dbo].[Medicos]
---SELECT*FROM [dbo].[Especialidades]
---SELECT*FROM [dbo].[MedicoEspecialidades]


-----Llamado--------
DECLARE @Especialidad_Medico VARCHAR(10) = 'M2';
DECLARE @resultado VARCHAR(50);
SET @resultado = [dbo].[ObtenerEspecialidadMedico](@Especialidad_Medico);
SELECT @resultado AS Especialidad_Medico;



-------------------------------------------------------------------------------------------------------------------------------------
-- =================F5=====================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/16
-- Description:	MOSTRAR EL ESTADO DE SALIDA DE UN PACIENTE 
--=========================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[EstadoSalida] (
    @dni_Paciente VARCHAR(13)
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @EstadoSalida VARCHAR(50);

    SELECT @EstadoSalida =
        CASE
            WHEN R.estado_salida = 1 THEN 'Dado de Alta'
            ELSE 'Permanece en el Hospital'
        END
    FROM
        Pacientes P
    INNER JOIN
        Personas PE ON P.DNI = PE.DNI
    INNER JOIN
        Registros R ON R.id_paciente = P.id_paciente
    WHERE
        P.DNI = @dni_Paciente;

    RETURN @EstadoSalida;
END
GO



--SELECT*FROM Registros
--SELECT*FROM Pacientes

----Llamado------
DECLARE @Resultado VARCHAR(13);
EXEC @Resultado =[dbo].[EstadoSalida]  '0205199800199';
SELECT @Resultado AS E_Hospital ;

SELECT *FROM Pacientes






   