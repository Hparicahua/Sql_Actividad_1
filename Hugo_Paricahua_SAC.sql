-- ACTIVIDAD: Crear un crud que tenga procedimientos almacenados, triggers, 
--funciones, tablas (tablas relacionadas) y que genere un backup de la base de datos.
Create database Hugo_Paricahua_SAC

use Hugo_Paricahua_SAC

--******************************************************************
--********************CREACION DE TABLAS*************************
--******************************************************************
--creacion de tabla usuario
create table usuario
(
id_usuario int not null identity(1,1) primary key, 
id_empleado int,
tipo_usuario varchar(13),
nombre varchar(30),
contraseña varchar(10)
)


--creacion de la tabla empleados
create table empleado 
(
id_empleado int not null identity(1,1) primary key, 
nombre_e varchar(30), 
direccion_e varchar(30), 
cargo varchar(30), 
edad varchar(2),  
estado_civil varchar(10),
celular int, 
hora_ingreso datetime,
clave varchar (20) 
);

--Crear tabla clientes

create table cliente
(
id_cliente int not null identity(1,1) primary key,
nombre_cli varchar(30),
direccion_cli varchar(30),
sexo varchar(10),
dni BIGINT,
ruc BIGINT,
celular int,
edad_descuento varchar(3)
);


--Crear tabla compras
create table compra
(
id_compra int not null identity(1,1) primary key,
fecha datetime,
id_cliente int,
id_empleado int,
nombre_e varchar(30),
nombre_cli varchar(30),
tipo_de_pago varchar(8), 
total int 
);

--Crear la tabla proveedor
create table proveedor 
( 
id_proveedor int not null identity(1,1) primary key,
nombre_prov varchar(30),
direccion_prov varchar(40),
email varchar(40),
telefono int,
celular int
);


--Create tabla Producto

create table producto 
( 
id_producto int not null identity(1,1) primary key, 
id_categoria int not null, 
id_proveedor int, 
nombre_pro varchar(30) not null, 
stock int not null, 
fecha_cad datetime not null , 
pre_compra decimal(10,2) not null
);


--Creacion de tabla categorias del producto
create table categoria 
( 
id_categoria int not null identity(1,1) primary key, 
descripcion varchar(30) not null 
);


--Creacion de tabla de detalle proveedor y empelado
create table detalle_solicitar
(
id_detalle_solicitar int not null identity(1,1) primary key,
id_proveedor int not null,
id_empleado int not null,
fecha datetime not null
);


--Creacion de tabla de detalle de producto y proveedor
create table detalle_pedido 
( 
id_detalle_pedido int not null identity(1,1) primary key, 
id_producto int not null, 
nombre_pro varchar(40) not null, 
cantidad decimal(10,2), 
precio_venta decimal(10,2), 
importe decimal(10,2) 
);

--Creacion tabla que contiene la factura
create table factura
(
id_factura int not null identity(1,1) primary key,
id_compra int not null, 
id_empleado int not null, 
nombre_cli varchar(30) not null, 
subtotal int not null, 
descuento int not null, 
total int not null,
fecha datetime not null
);


----------------------------------------------------------
--********** CREACION DE LLAVES FORANEAS  **************

alter table usuario
add constraint fk_id_empleado
foreign key(id_empleado) references empleado(id_empleado)

alter table compra
add constraint fk_id_empleados
foreign key(id_empleado) references empleado(id_empleado);

alter table compra
add constraint fk_id_clientes
foreign key(id_cliente) references cliente(id_cliente);

alter table producto
add constraint fk_id_proveedor
foreign key(id_proveedor) references proveedor(id_proveedor); 

alter table producto 
add constraint fk_id_categoria 
foreign key(id_categoria) references categoria(id_categoria);

alter table detalle_pedido 
add constraint fk_id_producto 
foreign key(id_producto) references producto(id_producto);

alter table factura 
add constraint fk_id_compra 
foreign key(id_compra) references compra(id_compra);

alter table detalle_solicitar 
add constraint fk_proveedor_id 
foreign key(id_proveedor) references proveedor(id_proveedor);

alter table detalle_solicitar 
add constraint fk_empleado_id 
foreign key(id_empleado) references empleado(id_empleado);

--Creacion de restricciones

alter table cliente add constraint ck_sexo check(sexo IN('Masculino','Femenino'));
alter table cliente add constraint uni_dni unique(dni);
alter table cliente add constraint uni_ruc  unique(ruc) ;
alter table empleado add constraint ck_estado_civil check(estado_civil IN('Soltero','Casado','Divorciado'));
alter table usuario add constraint ck_tipo_usuario check(tipo_usuario IN ('Administrador','Empleado'));
alter table compra add constraint ck_tipo_de_pago check(tipo_de_pago IN('Efectivo','Tarjeta'));

--Insertar
--ISERTAR DATOS A LAS TABLAS Empleado
create trigger TR_empleado_insert
on empleado
for insert
as
print 'hubo un cambio en la tabla empleado';

insert into Empleado values('Jose Cahuana','San vicente','Administrador','21','Casado',159321647,'2021-12-22T00:21:14.480','1234');
insert into Empleado values('Luis Rocha','Quilmana','Empleado','24','Soltero',123552687,'2021-12-22T09:00:00','1234');
insert into Empleado values('Brayan Grial','San vicente','Empleado','30','Casado',164523978,'2021-12-22T10:00:00','1934');
insert into Empleado values('Ernesto Fuente','Sam vicente','Empleado','20','Soltero',121235647,'2021-12-22T11:00:00','1234');
insert into Empleado values('Luis Ferrer','Imperial','Empleado','24','Soltero',156345780,'2021-12-22T12:00:00','1234');

--INSERTAR DATOS A LA TABLA Usuario
create trigger TR_usuario_insert
on usuario
for insert
as
print 'hubo un cambio en la tabla usuario';

insert into usuario values('1','Administrador','Jose Cahuana','pescado2');
insert into usuario values('2','Empleado','Luis Rocha','keoc4512');
insert into usuario values('3','Empleado','Brayan Grial','oo.ll125');
insert into usuario values('4','Empleado','Ernesto Fuente','fuente32');
insert into usuario values('5','Empleado','Luis Ferrer','ferr45er');

--ISERTAR DATOS A LAS TABLAS Cliente
create trigger TR_cliente_insert
on cliente
for insert
as
print 'hubo un cambio en la tabla cliente';

insert into cliente values('Lina','San vicente','Femenino',72884742,12345651245,997547215, 20);
insert into cliente values('Jose luis','San vicente','Masculino',84884342,10841884342,997547655, 24);
insert into cliente values('Cristina','Sam vicente','Femenino',84884042,18084884042,997547699,22);
insert into cliente values('Dany','San vicente','Masculino',84884942,10848849402,997547688,26);

--INSERTAR DATOS A LAS TABLAS Proveedor
create trigger TR_proveedor_insert
on proveedor
for insert
as
print 'hubo un cambio en la tabla proveedor';

insert into proveedor values('Metro','Lima','metro@gmail.com','3244550','997287262');
insert into proveedor values('Inkafarma','Asia','inkafarma@gmail.com','3246343','997284534');
insert into proveedor values('oukitas','La victoria','oukitas@gmail.com','3244334','997287234');
insert into proveedor values('credifarma','Mala','credifarma@gmail.com','3246343','997287564');

--INSERTAR DATOS A LAS TABLAS Categorias
create trigger TR_categoria_insert
on categoria
for insert
as
print 'hubo un cambio en la tabla categoria';

insert into categoria values('Dolor muscular');
insert into categoria values('Dolor de cabeza');
insert into categoria values('Dolor de diente');
insert into categoria values('Infecciones');
insert into categoria values('Resfrio');
insert into categoria values('Fiebre');


--INSERTAR DATOS A LAS TABLAS Producto
create trigger TR_producto_insert
on producto
for insert
as
print 'hubo un cambio en la tabla producto';

insert into producto values('2','1','naproxeno',20,'2022-12-10 00:00:00','0.30');
insert into producto values('2','2','PANADOL',19,'2022-12-10 00:00:00','1.00');
insert into producto values('1','1','DOLOCONTO',18,'2022-12-10 00:00:00','1.00');
insert into producto values('3','4','FORTE AS',20,'2022-12-10 00:00:00','1.00');

--INSERTAR DATOS A LAS TABLAS Detalle_pedido
create trigger TR_detalle_pedido
on detalle_pedido
for insert
as
print 'hubo un cambio en la tabla detalle_pedido';

insert into detalle_pedido values('2','PANADOL','13.3','2.50','0.10');
insert into detalle_pedido values('2','PANADOL','14.3','2.50','0.10');
insert into detalle_pedido values('2','PANADOL','19.3','2.50','0.10');
insert into detalle_pedido values('3','DOLOCONTO','15.3','1.50','0.12');
insert into detalle_pedido values('1','naproxeno','20.3','1.50','0.11');

--INSERTAR DATOS A LAS TABLAS Detalle_solicitar
create trigger TR_detalle_solicitar
on detalle_solicitar
for insert
as
print 'hubo un cambio en la tabla detalle_solicitar';

insert into detalle_solicitar values('2','1','2021-11-10 09:30:00');
insert into detalle_solicitar values('2','1','2021-11-10 09:30:00');
insert into detalle_solicitar values('2','1','2021-11-10 09:30:00');
insert into detalle_solicitar values('3','1','2021-11-10 10:30:00');
insert into detalle_solicitar values('1','1','2021-11-10 08:30:00');

--INSERTAR DATOS A LAS TABLAS Compra
create trigger TR_compra_insert
on compra
for insert
as
print 'hubo un cambio en la tabla compra';


insert into compra values('2021-10-10 08:00:00','1','2','Luis Rocha','Lina','Tarjeta','245');
insert into compra values('2021-11-11 09:10:00','3','2','Luis Rocha','Cristina','Tarjeta','80');
insert into compra values('2021-10-11 09:30:00','2','4','Ernesto Fuente','Jose luis','Efectivo','600');
insert into compra values('2021-11-11 09:40:00','4','5','Luis Ferrer','Dany','Efectivo','6754');
insert into compra values('2020-11-11 09:50:00','4','3','Brayan Grial','Dany','Efectivo','345');

--Actualizar
Update proveedor set celular='985453492' WHERE nombre_prov = 'credifarma';
Update empleado set estado_civil ='Soltero' Where nombre_e ='Jose luis';

--Eliminar

Delete from compra where nombre_e='Luis Ferrer';
Delete from compra where nombre_e='Ernesto Fuente';

--Visualizar

rec



DBCC CHECKIDENT (Empleado, RESEED, 0)

--GENERACION DE BACKUP

backup database Hugo_Paricahua_SAC to disk='d:\bd\Hugo_Paricahua2022_06_2022.bak'

backup database Hugo_Paricahua_SAC to disk='d:\bd\Hugo_Paricahua2022_06_2022.bak'
with differential
go
alter proc copiaBD @bd varchar(20), @nomcopia varchar(30)
as
declare @sql varchar(100)
set @sql ='backup database ' +@bd +' to disk=' + char(39)+'d:\bd\' +@nomcopia+'bak'+char(39)
exec (@sql)
go

copiaBD 'Hugo_Paricahua_SAC','Bakcup240622'