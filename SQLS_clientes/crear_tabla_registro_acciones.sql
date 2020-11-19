CREATE TABLE registro_acciones(
    id_accion NUMBER,
    accion VARCHAR2(150) NOT NULL,
    id_elemento NUMBER NOT NULL,
    tabla VARCHAR2(150) NOT NULL,
    fecha DATE NOT NULL,
    hora VARCHAR2(100) NOT NULL
);