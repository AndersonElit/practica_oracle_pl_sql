CREATE TRIGGER INSERT_ID_EMPLEADO
    BEFORE INSERT ON customers
    FOR EACH ROW
        WHEN (new.id_persona IS NULL)
    BEGIN
        :new.id_persona := SEQ.nextval;
END;