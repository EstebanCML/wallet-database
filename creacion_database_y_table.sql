CREATE DATABASE IF NOT EXISTS AlkeWallet;
USE AlkeWallet;


CREATE TABLE tipos_transacciones ( -- tabla que contiene los tipos de transacciones posibles en la wallet
    tipo_transaccion_id INT PRIMARY KEY AUTO_INCREMENT, 
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuarios ( -- registro de usuarios
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_usuario VARCHAR(255) NOT NULL,
    saldo DECIMAL(15,2) DEFAULT 0.00
);

CREATE TABLE monedas ( -- registro de tipos de monedas usadas en wallet. usaremos 2 moneda en la primera version CLP y USD
    moneda_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_moneda VARCHAR(50) NOT NULL,
    simbolo_moneda VARCHAR(10)
);

CREATE TABLE transacciones ( -- regiistro de las transacciones con destinario y remitente, con tipo y fecha/hora de la transacciones
    transaccion_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_remitente_id INT NOT NULL,
    usuario_receptor_id INT NOT NULL,
    moneda_id INT NOT NULL,
    importe DECIMAL(15,2) NOT NULL CHECK (importe > 0),
    tipo_transaccion_id INT NOT NULL,
    fecha_transaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_remitente_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (usuario_receptor_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (moneda_id) REFERENCES monedas(moneda_id),
    FOREIGN KEY (tipo_transaccion_id) REFERENCES tipos_transacciones(tipo_transaccion_id)
);