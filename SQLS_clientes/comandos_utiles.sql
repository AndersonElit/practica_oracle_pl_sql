/*
SET SERVEROUTPUT ON
CALL utilities.listar_empresas();
*/

--DROP PACKAGE utilities;

--DROP TRIGGER acciones_en_tabla_empresas2;

/*
SET SERVEROUTPUT ON
CALL utilities.insertar_empresa('tata');
*/

/*
SET SERVEROUTPUT ON
CALL utilities.eliminar_empresa('tata');
*/

/*
SET SERVEROUTPUT ON
CALL utilities.editar_empresa(2, 'google');
*/

/*
SET SERVEROUTPUT ON
CALL utilities.buscar_empresa(2);
*/

/*
SET SERVEROUTPUT ON
CALL utilities.listar_clientes();
*/

/*
SET SERVEROUTPUT ON
CALL utilities.insertar_cliente(32456782, 312469892, 'calle 45 sur # 34-53',
    'manuel', 'alonso', 'gomez', '', 'apple', 'inactivo');
*/

/*
SET SERVEROUTPUT ON
CALL utilities.eliminar_cliente(26);
*/

--DELETE FROM clientes WHERE id_persona = 1;
--DELETE FROM empresas2 WHERE id_empresa = 1;

/*
SET SERVEROUTPUT ON
CALL utilities.editar_cliente(24, 32456782, 312469892, 'calle 45 sur # 34-53',
    'manuel', 'alonso', 'gomez', '', 'coltefinanciera', 'inactivo');
*/

/*
SET SERVEROUTPUT ON
CALL utilities.buscar_cliente(25);
*/

/*
SET SERVEROUTPUT ON
CALL utilities.reporte_total_numero_clientes();
*/

/*
SET SERVEROUTPUT ON
CALL utilities.reporte_por_empresa(44);
*/

/*
SET SERVEROUTPUT ON
CALL utilities.consultar_creacion_cliente(25);
*/
