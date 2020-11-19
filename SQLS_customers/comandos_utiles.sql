/*
INSERT INTO customers (cedula, telefono, direccion, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, empresa, estatus)
VALUES (70343560, 3503234569, 'calle 50 # 23-42', 'andres', 'antonio', 'muñoz', 'peralta', 'coltefinanciera', 'activo')

INSERT INTO customers (cedula, telefono, direccion, primer_nombre, primer_apellido, empresa, estatus)
VALUES (1045343562, 3503234572, 'calle 50 # 23-45', 'andres',  'muñoz', 'coltefinanciera', 'activo')
*/
--SELECT * FROM USER_TRIGGERS ;
--INSERT INTO empresas (nombre) VALUES ('coltefinanciera');
--SELECT * FROM empresas;
--SELECT * FROM customers;

--SELECT * FROM customers;
--SELECT * FROM empresas;

--SET SERVEROUTPUT ON
/*
ver paquetes:
SELECT * FROM USER_PROCEDURES WHERE OBJECT_TYPE='PACKAGE';
*/

/*

--probar funcion
SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.insertar_empresa('personalsoft');
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.eliminar_empresa(1);
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.editar_empresa(186, 'coltefinanciera');
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.buscar_empresa(81);
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.insertar_cliente(71234569, 312469890, 'calle 45 sur # 34-58',
        'ricardo', '', 'perez', '', 'apple', 'inactivo');
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.eliminar_cliente(85);
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.listar_clientes();
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(250);
BEGIN
    respuesta := FUNCTIONS_SET.editar_cliente(101, 32145600, 312469893, 'calle 45 sur # 34-58',
        'ricardo', '', 'vasquez', '', 'microsoft', 'inactivo');
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.buscar_cliente(100);
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.reporte_total_numero_clientes();
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.reporte_total_numero_clientes();
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

SET SERVEROUTPUT ON
DECLARE
    respuesta VARCHAR2(100);
BEGIN
    respuesta := FUNCTIONS_SET.reporte_por_empresa('tata');
    DBMS_OUTPUT.PUT_LINE(respuesta);
END;

*/

/*
--eliminar paquete:
DROP PACKAGE FUNCTIONS_SET;
DROP PACKAGE PROCEDURES_SET;
*/

/*
--ejecutar un procedimiento almacenado
SET SERVEROUTPUT ON
CALL PROCEDURES_SET.ingresar_empresa('google');

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.editar_empresa(22, 'facebook');

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.buscar_empresa(61);

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.eliminar_cliente(3);

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.listar_clientes();

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.buscar_cliente(82);

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.eliminar_empresa(84);

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.insertar_cliente(71234563, 312469890, 'calle 45 sur # 34-58',
        'ricardo', '', 'perez', '', 'coltefinanciera', 'inactivo');
        
SET SERVEROUTPUT ON
CALL PROCEDURES_SET.editar_cliente(123, 71234563, 312469892, 'calle 45 sur # 34-58',
        'ricardo', '', 'perez', '', 'microsoft', 'activo');
        
SET SERVEROUTPUT ON
CALL PROCEDURES_SET.reporte_total_numero_clientes();

SET SERVEROUTPUT ON
CALL PROCEDURES_SET.reporte_por_empresa('apple');

*/

/*
SET SERVEROUTPUT ON
DECLARE
    fecha DATE := SYSDATE;
    --hora TIMESTAMP := SYSTIMESTAMP;
    hora VARCHAR2(100);
BEGIN
    hora := TO_CHAR(sysdate, 'HH24') || ':' || TO_CHAR(sysdate, 'MI');
    DBMS_OUTPUT.PUT_LINE(fecha);
    DBMS_OUTPUT.PUT_LINE(hora);
END;
*/

/*
--Mostrar error
WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            respuesta := '';
            RETURN respuesta;
*/
