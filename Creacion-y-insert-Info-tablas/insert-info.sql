USE AlkeWallet;

INSERT INTO tipos_transacciones (nombre) VALUES
('recarga'),          -- Carga de saldo
('transferencia'),    -- tranferencias entre usuarios  
('retiro'),           -- Retirar dinero del sistema
('rentabilidad'),     -- Ganancias por ahorro/inversión
('comision'),         -- Cobro por servicios
('reembolso'),        -- Devolución
('pago_servicio');    -- Pagos de servicios (luz, agua)

INSERT INTO usuarios (nombre, email, password_usuario, saldo) 
VALUES 
('Sistema wallet', 'sistema@wallet.com', 'sistema_pass', 9999999),
('Juan Pérez', 'juan@email.com', 'clave123', 1000.00),
('María García', 'maria@email.com', 'clave456', 500.00);

INSERT INTO monedas (nombre_moneda, simbolo_moneda) 
VALUES
('Peso Chileno', 'CLP'),
('Dólar Estadounidense', 'USD'),
('Euro', 'EUR')
;


-- Agregar 5 usuarios más (además del Sistema, Juan y María)
INSERT INTO usuarios (nombre, email, password_usuario, saldo) VALUES
('Carlos López', 'carlos@email.com', 'clave789', 1500.00),
('Ana Martínez', 'ana@email.com', 'clave101', 2200.00),
('Pedro Sánchez', 'pedro@email.com', 'clave202', 800.00),
('Lucía Fernández', 'lucia@email.com', 'clave303', 3100.00),
('David González', 'david@email.com', 'clave404', 950.00);