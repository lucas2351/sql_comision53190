-- Crear base de datos Sistemas 

DROP SCHEMA if exists Sistema;
CREATE SCHEMA IF NOT EXISTS Sistema;
-- Tabla categoría
use Sistema;

create table if not exists categoria(
	idcategoria integer auto_increment,
	nombre varchar(50) not null ,
	descripcion varchar(256) null,
    condicion tinyint(1),
    unique (idcategoria),
    unique (nombre),
    primary key (idcategoria)
);
-- Solo hago una prueba para ver si se insertan los datos 




use Sistema;

-- Tabla artículo
create table if not exists  articulo(
	idarticulo integer  auto_increment,
	idcategoria integer not null,
	codigo varchar(50) null,
	nombre varchar(100) not null,
	precio_venta decimal(11,2) not null,
	stock integer not null,
	descripcion varchar(256) null,
	condicion tinyint(1),
    primary key (idarticulo),
    unique (nombre),
	FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria)
    
);

use Sistema;
-- Tabla persona
create table if not exists  persona(
	idpersona integer  auto_increment,
	tipo_persona varchar(20) not null,
	nombre varchar(100) not null,
	tipo_documento varchar(20) null,
	num_documento varchar(20) null,
	direccion varchar(70) null,
	telefono varchar(20) null,
	email varchar(50) null,
    primary key (idpersona)
);
 use Sistema;
-- Tabla rol
create table if not exists  rol(
	idrol integer  auto_increment,
	nombre varchar(30) not null,
	descripcion varchar(100) null,
	condicion bit default(1),
    primary key (idrol)
);
use Sistema;
-- Tabla usuario
create table if not exists  usuario(
	idusuario integer auto_increment,
	idrol integer not null,
	nombre varchar(100) not null,
	tipo_documento varchar(20) null,
	num_documento varchar(20) null,
	direccion varchar(70) null,
	telefono varchar(20) null,
	email varchar(50) not null,
	password_hash char(64) not null,
	condicion tinyint(1),
    primary key (idusuario),
	FOREIGN KEY (idrol) REFERENCES rol (idrol)
);
use Sistema;
-- Tabla iegreso
create table if not exists ingreso(
	idingreso integer  auto_increment,
	idproveedor integer not null,
	idusuario integer not null,
	tipo_comprobante varchar(20) not null,
	serie_comprobante varchar(7) null,
	num_comprobante varchar (10) not null,
	fecha_hora datetime not null,
	impuesto decimal (4,2) not null,
	total decimal (11,2) not null,
	estado varchar(20) not null,
    primary key (idingreso),
	FOREIGN KEY (idproveedor) REFERENCES persona (idpersona),
	FOREIGN KEY (idusuario) REFERENCES usuario (idusuario)
);
  use Sistema;
-- Tabla detalle_ingreso
create table if not exists  detalle_ingreso(
	iddetalle_ingreso integer  auto_increment,
	idingreso integer not null,
	idarticulo integer not null,
	cantidad integer not null,
	precio decimal(11,2) not null,
    primary key (iddetalle_ingreso),
	FOREIGN KEY (idingreso) REFERENCES ingreso (idingreso) ON DELETE CASCADE,
	FOREIGN KEY (idarticulo) REFERENCES articulo (idarticulo)
);


-- Tabla venta
create table if not exists  venta(
	idventa integer  auto_increment,
	idcliente integer not null,
	idusuario integer not null,
	tipo_comprobante varchar(20) not null,
	serie_comprobante varchar(7) null,
	num_comprobante varchar (10) not null,
	fecha_hora datetime not null,
	impuesto decimal (4,2) not null,
	total decimal (11,2) not null,
	estado varchar(20) not null,
    primary key (idventa),
	FOREIGN KEY (idcliente) REFERENCES persona (idpersona),
	FOREIGN KEY (idusuario) REFERENCES usuario (idusuario)
);

-- Tabla detalle_venta
create table if not exists  detalle_venta(
	iddetalle_venta integer  auto_increment,
	idventa integer not null,
	idarticulo integer not null,
	cantidad integer not null,
	precio decimal(11,2) not null,
	descuento decimal(11,2) not null,
    primary key (iddetalle_venta),
	FOREIGN KEY (idventa) REFERENCES venta (idventa) ON DELETE CASCADE,
	FOREIGN KEY (idarticulo) REFERENCES articulo (idarticulo)
);