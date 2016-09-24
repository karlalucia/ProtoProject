CREATE DATABASE IF NOT EXISTS databaseprot CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE databaseprot;


/*Aca empieza lo de los usarios */
CREATE TABLE IF NOT EXISTS user_type (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  type_id    INT,
  usuario    VARCHAR(100) NOT NULL,
  contraseña VARCHAR(100) NOT NULL,
  FOREIGN KEY (type_id) REFERENCES user_type (id)
);
/*Aca termina lo de los usarios */



/*Aca empieza lo de los productos y el proceso cerote */
CREATE TABLE IF NOT EXISTS product_type (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS size_type (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  nombre      VARCHAR(30) NOT NULL,
  abreviatura VARCHAR(10)  NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  type_id     INT          NOT NULL,
  size_id     INT          NOT NULL,
  nombre      VARCHAR(100) NOT NULL,
  descripcion VARCHAR(1000),
  FOREIGN KEY (type_id) REFERENCES product_type (id),
  FOREIGN KEY (size_id) REFERENCES size_type (id)
);

CREATE TABLE IF NOT EXISTS existence (
  products_id  INT PRIMARY KEY,
  cantidad     DECIMAL(10, 2) ,
  precio_actual NUMERIC(10, 2) ,
  FOREIGN KEY (products_id) REFERENCES products (id)
);

CREATE TABLE IF NOT EXISTS process (
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

CREATE TABLE IF NOT EXISTS supplies (
  id                INT PRIMARY KEY AUTO_INCREMENT,
  product_id        INT            NOT NULL,
  process_id        INT            NOT NULL,
  cantidad          DECIMAL(15, 2) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products (id),
  FOREIGN KEY (process_id) REFERENCES process (id)
);
/*Aca termina lo de los productos */



/*Aca empieza lo de las empresas y personas, tambien incluye como hacer lo del credito fiscal */
CREATE TABLE IF NOT EXISTS departamentos (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS municipios (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  departamento_id INT         NOT NULL,
  nombre          VARCHAR(50) NOT NULL,
  FOREIGN KEY (departamento_id) REFERENCES departamentos (id)
);

CREATE TABLE IF NOT EXISTS business (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  nombres   VARCHAR(100) NOT NULL,
  dui       VARCHAR(10),
  municipio_id INT NOT NULL,
  giro      VARCHAR(100),
  registro  VARCHAR(20)  NOT NULL,
  telefono  VARCHAR(25),
  correo    VARCHAR(100),
  direccion VARCHAR(200),
  FOREIGN KEY (municipio_id) REFERENCES municipios (id)
);

CREATE TABLE IF NOT EXISTS person (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  nombres   VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  dui       VARCHAR(10)  NOT NULL,
  nit       VARCHAR(17),
  telefono  VARCHAR(25),
  correo    VARCHAR(300),
  direccion VARCHAR(500)
);
/*Aca termina lo de los empresas y personas */



/*Aca empieza lo de los clientes */
CREATE TABLE IF NOT EXISTS clients_type (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS clients (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  business_id   INT NOT NULL,
  person_id  INT NOT NULL,
  type_id     INT NOT NULL,
  FOREIGN KEY (business_id) REFERENCES business (id),
  FOREIGN KEY (person_id) REFERENCES person (id),
  FOREIGN KEY (type_id) REFERENCES clients_type (id)
);
/*Aca termina lo de los clientes */



/*Aca empieza lo de las transacciones */
CREATE TABLE IF NOT EXISTS transaction_type (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  type_id    INT NOT NULL,
  clients_id INT NOT NULL,
  users_id   INT NOT NULL,
  FOREIGN KEY (type_id) REFERENCES transaction_type (id) ,
  FOREIGN KEY (clients_id) REFERENCES clients (id) ,
  FOREIGN KEY (users_id) REFERENCES users (id)
);
/*Aca termian lo de las treansacciones */


/*Aca empieza lo de las facturas cerotas */
CREATE TABLE IF NOT EXISTS type_bills (
  id     INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE bills (
  transaccion_id           INT PRIMARY KEY,
  tipo_id                  INT NOT NULL,
  codigo                   INT ,
  ventas_gravadas          NUMERIC(15, 2), -- cf
  ventas_excentas          NUMERIC(15, 2),
  subtotal                 NUMERIC(15, 2), -- normal, cf
  iva_retenido             NUMERIC(15, 2), -- cf
  total                    NUMERIC(15, 2), -- normal, cf
  fecha                    DATE,
  numero_remision_anterior INT,
  fecha_remision_anterior  DATE,
  pdf                      VARCHAR(10000),
  FOREIGN KEY (transaccion_id) REFERENCES transactions (id),
  FOREIGN KEY (tipo_id) REFERENCES type_bills (id)
);
/*Aca termian lo de las facturas */
