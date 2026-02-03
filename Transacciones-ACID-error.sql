USE AlkeWallet;

START TRANSACTION;
-- Inserto transacción inválida (como usuario que no exista)
INSERT INTO transacciones (usuario_remitente_id, usuario_receptor_id, moneda_id, importe, tipo_transaccion_id)
VALUES (999, 2, 2, 100.00, 2);  -- usuario_id 999 no existe

-- Esto debería fallar por integridad referencial
-- Si MySQL no lo rechaza inmediatamente, ejecuta: ROLLBACK;
ROLLBACK;