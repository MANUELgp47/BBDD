
/*DROP TABLE compa�ia;

CREATE TABLE compa�ia (
cif char (9),
nombre varchar (20),
web varchar (30),
CONSTRAINT cifClave primary key (cif)
);
*/
/*
create table tarifa (
tarifa char(10),
compa�ia char (9),
descripcion varchar(50),
coste number (3, 2),
constraint tarifaClave PRIMARY KEY (tarifa, compa�ia),
constraint tarifaajena FOREIGN key (compa�ia) REFERENCES compa�ia(cif)
);
*/
/*
create table cliente (
dni CHAR (9),
nombre varchar (50),
f_nac date,
direccion varchar(100),
cp char (6),
ciudad varchar (50),
provincia varchar (50),
constraint clienteclave primary key (dni)
);
*/
/*
create table telefono (
numero CHAR (9),
f_contacto date,
tipo char(1),
puntos number (6, 0),
compa�ia char (9),
tarifa char (10),
cliente char (9),
constraint telefonoclave primary key (numero),
constraint tftarifaajena FOREIGN key (tarifa, compa�ia) REFERENCES tarifa,
constraint tfcompa�iaajena FOREIGN key (compa�ia) REFERENCES compa�ia(cif),
constraint tfclienteajena FOREIGN key (cliente) REFERENCES cliente(dni),
constraint tftipo check (tipo in ('T', 'C'))
);
*/
/*
create table llamada (
tf_origen char (9),
tf_destino char (9),
fecha_hora TIMESTAMP ,
duracion number (5, 0),
constraint llamadaclave primary key (tf_origen, fecha_hora),
constraint llamadaTForigenajena FOREIGN key (tf_origen) REFERENCES telefono(numero),
constraint llamadaTFdestinoajena FOREIGN key (tf_destino) REFERENCES telefono(numero),
constraint llamadadesunique unique (tf_destino, fecha_hora)
);*/


alter table compa�ia 
add constraint ciaunica unique (nombre);

describe llamada;

alter table llamada 
add constraint llamadaTfdistintos Check (tf_origen <> tf_destino);


alter table tarifa 
add constraint tarifacoste check (coste <= 1.50 and coste >=0.05);

alter table compa�ia 
add constraint compa�iaNomobligatorio  nombre not null;
alter table cliente 
add constraint ClienteNomobligatorio nombre not null;
alter table tarifa 
modify coste not null;


alter table tarifa
add constraint tarifaajena FOREIGN key (compa�ia) references compa�ia (cif) on delete cascade;


---------# Clase 3 #---------

INSERT INTO compañia values ('A00000001', 'Kietostar', 'http://www.kietostar.com') ;
INSERT INTO compañia values ('B00000002', 'Aotra', 'http://www.aotra.com') ;

INSERT INTO TARIFA values('joven', 'D00000004', 'menores de 21 años', 0,20) ;
INSERT INTO TARIFA values('dúo', 'B00000002', 'la pareja también está en la compañía', 0,18) ;
INSERT INTO TARIFA values('amigos', 'B00000002', '10 amigos están también en la compañía', 1,60) ;
