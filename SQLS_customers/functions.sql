CREATE PACKAGE FUNCTIONS_SET
IS
    FUNCTION listar_empresas RETURN VARCHAR2;
    FUNCTION insertar_empresa (nombre_empresa VARCHAR2) RETURN VARCHAR2;
    FUNCTION eliminar_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2;
    FUNCTION editar_empresa(id_emp NUMBER, nuevo_nombre VARCHAR2) RETURN VARCHAR2;
    FUNCTION buscar_empresa(id_emp NUMBER) RETURN VARCHAR2;
    FUNCTION listar_clientes RETURN VARCHAR2;
    FUNCTION insertar_cliente(cedula_usuario NUMBER, telefono NUMBER, direccion VARCHAR2,
        primer_nombre VARCHAR2, segundo_nombre VARCHAR2, primer_apellido VARCHAR2,
        segundo_apellido VARCHAR2, empresa VARCHAR2, estatus VARCHAR2) RETURN VARCHAR2;
    FUNCTION eliminar_cliente(id_usuario NUMBER) RETURN VARCHAR2;
    FUNCTION editar_cliente(id_usuario NUMBER, cedula_usuario NUMBER, telefono_usuario NUMBER,
        direccion_usuario VARCHAR2, primer_nombre_usuario VARCHAR2, segundo_nombre_usuario VARCHAR2, 
        primer_apellido_usuario VARCHAR2, segundo_apellido_usuario VARCHAR2, empresa_usuario VARCHAR2, estatus_usuario VARCHAR2) 
        RETURN VARCHAR2;
    FUNCTION buscar_cliente(id_usuario NUMBER) RETURN VARCHAR2;
    FUNCTION reporte_total_numero_clientes RETURN VARCHAR2;
    FUNCTION reporte_por_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2;
END;
/
CREATE PACKAGE BODY FUNCTIONS_SET
IS

    /*
    funciones para listar, insertar, editar o eliminar empresa
    */
    
    --listar empresas
    FUNCTION listar_empresas RETURN VARCHAR2
    IS
        CURSOR lista_empresas IS SELECT * FROM empresas ORDER BY nombre ASC;
        respuesta VARCHAR2(100);
        counter NUMBER := 0;
    BEGIN
        FOR n IN lista_empresas LOOP
            DBMS_OUTPUT.PUT_LINE('id: ' || n.id_empresa || ', nombre: ' || n.nombre || chr(13));
            counter := counter + 1;
        END LOOP;
        respuesta := 'total de registros: ' || counter;
        RETURN respuesta;
    END listar_empresas;
    
    --insertar nueva empresa metodo 1 (SELECT COUNT(*))
    /*
    FUNCTION insertar_empresa (nombre_empresa VARCHAR2) RETURN VARCHAR2
    IS
        empresa_existe NUMBER := 0;
        respuesta VARCHAR2(100);
    BEGIN
        --determinar si empresa existe
        SELECT COUNT(*) INTO empresa_existe FROM empresas WHERE nombre = nombre_empresa;
        IF empresa_existe = 0 THEN
            INSERT INTO empresas (nombre) VALUES (nombre_empresa);
            respuesta := 'La empresa ' || nombre_empresa || ' se inserto con exito';
            RETURN respuesta;
        ELSE
            respuesta := 'La empresa ' || nombre_empresa || ' ya existe';
            RETURN respuesta;
        END IF;
    END insertar_empresa;
    */
    
    --insertar nueva empresa metodo 2 (exception)
    FUNCTION insertar_empresa (nombre_empresa VARCHAR2)
    RETURN VARCHAR2
    --insertar nueva empresa metodo 2 (exception)
    IS
        respuesta VARCHAR2(100);
    BEGIN
        INSERT INTO empresas (nombre) VALUES ('microsoft');
        respuesta := 'La empresa ' || nombre_empresa || ' se inserto con exito';
        RETURN respuesta;
    EXCEPTION
        --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
        WHEN DUP_VAL_ON_INDEX THEN
            respuesta := 'La empresa ' || nombre_empresa || ' ya existe.';
            RETURN respuesta;
    END insertar_empresa;
    
    /*
    --eliminar empresa metodo 1(SELECT COUNT(*))
    FUNCTION eliminar_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2
    IS
        empresa_existe NUMBER := 0;
        respuesta VARCHAR2(100);
    BEGIN
        --determinar si empresa existe
        SELECT COUNT(*) INTO empresa_existe FROM empresas WHERE nombre = nombre_empresa;
        --eliminar empresa de la tabla
        IF empresa_existe = 0 THEN
            respuesta := 'La empresa ' || nombre_empresa || ' no se encuentra registrada';
            RETURN respuesta;
        ELSE
            DELETE FROM empresas WHERE nombre = nombre_empresa;
            respuesta := 'La empresa ' || nombre_empresa || ' se elimino de la tabla';
            RETURN respuesta;
        END IF;
    END eliminar_empresa;
    */
    
    FUNCTION eliminar_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2
    --eliminar empresa metodo 2(exceptios)
    IS
        integrity_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (integrity_err, -2292);
        respuesta VARCHAR2(100);
    BEGIN
        --eliminar empresa
        DELETE FROM empresas WHERE nombre = nombre_empresa;
        respuesta := 'La empresa ' || nombre_empresa || ' se elimino de la tabla.';
        RETURN respuesta;
    EXCEPTION
        --ORA-02292: restricción de integridad (SYSTEM.SYS_C0011234) violada - registro secundario encontrado
        WHEN integrity_err THEN
            respuesta := 'no se pudo eliminar la empresa, hay usuario(s) asociados a esta.';
            RETURN respuesta;
    END eliminar_empresa;    
    
    /*
    --editar empresa
    FUNCTION editar_empresa(id_emp NUMBER, nuevo_nombre VARCHAR2) RETURN VARCHAR2
    IS
        empresa_existe NUMBER := 0;
        empresa empresas.nombre%TYPE;
        respuesta VARCHAR2(100);
    BEGIN
        --determinar si empresa existe
        SELECT COUNT(*) INTO empresa_existe FROM empresas WHERE nombre = nuevo_nombre;
        SELECT nombre INTO empresa FROM empresas WHERE  id_empresa = id_emp;
        IF empresa_existe = 0 THEN
            UPDATE empresas SET nombre =  nuevo_nombre WHERE id_empresa = id_emp;
            respuesta := 'la empresa ' || empresa || ' fue actualizada a ' || nuevo_nombre;
            RETURN respuesta;
        ELSE
            respuesta := 'la empresa ' || nuevo_nombre || ' no se pudo editar';
            RETURN respuesta;
        END IF;
    END editar_empresa;
    */
    
    FUNCTION editar_empresa(id_emp NUMBER, nuevo_nombre VARCHAR2) RETURN VARCHAR2
    IS
        integrity_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (integrity_err, -2292);
        empresa empresas.nombre%TYPE;
        respuesta VARCHAR2(250);
    BEGIN
        --buscar nombre empresa
        SELECT nombre INTO empresa FROM empresas WHERE  id_empresa = id_emp;
        --actualizar nombre
        UPDATE empresas SET nombre =  nuevo_nombre WHERE id_empresa = id_emp;
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
    
    /*
    --buscar empresa por id
    FUNCTION buscar_empresa(id_emp NUMBER) RETURN VARCHAR2
    IS
        empresa_existe NUMBER := 0;
        empresa empresas.nombre%TYPE;
        respuesta VARCHAR2(100);
    BEGIN
        --determinar si empresa existe
        SELECT COUNT(*) INTO empresa_existe FROM empresas WHERE id_empresa = id_emp;
        IF empresa_existe = 0 THEN
            respuesta := 'La empresa con id ' || id_emp || ' no se encuentra registrada';
            RETURN respuesta;
        ELSE
            SELECT nombre INTO empresa FROM empresas WHERE id_empresa = id_emp;
            respuesta := 'id: ' || id_emp || ', nombre: ' || empresa;
            RETURN respuesta;
        END IF;
    END buscar_empresa;
    */
    
    FUNCTION buscar_empresa(id_emp NUMBER) RETURN VARCHAR2
    IS
        empresa empresas%ROWTYPE;
        respuesta VARCHAR2(100);
    BEGIN
        SELECT * INTO empresa FROM empresas WHERE id_empresa = id_emp;
        respuesta := 'id: ' || empresa.id_empresa || ', ' || 'nombre: ' || empresa.nombre;
        RETURN respuesta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            respuesta := 'la empresa no existe.';
            RETURN respuesta;
    END buscar_empresa;
    
    /*
    funciones para listar, insertar, editar o eliminar clientes
    */
    
    FUNCTION listar_clientes RETURN VARCHAR2
    IS
        CURSOR lista_clientes IS SELECT * FROM customers ORDER BY primer_nombre ASC;
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
        respuesta := 'total de registros: ' || counter;
        RETURN respuesta;
    END listar_clientes;
    
    /*
    --insertar nuevo usuario metodo 1 (SELECT COUNT(*))
    FUNCTION insertar_cliente(cedula_usuario NUMBER, telefono NUMBER, direccion VARCHAR2,
        primer_nombre VARCHAR2, segundo_nombre VARCHAR2, primer_apellido VARCHAR2,
        segundo_apellido VARCHAR2, empresa VARCHAR2, estatus VARCHAR2) RETURN VARCHAR2
    IS
        usuario_existe NUMBER := 0;
        respuesta VARCHAR2(100);
        respuesta2 VARCHAR2(100);
    BEGIN
        --determinar si usuario existe
        SELECT COUNT(*) INTO usuario_existe FROM customers WHERE cedula = cedula_usuario;
        IF usuario_existe = 0 THEN
            respuesta2 := insertar_empresa(empresa);
            INSERT INTO customers (cedula, telefono, direccion, primer_nombre, segundo_nombre,
                primer_apellido, segundo_apellido, empresa, estatus)
            VALUES (cedula_usuario, telefono, direccion, primer_nombre, segundo_nombre, primer_apellido,
                segundo_apellido, empresa, estatus);
            respuesta := 'El usuario se ingreso de forma exitosa';
            RETURN respuesta;
        ELSE
            respuesta := 'El usuario con CC N° ' || cedula_usuario || ' ya existe';
             RETURN respuesta;
        END IF;
    END insertar_cliente;
    */
    
    FUNCTION insertar_cliente(cedula_usuario NUMBER, telefono NUMBER, direccion VARCHAR2,
        primer_nombre VARCHAR2, segundo_nombre VARCHAR2, primer_apellido VARCHAR2,
        segundo_apellido VARCHAR2, empresa VARCHAR2, estatus VARCHAR2) RETURN VARCHAR2
    IS
        null_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (null_err, -1400);
        respuesta VARCHAR2(100);
        respuesta2 VARCHAR2(100);
    BEGIN
        respuesta2 := insertar_empresa(empresa);
        INSERT INTO customers (cedula, telefono, direccion, primer_nombre, segundo_nombre,
            primer_apellido, segundo_apellido, empresa, estatus)
        VALUES (cedula_usuario, telefono, direccion, primer_nombre, segundo_nombre, primer_apellido,
            segundo_apellido, empresa, estatus);
        respuesta := respuesta2 || ', ' || 'El usuario se ingreso de forma exitosa';
        RETURN respuesta;
    EXCEPTION
        --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
        WHEN DUP_VAL_ON_INDEX THEN
            respuesta := 'ya hay un usuario registrado con el numero de cedula ' || cedula_usuario;
            RETURN respuesta;
        WHEN null_err THEN
            --ORA-01400: no se puede realizar una inserción NULL
            respuesta := 'debes completar todos los campos.';
            RETURN respuesta;
    END insertar_cliente;
    
    /*
    FUNCTION eliminar_cliente(id_usuario NUMBER) RETURN VARCHAR2
    IS
        usuario_existe NUMBER := 0;
        contar_empresa NUMBER := 0;
        id_emp empresas.id_empresa%TYPE;
        nombre_empresa customers.empresa%TYPE;
        respuesta VARCHAR2(100);
        respuesta2 VARCHAR2(100);
    BEGIN
        SELECT COUNT(*) INTO usuario_existe FROM customers WHERE id_persona = id_usuario;
        IF usuario_existe = 0 THEN
            respuesta := 'El usuario con id: ' || id_usuario || ' no se encuentra registrado';
            RETURN respuesta;
        ELSE
            --extraer nombre empresa
            SELECT empresa INTO nombre_empresa FROM customers WHERE id_persona = id_usuario;
            --contar cuantos usuarios trabajan en esta empresa
            SELECT COUNT(*) INTO contar_empresa FROM customers WHERE empresa = nombre_empresa;
            --eliminar usuario
            DELETE FROM customers WHERE id_persona = id_usuario;
            --se eliminara empresa en caso tal que el usuario a eliminar sea el unico que trabaja en esta empresa
            IF contar_empresa = 1 THEN
                respuesta2 := eliminar_empresa(nombre_empresa);
                respuesta := respuesta2 || ', ' || 'El usuario se elimino de forma exitosa';
                RETURN respuesta;
            ELSE
                respuesta := 'El usuario se elimino de forma exitosa';
                RETURN respuesta;
            END IF;
        END IF;
    END eliminar_cliente;
    */
    
    FUNCTION eliminar_cliente(id_usuario NUMBER) RETURN VARCHAR2
    IS
        nombre_empresa customers.empresa%TYPE;
        respuesta VARCHAR2(250);
        respuesta2 VARCHAR2(250);
    BEGIN
        --extraer nombre empresa
        SELECT empresa INTO nombre_empresa FROM customers WHERE id_persona = id_usuario;
        --eliminar usuario
        DELETE FROM customers WHERE id_persona = id_usuario;
        --eliminar empresa
        respuesta2 := eliminar_empresa(nombre_empresa);
        respuesta := respuesta2 || ', ' || 'El usuario se elimino de forma exitosa';
        RETURN respuesta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            respuesta := 'el usuario no existe.';
            RETURN respuesta;
    END eliminar_cliente;
    
    /*
    FUNCTION editar_cliente(id_usuario NUMBER, cedula_usuario NUMBER, telefono_usuario NUMBER,
        direccion_usuario VARCHAR2, primer_nombre_usuario VARCHAR2, segundo_nombre_usuario VARCHAR2, 
        primer_apellido_usuario VARCHAR2, segundo_apellido_usuario VARCHAR2, empresa_usuario VARCHAR2, estatus_usuario VARCHAR2) 
        RETURN VARCHAR2
    IS
        usuario_existe NUMBER := 0;
        empresa_existe NUMBER := 0;
        num_usuarios_emp NUMBER := 0;
        nombre_emp VARCHAR2(100);
        respuesta VARCHAR2(100);
        respuesta2 VARCHAR2(100);
        respuesta3 VARCHAR2(100);
    BEGIN
        --determinar si usuario existe
        SELECT COUNT(*) INTO usuario_existe FROM customers WHERE id_persona = id_usuario; 
        IF usuario_existe = 0 THEN
            respuesta := 'El usuario con id: ' || id_usuario || ' no existe';
            RETURN respuesta;
        ELSE
            SELECT COUNT(*) INTO empresa_existe FROM empresas WHERE nombre = empresa_usuario;
            SELECT empresa INTO nombre_emp FROM customers WHERE id_persona = id_usuario;
            SELECT COUNT(*) INTO num_usuarios_emp FROM customers WHERE empresa = nombre_emp;
            IF ( empresa_existe = 0 AND num_usuarios_emp = 1) THEN
                respuesta2 := insertar_empresa (empresa_usuario);
                UPDATE customers
                SET cedula = cedula_usuario, telefono = telefono_usuario, direccion = direccion_usuario,
                    primer_nombre = primer_nombre_usuario, segundo_nombre = segundo_nombre_usuario,
                    primer_apellido = primer_apellido_usuario, segundo_apellido = segundo_apellido_usuario, empresa = empresa_usuario,
                    estatus = estatus_usuario
                WHERE id_persona = id_usuario;
                respuesta3 := eliminar_empresa(nombre_emp);
                respuesta := 'el usuario se edito de forma exitosa';
                RETURN respuesta;
            ELSIF ( empresa_existe = 0 AND num_usuarios_emp > 1) THEN
                respuesta2 := insertar_empresa (empresa_usuario);
                UPDATE customers
                SET cedula = cedula_usuario, telefono = telefono_usuario, direccion = direccion_usuario,
                    primer_nombre = primer_nombre_usuario, segundo_nombre = segundo_nombre_usuario,
                    primer_apellido = primer_apellido_usuario, segundo_apellido = segundo_apellido_usuario, empresa = empresa_usuario,
                    estatus = estatus_usuario
                WHERE id_persona = id_usuario;
                respuesta := respuesta2 || ', ' || 'el usuario se edito de forma exitosa';
                RETURN respuesta;
            ELSE
                UPDATE customers
                SET cedula = cedula_usuario, telefono = telefono_usuario, direccion = direccion_usuario,
                    primer_nombre = primer_nombre_usuario, segundo_nombre = segundo_nombre_usuario,
                    primer_apellido = primer_apellido_usuario, segundo_apellido = segundo_apellido_usuario, empresa = empresa_usuario,
                    estatus = estatus_usuario
                WHERE id_persona = id_usuario;
                respuesta := 'el usuario se edito de forma exitosa';
                RETURN respuesta;
            END IF;
        END IF;
        EXCEPTION
            --ORA-00001: restricción única (SYSTEM.SYS_C0011233) violada
            WHEN DUP_VAL_ON_INDEX THEN
                respuesta := 'La cedula que estas tratando de ingresar ya la posee otro usuario.';
                RETURN respuesta;
    END editar_cliente;
    */
    
    FUNCTION editar_cliente(id_usuario NUMBER, cedula_usuario NUMBER, telefono_usuario NUMBER,
        direccion_usuario VARCHAR2, primer_nombre_usuario VARCHAR2, segundo_nombre_usuario VARCHAR2, 
        primer_apellido_usuario VARCHAR2, segundo_apellido_usuario VARCHAR2, empresa_usuario VARCHAR2, estatus_usuario VARCHAR2) 
        RETURN VARCHAR2
    IS
        null_err EXCEPTION;
        PRAGMA EXCEPTION_INIT (null_err, -1407);
        nombre_emp VARCHAR2(100);
        respuesta VARCHAR2(250);
        respuesta2 VARCHAR2(100);
        respuesta3 VARCHAR2(100);
    BEGIN
        SELECT empresa INTO nombre_emp FROM customers WHERE id_persona = id_usuario;
        respuesta2 := insertar_empresa (empresa_usuario);
        UPDATE customers
        SET cedula = cedula_usuario, telefono = telefono_usuario, direccion = direccion_usuario,
            primer_nombre = primer_nombre_usuario, segundo_nombre = segundo_nombre_usuario,
            primer_apellido = primer_apellido_usuario, segundo_apellido = segundo_apellido_usuario, empresa = empresa_usuario,
            estatus = estatus_usuario
        WHERE id_persona = id_usuario;
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
    
    /*
    FUNCTION buscar_cliente(id_usuario NUMBER) RETURN VARCHAR2
    IS
        usuario_existe NUMBER := 0;
        registro customers%ROWTYPE;
        respuesta VARCHAR2(100);
    BEGIN
        --determinar si usuario existe
        SELECT COUNT(*) INTO usuario_existe FROM customers WHERE id_persona = id_usuario;
        IF usuario_existe = 0 THEN
            respuesta := 'El usuario con id: ' || id_usuario || ' no se encuentra registrado';
            RETURN respuesta;
        ELSE
            --recuperar el usuario de la tabla
            SELECT * INTO registro FROM customers WHERE id_persona = id_usuario;
            DBMS_OUTPUT.PUT_LINE('id: ' || registro.id_persona || ', cedula: ' || registro.cedula ||
                ', telefono: ' || registro.telefono || ', direccion: ' || registro.direccion || ', primer nombre: '
                || registro.primer_nombre || ', segundo nombre: ' || registro.segundo_nombre ||
                ', primer apellido: ' || registro.primer_apellido || ', segundo apellido: ' || registro.segundo_apellido
                || ', empresa: ' || registro.empresa || ', estatus: ' || registro.estatus);
             respuesta := 'datos recuperados con exito!';
             RETURN respuesta;
        END IF;
    END buscar_cliente;
    */
    
    FUNCTION buscar_cliente(id_usuario NUMBER) RETURN VARCHAR2
    IS
        registro customers%ROWTYPE;
        respuesta VARCHAR2(100);
    BEGIN
        --recuperar el usuario de la tabla
        SELECT * INTO registro FROM customers WHERE id_persona = id_usuario;
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
        CURSOR nombre_empresas IS SELECT * FROM empresas ORDER BY nombre ASC;
        numero_clientes NUMBER := 0;
    BEGIN
        FOR i IN nombre_empresas LOOP
            SELECT COUNT(*) INTO numero_clientes FROM customers WHERE empresa = i.nombre;
            DBMS_OUTPUT.PUT_LINE(i.nombre || ': ' || numero_clientes || chr(13));
            numero_clientes := 0;
        END LOOP;
        RETURN '';
    END reporte_total_numero_clientes;
    
    /*
    FUNCTION reporte_por_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2
    IS
        empresa_existe NUMBER := 0;
        numero_clientes NUMBER := 0;
        respuesta VARCHAR2(100);
    BEGIN
        --determinar si usuario existe
        SELECT COUNT(*) INTO empresa_existe FROM empresas WHERE nombre = nombre_empresa;
        IF empresa_existe = 0 THEN
            respuesta := 'la empresa ' || nombre_empresa || ' no se encuentra registrada';
            RETURN respuesta;
        ELSE
            SELECT COUNT(*) INTO numero_clientes FROM customers WHERE empresa = nombre_empresa;
            respuesta := 'numero de clientes que trabajan en ' || nombre_empresa || ': ' || numero_clientes;
            RETURN respuesta;
        END IF;
    END reporte_por_empresa;
    */
    
    FUNCTION reporte_por_empresa(nombre_empresa VARCHAR2) RETURN VARCHAR2
    IS
        numero_clientes NUMBER := 0;
        respuesta VARCHAR2(100);
    BEGIN
        SELECT COUNT(*) INTO numero_clientes FROM customers WHERE empresa = nombre_empresa;
        respuesta := 'numero de clientes que trabajan en ' || nombre_empresa || ': ' || numero_clientes;
        RETURN respuesta;
    END reporte_por_empresa;
                    
END FUNCTIONS_SET;