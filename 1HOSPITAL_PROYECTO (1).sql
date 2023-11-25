

--TABLAS
CREATE TABLE Personas(DNI VARCHAR2(13) NOT NULL, p_nombre VARCHAR2(50), s_nombre VARCHAR2(50), p_apellido VARCHAR2(50), s_apellido VARCHAR2(50), telefono VARCHAR2(20), id_colonia INT, direccion VARCHAR2(100), genero CHAR(1), correo VARCHAR2(30), fecha_nacimiento DATE);
CREATE TABLE Colonias(id_colonia INT GENERATED ALWAYS AS IDENTITY, id_municipio INT, descripcion VARCHAR2(50));
CREATE TABLE Municipios(id_municipio INT GENERATED ALWAYS AS IDENTITY, id_departamento INT, descripcion VARCHAR2(50));
CREATE TABLE Departamentos(id_departamento INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR(50));
CREATE TABLE Empleados(id_empleado VARCHAR2 (10) CHECK(id_empleado LIKE 'E%') NOT NULL, DNI VARCHAR2(13), id_tipo_empleado INT, id_antecedentes INT,fecha_ingreso DATE,salario DECIMAL);
CREATE TABLE Tipo_Empleado(id_tipo_empleado INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(50));
CREATE TABLE Antecedentes(id_antecedentes INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(50));
CREATE TABLE Pacientes(id_paciente VARCHAR2(10) CHECK(id_paciente  LIKE 'PA%') NOT NULL, DNI VARCHAR2(13), tipo_sangre VARCHAR2(50), paciente_interno NUMBER(1)CHECK (paciente_interno IN(0,1)));
CREATE TABLE Registros(id_registro VARCHAR2(10) CHECK(id_registro LIKE 'R%') NOT NULL, id_paciente VARCHAR2(10), fecha_hora_ingreso TIMESTAMP, fecha_hora_salida TIMESTAMP, estado_salida NUMBER(1) CHECK (estado_salida IN(0,1)) );
CREATE TABLE Medicos(id_medico VARCHAR2(10) CHECK(id_medico LIKE 'M%') NOT NULL, id_empleado VARCHAR2 (10), n_colegio int);
CREATE TABLE Especialidades(id_especialidad int GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(50));
CREATE TABLE MedicoEspecialidades(id_medico_especialidades INT GENERATED ALWAYS AS IDENTITY, id_medico VARCHAR2(10), id_especialidad int, fecha_graduacion DATE, costo DECIMAL);
CREATE TABLE Enfermeros(id_enfermero VARCHAR2(10) CHECK(id_enfermero LIKE 'EN%') NOT NULL, id_empleado VARCHAR2 (10), licenciatura NUMBER(1) CHECK (licenciatura IN(0,1)), costo_licenciatura DECIMAL);
CREATE TABLE Preclinica(id_preclinica INT GENERATED ALWAYS AS IDENTITY, id_registro VARCHAR2(10), id_sala INT, id_historial_clinico INT, temperatura_corporal INT, pulsaciones FLOAT, presion_aterial INT, glucosa INT);
CREATE TABLE Historial_Clinico(id_historial_clinico INT GENERATED ALWAYS AS IDENTITY, id_paciente VARCHAR2(10));
CREATE TABLE Padecimientos(id_padecimiento INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(50));
CREATE TABLE Padecimientos_Pacientes(id_padecimientos_pacientes int GENERATED ALWAYS AS IDENTITY, id_padecimiento INT, id_historial_clinico int, fecha_inicio date);
CREATE TABLE Enfermedades_Base_Alergias(id_enferm_base_alergia INT GENERATED ALWAYS AS IDENTITY, enfermedad_alergia NUMBER(1) CHECK(enfermedad_alergia IN(0,1)), descripcion Varchar2(100));
CREATE TABLE EnfermedadesBA_Historial(id_enfermedadesBA_historial INT GENERATED ALWAYS AS IDENTITY, id_enferm_base_alergia INT, id_historial_clinico INT, fecha_inicio DATE, grado_avance VARCHAR2(20), descripcion varchar(100));
CREATE TABLE Salas(id_sala INT GENERATED ALWAYS AS IDENTITY, id_tipo_sala INT, id_habitacion VARCHAR2(10), id_clinica VARCHAR2(10), descripcion VARCHAR2(50));
CREATE TABLE Tipo_Sala(id_tipo_sala INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(100));
CREATE TABLE Habitaciones(id_habitacion VARCHAR2(10) CHECK(id_habitacion LIKE 'HAB%') NOT NULL, numero_habitacion INT, descripcion VARCHAR2(50),disponibilidad NUMBER(1) CHECK(disponibilidad IN(0,1)));
CREATE TABLE Clinica(id_clinica VARCHAR2(10) CHECK(id_clinica LIKE 'CL%')  NOT NULL, numero_clinica INT, descripcion VARCHAR2(50));
CREATE TABLE Procedimientos(id_procedimiento INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(100), precio DECIMAL, id_medico varchar2(10));
CREATE TABLE Diagnosticos(id_diagnostico INT GENERATED ALWAYS AS IDENTITY, id_historial_clinico INT, id_preclinica INT, id_procedimiento INT, descripcin_diagnostio VARCHAR2(200));
CREATE TABLE Recetas(id_recetas INT GENERATED ALWAYS AS IDENTITY, descripcion_recetas VARCHAR2(100), id_paciente VARCHAR2(10), id_medico VARCHAR2(10), fecha_emicion Date);
CREATE TABLE Medicamentos(id_medicamentos INT GENERATED ALWAYS AS IDENTITY, descripcion VARCHAR2(100), costo DECIMAL);
CREATE TABLE Medicamentos_Recetas(id_medicamentos_recetas INT GENERATED ALWAYS AS IDENTITY, id_medicamentos INT, id_recetas INT, fecha_inicio DATE, fecha_fin DATE, docificacion INT, intervalo_tiempo INT);
CREATE TABLE Facturas(id_factura INT GENERATED ALWAYS AS IDENTITY, id_preimpreso INT, id_cita INT, cant_uni_citas INT, id_forma_pago INT, impuesto DECIMAL,id_descuento INT, subtotal DECIMAL, total DECIMAL);
CREATE TABLE Datos_Factura_Preimpreso(id_preimpreso INT GENERATED ALWAYS AS  IDENTITY, id_paciente VARCHAR2(10), id_CAI INT, RTN_hospital INT,direccion_hospital VARCHAR2(100), telefono_hospital VARCHAR2 (20), razon_denominacion VARCHAR2(50), num_correlativo VARCHAR2(15), fecha_limite_emicion DATE);
CREATE TABLE CAI(id_CAI INT GENERATED ALWAYS AS  IDENTITY, anio_emision INT, fecha_vencimiento DATE, rango_numero_autorizado VARCHAR2(10), descripcion VARCHAR2(50));
CREATE TABLE Descuentos(id_descuento INT GENERATED ALWAYS AS  IDENTITY, descripcion VARCHAR2(50), restriccin_edad int)
CREATE TABLE Formas_Pago(id_forma_pago INT GENERATED ALWAYS AS  IDENTITY, descripcion VARCHAR2(50));
CREATE TABLE Citas(id_cita int GENERATED ALWAYS AS IDENTITY, id_paciente VARCHAR2(10), id_Sala int, id_preclinica int, id_diagnostico int, mayor_edad NUMBER(1) CHECK(mayor_edad IN(0,1)), id_procedimiento int, id_fecha_inicio date, fecha_fin date)
CREATE TABLE RecetasHistorial(idRecetasHis INT  GENERATED ALWAYS AS IDENTITY, id_historial_clinico int, id_recetas int, observaciones varchar2(100))


--LLAVES PRIMARIAS
ALTER TABLE recetasHistorial 
ADD CONSTRAINT PK_RecetasHistorial PRIMARY KEY (idRecetasHis)

ALTER TABLE Personas 
ADD CONSTRAINT PK_PERSONAS PRIMARY KEY (DNI)

ALTER TABLE Colonias 
ADD CONSTRAINT PK_COLONIAS PRIMARY KEY (id_colonia)

ALTER TABLE Municipios 
ADD CONSTRAINT PK_MUNICIPIOS PRIMARY KEY (id_municipio)

ALTER TABLE Departamentos 
ADD CONSTRAINT PK_DEPARTAMENTOS PRIMARY KEY (id_departamento)

ALTER TABLE Empleados 
ADD CONSTRAINT PK_EMPLEADOS PRIMARY KEY (id_empleado)

ALTER TABLE Tipo_Empleado 
ADD CONSTRAINT PK_TIPO_EMPLEADOS PRIMARY KEY (id_tipo_empleado)

ALTER TABLE Antecedentes 
ADD CONSTRAINT PK_ANTECEDENTES PRIMARY KEY (id_antecedentes)

ALTER TABLE Pacientes 
ADD CONSTRAINT PK_PACIENTES PRIMARY KEY (id_paciente)

ALTER TABLE Registros 
ADD CONSTRAINT PK_REGISTROS PRIMARY KEY (id_registro)

ALTER TABLE Medicos 
ADD CONSTRAINT PK_MEDICO PRIMARY KEY (id_medico)

ALTER TABLE Especialidades 
ADD CONSTRAINT PK_ESPECIALIDADES PRIMARY KEY (id_especialidad)

ALTER TABLE MedicoEspecialidades 
ADD CONSTRAINT PK_MEDICO_ESPECIALIDADES PRIMARY KEY (id_medico_especialidades)

ALTER TABLE Enfermeros 
ADD CONSTRAINT PK_ENFERMEROS PRIMARY KEY (id_enfermero)

ALTER TABLE Preclinica 
ADD CONSTRAINT PK_PRECLINICA PRIMARY KEY (id_preclinica)

ALTER TABLE Historial_Clinico 
ADD CONSTRAINT PK_HISTORIAL_CLINICO PRIMARY KEY (id_historial_clinico)

ALTER TABLE Padecimientos 
ADD CONSTRAINT PK_PADECIMIENTOS PRIMARY KEY (id_padecimiento)

ALTER TABLE Padecimientos_Pacientes 
ADD CONSTRAINT PK_PADECIMIENTOS_PACIENTES PRIMARY KEY (id_padecimientos_pacientes)

ALTER TABLE Enfermedades_Base_Alergias 
ADD CONSTRAINT PK_ENFERMEDADES_BASE_ALERGIA PRIMARY KEY (id_enferm_base_alergia)

ALTER TABLE EnfermedadesBA_Historial 
ADD CONSTRAINT PK_ENFERMEDADES_BA_HISTORIAL PRIMARY KEY (id_enfermedadesBA_historial)

ALTER TABLE Citas 
ADD CONSTRAINT PK_CITAS PRIMARY KEY (id_cita)

ALTER TABLE Salas 
ADD CONSTRAINT PK_SALAS PRIMARY KEY (id_sala)

ALTER TABLE Tipo_Sala 
ADD CONSTRAINT PK_TIPO_SALAS PRIMARY KEY (id_tipo_sala)

ALTER TABLE Habitaciones 
ADD CONSTRAINT PK_HABITACIONES PRIMARY KEY (id_habitacion)

ALTER TABLE Clinica 
ADD CONSTRAINT PK_CLINICA PRIMARY KEY (id_clinica)

ALTER TABLE Procedimientos 
ADD CONSTRAINT PK_PROCEDIMIENTOS PRIMARY KEY (id_procedimiento)

ALTER TABLE Diagnosticos 
ADD CONSTRAINT PK_DIAGNOSTICO PRIMARY KEY (id_diagnostico)

ALTER TABLE Recetas 
ADD CONSTRAINT PK_RECETAS PRIMARY KEY (id_recetas)

ALTER TABLE Medicamentos 
ADD CONSTRAINT PK_MEDICAMENTOS PRIMARY KEY (id_medicamentos)

ALTER TABLE Medicamentos_Recetas 
ADD CONSTRAINT PK_MEDICAMENTOS_RECETAS PRIMARY KEY (id_medicamentos_recetas)


ALTER TABLE Facturas 
ADD CONSTRAINT PK_FACTURA PRIMARY KEY (id_factura )

ALTER TABLE Datos_Factura_Preimpreso 
ADD CONSTRAINT PK_PREIMPRESO PRIMARY KEY (id_preimpreso)

ALTER TABLE CAI 
ADD CONSTRAINT PK_CAI PRIMARY KEY (id_CAI)

ALTER TABLE Descuentos 
ADD CONSTRAINT PK_DESCUENTOS PRIMARY KEY (id_descuento)

ALTER TABLE Formas_Pago 
ADD CONSTRAINT PK_FORMAS_PAGO PRIMARY KEY (id_forma_pago)

--RELACIONES

--Relaciones de personas
ALTER TABLE Personas 
ADD CONSTRAINT FK_COLONIAS FOREIGN KEY (id_colonia) REFERENCES Colonias(id_colonia)

--Relaciones de colnias
ALTER TABLE Colonias
ADD CONSTRAINT FK_MUNICIPIOS FOREIGN KEY (id_municipio) REFERENCES Municipios(id_municipio)

--Relaciones de Municipios
ALTER TABLE Municipios
ADD CONSTRAINT FK_DEPARTAMENTOS FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)

--Relaciones de empleado
ALTER TABLE Empleados 
ADD CONSTRAINT FK_PERSONA FOREIGN KEY (DNI) REFERENCES Personas(DNI)

ALTER TABLE Empleados 
ADD CONSTRAINT FK_TIPO_EMPLEADO FOREIGN KEY (id_tipo_empleado) REFERENCES Tipo_Empleado(id_tipo_empleado )

ALTER TABLE Empleados
ADD CONSTRAINT FK_ANTECEDENTE FOREIGN KEY (id_antecedentes ) REFERENCES Antecedentes(id_antecedentes )

--Relaciones de pacientes
ALTER TABLE Pacientes 
ADD CONSTRAINT FK_PERSONAS FOREIGN KEY (DNI) REFERENCES Personas(DNI)


--Relaciones de registro
ALTER TABLE Registros 
ADD CONSTRAINT FK_PACIENTE FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)

--Relaciones de Medicos

ALTER TABLE Medicos 
ADD CONSTRAINT FK_EMPLEADOS FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)


--Relaciones de medicoEspecialidad
ALTER TABLE MedicoEspecialidades 
ADD CONSTRAINT FK_MEDICOS FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)

ALTER TABLE MedicoEspecialidades 
ADD CONSTRAINT FK_ESPECIALIDAD FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad)

--Relaciones de enfermeros
ALTER TABLE Enfermeros 
ADD CONSTRAINT FK_EMPLEADO FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)


--Relaciones de preclinica
ALTER TABLE Preclinica 
ADD CONSTRAINT FK_REGISTROS FOREIGN KEY (id_registro) REFERENCES Registros(id_registro)

ALTER TABLE Preclinica 
ADD CONSTRAINT FK_SALAS FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)

ALTER TABLE Preclinica 
ADD CONSTRAINT FK_HISTORIAL FOREIGN KEY (id_historial_clinico) REFERENCES Historial_Clinico(id_historial_clinico)

--Relaciones de Historial clinico
ALTER TABLE Historial_Clinico 
ADD CONSTRAINT FK_PACIENTEH FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)

--Relaciones de Padecimientos_pacientes
Alter table Padecimientos_Pacientes
ADD CONSTRAINT FK_PAHistorial FOREIGN KEY (id_historial_clinico) REFERENCES Historial_Clinico(id_historial_clinico)


--Relaciones de EnfermedadesBA_Historial
ALTER TABLE EnfermedadesBA_Historial 
ADD CONSTRAINT FK_ENFERMEDADESBASE_ALERGIA FOREIGN KEY (id_enferm_base_alergia) REFERENCES Enfermedades_Base_Alergias(id_enferm_base_alergia)

ALTER TABLE EnfermedadesBA_Historial 
ADD CONSTRAINT FK_HISTORIAL_CLINICO FOREIGN KEY (id_historial_clinico) REFERENCES Historial_Clinico(id_historial_clinico)

--Relaciones de Citas

ALTER TABLE Citas 
ADD CONSTRAINT FK_Paciente_ FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)

ALTER TABLE Citas 
ADD CONSTRAINT FK_Salas_ FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)

ALTER TABLE Citas 
ADD CONSTRAINT FK_Preclinica_ FOREIGN KEY (id_preclinica) REFERENCES  Preclinica(id_preclinica)

ALTER TABLE Citas 
ADD CONSTRAINT FK_Diagnostico_ FOREIGN KEY (id_diagnostico) REFERENCES  Diagnosticos(id_diagnostico)

ALTER TABLE Citas 
ADD CONSTRAINT FK_PROC_ FOREIGN KEY (id_procedimiento) REFERENCES  Procedimientos(id_procedimiento)

--Relaciones de Salas
ALTER TABLE Salas 
ADD CONSTRAINT FK_TipoSala FOREIGN KEY (id_tipo_sala) REFERENCES Tipo_Sala(id_tipo_sala)

ALTER TABLE Salas 
ADD CONSTRAINT FK_HABITACIONES FOREIGN KEY (id_habitacion) REFERENCES Habitaciones(id_habitacion)

ALTER TABLE Salas 
ADD CONSTRAINT FK_CLINICA FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica)

--Relaciones de Diagnosticos
ALTER TABLE Diagnosticos 
ADD CONSTRAINT FK_HISTORIAL_CLINICO_D FOREIGN KEY (id_historial_clinico) REFERENCES Historial_Clinico(id_historial_clinico)

ALTER TABLE Diagnosticos 
ADD CONSTRAINT FK_PRECLINICA_D FOREIGN KEY (id_preclinica) REFERENCES  Preclinica(id_preclinica)

ALTER TABLE Diagnosticos 
ADD CONSTRAINT FK_PROCEDIMIENTOS_D FOREIGN KEY (id_procedimiento) REFERENCES Procedimientos(id_procedimiento)

--Relaciones de Medicamentos_Recetas
ALTER TABLE Medicamentos_Recetas 
ADD CONSTRAINT FK_MEDICAMENTOS FOREIGN KEY (id_medicamentos) REFERENCES Medicamentos(id_medicamentos)

ALTER TABLE Medicamentos_Recetas 
ADD CONSTRAINT FK_RECETAS FOREIGN KEY (id_recetas) REFERENCES Recetas(id_recetas)


--Relaciones de Facturas
ALTER TABLE Facturas 
ADD CONSTRAINT FK_PREIMPRESO FOREIGN KEY (id_preimpreso) REFERENCES Datos_Factura_Preimpreso(id_preimpreso)

ALTER TABLE Facturas 
ADD CONSTRAINT FK_CITAS_F FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)

ALTER TABLE Facturas 
ADD CONSTRAINT FK_FORMA_PAGO FOREIGN KEY (id_forma_pago) REFERENCES Formas_Pago(id_forma_pago)

ALTER TABLE Facturas 
ADD CONSTRAINT FK_DESCUENTOS FOREIGN KEY (id_descuento) REFERENCES Descuentos(id_descuento)

--Relaciones de Datos_Factura_Preimpreso
ALTER TABLE Datos_Factura_Preimpreso 
ADD CONSTRAINT FK_PACIENTE_FP FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)

ALTER TABLE Datos_Factura_Preimpreso 
ADD CONSTRAINT FK_CAI FOREIGN KEY (id_CAI) REFERENCES CAI(id_CAI)

--Relaciones de la recetas
ALTER TABLE Recetas
ADD CONSTRAINT FK_PaRecet FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)

ALTER TABLE Recetas
ADD CONSTRAINT FK_MeRecet FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)

--Relaciones procedimiento medico

ALTER TABLE procedimientos
ADD CONSTRAINT FK_ProMed FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)

--Recetas historial
     ALTER TABLE recetasHistorial 
	 ADD CONSTRAINT FK_ReHistorial FOREIGN KEY (id_historial_clinico) REFERENCES Historial_Clinico(id_historial_clinico)
   
     ALTER TABLE recetasHistorial 
	 ADD CONSTRAINT FK_RecetasHis FOREIGN KEY (id_recetas) REFERENCES Recetas(id_recetas)




--=======================================================REGISTROS==================================================================================================
-----Departamentos------
INSERT INTO Departamentos (descripcion)
VALUES ('Comayagua');
INSERT INTO Departamentos (descripcion)
VALUES('Copan');
INSERT INTO Departamentos (descripcion)
VALUES('Cortes');
INSERT INTO Departamentos (descripcion)
VALUES('Choluteca');
INSERT INTO Departamentos (descripcion)
VALUES('El Paraiso'); 
INSERT INTO Departamentos (descripcion)
VALUES('Francisco Morazan');
INSERT INTO Departamentos (descripcion)
VALUES('Gracias a Dios');
 INSERT INTO Departamentos (descripcion)
VALUES('Intibuca');
INSERT INTO Departamentos (descripcion)
VALUES('Islas de la Bahia');
INSERT INTO Departamentos (descripcion)
VALUES('La Paz');
INSERT INTO Departamentos (descripcion)
VALUES('Lempira');
INSERT INTO Departamentos (descripcion)
VALUES('Ocotepeque');

INSERT INTO Departamentos (descripcion)
VALUES('Olancho');

INSERT INTO Departamentos (descripcion)
VALUES('Santa Barbara');

INSERT INTO Departamentos (descripcion)
VALUES('Valle');
INSERT INTO Departamentos (descripcion)
VALUES('Yoro');


------Municipios-----
INSERT INTO Municipios( id_departamento, descripcion)
VALUES (1,'La Ceiba');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(1,'Tela');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(2,'Trujillo');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(2,'Santa Fe');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(3,'Comayagua');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(3,'Taulabe');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(4,'Copan Ruinas');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(4,'Florida');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(5,'San Pedro Sula');
INSERT INTO Municipios( id_departamento, descripcion)
VALUES(5,'Puerto Cortes');




-----Colonias y Barrios----
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (1,'Colonia Girasol');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (1,'Colonia La olimpica');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (2,'Colonia 13 de Julio');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (2,'Colonia El Esfuerzo');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (3,'Puerto Castilla');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (3,'Colonia Aguan');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (4,'Plan Grande');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (4,'Santa Fe');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (5,'Piedras Azules');
INSERT INTO Colonias( id_municipio, descripcion)
VALUES (5,'Comayagua');
-------Personas--------
-------Personas--------
Personas(DNI VARCHAR2(13) NOT NULL, p_nombre VARCHAR2(50), s_nombre VARCHAR2(50), p_apellido VARCHAR2(50), s_apellido VARCHAR2(50), telefono VARCHAR2(20), id_colonia INT, direccion VARCHAR2(100), genero CHAR(1), correo VARCHAR2(30), fecha_nacimiento DATE);
INSERT INTO Personas (DNI, p_nombre, s_nombre, p_apellido, s_apellido , telefono , id_colonia , direccion, genero , correo, fecha_nacimiento)
VALUES('0801199818847','KEVIN','DANIEL','VALLADARES','CANTARERO','89294960',1,'CALLE PRINCIPAL','H','KEVINCANTARERO45@GMAIL.COM',TO_DATE('1998-09-22', 'YYYY-MM-DD'));


INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES ( '0101199700123','Jose', 'Roberto','Torres','Zabala','99426789',1, 'Avenida 5, casa 23','H', 'torresjose@gmail.com', TO_DATE('1997-12-04','YYYY-MM-DD');

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0205199800199','Carlos', 'Alberto','Hernandez','Perez','97345678',2, 'Calle 6, Ala par de pulperia Tres Hermanos','H', 'alberto23h@gmail.com',TO_DATE( '1998/01/25','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0304198700524','Karla', 'Malissa','Alvarado','Hernandez','34567698',2, 'Avenida 7, casa 29','M', 'karlamelissa345@gmail.com', TO_DATE('1977/06/15','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0408200100467','Heydy', 'Leticia','','Zabala','99426789',3, 'Sector3, Avenida 2, casa 35','M', '', TO_DATE('2001/10/29','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0506199400534','Juan', '','Cruz','Lopez','32657842',4, 'A tres cuadras del supermercado Mini Despensa','H', 'cruzj123@hootmail.com',TO_DATE('1997/12/04','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0107199400098','Maria', '','Herrera','','99456789',1, 'Dos cuadras a la derecha de Pulperia Elizabeth','M', '', TO_DATE('1994/08/31','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0107198800554','Gerson', 'Dagoberto','Perez','Cayuela','99347865',2, 'Sector 3,Bloque 5 casa 6547','H', 'gersoncayuela34@hootmail.com',TO_DATE( '1988/03/11','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0304199000456','Alejandro', 'Manuel','Muñoz','Samaniego','33567645',4, 'Bloque 6, casa 3546','H', 'muñozalejandro90@gmail.com', TO_DATE('1990/05/10','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0407197500077','Rosa', 'Maria','Navarro','Sanchez','98347685',5, 'Avenida 6, casa 3456','M', 'navarromr@gmail.com', TO_DATE('1975/11/29','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0545199200345','Francisco', '','Placios','Ortega','97459865',3, 'Frente al estadio Castilla','H', 'ortegapalacios92@gmail.com', TO_DATE ( '1992/09/26','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0305199300345','Alice', 'Leticia','Mendez','Zabala','33568734',3, 'Avenida 6, casa 239','M', 'alicemendez123@gmail.com',TO_DATE( '1993/10/04','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '080119991146','Kevin', 'Alberto','Cruz','Gomez','32175951',4, 'Bloque 5, Casa 18','H', 'cruzkevin511@gmail.com',TO_DATE( '1999/03/13','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0801199200569','Victor', 'Andres','Salgado','Zeleya','32964280',2, 'Frente a la Sagastume','H', 'victorsalgado20@gmail.com', TO_DATE('1992/07/13','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '080119761532','Luis', 'Fernando','Buzeta','Fiallos','32678954',3, 'bloque 7, casa 6754','H', 'buzetaluis67@gmail.com',TO_DATE( '1986/04/23','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0801199800674','Fany', 'Daniela','Ucles','Amaya','97565421',3, 'Bloque 7, Casa 184','M', 'danielaucles34@gmail.com',TO_DATE( '1998/04/27','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0109197800788','Valentina', 'Onet','Gomez','Perez','97905412',4, 'Bloque 2, casa 456','M', 'valentinagomez56@gmail.com',TO_DATE( '1978/09/01','YYYY-MM-DD'));

INSERT INTO Personas(DNI, p_nombre , s_nombre , p_apellido, s_apellido , telefono, id_colonia, direccion, genero , correo , fecha_nacimiento)
VALUES( '0109199001987','Jorge', 'Alberto','Lopez','Mendez','95674312',4, 'Avenida 6, casa 46','H', 'mendezlopez56@gmail.com', TO_DATE('1990/04/28','YYYY-MM-DD'));


------Tipo Empleado------------
INSERT INTO Tipo_Empleado( descripcion)
VALUES('Medico General');
INSERT INTO Tipo_Empleado( descripcion)
VALUES('Especialista');
INSERT INTO Tipo_Empleado( descripcion)
VALUES('administrador');
INSERT INTO Tipo_Empleado( descripcion)
VALUES('enfermero');
INSERT INTO Tipo_Empleado( descripcion)
VALUES('paramedico');

SELECT *FROM Tipo_empleado





------Antecedentes--------------
INSERT INTO Antecedentes( descripcion )
VALUES('No posee antecedentes');

INSERT INTO Antecedentes( descripcion )
VALUES('Tiene Antecedentes Policiales');

INSERT INTO Antecedentes( descripcion )
VALUES('Tiene Antecedentes Penales');

INSERT INTO Antecedentes( descripcion )
VALUES('Tiene Antecedentes Penales y Policiales');

------Empleado-------
INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E1','0801199818847',2,1,TO_DATE('2015/01/15','YYYY-MM-DD'),200000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E2','0304198700524',2,1,TO_DATE('2011/01/15', 'YYYY-MM-DD'),38000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E3','0545199200345',2,1,TO_DATE('2023/01/01', 'YYYY-MM-DD'),30000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E4','0304199000456',1,1,TO_DATE('2019/06/15', 'YYYY-MM-DD'),28000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E5','0506199400534',3,1,TO_DATE('2020/06/01', 'YYYY-MM-DD'),18000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E7','080119991146',4,1,TO_DATE('2020/06/15', 'YYYY-MM-DD'),30000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E8','0801199200569',4,1,TO_DATE('2023/01/15', 'YYYY-MM-DD'),13000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E9','080119761532',4,1,TO_DATE('2021/01/25', 'YYYY-MM-DD'),18000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E10','0109197800788',1,1,TO_DATE('2016/01/15', 'YYYY-MM-DD'),200000);

INSERT INTO Empleados(id_empleado, DNI , id_tipo_empleado , id_antecedentes ,fecha_ingreso,salario )
VALUES('E11','0109199001987',1,1,TO_DATE('2014/01/15', 'YYYY-MM-DD'),220000);

------Paciente------A+, A-, B+, B-, AB+, AB-, O+ y O-
INSERT INTO Pacientes(id_paciente, DNI , tipo_sangre, paciente_interno )
VALUES('PA1','0205199800199','A+', 0);

INSERT INTO Pacientes(id_paciente, DNI , tipo_sangre, paciente_interno )
VALUES('PA2','0408200100467','A-',0);

INSERT INTO Pacientes(id_paciente, DNI , tipo_sangre, paciente_interno )
VALUES('PA3','0107199400098','B+',1);

INSERT INTO Pacientes(id_paciente, DNI , tipo_sangre, paciente_interno )
VALUES('PA4','0107198800554','AB+',1);

INSERT INTO Pacientes(id_paciente, DNI , tipo_sangre, paciente_interno )
VALUES('PA5','0407197500077','O+',0);

---------REGISTROS-----------

INSERT INTO Registros(id_registro, id_paciente , fecha_hora_ingreso , fecha_hora_salida, estado_salida)
VALUES ('R1','PA1',TO_TIMESTAMP('2023-08-17 08:30:00', 'YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-08-17 15:35:00', 'YYYY-MM-DD HH24:MI:SS'),0);

INSERT INTO Registros(id_registro, id_paciente , fecha_hora_ingreso , fecha_hora_salida, estado_salida)
VALUES('R2','PA2',TO_TIMESTAMP('2023-06-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-06-22 12:15:00', 'YYYY-MM-DD HH24:MI:SS'),0);

INSERT INTO Registros(id_registro, id_paciente , fecha_hora_ingreso , fecha_hora_salida, estado_salida)
VALUES('R3','PA3',TO_TIMESTAMP('2022-05-20 08:30:00', 'YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-05-28 08:24:06', 'YYYY-MM-DD HH24:MI:SS'),1);

INSERT INTO Registros(id_registro, id_paciente , fecha_hora_ingreso , fecha_hora_salida, estado_salida)
VALUES('R4','PA4',TO_TIMESTAMP('2023-07-11 09:30:00', 'YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-07-17 14:35:02', 'YYYY-MM-DD HH24:MI:SS'),1);

INSERT INTO Registros(id_registro, id_paciente , fecha_hora_ingreso , fecha_hora_salida, estado_salida)
VALUES('R5','PA5',TO_TIMESTAMP('2023-08-15 18:30:00', 'YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-08-17 18:30:35', 'YYYY-MM-DD HH24:MI:SS'),0);
SELECT *FROM EMPLEADOS

------MEDICOS---------
INSERT INTO Medicos(id_medico, id_empleado, n_colegio)
VALUES ('M1','E1',34567);

INSERT INTO Medicos(id_medico, id_empleado, n_colegio)
VALUES('M2','E2',365987);

INSERT INTO Medicos(id_medico, id_empleado, n_colegio)
VALUES('M3','E3',367890);

INSERT INTO Medicos(id_medico, id_empleado, n_colegio)
VALUES('M4','E4',339867);

INSERT INTO Medicos(id_medico, id_empleado, n_colegio)
VALUES('M5','E5',367845);


--------ESPECIALIDADES-------
INSERT INTO Especialidades(descripcion)
VALUES('Medicina General');

INSERT INTO Especialidades(descripcion)
VALUES('Pediatría');

INSERT INTO Especialidades(descripcion)
VALUES('Obstetricia');

INSERT INTO Especialidades(descripcion)
VALUES('Ginecología');

INSERT INTO Especialidades(descripcion)
VALUES('Cirugía General');

INSERT INTO Especialidades(descripcion)
VALUES('Medicina Interna');

INSERT INTO Especialidades(descripcion)
VALUES('Cardiología');
INSERT INTO Especialidades(descripcion)
VALUES('Dermatología');

INSERT INTO Especialidades(descripcion)
VALUES('Oftalmología');

INSERT INTO Especialidades(descripcion)
VALUES('Otorrinolaringología');

INSERT INTO Especialidades(descripcion)
VALUES('Ortopedia');

INSERT INTO Especialidades(descripcion)
VALUES('Traumatología');

INSERT INTO Especialidades(descripcion)
VALUES('Urología');
INSERT INTO Especialidades(descripcion)
VALUES('Psiquiatría');

INSERT INTO Especialidades(descripcion)
VALUES('Neurología');

INSERT INTO Especialidades(descripcion)
VALUES('Endocrinología');

INSERT INTO Especialidades(descripcion)
VALUES('Gastroenterología');

INSERT INTO Especialidades(descripcion)
VALUES('Nefrología');

INSERT INTO Especialidades(descripcion)
VALUES('Neumología');

INSERT INTO Especialidades(descripcion)
VALUES('Hematología');
INSERT INTO Especialidades(descripcion)
VALUES('Oncología');

INSERT INTO Especialidades(descripcion)
VALUES('Infectología');

INSERT INTO Especialidades(descripcion)
VALUES('Reumatología');

INSERT INTO Especialidades(descripcion)
VALUES('Medicina Familiar');

INSERT INTO Especialidades(descripcion)
VALUES('Medicina de Emergencia');

INSERT INTO Especialidades(descripcion)
VALUES('Radiología');

INSERT INTO Especialidades(descripcion)
VALUES('Anestesiología');
INSERT INTO Especialidades(descripcion)
VALUES('Medicina Física y Rehabilitación');

INSERT INTO Especialidades(descripcion)
VALUES('Medicina Nuclear');

INSERT INTO Especialidades(descripcion)
VALUES('Medicina Deportiva');

INSERT INTO Especialidades(descripcion)
VALUES('Geriatría');

------MEDICO--ESPECIALIDADES----
INSERT INTO MedicoEspecialidades(id_medico , id_especialidad, fecha_graduacion, costo)
VALUES ('M1',1,TO_DATE('2010-11-03', 'YYYY-MM-DD'),800);

INSERT INTO MedicoEspecialidades(id_medico , id_especialidad, fecha_graduacion, costo)
VALUES ('M2',2,TO_DATE('2009-06-05', 'YYYY-MM-DD'),1500);

INSERT INTO MedicoEspecialidades(id_medico , id_especialidad, fecha_graduacion, costo)
VALUES ('M3',4,TO_DATE('2007-03-15', 'YYYY-MM-DD'),1800);

INSERT INTO MedicoEspecialidades(id_medico , id_especialidad, fecha_graduacion, costo)
VALUES ('M4',1,TO_DATE('1997-12-04', 'YYYY-MM-DD'),900);

--------Enfermeros-------
INSERT INTO Enfermeros(id_enfermero, id_empleado, licenciatura,costo_licenciatura)
VALUES ('EN1','E7',1,20000);

INSERT INTO Enfermeros(id_enfermero, id_empleado, licenciatura,costo_licenciatura)
VALUES ('EN2','E8',1,20000);

INSERT INTO Enfermeros(id_enfermero, id_empleado, licenciatura,costo_licenciatura)
VALUES ('EN3','E9',0,0);

INSERT INTO Enfermeros(id_enfermero, id_empleado, licenciatura,costo_licenciatura)
VALUES ('EN4','E10',1,22000);

INSERT INTO Enfermeros(id_enfermero, id_empleado, licenciatura,costo_licenciatura)
VALUES ('EN5','E11',1,21000);


-----HABITACIONES----
INSERT INTO Habitaciones(id_habitacion, numero_habitacion , descripcion, disponibilidad)
VALUES ('HAB1',1 ,'Primer Piso',1);

INSERT INTO Habitaciones(id_habitacion, numero_habitacion , descripcion, disponibilidad)
VALUES('HAB2', 2, 'Segundo Piso',0);

INSERT INTO Habitaciones(id_habitacion, numero_habitacion , descripcion, disponibilidad)
VALUES('HAB3',3, 'Tercer Piso',1);

INSERT INTO Habitaciones(id_habitacion, numero_habitacion , descripcion, disponibilidad)
VALUES('HAB4',4, 'Cuarto Piso',0);

INSERT INTO Habitaciones(id_habitacion, numero_habitacion , descripcion, disponibilidad)
VALUES('HAB5',5, 'Quinto Piso',1);
-------TIPO_SALA-----
INSERT INTO Tipo_Sala(descripcion)
VALUES ('Sala de Emergencia');

INSERT INTO Tipo_Sala(descripcion)
VALUES('Sala de Espera');

INSERT INTO Tipo_Sala(descripcion)
VALUES('Sala de Enfermeria');

INSERT INTO Tipo_Sala(descripcion)
VALUES('Sala de niños');

INSERT INTO Tipo_Sala(descripcion)
VALUES('Sala de Parto');


--------CLINICA-----
INSERT INTO Clinica(id_clinica, numero_clinica, descripcion)
VALUES ('CL1',1 ,'Primer Piso');

INSERT INTO Clinica(id_clinica, numero_clinica, descripcion)
VALUES('CL2', 2, 'Segundo Piso');

INSERT INTO Clinica(id_clinica, numero_clinica, descripcion)
VALUES('CL3',3, 'Tercer Piso');

INSERT INTO Clinica(id_clinica, numero_clinica, descripcion)
VALUES('CL4',4, 'Cuarto Piso');

INSERT INTO Clinica(id_clinica, numero_clinica, descripcion)
VALUES('CL5',5, 'Quinto Piso');

--------SALAS----
INSERT INTO Salas(id_tipo_sala,id_habitacion, id_clinica, descripcion)
VALUES (1,'HAB1','CL1' ,'Primer Piso');

INSERT INTO Salas(id_tipo_sala,id_habitacion, id_clinica, descripcion)
VALUES (2,'HAB2','CL2','Segundo Piso');

INSERT INTO Salas(id_tipo_sala,id_habitacion, id_clinica, descripcion)
VALUES (3,'HAB3','CL3', 'Tercer Piso');

INSERT INTO Salas(id_tipo_sala,id_habitacion, id_clinica, descripcion)
VALUES (4,'HAB4','CL4', 'Cuarto Piso');

INSERT INTO Salas(id_tipo_sala,id_habitacion, id_clinica, descripcion)
VALUES (5,'HAB5','CL5', 'Quinto Piso');

------------ENFERMEDADES BASE_ALERGIAS----------
INSERT INTO Enfermedades_Base_Alergias(enfermedad_alergia , descripcion )
VALUES (0,'Presion Alta');

INSERT INTO Enfermedades_Base_Alergias(enfermedad_alergia , descripcion )
VALUES (1, 'Presion Baja');

INSERT INTO Enfermedades_Base_Alergias(enfermedad_alergia , descripcion )
VALUES (0, 'Diabetes');

INSERT INTO Enfermedades_Base_Alergias(enfermedad_alergia , descripcion )
VALUES (1, 'Obesidad ');

INSERT INTO Enfermedades_Base_Alergias(enfermedad_alergia , descripcion )
VALUES (0, 'Asma');

------PROCEDIMIENTOS-----
INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Primera Cita medicina general',800);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Segimientos de Citas generales',600);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Citas de Recuperacion',900);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Citas con Especialista',1000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Cirugias de emergencia',80000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Cirugias',70000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Exámenes de diagnóstico por imagen',2000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Endoscópicos',3000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Parto y atención obstétrica',4000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Procedimientos de rehabilitación',4000);

INSERT INTO Procedimientos( descripcion, precio )
VALUES ('Quimioterapia y radioterapia',30000);




------RECETAS------
INSERT INTO Recetas( descripcion_recetas, id_paciente, id_medico, fecha_emicion)
VALUES('Tomar 1 tableta de Paracetamol (500 mg) cada 6 horas con un vaso de agua, después de las comidas', 'PA1', 'M1', TO_DATE('2023/08/08','YYYY-MM-DD'));

INSERT INTO Recetas( descripcion_recetas, id_paciente, id_medico, fecha_emicion)
VALUES('Tomar 1 tableta de Ibuprofeno (500 mg) cada 8 horas con un vaso de agua', 'PA2', 'M1', TO_DATE('2023/08/08','YYYY-MM-DD'));

INSERT INTO Recetas( descripcion_recetas, id_paciente, id_medico, fecha_emicion)
VALUES('Tomar 2 tableta de Acetaminofen (250 mg) cada 8 horas con un vaso de agua', 'PA3', 'M2', TO_DATE('2023/08/08','YYYY-MM-DD'));

INSERT INTO Recetas( descripcion_recetas, id_paciente, id_medico, fecha_emicion)
VALUES('Tomar 1 tableta de Pracetamol(2500 mg) cada 6 horas con un vaso de agua, despues de cada comida', 'PA4', 'M2',TO_DATE( '2023/08/08','YYYY-MM-DD'));

INSERT INTO Recetas( descripcion_recetas, id_paciente, id_medico, fecha_emicion)
VALUES('Tomar 1 tableta de Enlapril (500 mg) cada 24 horas', 'PA5', 'M4',TO_DATE( '2023/08/08','YYYY-MM-DD'));


--------PADECIMIENTOS--------
INSERT INTO  Padecimientos(descripcion)
VALUES ('Presion Alta');

INSERT INTO  Padecimientos(descripcion)
VALUES('Presion Bajo');

INSERT INTO  Padecimientos(descripcion)
VALUES('Tos');

INSERT INTO  Padecimientos(descripcion)
VALUES('Fiebre');

INSERT INTO  Padecimientos(descripcion)
VALUES('Gripe');


----HISTORIAL_CLINICO-------
INSERT INTO Historial_Clinico(id_paciente)
VALUES('PA1');


INSERT INTO Historial_Clinico(id_paciente)
VALUES('PA2');


INSERT INTO Historial_Clinico(id_paciente)
VALUES('PA3');


INSERT INTO Historial_Clinico(id_paciente)
VALUES('PA4');


INSERT INTO Historial_Clinico(id_paciente)
VALUES('PA5');

SELECT *FROM HISTORIAL_CLINICO
--------------EnfermedadesBA_Historial--------
INSERT INTO EnfermedadesBA_Historial(id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
VALUES(2,1,TO_DATE('2023-03-08', 'YYYY-MM-DD'),'Bajo','Padece de Presion baja');

INSERT INTO EnfermedadesBA_Historial(id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
VALUES(5,2,TO_DATE('2019-08-08', 'YYYY-MM-DD'),'Medio','Padece de Asma');

INSERT INTO EnfermedadesBA_Historial(id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
VALUES(3,4,TO_DATE('1997-12-04', 'YYYY-MM-DD'),'Alto','Padece de Diabetes');

INSERT INTO EnfermedadesBA_Historial(id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
VALUES(4,3,TO_DATE('2023-01-31', 'YYYY-MM-DD'),'Bajo','Padece de Colesterol alto');

INSERT INTO EnfermedadesBA_Historial(id_enferm_base_alergia, id_historial_clinico, fecha_inicio, grado_avance, descripcion)
VALUES(1,5,TO_DATE('2022-03-08', 'YYYY-MM-DD'),'Bajo','Padece de Presion alta');

----Preclinica-----
INSERT INTO Preclinica( id_registro, id_sala, id_historial_clinico, temperatura_corporal , pulsaciones , presion_aterial, glucosa)
VALUES ('R1',2,2,36,80,75,78);

INSERT INTO Preclinica( id_registro, id_sala, id_historial_clinico, temperatura_corporal , pulsaciones , presion_aterial, glucosa)
VALUES('R3',4,1,3,70,78,85);

INSERT INTO Preclinica( id_registro, id_sala, id_historial_clinico, temperatura_corporal , pulsaciones , presion_aterial, glucosa)
VALUES('R5',5,3,1,75,80,98);

INSERT INTO Preclinica( id_registro, id_sala, id_historial_clinico, temperatura_corporal , pulsaciones , presion_aterial, glucosa)
VALUES('R4',3,5,4,73,73,102);

INSERT INTO Preclinica( id_registro, id_sala, id_historial_clinico, temperatura_corporal , pulsaciones , presion_aterial, glucosa)
VALUES('R2',2,4,5,69,98,65);


SELECT * FROM PROCEDIMIENTOS
-----------Diagnosticos-----------
INSERT INTO Diagnosticos(id_historial_clinico , id_preclinica, id_procedimiento , descripcin_diagnostio )
VALUES(1,4,2,'Saludable');

INSERT INTO Diagnosticos(id_historial_clinico , id_preclinica, id_procedimiento , descripcin_diagnostio )
VALUES(4,4,3,'Glucosa Alta');

INSERT INTO Diagnosticos(id_historial_clinico , id_preclinica, id_procedimiento , descripcin_diagnostio )
VALUES(3,2,1,'Estable');

INSERT INTO Diagnosticos(id_historial_clinico , id_preclinica, id_procedimiento , descripcin_diagnostio )
VALUES(5,5,5,'Estable');

INSERT INTO Diagnosticos(id_historial_clinico , id_preclinica, id_procedimiento , descripcin_diagnostio )
VALUES(2,1,4,'Saludable');


SELECT*FROM DIAGNOSTICOS
--------CITAS---------
SELECT *FROM PROCEDIMIENTOS
--------CITAS---------
INSERT INTO Citas(id_paciente, id_sala , id_preclinica, id_diagnostico, mayor_edad, id_procedimiento,  id_fecha_inicio, fecha_fin )
VALUES('PA2',2,4,4,1,1, TO_DATE('2023-04-09', 'YYYY-MM-DD'),TO_DATE('2023-01-05', 'YYYY-MM-DD') );

INSERT INTO Citas(id_paciente, id_sala , id_preclinica, id_diagnostico, mayor_edad, id_procedimiento,  id_fecha_inicio, fecha_fin )
VALUES('PA4',4,5,4,0, 2,TO_DATE('2023-05-25', 'YYYY-MM-DD') ,  TO_DATE('2023-06-30', 'YYYY-MM-DD') );


INSERT INTO Citas(id_paciente, id_sala , id_preclinica, id_diagnostico, mayor_edad, id_procedimiento,  id_fecha_inicio, fecha_fin )
VALUES('PA3',5,5,6,1,3, TO_DATE('2023/07/17', 'YYYY-MM-DD'),TO_DATE('2023/09/09', 'YYYY-MM-DD') );

INSERT INTO Citas(id_paciente, id_sala , id_preclinica, id_diagnostico, mayor_edad, id_procedimiento,  id_fecha_inicio, fecha_fin )
VALUES('PA1',3,3,9,0,4,TO_DATE('2023/09/17', 'YYYY-MM-DD') ,TO_DATE('', 'YYYY-MM-DD'));

INSERT INTO Citas(id_paciente, id_sala , id_preclinica, id_diagnostico, mayor_edad, id_procedimiento,  id_fecha_inicio, fecha_fin )
VALUES('PA5',1,2,10,1,5,TO_DATE('2023/11/22', 'YYYY-MM-DD') ,TO_DATE('', 'YYYY-MM-DD'));

-------PADECIMIENTO_PACIENTE-------
-------PADECIMIENTO_PACIENTE-------
INSERT INTO  Padecimientos_Pacientes(id_padecimiento,id_historial_clinico, fecha_inicio)
VALUES (5, 1, TO_DATE('2023/06/15','YYYY-MM-DD'));

INSERT INTO  Padecimientos_Pacientes(id_padecimiento,id_historial_clinico, fecha_inicio)
VALUES(4,2,TO_DATE('2023/07/19','YYYY-MM-DD'));

INSERT INTO  Padecimientos_Pacientes(id_padecimiento,id_historial_clinico, fecha_inicio)
VALUES(3,3,TO_DATE('2023/08/20','YYYY-MM-DD'));

INSERT INTO  Padecimientos_Pacientes(id_padecimiento,id_historial_clinico, fecha_inicio)
VALUES(2,4,TO_DATE('2023/08/13','YYYY-MM-DD'));

INSERT INTO  Padecimientos_Pacientes(id_padecimiento,id_historial_clinico, fecha_inicio)
VALUES(1,5,TO_DATE('2023/08/12','YYYY-MM-DD'));

-------MEDICAMETO---------
-------MEDICAMETO---------
INSERT INTO  Medicamentos(descripcion , costo)
VALUES ('Panadol', 120.5);

INSERT INTO  Medicamentos(descripcion , costo)
VALUES('Alergil',200);

INSERT INTO  Medicamentos(descripcion , costo)
VALUES('Acetaminofen',100);

INSERT INTO  Medicamentos(descripcion , costo)
VALUES('Propranolol',300);

INSERT INTO  Medicamentos(descripcion , costo)
VALUES('Prednisona',250);
-------MEDICAMENTO_RECETA---------
-------MEDICAMENTO_RECETA---------
INSERT INTO Medicamentos_Recetas( id_medicamentos , id_recetas , 
fecha_inicio, fecha_fin , docificacion , intervalo_tiempo )
VALUES (1,10,TO_DATE('2022-12-04', 'YYYY-MM-DD'),TO_DATE('2023-01-04', 'YYYY-MM-DD'),15,30 );

INSERT INTO Medicamentos_Recetas( id_medicamentos , id_recetas , 
fecha_inicio, fecha_fin , docificacion , intervalo_tiempo )
VALUES (1,9,TO_DATE('2023-01-04', 'YYYY-MM-DD'),TO_DATE('2023-08-04', 'YYYY-MM-DD'),15,30 );

INSERT INTO Medicamentos_Recetas( id_medicamentos , id_recetas , 
fecha_inicio, fecha_fin , docificacion , intervalo_tiempo )
VALUES (2,6,TO_DATE('2023-06-04', 'YYYY-MM-DD'),TO_DATE('2023-07-04', 'YYYY-MM-DD'),15,30 );

INSERT INTO Medicamentos_Recetas( id_medicamentos , id_recetas , 
fecha_inicio, fecha_fin , docificacion , intervalo_tiempo )
VALUES (3,7,TO_DATE('2023-04-12', 'YYYY-MM-DD'),TO_DATE('2023-04-10', 'YYYY-MM-DD'),15,30 );

INSERT INTO Medicamentos_Recetas( id_medicamentos , id_recetas , 
fecha_inicio, fecha_fin , docificacion , intervalo_tiempo )
VALUES (2,8,TO_DATE('2023-08-04', 'YYYY-MM-DD'),TO_DATE('2023-10-04', 'YYYY-MM-DD'),15,30 );
SELECT *FROM RECETAS
 ---------CAI-------
 ---------CAI-------
 INSERT INTO CAI(anio_emision, fecha_vencimiento, rango_numero_autorizado, descripcion)
VALUES (2022,TO_DATE('2024-05-15', 'YYYY-MM-DD'), '1','Este numero de CAI dene de estar entere 1-200000');

 INSERT INTO CAI(anio_emision, fecha_vencimiento, rango_numero_autorizado, descripcion)
VALUES (2023,TO_DATE('2024-05-15', 'YYYY-MM-DD'), '2','Este numero de CAI dene de estar entere 1-200000');

 INSERT INTO CAI(anio_emision, fecha_vencimiento, rango_numero_autorizado, descripcion)
VALUES (2023,TO_DATE('2024-05-15', 'YYYY-MM-DD'), '3','Este numero de CAI dene de estar entere 1-200000');

 INSERT INTO CAI(anio_emision, fecha_vencimiento, rango_numero_autorizado, descripcion)
VALUES (2023,TO_DATE('2024-05-15', 'YYYY-MM-DD'), '4','Este numero de CAI dene de estar entere 1-200000');

 INSERT INTO CAI(anio_emision, fecha_vencimiento, rango_numero_autorizado, descripcion)
VALUES (2023,TO_DATE('2024-05-15', 'YYYY-MM-DD'), '5','Este numero de CAI dene de estar entere 1-200000');

 ---Datos_Factura_Preimpreso-------
 INSERT INTO Datos_Factura_Preimpreso( id_paciente , id_CAI , RTN_hospital ,direccion_hospital, telefono_hospital,
razon_denominacion , num_correlativo, fecha_limite_emicion)
VALUES ('PA1',1,09876523,'BARRIO BELLA VISTA,11 Y 12 CALLE ENTRE 6 Y OCTAVA AVENIDA,CALLE PRINCIPAL','27834567','HOSPITAL DE ESPECIALIDADES MEDICAS','A457',TO_DATE('2023-10-01', 'YYYY-MM-DD'));

 INSERT INTO Datos_Factura_Preimpreso( id_paciente , id_CAI , RTN_hospital ,direccion_hospital, telefono_hospital,
razon_denominacion , num_correlativo, fecha_limite_emicion)
VALUES('PA2',2,09876523,'BARRIO BELLA VISTA,11 Y 12 CALLE ENTRE 6 Y OCTAVA AVENIDA,CALLE PRINCIPAL','27834567','HOSPITAL DE ESPECIALIDADES MEDICAS','A457',TO_DATE('2023-10-01', 'YYYY-MM-DD'));

 INSERT INTO Datos_Factura_Preimpreso( id_paciente , id_CAI , RTN_hospital ,direccion_hospital, telefono_hospital,
razon_denominacion , num_correlativo, fecha_limite_emicion)
VALUES('PA3',3,09876523,'BARRIO BELLA VISTA,11 Y 12 CALLE ENTRE 6 Y OCTAVA AVENIDA,CALLE PRINCIPAL','27834567','HOSPITAL DE ESPECIALIDADES MEDICAS','A457',TO_DATE('2023-10-01', 'YYYY-MM-DD'));

 INSERT INTO Datos_Factura_Preimpreso( id_paciente , id_CAI , RTN_hospital ,direccion_hospital, telefono_hospital,
razon_denominacion , num_correlativo, fecha_limite_emicion)
VALUES('PA4',4,09876523,'BARRIO BELLA VISTA,11 Y 12 CALLE ENTRE 6 Y OCTAVA AVENIDA,CALLE PRINCIPAL','27834567','HOSPITAL DE ESPECIALIDADES MEDICAS','A457',TO_DATE('2023-10-01', 'YYYY-MM-DD'));

 INSERT INTO Datos_Factura_Preimpreso( id_paciente , id_CAI , RTN_hospital ,direccion_hospital, telefono_hospital,
razon_denominacion , num_correlativo, fecha_limite_emicion)
VALUES('PA5',5,09876523,'BARRIO BELLA VISTA,11 Y 12 CALLE ENTRE 6 Y OCTAVA AVENIDA,CALLE PRINCIPAL','27834567','HOSPITAL DE ESPECIALIDADES MEDICAS','A457',TO_DATE('2023-10-01', 'YYYY-MM-DD'));


----Descuentos-------
INSERT INTO Descuentos( descripcion , restriccin_edad)
VALUES ('Tercera Edad',65);

INSERT INTO Descuentos( descripcion , restriccin_edad)
VALUES('No Hay Descuento',64);
----Formas_Pago-------
INSERT INTO Formas_Pago( descripcion )
VALUES ('Efectivo');

INSERT INTO Formas_Pago( descripcion )
VALUES ('Transferencia');

INSERT INTO Formas_Pago( descripcion )
VALUES ('Tarjeta de Debito');

INSERT INTO Formas_Pago( descripcion )
VALUES ('Tarjeta de Credito');

INSERT INTO Formas_Pago( descripcion )
VALUES ('Cheque');

INSERT INTO Formas_Pago( descripcion )
VALUES ('Boton de pago');

SELECT *FROM FORMAS_PAGO

-------- Factura----------
INSERT INTO Facturas( id_preimpreso, id_cita, cant_uni_citas, id_forma_pago, impuesto,id_descuento, subtotal, total)
VALUES (1,2,3,3,12.5,1,10000,12000.5);

INSERT INTO Facturas( id_preimpreso, id_cita, cant_uni_citas, id_forma_pago, impuesto,id_descuento, subtotal, total)
VALUES (2,8,2,1,12.5,2,2500,2512.5);

INSERT INTO Facturas( id_preimpreso, id_cita, cant_uni_citas, id_forma_pago, impuesto,id_descuento, subtotal, total)
VALUES (3,2,1,2,12.5,2,1100,1112.5);

INSERT INTO Facturas( id_preimpreso, id_cita, cant_uni_citas, id_forma_pago, impuesto,id_descuento, subtotal, total)
VALUES (4,9,2,1,12.5,1,15000,15000);

INSERT INTO Facturas( id_preimpreso, id_cita, cant_uni_citas, id_forma_pago, impuesto,id_descuento, subtotal, total)
VALUES (5,13,1,4,12.5,1,1000,1000);

---------RecetasHistorial---------
INSERT INTO RecetasHistorial( id_historial_clinico , id_recetas , observaciones )
VALUES (2,6,'En Uso ');

INSERT INTO RecetasHistorial( id_historial_clinico , id_recetas , observaciones )
VALUES(3,7,'Suspendido');

INSERT INTO RecetasHistorial( id_historial_clinico , id_recetas , observaciones )
VALUES (5,8,'Suspendido');

(INSERT INTO RecetasHistorial( id_historial_clinico , id_recetas , observaciones )
VALUES (2,9,'En Uso');

INSERT INTO RecetasHistorial( id_historial_clinico , id_recetas , observaciones )
VALUES (1,8,'En Uso');
SELECT *FROM RECETASHISTORIAL

