-- ============================================
-- SCRIPT MEJORADO: Generar 50 Transacciones Aleatorias
-- Usa TODOS los usuarios disponibles - VERSIÓN CORREGIDA
-- ============================================
-- En caso que quieras borrar las 50 insert y/o volver usar las ID (6--->-) usar estos 2 metodos
-- DELETE FROM transacciones WHERE transaccion_id > 5;
-- ALTER TABLE transacciones AUTO_INCREMENT = 6;
-- ============================================

-- 1. Configurar delimitador primero
DELIMITER $$

-- 2. Eliminar el procedimiento si ya existe
DROP PROCEDURE IF EXISTS GenerarTransaccionesAleatoriasMejorado$$

-- 3. Crear el procedimiento mejorado
CREATE PROCEDURE GenerarTransaccionesAleatoriasMejorado(IN cantidad INT)
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE remitente_id INT;
    DECLARE receptor_id INT;
    DECLARE moneda_id INT;
    DECLARE tipo_id INT;
    DECLARE importe_random DECIMAL(15,2);
    DECLARE fecha_aleatoria DATETIME;
    DECLARE total_usuarios INT;
    
    -- Obtener el total de usuarios (excepto el sistema)
    SELECT COUNT(*) INTO total_usuarios FROM usuarios WHERE usuario_id > 1;
    
    -- Bucle para generar 'cantidad' transacciones
    WHILE contador < cantidad DO
        -- ============================================
        -- A. DECIDIR TIPO DE TRANSACCIÓN ALEATORIA
        -- ============================================
        -- 25% probabilidad de recarga, 75% de transferencia
        IF RAND() < 0.25 THEN
            -- RECARGA: Sistema (ID 1) a usuario aleatorio
            SET remitente_id = 1;  -- Sistema ALKE
            -- Usuario aleatorio (excluyendo el sistema, ID > 1)
            SET receptor_id = (
                SELECT usuario_id 
                FROM usuarios 
                WHERE usuario_id > 1 
                ORDER BY RAND() 
                LIMIT 1
            );
            SET tipo_id = 1;  -- ID de 'recarga'
        ELSE
            -- TRANSFERENCIA: Entre dos usuarios aleatorios diferentes
            -- Obtener dos usuarios aleatorios diferentes
            SELECT usuario_id INTO remitente_id
            FROM usuarios 
            WHERE usuario_id > 1 
            ORDER BY RAND() 
            LIMIT 1;
            
            SELECT usuario_id INTO receptor_id
            FROM usuarios 
            WHERE usuario_id > 1 
            AND usuario_id != remitente_id
            ORDER BY RAND() 
            LIMIT 1;
            
            SET tipo_id = 2;  -- ID de 'transferencia'
        END IF;
        
        -- ============================================
        -- B. DATOS ALEATORIOS
        -- ============================================
        -- Moneda aleatoria (1=CLP, 2=USD, 3=EUR)
        SET moneda_id = FLOOR(1 + RAND() * 3);
        
        -- Importe aleatorio (entre 1 y 2000)
        SET importe_random = ROUND(1 + RAND() * 1999, 2);
        
        -- Fecha aleatoria (últimos 90 días)
        SET fecha_aleatoria = NOW() - INTERVAL FLOOR(RAND() * 90) DAY 
                                       - INTERVAL FLOOR(RAND() * 24) HOUR 
                                       - INTERVAL FLOOR(RAND() * 60) MINUTE;
        
        -- ============================================
        -- C. INSERTAR LA TRANSACCIÓN
        -- ============================================
        INSERT INTO transacciones (
            usuario_remitente_id,
            usuario_receptor_id,
            moneda_id,
            importe,
            tipo_transaccion_id,
            fecha_transaccion
        ) VALUES (
            remitente_id,
            receptor_id,
            moneda_id,
            importe_random,
            tipo_id,
            fecha_aleatoria
        );
        
        -- Incrementar contador
        SET contador = contador + 1;
    END WHILE;
    
    -- Mensaje de confirmación (SIN EMOJIS para evitar errores)
    SELECT CONCAT('EXITO: ', cantidad, ' transacciones aleatorias generadas con exito.') AS Resultado;
    SELECT CONCAT('INFO: Usuarios disponibles: ', total_usuarios + 1, ' (incluyendo Sistema)') AS Info;
END$$

-- 4. Restaurar el delimitador original
DELIMITER ;

-- ============================================
-- 5. EJECUTAR EL PROCEDIMIENTO MEJORADO (50 TRANSACCIONES)
-- ============================================
CALL GenerarTransaccionesAleatoriasMejorado(50);

-- ============================================
-- 6. VERIFICACIONES
-- ============================================
-- Ver total de transacciones
SELECT COUNT(*) AS 'Total de transacciones' FROM transacciones;

-- Ver las últimas 10 transacciones generadas
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