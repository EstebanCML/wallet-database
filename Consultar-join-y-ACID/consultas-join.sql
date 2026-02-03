USE AlkeWallet;

-- tipos de moneda que a usado el usuario
SELECT DISTINCT u.nombre, m.nombre_moneda
FROM transacciones t
JOIN usuarios u ON u.usuario_id IN (t.usuario_remitente_id, t.usuario_receptor_id)
JOIN monedas m ON t.moneda_id = m.moneda_id
WHERE u.usuario_id = 2;

-- consulta tabla completa de transacciones
SELECT t.transaccion_id, remitente.nombre, receptor.nombre, t.importe, t.fecha_transaccion
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id;

-- Reemplazo usuario_remitente_id y usuario_receptor_id por nombres[De - Para]
SELECT 
    t.transaccion_id,
    remitente.nombre AS 'De',
    receptor.nombre AS 'Para',
    t.importe,
    t.fecha_transaccion
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id;

-- Incluye información de moneda y la concateno
SELECT 
    t.transaccion_id,
    remitente.nombre AS 'Remitente',
    receptor.nombre AS 'Receptor',
    CONCAT(t.importe, ' ', m.simbolo_moneda) AS 'Monto', -- aca junto 2 columnas como si fuera 1
    t.fecha_transaccion
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id
JOIN monedas m ON t.moneda_id = m.moneda_id;


-- consulta de todas las columnas, manteniendo el nombre y remplaza los id con alguna culumna de la otra tabla
SELECT 
    t.transaccion_id,
    remitente.nombre AS 'De', -- Reemplaza ID por nombre
    receptor.nombre AS 'Para', -- Reemplaza ID por nombre
    m.simbolo_moneda AS 'Moneda', -- Reemplaza ID por simbolo
    t.importe,
    tt.nombre AS 'tipo_transaccion', -- Reemplaza ID por nombre
    DATE_FORMAT(t.fecha_transaccion, '%Y/%m/%d - %H:%i:%s') AS 'fecha_transaccion'
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id
JOIN monedas m ON t.moneda_id = m.moneda_id
JOIN tipos_transacciones tt ON t.tipo_transaccion_id = tt.tipo_transaccion_id
ORDER BY t.transaccion_id;


-- Consulta completa en un orden mas facil de leer y concanetacion entre 2 tablas
SELECT 
    t.transaccion_id AS 'ID',
    DATE_FORMAT(t.fecha_transaccion, '%Y/%m/%d - %H:%i:%s') AS 'Fecha',
    remitente.nombre AS 'De',
    receptor.nombre AS 'Para',
    CONCAT(t.importe, ' ', m.simbolo_moneda) AS 'Monto',
    tt.nombre AS 'Tipo de Transacción',
    m.nombre_moneda AS 'Moneda'
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id
JOIN monedas m ON t.moneda_id = m.moneda_id
JOIN tipos_transacciones tt ON t.tipo_transaccion_id = tt.tipo_transaccion_id
ORDER BY t.fecha_transaccion DESC;


-- Consulta de las Monedas utilizadas por Juan (usuario_id = 2)
SELECT DISTINCT
    u.nombre AS 'Usuario',
    m.nombre_moneda AS 'Moneda Utilizada',
    m.simbolo_moneda AS 'Símbolo'
FROM transacciones t
JOIN usuarios u ON u.usuario_id IN (t.usuario_remitente_id, t.usuario_receptor_id)
JOIN monedas m ON t.moneda_id = m.moneda_id
WHERE u.usuario_id = 2;


-- Todas las transacciones que a hecho María (usuario_id = 3) y consulta case
SELECT 
    t.transaccion_id,
    DATE_FORMAT(t.fecha_transaccion, '%Y/%m/%d - %H:%i:%s') AS 'Fecha',
    CASE -- aca hace 2 consulta y dependiendo de la fila, deja la respuesta en [Accion]
        WHEN t.usuario_remitente_id = 3 THEN 'Envió'
        WHEN t.usuario_receptor_id = 3 THEN 'Recibió'
    END AS 'Accion',
    CASE -- aca igual hace 2 consulta si corresponde a receptro o remitente y solo coloca el que coincide con el anterior case
        WHEN t.usuario_remitente_id = 3 THEN receptor.nombre
        WHEN t.usuario_receptor_id = 3 THEN remitente.nombre
    END AS 'Intercambio con',
    CONCAT(t.importe, ' ', m.simbolo_moneda) AS 'Monto',
    tt.nombre AS 'Tipo'
FROM transacciones t
JOIN usuarios remitente ON t.usuario_remitente_id = remitente.usuario_id
JOIN usuarios receptor ON t.usuario_receptor_id = receptor.usuario_id
JOIN monedas m ON t.moneda_id = m.moneda_id
JOIN tipos_transacciones tt ON t.tipo_transaccion_id = tt.tipo_transaccion_id
WHERE t.usuario_remitente_id = 3 OR t.usuario_receptor_id = 3
ORDER BY t.fecha_transaccion DESC;