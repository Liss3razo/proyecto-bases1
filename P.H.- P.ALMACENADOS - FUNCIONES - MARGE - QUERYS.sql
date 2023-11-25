
--==========================================================================================================================================
---------------------------------------------------PROCEDIMIENTOS ALMACENADOS----------------------------------------------------------------
--==========================================================================================================================================

--==================PA 1==============================================
-- Author:		Los Data Warrios
-- Create date: 18/08/2023
-- Description: Obtener el tipo de sangre por el DNI de Paciente
--====================================================================
CREATE OR REPLACE PROCEDURE TIPO_SANGRE_PACIENTE(p_dni IN VARCHAR2)
AS
    v_dni VARCHAR2(13);
    v_tipo_sangre VARCHAR2(50);
    v_genero CHAR(1);
    v_p_nombre VARCHAR2(50);
    v_p_apellido VARCHAR2(50);
BEGIN
    SELECT PA.DNI, PA.tipo_sangre, PE.genero, PE.p_nombre, PE.p_apellido
    INTO v_dni, v_tipo_sangre, v_genero, v_p_nombre, v_p_apellido
    FROM Personas PE
    INNER JOIN Pacientes PA ON PE.DNI = PA.DNI
    WHERE PA.DNI = p_dni;

    DBMS_OUTPUT.PUT_LINE('DNI: ' || v_dni);
    DBMS_OUTPUT.PUT_LINE('Tipo de Sangre: ' || v_tipo_sangre);
    DBMS_OUTPUT.PUT_LINE('Género: ' || v_genero);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_p_nombre);
    DBMS_OUTPUT.PUT_LINE('Apellido: ' || v_p_apellido);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró ningún paciente con ese DNI.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error en el procedimiento.');
END;

----LLAMADO-----
SET SERVEROUTPUT ON;
BEGIN
    TIPO_SANGRE_PACIENTE('0107198800554'); -- Reemplazar con el DNI del paciente deseado
END;


--SELECT*FROM PACIENTES



--==================PA 2==============================================
-- Author:		Los Data Warrios
-- Create date: 18/08/2023
-- Description: Agregar un Paciente
--====================================================================
CREATE OR REPLACE PROCEDURE AgregarPacientes(
    p_DNI IN VARCHAR2,
    p_pnombre IN VARCHAR2,
    p_snombre IN VARCHAR2,
    p_papellido IN VARCHAR2,
    p_sapellido IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_id_colonia IN INT,
    p_direccion IN VARCHAR2,
    p_genero IN CHAR,
    p_correo IN VARCHAR2,
    p_fecha_nacimiento IN DATE,
    p_id_paciente IN VARCHAR,
	p_tipo_sangre IN VARCHAR,
	p_paciente_interno IN NUMBER
) AS
BEGIN
    INSERT INTO Personas(DNI, p_nombre, s_nombre, p_apellido, s_apellido, telefono, id_colonia, direccion, genero, correo, fecha_nacimiento )
    VALUES (p_DNI, p_pnombre, p_snombre, p_papellido, p_sapellido, p_telefono, p_id_colonia, p_direccion, p_genero, p_correo, p_fecha_nacimiento );
    
    INSERT INTO PACIENTES (id_paciente,DNI,tipo_sangre ,paciente_interno)
	VALUES (p_id_paciente, p_DNI, p_tipo_sangre, p_paciente_interno);
    
COMMIT;
END;


----------------------LLAMADO----------------

BEGIN
    AgregarPacientes(
        '0501199400513',
        'Juana',
        'Melisa',
        'Vasquez',
        'Urquia',
        '97408790',
        3,
        'calle 3, bloque 5',
        'M',
        'juanitacuellar@gmail.com',
        TO_DATE('1994-05-07', 'YYYY-MM-DD'),
        'PA8',
        'A+',
        1
    );
END;


SELECT*FROM Pacientes




--==================PA 3==============================================
-- Author:		Los Data Warrios
-- Create date: 18/08/2023
-- Description: Agregar una Cita
--====================================================================
--SELECT*FROM CITAS
--SELECT*FROM PERSONAS
--SELECT*FROM PACIENTES
--SELECT*FROM SALAS
--SELECT*FROM PRECLINICA
--SELECT *FROM DIAGNOSTICOS
--SELECT*FROM PROCEDIMIENTOS

CREATE OR REPLACE PROCEDURE CREAR_CITA(
    p_id_paciente IN VARCHAR2,
    p_id_Sala IN INT,
    p_id_preclinica IN INT,
    p_id_diagnostico IN INT,
    p_mayor_edad IN  NUMBER,
    p_id_procedimiento IN INT,
    p_id_fecha_inicio IN DATE,
    p_fecha_fin IN DATE 
 ) AS
BEGIN

    INSERT INTO CITAS(id_paciente , id_Sala , id_preclinica , id_diagnostico , mayor_edad, id_procedimiento , id_fecha_inicio , fecha_fin)
    VALUES ( p_id_paciente, p_id_Sala , p_id_preclinica , p_id_diagnostico , p_mayor_edad ,p_id_procedimiento ,p_id_fecha_inicio ,p_fecha_fin );
    COMMIT;
END;
---LLAMADO

BEGIN
    CREAR_CITA('PA4', 5,4 , 2,0, 2,TO_DATE('2023-08-19', 'YYYY-MM-DD') , TO_DATE('2023-08-19', 'YYYY-MM-DD'));
END;



--==================PA 4==============================================
-- Author:		Los Data Warrios
-- Create date: 19/08/2023
-- Description: AGREGAR HISTORIAL 
--====================================================================

CREATE OR REPLACE PROCEDURE Agregar_Historial(
    p_id_paciente IN VARCHAR2,
    p_id_padecimiento IN NUMBER,
    p_fechainicioP IN DATE,
    p_id_recetas IN NUMBER,
    p_observaciones IN VARCHAR2,
    p_id_enfBaseA IN NUMBER,
    p_fechaInicioE IN DATE,
    p_gradoAvance IN VARCHAR2,
    p_descripcion IN VARCHAR2
)
AS
    v_id_historial NUMBER;
BEGIN
    INSERT INTO Historial_Clinico (id_paciente)
    VALUES (p_id_paciente)
    RETURNING id_historial_clinico INTO v_id_historial;

    INSERT INTO Padecimientos_Pacientes (id_padecimiento, id_historial_clinico, fecha_inicio)
    VALUES (p_id_padecimiento, v_id_historial, p_fechainicioP);

    INSERT INTO EnfermedadesBA_Historial (id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
    VALUES (p_id_enfBaseA, v_id_historial, p_fechaInicioE, p_gradoAvance, p_descripcion);

    INSERT INTO recetasHistorial (id_historial_clinico, id_recetas, observaciones)
    VALUES (v_id_historial, p_id_recetas, p_observaciones);

    DBMS_OUTPUT.PUT_LINE('Historial agregado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('');
END;

------Llamado-----------
SELECT*FROM PACIENTES
SELECT*FROM PADECIMIENTOS
--SELECT*FROM RECETAS
--SELECT*FROM ENFERMEDADES_BASE_ALERGIAS
SELECT*FROM HISTORIAL_CLINICO

DECLARE
    v_id_paciente VARCHAR2(10) := 'PA5';
    v_id_padecimiento NUMBER := 3;
    v_fechainicioP DATE := TO_DATE('2023-08-18', 'YYYY-MM-DD');
    v_id_recetas NUMBER := 2;
    v_observaciones VARCHAR2(100) := 'suspendidas';
    v_id_enfBaseA NUMBER := 2;
    v_fechaInicioE DATE := TO_DATE('2023-08-19', 'YYYY-MM-DD');
    v_gradoAvance VARCHAR2(20) := 'Alto';
    v_descripcion VARCHAR2(100) := ' ';
BEGIN
    Agregar_Historial(
        p_id_paciente => v_id_paciente,
        p_id_padecimiento => v_id_padecimiento,
        p_fechainicioP => v_fechainicioP,
        p_id_recetas => v_id_recetas,
        p_observaciones => v_observaciones,
        p_id_enfBaseA => v_id_enfBaseA,
        p_fechaInicioE => v_fechaInicioE,
        p_gradoAvance => v_gradoAvance,
        p_descripcion => v_descripcion
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Procedimiento ejecutado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('-');
END;

-- =====================PA 5=================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/19
-- Description: Obtener el tipo de Empleado por el dni
-- =============================================================================


CREATE OR REPLACE PROCEDURE TipoEmpleado(p_dni IN VARCHAR2)
AS
BEGIN
    SELECT E.id_empleado, TE.descripcion, (PE.p_nombre || ' ' || PE.s_nombre || ' ' || PE.p_apellido || ' ' || PE.s_apellido) AS Nombre_Empleado
    FROM Personas PE
    INNER JOIN Empleados E ON E.DNI = PE.DNI
    INNER JOIN Tipo_Empleado TE ON E.id_tipo_empleado = TE.id_tipo_empleado
    WHERE E.DNI = p_dni;
END;





--========================================================================================================================================================================
---------------------------------------------------FUNCIONES---------------------------------------------------------------------------------------------------------------
--=========================================================================================================================================================================

-- =================F1========================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/18
-- Description:	Tabla Facturas Aplicar descuentos segun la edad del Persona
-- ===========================================================================

CREATE OR REPLACE FUNCTION CalcularFacturaConDescuento (
    p_id_factura IN INT,
    p_id_descuento IN INT
)
RETURN DECIMAL
IS
    v_total_sin_descuento DECIMAL;
    v_nuevo_total DECIMAL;
BEGIN
    SELECT total INTO v_total_sin_descuento
    FROM Facturas FA
    WHERE FA.id_factura = p_id_factura;

    IF v_total_sin_descuento IS NOT NULL THEN
        IF p_id_descuento = 1 THEN
            v_nuevo_total := v_total_sin_descuento - (v_total_sin_descuento * 0.30);
        ELSE
            v_nuevo_total := v_total_sin_descuento;
        END IF;
    ELSE
        v_nuevo_total := 0;
    END IF;

    RETURN v_nuevo_total;
END;


-------Lamado------------
SELECT *FROM FACTURAS
SET SERVEROUTPUT ON
DECLARE
    v_total DECIMAL;
BEGIN
    v_total := CalcularFacturaConDescuento(11, 1); 
    DBMS_OUTPUT.PUT_LINE(' Total: ' || v_total);
END;



-- =================F2========================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/19
-- Description:	Calcular el sueldo de un medico (Tabla Empleado)
-- ============================================================================

CREATE OR REPLACE FUNCTION CalcularSalarioMedico (
   p_id_medico IN VARCHAR2
)
RETURN DECIMAL
IS
    v_SumaTotalSalario DECIMAL;
BEGIN
    SELECT NVL(SUM(salario), 0) + NVL(SUM(costo), 0)
    INTO v_SumaTotalSalario
    FROM Medicos M
    INNER JOIN Empleados EM ON EM.id_empleado = M.id_empleado
    INNER JOIN MedicoEspecialidades ME ON ME.id_medico = M.id_medico
    WHERE M.id_medico = p_id_medico;

    RETURN v_SumaTotalSalario;
END;


------Llamado-------
SET SERVEROUTPUT ON
DECLARE
    v_total_salario DECIMAL;
    v_id_medico VARCHAR2(10) := 'M1'; 
BEGIN
    v_total_salario := CalcularSalarioMedico(v_id_medico);
    DBMS_OUTPUT.PUT_LINE('Salario total del Medico ' || v_id_medico || ': ' || v_total_salario);
END;


-- =================F3========================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/18
-- Description:	MOSTRAR SI LA HABITACION DE LA SALA ESTA DISPONIBLE
-- ===========================================================================

CREATE OR REPLACE FUNCTION Habitaciones_Disponibles(
    p_id_sala IN INT
)
RETURN INT
IS
    v_CantidadDisponibles INT;
BEGIN
    SELECT COUNT(*)
    INTO v_CantidadDisponibles
    FROM Habitaciones H
    INNER JOIN Salas S ON H.id_habitacion = S.id_habitacion
    WHERE H.disponibilidad = 1 AND S.ID_SALA = p_id_sala;

    RETURN v_CantidadDisponibles;
END;

-------Llamado-------------
SET SERVEROUTPUT ON
SELECT *FROM HABITACIONES
DECLARE
    v_available_rooms INT;
    v_sala_id INT := 1; 
BEGIN
    v_available_rooms := Habitaciones_Disponibles(v_sala_id);
    IF v_available_rooms > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Habitacion Disponible ' || v_sala_id || ': ' || v_available_rooms);
    ELSE
        DBMS_OUTPUT.PUT_LINE('NHabitacion No Disponible  ' || v_sala_id);
    END IF;
END;


-- =================F4=========================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/19
-- Description:	MOSTRAR ESPECIALIDAD DE UN MEDICO
--=============================================================================
CREATE OR REPLACE FUNCTION ObtenerEspecialidadMedico (
   p_id_medico IN VARCHAR2
)
RETURN VARCHAR2
IS
    v_Especialidad VARCHAR2(50);
BEGIN
    SELECT descripcion
    INTO v_Especialidad
    FROM Medicos M
    INNER JOIN MedicoEspecialidades ME ON ME.id_medico = M.id_medico
    INNER JOIN Especialidades E ON E.id_especialidad = ME.id_especialidad
    WHERE M.id_medico = p_id_medico;

    RETURN v_Especialidad;
END;

---------Llamado---------
SET SERVEROUTPUT ON
DECLARE
    v_especialidad VARCHAR2(50);
    v_medico_id VARCHAR2(10) := 'M1'; 
BEGIN
    v_especialidad := ObtenerEspecialidadMedico(v_medico_id);
    DBMS_OUTPUT.PUT_LINE('ESPECIALIDAD ' || v_medico_id || ': ' || v_especialidad);
END;


-- =================F5=========================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/19
-- Description:	MOSTRAR EL ESTADO DE SALIDA DE UN PACIENTE 
--=============================================================================
 CREATE OR REPLACE FUNCTION EstadoSalida (
    dni_Paciente IN VARCHAR2
)
RETURN VARCHAR2
AS
    EstadoSalida VARCHAR2(50);
BEGIN
    SELECT
        CASE
            WHEN R.estado_salida = 1 THEN 'Dado de Alta'
            ELSE 'Permanece en el Hospital'
        END
    INTO EstadoSalida
    FROM Pacientes P
    INNER JOIN Personas PE ON P.DNI = PE.DNI
    INNER JOIN Registros R ON R.id_paciente = P.id_paciente
    WHERE P.DNI = dni_Paciente;

    RETURN EstadoSalida;
END;
/

----------Llamado----------
SELECT *FROM PACIENTES
DECLARE
    Resultado VARCHAR2(50);
BEGIN
    Resultado := EstadoSalida('0107198800554'); -- Reemplaza con el DNI deseado
    DBMS_OUTPUT.PUT_LINE('Estado de salida: ' || Resultado);
END;
/



--========================================================================================================================================================================
---------------------------------------------------MARGE-----------------------------------------------------------------------------------------------------------------
--========================================================================================================================================================================

-- =================MARGE 1====================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/15
-- Description:	AGREGAR O EDITAR DATOS DE LA TABLA PERSONAS 
--=============================================================================
-- Crear la tabla PERSONAS_NUEVAS
--CREATE TABLE Personas(DNI VARCHAR2(13) NOT NULL, p_nombre VARCHAR2(50), s_nombre VARCHAR2(50), p_apellido VARCHAR2(50), s_apellido VARCHAR2(50)
--, telefono VARCHAR2(20), id_colonia INT, direccion VARCHAR2(100), genero CHAR(1), correo VARCHAR2(30), fecha_nacimiento DATE);

CREATE TABLE PERSONAS_NUEVAS (
    DNI VARCHAR2(13) NOT NULL,
    p_nombre VARCHAR2(50),
    s_nombre VARCHAR2(50),
    p_apellido VARCHAR2(50),
    s_apellido VARCHAR2(50),
    telefono VARCHAR2(20),
    id_colonia NUMBER,
    direccion VARCHAR2(100),
    genero CHAR(1),
    correo VARCHAR2(30),
    fecha_nacimiento DATE,
    CONSTRAINT PK_PERSONAS_NUEVAS PRIMARY KEY (DNI)
);

--INSERSION DE DATOS ALA TABLA PERSONAS NUEVAS
--PERSONAS CON DATOS A ACTUALIZAR(TELEFONO,ID_COLONIA Y DIRECCION)
INSERT INTO PERSONAS_NUEVAS (
    DNI, p_nombre, s_nombre, p_apellido, s_apellido, telefono, id_colonia, direccion, genero, correo, fecha_nacimiento
) VALUES (
    '0101199700123', 'Jose', 'Roberto', 'Torres', 'Zabala', '98521478', 1, 'Avenida 5, casa 23', 'H', 'torresjose@gmail.com', TO_DATE('1997-12-04', 'YYYY-MM-DD')
);

INSERT INTO PERSONAS_NUEVAS (
    DNI, p_nombre, s_nombre, p_apellido, s_apellido, telefono, id_colonia, direccion, genero, correo, fecha_nacimiento
) VALUES (
    '0107198800554', 'Gerson', 'Dagoberto', 'Perez', 'Cayuela', '99347865', 2, 'Calle principal enfrente farmacia siman', 'H', 'gersoncayuela34@hootmail.com', TO_DATE('1988-03-11', 'YYYY-MM-DD')
);

INSERT INTO PERSONAS_NUEVAS (
    DNI, p_nombre, s_nombre, p_apellido, s_apellido, telefono, id_colonia, direccion, genero, correo, fecha_nacimiento
) VALUES (
    '0107199400098', 'Maria', NULL, 'Herrera', NULL, '99456789', 3, 'Dos cuadras a la derecha de Pulperia Elizabeth', 'M', NULL, TO_DATE('1994-08-31', 'YYYY-MM-DD')
);

--INFORMACION DE LAS PERSONAS NUEVAS QUE SE VAN A INGRESAR A LA TABLA PERSONAS
INSERT INTO PERSONAS_NUEVAS (
    DNI, p_nombre, s_nombre, p_apellido, s_apellido, telefono, id_colonia, direccion, genero, correo, fecha_nacimiento
) VALUES (
    '0801198500152', 'Sandra', 'Patricia', 'Cantarero', 'OLIVA', '95697841', 4, 'Calle la rosa, Frente a farmacia Siman', 'M', 'SandraPatricia@hotmail.com', TO_DATE('1989-11-01', 'YYYY-MM-DD')
);

INSERT INTO PERSONAS_NUEVAS (
    DNI, p_nombre, s_nombre, p_apellido, s_apellido, telefono, id_colonia, direccion, genero, correo, fecha_nacimiento
) VALUES (
    '080119692356', 'Anderson', 'Alberto', 'Garcia', 'Chavez', '33524715', 2, 'bloque 2,calle principal', 'H', 'andersongarcia8@gmail.com', TO_DATE('1969-01-21', 'YYYY-MM-DD')
);

--SELECT*FROM PERSONAS_NUEVAS

-------------------------------------------------------------------------------------
--------------------INICIO MERGE-----------------------------------------------------
-------------------------------------------------------------------------------------
--MERGE ENTRE TABLA PERSONAS Y PERSONAS NUEVAS
DECLARE
    CURSOR c_personas_nuevas IS
        SELECT
            PS.DNI, PS.p_nombre, PS.s_nombre, PS.p_apellido, PS.s_apellido,
            PS.telefono, PS.id_colonia, PS.direccion, PS.genero, PS.correo,
            PS.fecha_nacimiento
        FROM PERSONAS_NUEVAS PS;
    
    v_num_matched NUMBER := 0;
BEGIN
    FOR rec IN c_personas_nuevas LOOP
        BEGIN
            -- Intentar actualizar el registro existente
            UPDATE Personas
            SET
                telefono = rec.telefono,
                id_colonia = rec.id_colonia,
                direccion = rec.direccion
            WHERE DNI = rec.DNI;
            
            IF SQL%ROWCOUNT > 0 THEN
                v_num_matched := v_num_matched + 1;
            ELSE
                -- Si no se actualizó ningún registro, insertar uno nuevo
                INSERT INTO Personas (
                    DNI, p_nombre, s_nombre, p_apellido, s_apellido,
                    telefono, id_colonia, direccion, genero, correo,
                    fecha_nacimiento
                ) VALUES (
                    rec.DNI, rec.p_nombre, rec.s_nombre, rec.p_apellido, rec.s_apellido,
                    rec.telefono, rec.id_colonia, rec.direccion, rec.genero, rec.correo,
                    rec.fecha_nacimiento
                );
                v_num_matched := v_num_matched + 1;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                NULL; -- Manejo de excepciones (opcional)
        END;
    END LOOP;

    -- Imprimir mensaje de resultado
    IF v_num_matched > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Datos insertados o actualizados correctamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se realizaron cambios.');
    END IF;
    
    COMMIT;
END;

--SELECT*FROM PERSONAS



--========================================================================================================================================================================
---------------------------------------------------QUERYS-----------------------------------------------------------------------------------------------------------------
--========================================================================================================================================================================
-- =================Q1====================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/19
-- Description: QUERY QUE MUESTRE LOS DATOS DE LOS PACIENTES QUE  SU PRIMER NOMBRE TERMINE CON LA LETRA A
--=========================================================================

--SELECT *FROM Pacientes
--SELECT*FROM Personas

SELECT PA.DNI,
       (PE.p_nombre || ' ' || PE.s_apellido) AS NOMBRE_PACIENTE_terminate_LETRA_A,
       PE.telefono,
       MU.descripcion,
       CO.descripcion,
       PE.direccion,
       PE.genero,
       PE.correo,
       PE.fecha_nacimiento
FROM Pacientes PA
INNER JOIN Personas PE ON PE.DNI = PA.DNI
INNER JOIN Colonias CO ON CO.id_colonia = PE.id_colonia
INNER JOIN Municipios MU ON MU.id_municipio = CO.id_municipio
WHERE UPPER(SUBSTR(PE.p_nombre, -1)) = 'A'
GROUP BY PA.DNI,
         (PE.p_nombre || ' ' || PE.s_apellido),
         PE.telefono,
         MU.descripcion,
         CO.descripcion,
         PE.direccion,
         PE.genero,
         PE.correo,
         PE.fecha_nacimiento;

-- =================Q2====================================================
-- Author:		Los Data Warrios
-- Create date: 2023/08/19
-- Description: QUERY MOSTAR ENFERMERO  CON MAYOR SUELDO
--=========================================================================

--SELECT*FROM Empleados
--SELECT*FROM Enfermeros

SELECT SALARIO_COMPLETO, id_enfermero
FROM (
    SELECT MAX(EM.salario + EF.costo_licenciatura) AS SALARIO_COMPLETO, EF.id_enfermero 
    FROM Enfermeros EF
    INNER JOIN Empleados EM ON EM.id_empleado = EF.id_empleado
    GROUP BY EF.id_enfermero
    ORDER BY SALARIO_COMPLETO DESC
) SalariosEnfermeros
FETCH FIRST 1 ROW ONLY;

--==============Q3===========================================================================================================
--QUERY para obtener información sobre pacientes, diagnosticos y el estado de sus recetas medicas(RECETADO, NO RECETADO).
--==========================================================================================================================

SELECT
    P.DNI AS DNI_Paciente,
    P.p_nombre,
    P.s_nombre,
    P.p_apellido,
    P.s_apellido,
    HC.id_historial_clinico,
    D.descripcin_diagnostio AS Diagnostico,
    CASE
        WHEN R.id_recetas IS NOT NULL THEN 'Recetado'
        ELSE 'No Recetado'
    END AS Estado_Receta
FROM Personas P
INNER JOIN Pacientes PC ON P.DNI = PC.DNI
INNER JOIN Historial_Clinico HC ON PC.id_paciente = HC.id_paciente
INNER JOIN Diagnosticos D ON HC.id_historial_clinico = D.id_historial_clinico
LEFT JOIN RecetasHistorial RH ON HC.id_historial_clinico = RH.id_historial_clinico
LEFT JOIN Recetas R ON RH.id_recetas = R.id_recetas;



--==============Q4================================================================================================
--QUERY QUE MUESTRE LOS DATOS DE SOLO LOS MEDICOS GENERALES
--================================================================================================================
SELECT
    M.id_medico,
    PE.p_nombre,
    PE.p_apellido,
    ES.descripcion AS especialidad
FROM
    Medicos M
INNER JOIN Empleados E ON M.id_empleado = E.id_empleado
INNER JOIN MedicoEspecialidades ME ON M.id_medico = ME.id_medico
INNER JOIN Especialidades ES ON ME.id_especialidad = ES.id_especialidad
INNER JOIN Personas PE ON E.DNI = PE.DNI
WHERE
    ES.descripcion LIKE '%Medicina General%'
ORDER BY
    PE.p_apellido, PE.p_nombre;
    
    
--==============Q5=========================================================================================================================
--QUERY QUE MUESTRE LOS ESTADOS DE PRESION MAXIMA, PROMEDIO DE TEMPERATURA, ESTADO DE TEMPERATURA Y PRESION ARTERIAL DE LOS PACIENTES
--====================================================================================================================================



SELECT
    PE.p_nombre,
    PE.p_apellido,
    MAX(PR.presion_aterial) AS Presion_maxima,
    AVG(PR.temperatura_corporal) AS promedio_temperatura,
    CASE
        WHEN AVG(PR.temperatura_corporal) <= 35 THEN 'Hipotermia'
        WHEN AVG(PR.temperatura_corporal) <= 37 AND AVG(PR.temperatura_corporal) = 37.5 THEN 'Normal'
        ELSE 'Fiebre'
    END AS estado_temperatura, 
    CASE
        WHEN AVG(PR.presion_aterial) >= 70 THEN 'Presion ALTA'
        WHEN AVG(PR.presion_aterial) <= 60 AND AVG(PR.presion_aterial) = 60 THEN 'Presion BAJA'
        ELSE 'Presion NORMAL'
    END AS presion_arterial
FROM
    Pacientes P 
INNER JOIN Personas PE ON P.DNI = PE.DNI
INNER JOIN Registros R ON P.id_paciente = R.id_paciente
INNER JOIN Preclinica PR ON R.id_registro = PR.id_registro
GROUP BY
    PE.p_nombre, PE.p_apellido
ORDER BY
    promedio_temperatura DESC;
	
