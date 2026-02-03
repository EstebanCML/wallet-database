-- Ver todos los usuarios
SELECT 
    usuario_id AS 'ID',
    nombre AS 'Nombre',
    email AS 'Correo',
    CONCAT('$', FORMAT(saldo, 2)) AS 'Saldo'
FROM usuarios
ORDER BY usuario_id;

-- Ver distribución de transacciones por usuario
SELECT 
    u.nombre AS 'Usuario',
    COUNT(DISTINCT t.transaccion_id) AS 'Total Transacciones',
    SUM(CASE WHEN t.usuario_remitente_id = u.usuario_id THEN t.importe ELSE 0 END) AS 'Total Enviado',
    SUM(CASE WHEN t.usuario_receptor_id = u.usuario_id THEN t.importe ELSE 0 END) AS 'Total Recibido',
    CONCAT('$', FORMAT(u.saldo, 2)) AS 'Saldo Actual'
FROM usuarios u
LEFT JOIN transacciones t ON u.usuario_id = t.usuario_remitente_id OR u.usuario_id = t.usuario_receptor_id
WHERE u.usuario_id > 1  -- Excluir sistema
GROUP BY u.usuario_id
ORDER BY u.usuario_id;

-- Ver las 10 transacciones más recientes con nombres completos
SELECT 
    t.transaccion_id AS 'ID',
    DATE_FORMAT(t.fecha_transaccion, '%d/%m/%Y') AS 'Fecha',
    TIME(t.fecha_transaccion) AS 'Hora',
    remitente.nombre AS 'De',
    receptor.nombre AS 'Para',
    CONCAT(t.importe, ' ', m.simbolo_moneda) AS 'Monto',
    tt.nombre AS 'Tipo'
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id
JOIN monedas m ON t.moneda_id = m.moneda_id
JOIN tipos_transacciones tt ON t.tipo_transaccion_id = tt.tipo_transaccion_id
ORDER BY t.fecha_transaccion DESC
LIMIT 10;