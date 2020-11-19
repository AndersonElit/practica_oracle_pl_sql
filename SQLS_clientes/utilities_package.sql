CREATE PACKAGE UTILITIES
IS
    PROCEDURE listar_empresas;
    PROCEDURE insertar_empresa(empresa IN VARCHAR2);
    PROCEDURE eliminar_empresa(nombre_empresa IN VARCHAR2);
    PROCEDURE editar_empresa(id_emp IN NUMBER, nuevo_nombre IN VARCHAR2);
    PROCEDURE buscar_empresa(id_emp IN NUMBER);
    PROCEDURE listar_clientes;
    PROCEDURE insertar_cliente(cedula IN NUMBER, telefono IN NUMBER, direccion IN VARCHAR2,
        primer_nombre IN VARCHAR2, segundo_nombre IN VARCHAR2, primer_apellido IN VARCHAR2,
        segundo_apellido IN VARCHAR2, empresa IN VARCHAR2, estatus IN VARCHAR2);
    PROCEDURE eliminar_cliente(id_usuario IN NUMBER);
    PROCEDURE editar_cliente(id_usuario IN NUMBER, cedula_usuario IN NUMBER, telefono_usuario IN NUMBER, direccion_usuario IN VARCHAR2,
        primer_nombre_usuario IN VARCHAR2, segundo_nombre_usuario IN VARCHAR2, primer_apellido_usuario IN VARCHAR2,
        segundo_apellido_usuario IN VARCHAR2, empresa_usuario IN VARCHAR2, estatus_usuario IN VARCHAR2);
    PROCEDURE buscar_cliente(id_usuario IN NUMBER);
    PROCEDURE reporte_total_numero_clientes;
    PROCEDURE reporte_por_empresa(id_e IN NUMBER);
END;
/
CREATE PACKAGE BODY UTILITIES
IS

    /*
    FUNCTIONS
    */
    
    --functions to companies
    
    FUNCTION listar_empresas RETURN VARCHAR2
    IS
        CURSOR lista_empresas IS SELECT * FROM empresas2 ORDER BY nombre ASC;
        respuesta VARCHAR2(100);
        counter NUMBER := 0;
    BEGIN
        FOR n IN lista_empresas LOOP
            DBMS_OUTPUT.PUT_LINE('id: ' || n.id_empresa || ', nombre: ' || n.nombre || chr(13));
            counter := counter + 1;
        END LOOP;
        --respuesta := 'total de registros: ' || counter;
        respuesta := '';
        RETURN respuesta;
    END listar_empresas;
    
    FUNCTION insertar_empresa (nombre_empresa VARCHAR2)
    RETURN VARCHAR2
    IS
        respuesta VARCHAR2(100);
    BEGIN
        INSERT INTO empresas2 (nombre) VALUES (nombre_empresa);
        respuesta := 'La empresa ' || nombre_empresa || ' se inserto con exito';
        RETURN respuesta;
    EXCEPTION
        --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
        WHEN DUP_VAL_ON_INDEX THEN
            respuesta := 'La empresa ' || nombre_empresa || ' ya existe.';
            RETURN respuesta;
    END insertar_empresa;
    
    FUNCTION eliminar_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2
    --eliminar empresa metodo 2(exceptios)
    IS
        integrity_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (integrity_err, -2292);
        contar_e NUMBER;
        respuesta VARCHAR2(100);
    BEGIN
        --eliminar empresa
        SELECT COUNT(*) INTO contar_e FROM empresas2 WHERE nombre = nombre_empresa;
        IF contar_e = 0 THEN
            respuesta := 'la empresa no existe';
            RETURN respuesta;
        ELSE
            DELETE FROM empresas2 WHERE nombre = nombre_empresa;
            respuesta := 'La empresa ' || nombre_empresa || ' se elimino de la tabla.';
            RETURN respuesta;
        END IF;
    EXCEPTION
        --ORA-02292: restricción de integridad (SYSTEM.SYS_C0011234) violada - registro secundario encontrado
        WHEN integrity_err THEN
            respuesta := 'no se pudo eliminar la empresa, hay usuario(s) asociados a esta.';
            RETURN respuesta;
    END eliminar_empresa;
    
    FUNCTION editar_empresa(id_emp NUMBER, nuevo_nombre VARCHAR2) RETURN VARCHAR2
    IS
        integrity_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (integrity_err, -2292);
        empresa empresas.nombre%TYPE;
        respuesta VARCHAR2(250);
    BEGIN
        --buscar nombre empresa
        SELECT nombre INTO empresa FROM empresas2 WHERE  id_empresa = id_emp;
        --actualizar nombre
        UPDATE empresas2 SET nombre =  nuevo_nombre WHERE id_empresa = id_emp;
        respuesta := 'la empresa ' || empresa || ' fue actualizada a ' || nuevo_nombre;
        RETURN respuesta;
    EXCEPTION
        --ORA-02292: restricción de integridad (SYSTEM.SYS_C0011234) violada - registro secundario encontrado
        WHEN integrity_err THEN
            respuesta := 'la empresa '|| empresa || ' no se pudo actualizar a ' || nuevo_nombre ||', hay usuario(s) asociados a esta.';
            RETURN respuesta;
        --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
        WHEN DUP_VAL_ON_INDEX THEN
            respuesta := 'La empresa ' || nuevo_nombre || ' ya se encuentra en la tabla.';
            RETURN respuesta;
        WHEN NO_DATA_FOUND THEN
            respuesta := 'la empresa no existe.';
            RETURN respuesta;
    END editar_empresa;
    
    FUNCTION buscar_empresa(id_emp NUMBER) RETURN VARCHAR2
    IS
        empresa empresas%ROWTYPE;
        respuesta VARCHAR2(100);
    BEGIN
        SELECT * INTO empresa FROM empresas2 WHERE id_empresa = id_emp;
        respuesta := 'id: ' || empresa.id_empresa || ', ' || 'nombre: ' || empresa.nombre;
        RETURN respuesta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            respuesta := 'la empresa no existe.';
            RETURN respuesta;
    END buscar_empresa;
    
    --fuctions to customers
    
    FUNCTION listar_clientes RETURN VARCHAR2
    IS
        CURSOR lista_clientes IS SELECT * FROM clientes ORDER BY primer_nombre ASC;
        respuesta VARCHAR2(100);
        counter NUMBER := 0;
    BEGIN
        FOR n IN lista_clientes LOOP
            DBMS_OUTPUT.PUT_LINE('id: ' || n.id_persona || chr(13) || 'cedula: ' || n.cedula || chr(13) || 'telefono: ' ||
                n.telefono || chr(13) || 'direccion: ' || n.direccion || chr(13) || 'primer nombre: ' || n.primer_nombre ||
                chr(13) || 'segundo nombre: ' || n.segundo_nombre || chr(13) || 'primer apellido: ' || n.primer_apellido ||
                chr(13) || 'segundo apellido: ' || n.segundo_apellido || chr(13) || 'empresa: ' || n.empresa || chr(13) || 'estatus: ' ||
                n.estatus || chr(13) || chr(13));
            counter := counter + 1;
        END LOOP;
        respuesta := '';
        RETURN respuesta;
    END listar_clientes;
    
    FUNCTION insertar_cliente(cedula_usuario NUMBER, telefono NUMBER, direccion VARCHAR2,
        primer_nombre VARCHAR2, segundo_nombre VARCHAR2, primer_apellido VARCHAR2,
        segundo_apellido VARCHAR2, empresa VARCHAR2, estatus VARCHAR2) RETURN VARCHAR2
    IS
        null_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (null_err, -1400);
        id_e NUMBER;
        id_cl NUMBER;
        respuesta VARCHAR2(100);
        respuesta2 VARCHAR2(100);
    BEGIN
        --insertar empresa
        respuesta2 := insertar_empresa(empresa);
        --insertar dato en tabla clientes
        INSERT INTO clientes (cedula, telefono, direccion, primer_nombre, segundo_nombre,
            primer_apellido, segundo_apellido, empresa, estatus)
        VALUES (cedula_usuario, telefono, direccion, primer_nombre, segundo_nombre, primer_apellido,
            segundo_apellido, empresa, estatus);
        --insertar id_empresa id_cliente en tabla empresas_clientes
        SELECT id_empresa INTO id_e FROM empresas2 WHERE nombre = empresa;
        SELECT id_persona INTO id_cl FROM clientes WHERE cedula = cedula_usuario;
        INSERT INTO empresas_clientes (id_empr, id_cli) VALUES (id_e, id_cl);
        respuesta := respuesta2 || ', ' || 'El usuario se ingreso de forma exitosa';
        RETURN respuesta;
    EXCEPTION
        --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
        WHEN DUP_VAL_ON_INDEX THEN
            respuesta := 'ya hay un usuario registrado con el numero de cedula ' || cedula_usuario;
            respuesta2 := eliminar_Empresa(empresa);
            RETURN respuesta2 || ', ' || respuesta;
        WHEN null_err THEN
            --ORA-01400: no se puede realizar una inserción NULL
            respuesta := 'debes completar todos los campos.';
            RETURN respuesta;
    END insertar_cliente;
    
    FUNCTION eliminar_cliente(id_usuario NUMBER) RETURN VARCHAR2
    IS
        nombre_empresa customers.empresa%TYPE;
        respuesta VARCHAR2(250);
        respuesta2 VARCHAR2(250);
    BEGIN
        --extraer nombre empresa
        SELECT empresa INTO nombre_empresa FROM clientes WHERE id_persona = id_usuario;
        --eliminar usuario
        DELETE FROM clientes WHERE id_persona = id_usuario;
        DELETE FROM empresas_clientes WHERE id_cli = id_usuario;
        --eliminar empresa
        respuesta2 := eliminar_empresa(nombre_empresa);
        respuesta := respuesta2 || ', ' || 'El usuario se elimino de forma exitosa';
        RETURN respuesta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            respuesta := 'el usuario no existe.';
            RETURN respuesta;
    END eliminar_cliente;
    
    FUNCTION editar_cliente(id_usuario NUMBER, cedula_usuario NUMBER, telefono_usuario NUMBER,
        direccion_usuario VARCHAR2, primer_nombre_usuario VARCHAR2, segundo_nombre_usuario VARCHAR2, 
        primer_apellido_usuario VARCHAR2, segundo_apellido_usuario VARCHAR2, empresa_usuario VARCHAR2, estatus_usuario VARCHAR2) 
        RETURN VARCHAR2
    IS
        null_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (null_err, -1407);
        nombre_emp VARCHAR2(100);
        id_e NUMBER;
        respuesta VARCHAR2(250);
        respuesta2 VARCHAR2(100);
        respuesta3 VARCHAR2(100);
    BEGIN
        SELECT empresa INTO nombre_emp FROM clientes WHERE id_persona = id_usuario;
        respuesta2 := insertar_empresa (empresa_usuario);
        --actualizar usuario
        UPDATE clientes
        SET cedula = cedula_usuario, telefono = telefono_usuario, direccion = direccion_usuario,
            primer_nombre = primer_nombre_usuario, segundo_nombre = segundo_nombre_usuario,
            primer_apellido = primer_apellido_usuario, segundo_apellido = segundo_apellido_usuario, empresa = empresa_usuario,
            estatus = estatus_usuario
        WHERE id_persona = id_usuario;
        --actualizar empresa
        SELECT id_empresa INTO id_e FROM empresas2 WHERE nombre = empresa_usuario;
        UPDATE empresas_clientes SET id_empr = id_e WHERE id_cli = id_usuario;
        --eliminar empresa antigua
        respuesta3 := eliminar_empresa(nombre_emp);
        respuesta := respuesta2 || ', ' || respuesta3 || ', el usuario se edito de forma exitosa';
        RETURN respuesta;
    EXCEPTION
        --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
        WHEN DUP_VAL_ON_INDEX THEN
            respuesta := 'La cedula que estas tratando de ingresar ya la posee otro usuario.';
            RETURN respuesta;
        WHEN NO_DATA_FOUND THEN
            respuesta := 'el id  no tiene un usuario asociado.';
            RETURN respuesta;
        --ORA-01400: no se puede realizar una inserción NULL
        WHEN null_err THEN
            respuesta := 'debes completar todos los campos.';
            RETURN respuesta;
    END editar_cliente;
    
    FUNCTION buscar_cliente(id_usuario NUMBER) RETURN VARCHAR2
    IS
        registro customers%ROWTYPE;
        respuesta VARCHAR2(100);
    BEGIN
        --recuperar el usuario de la tabla
        SELECT * INTO registro FROM clientes WHERE id_persona = id_usuario;
        DBMS_OUTPUT.PUT_LINE('id: ' || registro.id_persona || chr(13) || 'cedula: ' || registro.cedula || chr(13) ||
            'telefono: ' || registro.telefono || chr(13) || 'direccion: ' || registro.direccion || chr(13) || 'primer nombre: '
            || registro.primer_nombre || chr(13) || 'segundo nombre: ' || registro.segundo_nombre || chr(13) ||
            'primer apellido: ' || registro.primer_apellido || chr(13) || 'segundo apellido: ' || registro.segundo_apellido
            || chr(13) || 'empresa: ' || registro.empresa || chr(13) || 'estatus: ' || registro.estatus);
        respuesta := '';
        RETURN respuesta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            respuesta := 'el usuario no existe.';
            RETURN respuesta;
    END buscar_cliente;
    
    FUNCTION reporte_total_numero_clientes RETURN VARCHAR2
    IS
        CURSOR nombre_empresas IS SELECT * FROM empresas2 ORDER BY nombre ASC;
        numero_clientes NUMBER := 0;
    BEGIN
        FOR i IN nombre_empresas LOOP
            SELECT COUNT(*) INTO numero_clientes FROM empresas_clientes WHERE id_empr = i.id_empresa;
            DBMS_OUTPUT.PUT_LINE(i.nombre || ': ' || numero_clientes || chr(13));
            numero_clientes := 0;
        END LOOP;
        RETURN '';
    END reporte_total_numero_clientes;
    
    FUNCTION reporte_por_empresa(id_e NUMBER) RETURN VARCHAR2
    IS
        numero_clientes NUMBER := 0;
        nombre_e VARCHAR2(100);
        contar_e NUMBER;
        respuesta VARCHAR2(100);
    BEGIN
        SELECT COUNT(*) INTO contar_e FROM empresas2 WHERE id_empresa = id_e;
        IF contar_e = 0 THEN
            respuesta := 'La empresa no existe.';
            RETURN respuesta;
        ELSE
            SELECT nombre INTO nombre_e FROM empresas2 WHERE id_empresa = id_e;
            SELECT COUNT(*) INTO numero_clientes FROM empresas_clientes WHERE id_empr = id_e;
            respuesta := 'numero de clientes que trabajan en ' || nombre_e || ': ' || numero_clientes;
            RETURN respuesta;
        END IF;        
    END reporte_por_empresa;
    
    /*
    PROCEDURES
    */
    
    --procedures to companies
    
    PROCEDURE listar_empresas
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := listar_empresas();
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END listar_empresas;
    
    PROCEDURE insertar_empresa(empresa IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
         respuesta := insertar_empresa(empresa);
         DBMS_OUTPUT.PUT_LINE(respuesta);
    END insertar_empresa;
    
    PROCEDURE eliminar_empresa(nombre_empresa IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := eliminar_empresa(nombre_empresa);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END eliminar_empresa;
    
    PROCEDURE editar_empresa(id_emp IN NUMBER, nuevo_nombre IN VARCHAR2)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := editar_empresa(id_emp, nuevo_nombre);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END editar_empresa;
    
    PROCEDURE buscar_empresa(id_emp IN NUMBER)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := buscar_empresa(id_emp);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END buscar_empresa;
    
    --procedures to customers
    
    PROCEDURE listar_clientes
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := listar_clientes();
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END listar_clientes;
    
    PROCEDURE insertar_cliente(cedula IN NUMBER, telefono IN NUMBER, direccion IN VARCHAR2,
        primer_nombre IN VARCHAR2, segundo_nombre IN VARCHAR2, primer_apellido IN VARCHAR2,
        segundo_apellido IN VARCHAR2, empresa IN VARCHAR2, estatus IN VARCHAR2)
    AS
        respuesta VARCHAR2(200);
    BEGIN
        respuesta := insertar_cliente(cedula, telefono, direccion,  primer_nombre,
            segundo_nombre, primer_apellido, segundo_apellido, empresa, estatus);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END insertar_cliente;
    
    PROCEDURE eliminar_cliente(id_usuario IN NUMBER)
    AS
        respuesta VARCHAR2(200);
    BEGIN
        respuesta := eliminar_cliente(id_usuario);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END eliminar_cliente;
    
    PROCEDURE editar_cliente(id_usuario IN NUMBER, cedula_usuario IN NUMBER, telefono_usuario IN NUMBER, direccion_usuario IN VARCHAR2,
        primer_nombre_usuario IN VARCHAR2, segundo_nombre_usuario IN VARCHAR2, primer_apellido_usuario IN VARCHAR2,
        segundo_apellido_usuario IN VARCHAR2, empresa_usuario IN VARCHAR2, estatus_usuario IN VARCHAR2)
    AS
        respuesta VARCHAR2(200);
    BEGIN
        respuesta := editar_cliente(id_usuario, cedula_usuario, telefono_usuario, direccion_usuario,  primer_nombre_usuario,
            segundo_nombre_usuario, primer_apellido_usuario, segundo_apellido_usuario, empresa_usuario, estatus_usuario);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END editar_cliente;
    
    PROCEDURE buscar_cliente(id_usuario IN NUMBER)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := buscar_cliente(id_usuario);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END buscar_cliente;
    
    PROCEDURE reporte_total_numero_clientes
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := reporte_total_numero_clientes();
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END reporte_total_numero_clientes;
    
     PROCEDURE reporte_por_empresa(id_e IN NUMBER)
    AS
        respuesta VARCHAR2(100);
    BEGIN
        respuesta := reporte_por_empresa(id_e);
        DBMS_OUTPUT.PUT_LINE(respuesta);
    END reporte_por_empresa;
    
END UTILITIES;