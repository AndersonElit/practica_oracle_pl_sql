CREATE TRIGGER INSERTAR_ID_REGISTRO_ACCIONES
    BEFORE INSERT ON registro_acciones
    FOR EACH ROW
        WHEN (new.id_accion IS NULL)
    BEGIN
        :new.id_accion := SECUENCIA_REGISTRO_ACCIONES.nextval;
END;