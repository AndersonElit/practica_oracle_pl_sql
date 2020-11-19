CREATE TRIGGER INSERTAR_ID_EMPRESAS2
    BEFORE INSERT ON empresas2
    FOR EACH ROW
        WHEN (new.id_empresa IS NULL)
    BEGIN
        :new.id_empresa := SECUENCIA_EMPRESAS.nextval;
END;