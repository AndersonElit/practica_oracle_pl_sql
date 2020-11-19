CREATE TRIGGER acciones_en_tabla_customers
AFTER INSERT OR UPDATE OR DELETE ON customers
FOR EACH ROW
DECLARE
    fecha DATE := SYSDATE;
    hora VARCHAR2(100);
BEGIN
    hora := TO_CHAR(sysdate, 'HH24') || ':' || TO_CHAR(sysdate, 'MI');
    CASE
        WHEN INSERTING THEN
            INSERT INTO acciones (accion, tabla, fecha, hora)
            VALUES ('INSERT', 'customers', fecha, hora);
        WHEN DELETING THEN
            INSERT INTO acciones (accion, tabla, fecha, hora)
            VALUES ('DELETE', 'customers', fecha, hora);
        WHEN UPDATING THEN
            INSERT INTO acciones (accion, tabla, fecha, hora)
            VALUES ('UPDATE', 'customers', fecha, hora);
    END CASE;
END;
            