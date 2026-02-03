USE AlkeWallet;
START TRANSACTION;

-- Paso 1 Registrar la transacción
INSERT INTO transacciones (usuario_remitente_id, usuario_receptor_id, moneda_id, importe, tipo_transaccion_id)
VALUES (2, 3, 2, 100.00, 2);

-- Paso 2 Actualizar saldo del remitente
UPDATE usuarios SET saldo = saldo - 50 WHERE usuario_id = 2;

-- Paso 3 Actualizar saldo del receptor
UPDATE usuarios SET saldo = saldo + 50 WHERE usuario_id = 3;

-- Verificar que todo está bien antes de confirmar
SELECT * FROM usuarios WHERE usuario_id IN (2, 3);

-- Si todo está correcto ejecuta commit
COMMIT;

-- Si hay error (ej: saldo insuficiente)
-- ROLLBACK; se debera ejecutar esto