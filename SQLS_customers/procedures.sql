CREATE PACKAGE PROCEDURES_SET
IS
    PROCEDURE listar_empresas;
    PROCEDURE ingresar_empresa(empresa IN VARCHAR2);
    PROCEDURE eliminar_empresa(nombre_empresa IN VARCHAR2);
    PROCEDURE editar_empresa(id_emp IN NUMBER, nuevo_nombre IN VARCHAR2);
    PROCEDURE buscar_empresa(id_emp IN NUMBER);
    PROCEDURE listar_clientes;
    PROCEDURE editar_cliente(id_usuario IN NUMBER, cedula_usuario IN NUMBER, telefono_usuario IN NUMBER, direccion_usuario IN VARCHAR2,
        primer_nombre_usuario IN VARCHAR2, segundo_nombre_usuario IN VARCHAR2, primer_apellido_usuario IN VARCHAR2,
        segundo_apellido_usuario IN VARCHAR2, empresa_usuario IN VARCHAR2, estatus_usuario IN VARCHAR2);
    PROCEDURE eliminar_cliente(id_usuario IN NUMBER);
    PROCEDURE insertar_cliente(cedula IN NUMBER, telefono IN NUMBER, direccion IN VARCHAR2,
        primer_nombre IN VARCHAR2, segundo_nombre IN VARCHAR2, primer_apellido IN VARCHAR2,
        segundo_apellido IN VARCHAR2, empresa IN VARCHAR2, estatus IN VARCHAR2);
    PROCEDURE buscar_cliente(id_usuario IN NUMBER);
    PROCEDURE reporte_total_numero_clientes;
    PROCEDURE reporte_por_empresa(nombre_empresa IN VARCHAR2);
END;
/
CREATE PACKAGE BODY PROCEDURES_SET
IS

    /*
    procedimientos para listar, insertar, editar o eliminar empresa
    */
    
    PROCEDURE listar_empresas
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.listar_empresas();
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END listar_empresas;
      
    PROCEDURE ingresar_empresa(empresa IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
         respuesta := FUNCTIONS_SET.insertar_empresa(empresa);
         DBMS_OUTPUT.PUT_LINE(respuesta);
    END ingresar_empresa;
    
    PROCEDURE eliminar_empresa(nombre_empresa IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.eliminar_empresa(nombre_empresa);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END eliminar_empresa;
    
    PROCEDURE editar_empresa(id_emp IN NUMBER, nuevo_nombre IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.editar_empresa(id_emp, nuevo_nombre);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END editar_empresa;
    
    PROCEDURE buscar_empresa(id_emp IN NUMBER)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.buscar_empresa(id_emp);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END buscar_empresa;
    
    /*
    procedimientos para listar, insertar, editar o eliminar usuario
    */
    
    PROCEDURE listar_clientes
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.listar_clientes();
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END listar_clientes;
    
    PROCEDURE insertar_cliente(cedula IN NUMBER, telefono IN NUMBER, direccion IN VARCHAR2,
        primer_nombre IN VARCHAR2, segundo_nombre IN VARCHAR2, primer_apellido IN VARCHAR2,
        segundo_apellido IN VARCHAR2, empresa IN VARCHAR2, estatus IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.insertar_cliente(cedula, telefono, direccion,  primer_nombre,
            segundo_nombre, primer_apellido, segundo_apellido, empresa, estatus);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END insertar_cliente;
    
    PROCEDURE eliminar_cliente(id_usuario IN NUMBER)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.eliminar_cliente(id_usuario);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END eliminar_cliente;
    
     PROCEDURE editar_cliente(id_usuario IN NUMBER, cedula_usuario IN NUMBER, telefono_usuario IN NUMBER, direccion_usuario IN VARCHAR2,
        primer_nombre_usuario IN VARCHAR2, segundo_nombre_usuario IN VARCHAR2, primer_apellido_usuario IN VARCHAR2,
        segundo_apellido_usuario IN VARCHAR2, empresa_usuario IN VARCHAR2, estatus_usuario IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.editar_cliente(id_usuario, cedula_usuario, telefono_usuario, direccion_usuario,  primer_nombre_usuario,
            segundo_nombre_usuario, primer_apellido_usuario, segundo_apellido_usuario, empresa_usuario, estatus_usuario);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END editar_cliente;
    
    PROCEDURE buscar_cliente(id_usuario IN NUMBER)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.buscar_cliente(id_usuario);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END buscar_cliente;
    
    PROCEDURE reporte_total_numero_clientes
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.reporte_total_numero_clientes();
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END reporte_total_numero_clientes;
    
    PROCEDURE reporte_por_empresa(nombre_empresa IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := FUNCTIONS_SET.reporte_por_empresa(nombre_empresa);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END reporte_por_empresa;
    
END PROCEDURES_SET;

