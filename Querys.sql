USE PROYECTO_HOSPITAL

--==============================QUERYS==========================================

--==============Q1=============================
--QUERY QUE MUESTRE LOS DATOS DE LOS PACIENTES
--=============================================
--SELECT *FROM Pacientes
--SELECT*FROM Personas

SELECT PA.DNI, (PE.p_nombre +' '+PE.s_apellido) AS NOMBRE_PACIENTE, PE.telefono
,MU.descripcion, CO.descripcion, PE.direccion, PE.genero, PE.correo, PE.fecha_nacimiento
FROM Pacientes PA
INNER JOIN Personas PE ON PE.DNI=PA.DNI
INNER JOIN Colonias CO ON CO.id_colonia=PE.id_colonia
INNER JOIN Municipios MU ON MU.id_municipio=CO.id_municipio

GROUP BY PA.DNI, (PE.p_nombre +' '+PE.s_apellido), PE.telefono,MU.descripcion, CO.descripcion
, PE.direccion, PE.genero, PE.correo, PE.fecha_nacimiento


--==============Q2========================================
--QUERY MOSTAR QUE MEDICO ESPECIALISTA CON MAYOR SUELDO
--========================================================
--SELECT*FROM Empleados
--SELECT*FROM Enfermeros

SELECT TOP 1 SALARIO_COMPLETO, id_enfermero
FROM (
    SELECT MAX(EM.salario + EF.costo_licenciatura) AS SALARIO_COMPLETO, EF.id_enfermero 
    FROM Enfermeros EF
    INNER JOIN Empleados EM ON EM.id_empleado = EF.id_empleado
    GROUP BY EF.id_enfermero
) AS SalariosEnfermeros
ORDER BY SALARIO_COMPLETO DESC;


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
--==============Q4==========================================================================================================
--QUERY QUE MUESTRE LOS DATOS DE SOLO LOS MEDICOS GENERALES
--==========================================================================================================================

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


--==============Q5====================================================================================================================
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
        WHEN AVG(PR.presion_aterial) <= 60 AND AVG(PR.presion_aterial)= 60 THEN 'Presion BAJA'
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