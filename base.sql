CREATE DATABASE databaseProt
USE databaseProt;

--actualizacion a la 1:44PM

CREATE TABLE user_type (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE users (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  type_id    INT,
  usuario    VARCHAR(100) NOT NULL,
  contraseña VARCHAR(100) NOT NULL,
  FOREIGN KEY (type_id) REFERENCES user_type (id)
);

CREATE TABLE product_type (--mierdas que ingresa, cuando se procesan, mierda final
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25) NOT NULL
);

CREATE TABLE size_type (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  nombre      VARCHAR(30) NOT NULL,
  abreviatura VARCHAR(10)  NOT NULL
);

CREATE TABLE products (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  type_id     INT          NOT NULL,
  size_id     INT          NOT NULL,
  nombre      VARCHAR(100) NOT NULL,
  descripcion VARCHAR(1000),
  FOREIGN KEY (type_id) REFERENCES product_type (id),
  FOREIGN KEY (size_id) REFERENCES size_type (id)
);

CREATE TABLE process (
  id             INT PRIMARY KEY AUTO_INCREMENT,
  product_id     INT NOT NULL,
  user_id        INT NOT NULL,
  costo          NUMERIC(15, 2) UNSIGNED,
  cantidad       DOUBLE(15, 2) UNSIGNED,
  ganancia       NUMERIC(15, 2) UNSIGNED,
  quien_saco     VARCHAR(150),
  descripcion    VARCHAR(10000),
  estado         TINYINT,
  fecha_inicio   DATE,
  fecha_fin      DATE,
  fecha_fin_real DATE,
  FOREIGN KEY (product_id) REFERENCES products (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE client (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  nombres   VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  dui       VARCHAR(10)  NOT NULL,
  nit       VARCHAR(17),
  telefono  VARCHAR(50),
  correo    VARCHAR(300),
  direccion VARCHAR(500)
);

CREATE TABLE company (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(100) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
);

CREATE TABLE clients_type (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50)
);

CREATE TABLE clients (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  client_id   INT NOT NULL,
  company_id  INT NOT NULL,
  type_id     INT NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients (id),
  FOREIGN KEY (company_id) REFERENCES company (id),
  FOREIGN KEY (type_id) REFERENCES clients_type (id)
);

CREATE TABLE transaction_type (-- compra, venta
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(10) NOT NULL
);


CREATE TABLE transactions (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  type_id    INT NOT NULL,
  clients_id INT NOT NULL,
  users_id   INT NOT NULL,
  FOREIGN KEY (type_id) REFERENCES transaction_type (id) ,
  FOREIGN KEY (clients_id) REFERENCES clients (id) ,
  FOREIGN KEY (users_id) REFERENCES users (id)
);
