USE AlkeWallet;


-- modificacion da la columna email, sobre el id 2
UPDATE usuarios 
SET email = 'juan.nuevo_email@correo.com' 
WHERE usuario_id = 2;
-- Consulta a la tabla y Verificar si el dato se actualizo
SELECT * FROM usuarios WHERE usuario_id = 2;


-- Eliminacion de una transaccion completa
DELETE FROM transacciones 
WHERE transaccion_id = 1;
-- Consulta a la tabla y Verificar que se elimino id
SELECT * FROM transacciones;



