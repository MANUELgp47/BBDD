
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
SELECT distinct tf_destino
FROM MF.LLAMADA
WHERE tf_origen = '666010101' AND (EXTRACT (YEAR FROM fecha_hora ) = 2006;

-- MF-4. Obtener los números de teléfono que han llamado alguna vez al “666010101”, entre las 10:00 y las 12:00
select distinct tf_origen
FROM MF.LLAMADA
WHERE TF_DESTINO ='666010101' AND ESTRACT (hour from fecha_hora) between 10 and 12;				   
				   
----------Clase 4 08/11

--EI-8. Obtener los nombres de las asignaturas junto con el nombre del profesor responsable
select A.NOMBRE, P.NOMBRE
FROM EI.ASIGNATURA A, EI.PROFESOR P
WHERE A.PROF = P.NPR;
--MISMO PERO CON INNER JOIN
SELECT A.NOMBRE AS NOMASIG, P.NOMBRE AS NOMPROF
FROM EI.ASIGNATURA A INNER JOIN EI.PROFESOR P ON A.PROF = P.NPR

--EI-9. Obtener los números de los alumnos que se han matriculado en Bases de Datos I en el curso 2002-03
SELECT ALUM
FROM EI.MATRICULA M INNER JOIN EI.ASIGNATURA A USING (IDASIG)
WHERE A.NOMBRE = 'Bases de Datos I' AND AÑO=2002;

/*EI-10. Obtener los nombres de los alumnos que han aprobado la asignatura Algoritmos y Estructuras de 
Datos I en la convocatoria de febrero_junio de 2001*/
select A.NOMBRE
from (EI.ASIGNATURA ASIG INNER JOIN EI.MATRICULA M USING(IDASIG))
  INNER JOIN EI.ALUMNO A ON M.ALUM = A.NAI
where ASIG.NOMBRE = 'Algoritmos y Estructuras de Datos I' AND AÑO = 2001 AND FEB_JUN >=5;

/*EI-11. Obtener un listado con el número de despacho, pero sólo de aquellos donde hay al menos 2 
profesores*/
SELECT DISTINCT DESPACHO
FROM EI.PROFESOR P1 JOIN EI.PROFESOR P2 USING (DESPACHO)
WHERE P1.NOMBRE <> P2.NOMBRE;

/*EI-12. Obtener una lista con todas las asignaturas de las que es responsable o docente la profesora 
Dolores Toscano Barriga*/
(SELECT A.NOMBRE
FROM EI.ASIGNATURA A INNER JOIN EI.PROFESOR P ON P.NPR = A.PROF 
WHERE P.NOMBRE ='Dolores Toscano Barriga')
UNION
(SELECT A.NOMBRE
FROM (EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG))
INNER JOIN EI.PROFESOR P ON M.PROF=P.NPR
WHERE P.NOMBRE = 'Dolores Toscano Barriga');

/*EI-13. Obtener los nombres de los alumnos que no se han presentado a ‘Bases de Datos I’ en diciembre 
de 2002 por haberla aprobado en una convocatoria anterior del mismo año*/
SELECT A.nombre
FROM (EI.ALUMNO A INNER JOIN EI.MATRICULA M ON A.nAI=M.alum)
  INNER JOIN EI.ASIGNATURA ASIG USING (idAsig)
WHERE ASIG.nombre = 'Bases de Datos I' AND AÑO = 2002 AND dic IS NULL AND (feb_jun>= OR sep>=5);


/*MF-5. Mostrar el código y coste de las tarifas junto con el nombre de la compañía que las ofrecen, de aquellas 
tarifas cuya descripción indique que otras personas deben estar también en la misma compañía*/
SELECT T.TARIFA, T.COSTE, C.NOMBRE
FROM MF.TARIFA T INNER JOIN MF.COMPAÑIA C ON T.COMPAÑIA = C.CIF
WHERE T.DESCRIPCION LIKE '% compañía';

/*MF-6. Nombre y número de teléfonos de aquellos abonados con contrato que tienen tarifas inferiores a 0,20 €*/
select tf.numero, c.nombre
from (mf.telefono tf inner join  mf.tarifa t using (tarifa, compañia))
      inner join mf.cliente c on tf.cliente = c.dni
where tf.tipo = 'C' and t.coste < 0.2;

/*MF-7. Obtener el código de las tarifas, el nombre de las compañías, los números de teléfono y los puntos, de 
aquellos teléfonos que se contrataron en el año 2006 y que hayan obtenido más de 200 puntos*/
select t.tarifa, c.nombre--, tf.nuemero, tf.puntos
from  mf.tarifa t inner join mf.compañia c on t.compañia = c.cif
      mf.telefono tf inner join c tf..compañia = c.cif
where (EXTRACT (YEAR FROM tf.f_contrato ))=2006 and t.puntos > 200;
---terminar 


/*MF-8. Obtener los números de teléfono (origen y destino), así como el tipo de contrato, de los clientes que 
alguna vez hablaron por teléfono entre las 8 y las 10 de la mañana*/
select distinct tfo.numero origen , tfo.tipo, tfd.numero destino, tfd.tipo
from mf.telefono tfo inner join mf.llamada ll on tfo.numero = ll.tf_origen
inner join mf.telefono tfd on tfd.numero = ll.tf_destino
where extract (hour from fecha_hora) >= 8 and extract (hour from fecha_hora) <10;
				   
/*MF-9. Interesa conocer los nombres y números de teléfono de los clientes (origen y destino) que, perteneciendo 
a  compañías distintas, mantuvieron llamadas que superaron los 15 minutos. Se desea conocer, también, la 
fecha y la hora de dichas llamadas así como la duración de esas llamadas*/
				   
----------Clase 5 15/11
--------------TEORIA 

SELECT NOMBRE 
FROM EI.ALUMNO
WHERE LUGAR =(SELCT LUGAR WHERE FROM EI.ALUMNO WHERE NOMBRE = 'SAMUEL...')
  AND nH = (SELECT..... ;

--ALUMNOS MATRI. EN BD2 Y NO EN BD1
SELECT NOMBRE 
FROM EI.ALUMNO 
WHERE nAI IN (SELECT M.ALUM FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG) WHERE A.NOMBRE = 'bd2')
  AND NAI NOT IN (SELECT M.ALUM FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG) WHERE A. NOMBRE = 'BD2');
  
--LISTA DE PROF CON MAS ANTIGÜEDAD QUE ALGUNO DE LOS PROFESORES DEL DESPACHO fc-7366
SELECT NOMBRE 
FROM EI.PROFESORE
WHERE DESPACHO <> 'FC-...' AND
    ANT < ANY ( SELECT ANT FROM EI.PROFESOR WHERE DESPACHO = 'FC-...';

--DATOS NOM ALU CON NOTA SEPTIEBRE > QUE LA MAS ALTA DE LAS NOTAS DE JUNIO EN BD1 EN 2002
SELECT AL.NOMBRE
FROM (EI.MATRICULA M INNER JOIN EI.ASIGNATURA A USING (IDASIG))
      INNER JOIN EI.ALUMNO AL ON AL.nAL=ALUM 
WHERE A.NOMBRE = 'BD1' AND AÑO = 2002
  AND SEP > ALL (SELECT FEB_JUN FROM EI.MATRICULA M INNER JOIN EI.ASIGNATURA A USING (IDASIG) WHERE NOMBRE = 'BD1' AND AÑO= 2002 AND FEB_JUN IS NOT NULL);
  
--MF-10
SELECT TO_CHAR ( FECHA_HORA , 'DD/MM/YYYY') FECHA
FROM LLAMDA 
WHERE DURACION >= ALL ( SELECT DURACION FROM LLAMADA );

--MF-11
SELECT NOMBRE 
FROM CLIENTE
WHEN DNI = ( SELECT CLIENTE FROM TELEFONO T INNER JOIN COMPAÑIA USING (COMPAÑIA) WHERE COMPAÑIA.NOMBRE = 'Aotra' AND TELEFONO.NUMERO='654123321')
  
SELECT C.NOMBRE
FROM (MF.CLIENTE C INNER JOIN MF.TELEFON T ON C.DNI=T.CLIENTE) INNER JOIN MF.COMPAÑIA CO ON CO.EIF=T.COMPAÑIA
WHERE CO.NOMBRE = 'Aotra' and T.TARIFA = ( SELECT T.TARIFA FROM MF.TELEFONO T WHERE T.NUMERO = '654123321');
 

 
--MF-12
SELECT DISTINCT T.NUMERO, T.F_CONTRATO. T.TIPO
FROM MF.TELEFONO T INNER JOIN MF.LLAMADA LL ON T.NUMERO = LL.TF_ORIGEN 
WHERE TO_CHAR (LL.FECHA_HORA, 'MM/YY') = '10/06'
  AND LL.TF_DESTINO NOT IN (SELECT T.NUMERO FROM MF.TELEFONO Y INNER JOIN MF.CLIENTE C ON C.DNI = T.CLIENTE WHERE PROVINCIA = 'La Coruña' );

--MF-13
SELECT NOMBRE 
FROM MF.CLIENTE
WHERE DNI IN (SELECT CLIENTE FROM MF.TELEFONO WHERE TARIFA= 'dúo') and DNI not in ( SELECT CLIENTE FROM MF.TELEFONO WHERE TARIFA= 'autónomos');

/*MF-16. Se necesita conocer el nombre de los clientes que tienen teléfonos con fecha de contratación anterior a 
alguno de los teléfonos de Ramón Martínez Sabina, excluido, claro, el propio Ramón Martínez Sabina.*/
SELECT NOMBRE
FROM mf.CLIENTES C INNER JOIN mf.TELEFONO T USING (DNI)
WHERE TO_CHAR (T.f_contrato, 'dd/MM/YY') < any (select TO_CHAR (T.f_contrato, 'dd/MM/YY') fecha
                                                from mf.telefono INNER JOIN mf.cliente cli USING (cliente)
                                                where cli.nombre <> 'Ramón Martínez Sabina');
select distinct c.nombre
from mf.cliente c inner join mf.telefono t on c.dni = t.cliente
where c.nombre <> 'Ramón Martínez Sabina'
      and t.f_contrato < any (select t.f_contrato
                              from mf.cliente c inner join mf.telefono t on c.dni = t.cliente 
                              where c.nombre = 'Ramón Martínez Sabina');
