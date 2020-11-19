CREATE TRIGGER INSERTAR_ID_CLIENTES
    BEFORE INSERT ON clientes
    FOR EACH ROW
        WHEN (new.id_persona IS NULL)
    BEGIN
        :new.id_persona := SECUENCIA_CLIENTES.nextval;
END;