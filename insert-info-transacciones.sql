USE AlkeWallet;

-- Inserto de transacciones
INSERT INTO transacciones (usuario_remitente_id, usuario_receptor_id, moneda_id, importe, tipo_transaccion_id) VALUES
(1, 2, 2, 200, 1),   -- Sistema, recarga, 200, USD, a Juan  [Sistema-->Juan, USD, 200, recarga]
(1, 3, 1, 50000, 1), -- Sistema, recarga, 50.000, CLP, a María [Sistema-->María, CLP, 50.000, recarga]
(2, 3, 2, 50, 2),    -- Juan, transfiere, 50, USD, a María [Juan-->María, USD, 50, transfiere]
(3, 2, 3, 40, 2),    -- María, transfiere, 40, EUR, a Juan [María-->Juan, EUR, 40, transfiere]
(1, 2, 2, 10, 5);    -- Sistema, cobra comisión, de 10, USD, a Juan [Sistema-->Juan, USD, 10, cobra comisión]