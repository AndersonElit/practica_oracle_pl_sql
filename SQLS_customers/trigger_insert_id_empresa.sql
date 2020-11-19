CREATE TRIGGER INSERT_ID_EMPRESA
    BEFORE INSERT ON empresas
    FOR EACH ROW
        WHEN (new.id_empresa IS NULL)
    BEGIN
        :new.id_empresa := SEQ.nextval;
END;