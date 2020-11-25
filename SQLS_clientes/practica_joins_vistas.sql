
/*
--reporte acciones tabla clientes
SELECT clientes.id_persona, clientes.cedula, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM clientes
INNER JOIN registro_acciones ON clientes.id_persona = registro_acciones.id_elemento;
*/

/*
--reporte acciones tabla empresas
SELECT empresas2.id_empresa, empresas2.nombre, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM empresas2
INNER JOIN registro_acciones ON empresas2.id_empresa = registro_acciones.id_elemento;
*/

/*
SELECT clientes.id_persona, clientes.cedula, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM clientes
LEFT OUTER JOIN registro_acciones ON clientes.id_persona = registro_acciones.id_elemento;
*/

/*
--sirve para ver fecha y hora a la que se creo un usuario
SELECT clientes.id_persona, clientes.cedula, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM clientes
LEFT OUTER JOIN registro_acciones ON clientes.id_persona = registro_acciones.id_elemento  WHERE registro_acciones.accion = 'INSERT' AND clientes.id_persona = 21;
*/

/*
--reporte ids clientes y empresas
SELECT clientes.id_persona, clientes.cedula, empresas2.id_empresa,  clientes.empresa FROM clientes
LEFT OUTER JOIN empresas2 ON clientes.empresa = empresas2.nombre;
*/

/*
PRACTICA VISTAS
*/

/*
--crear vista acciones tabla clientes
CREATE VIEW REPORTE_ACCIONES_CLIENTES AS
    SELECT clientes.id_persona, clientes.cedula, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM clientes
    LEFT OUTER JOIN registro_acciones ON clientes.id_persona = registro_acciones.id_elemento  WHERE registro_acciones.tabla = 'clientes';

SELECT
    *
FROM reporte_acciones_clientes;
*/

/*
--crear vista acciones tabla empresas
CREATE VIEW REPORTE_ACCIONES_EMPRESAS AS
    SELECT empresas2.id_empresa, empresas2.nombre, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM empresas2
    LEFT OUTER JOIN registro_acciones ON empresas2.id_empresa = registro_acciones.id_elemento WHERE registro_acciones.tabla = 'empresas2';

SELECT
    *
FROM reporte_acciones_empresas;
*/

/*
--crear vista ids y nombres empresas clientes
CREATE VIEW IDS_NOMBRES AS
    SELECT clientes.id_persona, clientes.cedula, empresas2.id_empresa, empresas2.nombre FROM clientes
    LEFT OUTER JOIN empresas2 ON clientes.empresa = empresas2.nombre;

SELECT * FROM ids_nombres;
*/

/*
--crear vista ids empresas clientes
CREATE VIEW IDS AS
    SELECT clientes.id_persona, empresas2.id_empresa FROM clientes
    LEFT OUTER JOIN empresas2 ON clientes.empresa = empresas2.nombre;

SELECT * FROM ids;
*/

/*
SELECT empresas2.id_empresa, empresas2.nombre, registro_acciones.accion, registro_acciones.fecha, registro_acciones.hora FROM empresas2
INNER JOIN registro_acciones ON empresas2.id_empresa = registro_acciones.id_elemento WHERE registro_acciones.fecha >= to_date('17/11/2020', 'dd/mm/yyyy');
*/
