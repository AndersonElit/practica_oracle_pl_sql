CREATE TABLE clientes(
    id_persona NUMBER,
    cedula NUMBER PRIMARY KEY,
    telefono NUMBER NOT NULL,
    direccion VARCHAR2(150) NOT NULL,
    primer_nombre VARCHAR2(150) NOT NULL,
    segundo_nombre VARCHAR2(150),
    primer_apellido VARCHAR2(150) NOT NULL,
    segundo_apellido VARCHAR2(150) ,
    empresa VARCHAR2(150) NOT NULL,
    estatus VARCHAR2(10) NOT NULL,
    FOREIGN KEY (empresa) REFERENCES empresas2(nombre)
);