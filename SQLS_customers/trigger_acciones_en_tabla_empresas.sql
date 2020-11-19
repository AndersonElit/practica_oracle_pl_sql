CREATE TRIGGER acciones_en_tabla_empresas
AFTER INSERT OR UPDATE OR DELETE ON empresas
FOR EACH ROW
DECLARE
    fecha DATE := SYSDATE;
    hora VARCHAR2(100);
BEGIN
    hora := TO_CHAR(sysdate, 'HH24') || ':' || TO_CHAR(sysdate, 'MI');
    CASE
        WHEN INSERTING THEN
            INSERT INTO acciones (accion, tabla, fecha, hora)
            VALUES ('INSERT', 'empresas', fecha, hora);
        WHEN DELETING THEN
            INSERT INTO acciones (accion, tabla, fecha, hora)
            VALUES ('DELETE', 'empresas', fecha, hora);
        WHEN UPDATING THEN
            INSERT INTO acciones (accion, tabla, fecha, hora)
            VALUES ('UPDATE', 'empresas', fecha, hora);
    END CASE;
END;