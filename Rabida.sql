
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

------Practica 2 #############
select * from ei.profesor;

select tipo from ei.ordenador ;

select distinc O.tipo Esto_es_un_alias
from ei.ordenador O;--la "O" es un alias 

select A.Idasig as codigo, A.Nombre, A.ESP as especialidad
from EI.ASIGNATURA A 
WHERE A.curso = 3 and A.creditos > 4.5;

select A.NOMBRE, A.NH AS NUM_HERMANOS, 300*A.NH AS DESCUENTO
from EI.ALUMNO A
ORDER BY DESCUENTO DESC, A.NOMBRE;

select A.DNI, A.NOMBRE
from EI.ALUMNO A
WHERE (EXTRACT (YEAR FROM A.FECHANAC ) BETWEEN 1970 AND 1974) 
		AND (A.LUGar IN ('Huelva','Cadiz');
		
select to_char(sysdate, 'dd-mm-yyyy hh:mi:ss') fecha_hora
from dual; 

select to_char(CURRENT_DATE, 'dd-mm-yyyy hh:mi:ss') fecha_hora --CURRENT_DATE HORA DE LA ZONA HORARIA DE LA SESIÓN
from dual; 

SELECT A.NOMBRE
FROM EI.ALUMNO
WHERE NOMBRE LIKE 'M%'AND LUGAR LIKE '______%' AND LUGAR NOT LIKE 'P%';
		     
SELECT DISTINCT (EXTRACT (YEAR FROM FECHANAC ) ANIO --DISTINCT PARA QUE NO SE REPITAN LOS MISMO AÑOS VARIAS VECES
FROM EI.ALUMNO
ORDER BY ANIO;

--MF-1. Obtener el nombre de las compañías cuya dirección web contenga la cadena ‘et’ y acabe en ‘com’
SELECT NOMBRE
FROM MF.COMPAÑIA
WHERE WEB LIKE '&et&com';

--MF-2. Obtener el nombre y dirección de los clientes nacidos en 1973 o 1985 y cuyo código postal comience por 
-- 15, ordenado ascendentemente por el nombre y, en caso de igualdad, descendentemente por la dirección
select nombre, direccion 
from mf.cliente 
where (EXTRACT (YEAR FROM F_NAC ) IN (1973, 1985) AND CP LIKE '15%'
ORDER BY NOMBRE, DIRECCION DESC;

-- MF-3. Obtener el teléfono de destino de las llamadas realizadas desde el número  “666010101”, en el año 2006
SELECT tf_destino
FROM MF.LLAMADA
WHERE tf_origen = '666010101' AND (EXTRACT (YEAR FROM fecha_hora ) = 2006;

-- MF-4. Obtener los números de teléfono que han llamado alguna vez al “666010101”, entre las 10:00 y las 12:00
