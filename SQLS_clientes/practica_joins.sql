
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

