CREATE TRIGGER INSERT_ID_ACCIONES
    BEFORE INSERT ON acciones
    FOR EACH ROW
        WHEN (new.id_accion IS NULL)
    BEGIN
        :new.id_accion := SEQ.nextval;
END;