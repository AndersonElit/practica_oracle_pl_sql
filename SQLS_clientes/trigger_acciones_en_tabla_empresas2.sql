CREATE TRIGGER acciones_en_tabla_empresas2
AFTER INSERT OR UPDATE OR DELETE ON empresas2
FOR EACH ROW
DECLARE
    fecha DATE := SYSDATE;
    hora VARCHAR2(100);
    id_registro NUMBER := 0;
BEGIN
    hora := TO_CHAR(sysdate, 'HH24') || ':' || TO_CHAR(sysdate, 'MI');
    
    CASE
        WHEN INSERTING THEN
            --seleccionar id del elemento insertado
            SELECT SECUENCIA_EMPRESAS.CURRVAL INTO id_registro FROM DUAL;
            --insertar valores
            INSERT INTO registro_acciones (accion, id_elemento, tabla, fecha, hora)
            VALUES ('INSERT', id_registro, 'empresas2', fecha, hora);
        WHEN DELETING THEN
            INSERT INTO registro_acciones (accion, id_elemento, tabla, fecha, hora)
            VALUES ('DELETE', :old.id_empresa, 'empresas2', fecha, hora);
        WHEN UPDATING THEN
            INSERT INTO registro_acciones (accion, id_elemento, tabla, fecha, hora)
            VALUES ('UPDATE', :old.id_empresa, 'empresas2', fecha, hora);
    END CASE;
END;