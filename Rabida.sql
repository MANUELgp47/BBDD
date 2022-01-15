
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

------clase 6	       
---22/11/2021
--EI-18. Listado de los despachos donde hay profesores que no son responsables de ninguna asignatura
select distinct p.despacho
from ei.profesor p
where not EXISTS(select * from ri.asignatura a where p.npr= a.profesor);

/*EI-19. Listado de los alumnos que se han matriculado de alguna asignatura en el año 2000 o 2002, y de 
ninguna asignatura en el año 2001*/
select nombre 
from ei.alumno a
where exists (select *
              from ei.matricula m
              where (año = 2000 or año = 2002) and a.NAL = m.alum)
              and not exists
              ( select * from ei.matricula m where año = 2001 and a.nal = m.alum);
            
--ei-20
select nombre, despacho
from  ei.profesor p1
where despacho not in (select despacho
                      from ei.profesor p2
                      where p2.npr <>p1.npr);
                      
/*MF-17. Utilizando consultas correlacionadas, mostrar el nombre de los abonados que han llamado el día ‘16/10/06’*/
select  nombre 
from mf.cliente c
where exists (SELECT * from mf.telefono tf inner join mf.llamada ll on tf.numero = ll.tf_origen 
              where c.dni = tf.cliente and TO_CHAR (ll.FECHA_HORA, 'dd/MM/YY') = '16/10/06');


/*MF-18. Utilizando consultas correlacionadas, obtener el nombre de los abonados que han realizado llamadas de 
menos de 1 minuto y medio*/
select nombre
from mf.cliente c
where exists (select * from mf.llamada ll inner join mf.telefono tf on ll.tf_origen = tf.numero 
              where c.dni= tf.CLIENTE and ll.DURACION <90);

/*MF-19. Utilizando consultas correlacionadas, obtener el nombre de los abonados de la compañía ‘KietoStar’ que 
no hicieron ninguna llamada el mes de septiembre*/
select c.nombre, tf.numero 
from mf.cliente c inner join MF.TELEFONO tf on tf.cliente = c.DNI
                  inner join mf.compañia co on co.cif= tf.compañia
where co.nombre = 'Kietostar' and not exists ( select * from MF.LLAMADA ll 
                                               where tf.numero = ll.tf_origen and extract (month from ll.fecha_hora) = 9);                 
      
/*MF-20. Utilizando consultas correlacionadas, mostrar todos los datos de los telefonos que hayan llamado al 
número 654234234 pero no al 666789789*/
select *
from MF.TELEFONO t
where EXISTS ( select * from MF.LLAMADA where tf_origen = t.numero and tf_destino = 654234234) and not exists ( select * from MF.LLAMADA where tf_origen = t.numero and tf_destino = 666789789);

/*MF-21. Utilizando consultas correlacionadas, obtener el nombre y número de teléfono de los clientes de la 
compañía Kietostar que no han hecho llamadas a otros teléfonos de la misma compañía*/
select c.nombre, t.numero 
from mf.cliente c inner join MF.TELEFONO t on t.cliente = c.DNI
                  inner join mf.compañia cia on cia.cif= t.compañia
where cia.nombre = 'Kietostar' and not exists (select * from mf.llamada l inner join mf.telefono td on 
                                        td.numero=l.tf_destino
                                        inner join mf.compañia c on c.cif = td.compañia
                                      where c.nombre = 'Kietostar' and t.numero = l.tf_origen);

                                      
----Clase 7
---29/11/2021


--EI21
SELECT P.NOMBRE, A.NOMBRE
FROM EI.PROFESOR P LEFT OUTER JOIN EI.ASIGNATURA A ON P.NPR = A.PROF;

--EI22
SELECT COUNT (DISTINCT DESPACHO)-- AS DESPACHOS
FROM EI.PROFESOR;

--EI23
SELECT COUNT (*), MAX (SEP) AS MAXIMA, MIN (SEP) AS MINIMA, AVG(SEP) MEDIA
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG)
WHERE A.NOMBRE = 'Bases de Datos I' AND M.AÑO=2002;

--EI24
SELECT A.NOMBRE
FROM EI.ASIGNATURA A
WHERE (SELECT COUNT(*) FROM EI.RECOMENDACIONES R WHERE A.IDASIG= R.IDASIG1) >= 2;

--EI25
SELECT P1.NOMBRE
FROM EI.PROFESOR P1
WHERE (SELECT COUNT(*) FROM EI.PROFESOR P2 WHERE P1.ANT > P2.ANT)>=5;

--EI26
SELECT A.NOMBRE , M.AÑO , COUNT(FEB_JUN) AS PRESENTADOS, AVG (FEB_JUN) AS MEDIA
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG)
GROUP BY A.NOMBRE, M.AÑO;

--EI27
SELECT A.NOMBRE, ASIG.NOMBRE, COUNT (*)
FROM (EI.ALUMNO A INNER JOIN EI.MATRICULA M ON A.NAL = M.ALUM)
      INNER JOIN EI.ASIGNATURA ASIG USING (IDASIG)
GROUP BY A.NOMBRE, ASIG.NOMBRE
HAVING COUNT(*)>=3;


--EI28
SELECT A.NOMBRE
FROM EI.ALUMNO A INNER JOIN EI.MATRICULA M ON A.NAL = M.ALUM
WHERE AÑO= 2002
GROUP BY A.NOMBRE
HAVING AVG(FEB_JUN)>5;

--EI29
SELECT A.NOMBRE , COUNT(*)
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG)
WHERE AÑO=2002
GROUP BY A.NOMBRE
HAVING COUNT (*)>= ALL (SELECT COUNT (*)FROM EI.MATRICULA WHERE AÑO=2002 GROUP BY IDASIG);

--EI30
SELECT A.NOMBRE, COUNT(*)
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (IDASIG)
WHERE M.AÑO=2002 AND M.FEB_JUN < 5 AND IDASIG IN (SELECT M.IDASIG
                                                 FROM EI.MATRICULA M
                                                 WHERE M.AÑO=2002
                                                 GROUP BY M.IDASIG
                                                 HAVING COUNT(*)>50)
GROUP BY A.NOMBRE ;

SELECT NOMBRE 
FROM EI.ALUMNO AI
WHERE NOT EXSTS (SELECT *FROM EI.ASIGNATURA A INNER JOIN EI.PROFESOR P ON A.PROF = P.NPR;




/*MF-24. Mostrar el nombre de cada cliente junto con coste total de las llamadas que realiza con cada compañia. 
El resultado debe mostrarse ordenado descendentemente por cliente y ascendentemente por compañia*/
SELECT CL.NOMBRE AS CLIENTE , C.NOMBRE AS COMPAÑIA , SUM (LL.DURACION/60*TA.COSTE) AS COSTETOTAL
FROM (MF.CLIENTE CL INNER JOIN MF.TELEFONO T ON T.CLIENTE = CL.DNI)
      INNER JOIN MF.TARIFA TA ON TA.TARIFA = T.TARIFA AND TA.COMPAÑIA = T.COMPAÑIA
      INNER JOIN MF.COMPAÑIA C ON C.CIF= TA.COMPAÑIA
      INNER JOIN MF.LLAMADA LL ON LL.TF_ORIGEN = T.NUMERO
GROUP BY CL.NOMBRE, C.NOMBRE
ORDER BY CLIENTE DESC, COMPAÑIA ASC;
      
/*MF-25. Para cada cliente residente en la provincia de 'La Coruña', mostrar la duración de todas las llamadas 
realizadas a clientes residentes en 'Jaén'*/
SELECT LL.DURACION
FROM MF.LLAMADA LL INNER JOIN MF.TELEFONO TF ON LL.TF_ORIGEN = TF.NUMERO
      INNER JOIN MF.CLIENTE C ON TF.CLIENTE = C.DNI
WHERE C.PROVINCIA ='La Coruña' AND IN (SELECT * FROM LL WHERE C.PROVINCIA = 'Jaén' AND TF.NUMERO= LL.TF_DESTINO);

SELECT CL.NOMBRE AS CLIENTE, SUM (LL.DURACION) AS DURACION
FROM(MF.LLAMADA LL INNER JOIN MF.TELEFONO T ON LL.TF_ORIGEN =T.NUMERO)
  INNER JOIN MF.CLIENTE CL ON T.CLIENTE = CL.DNI
WHERE LL.TF_DESTINO IN (SELECT TE.NUMERO
                        FROM MF.TELEFONO TE INNER JOIN mf.CLIENTE CI ON TE.CLIENTE = CI.DNI
                        WHERE CI.PROVINCIA = 'Jaén')
          and LL.TF_ORIGEN IN (SELECT TE.NUMERO
                               FROM MF.TELEFONO TE INNER JOIN MF.CLIENTE CI ON TE.CLIENTE = CI.DNI
                               WHERE CI.PROVINCIA = 'La Coruña')
group by cl.nombre;

--MF-26
SELECT CI.NOMBRE, COUNT(*) AS TOTAL 
FROM MF.LLAMADA LL INNER JOIN MF.TELEFONO T ON LL.TF_ORIGEN = T.NUMERO
      INNER JOIN MF.CLIENTE CI ON CI.DNI=T.CLIENTE
GROUP BY CI.NOMBRE 
HAVING COUNT(*) >5;

--MF-27
SELECT C.NOMBRE AS CLIENTE, AVG (TA.COSTE) MEDIA
FROM MF.CLIENTE C INNER JOIN MF.TELEFONO TF ON C.DNI = TF.CLIENTE
                  INNER JOIN MF.TARIFA TA USING (TARIFA, COMPAÑIA)
GROUP BY C.NOMBRE                  
HAVING AVG(TA.COSTE) > ALL (SELECT AVG(COSTE)FROM MF.TARIFA);

--MF-28
SELECT C.NOMBRE
FROM MF.CLIENTE C INNER JOIN MF.TELEFONO TF ON TF.CLIENTE = C.DNI 
                  INNER JOIN MF.LLAMADA LL ON TF.NUMERO = LL.TF_ORIGEN 
                  INNER JOIN MF.COMPAÑIA CO ON CO.CIF= TF.COMPAÑIA
WHERE (SELECT * FROM CO WHERE CO.NOMBRE = '' AND             
GROUP BY C.NOMBRE
HAVING SUM (LL.COSTE);
--TERMINAR

--MF-22
SELECT CO.NOMBRE
FROM MF.LLAMADA LL INNER JOIN MF.TELEFONO T ON LL.TF_ORIGEN=T.NUMERO
                   INNER JOIN MF.COMPAÑIA CO ON T.COMPAÑIA = CO.CIF
WHERE TO_CHAR(FECHA_HORA, 'DD/MM/YY')='16/10/06'
GROUP BY CO.NOMBRE
HAVING COUNT (*) >= ALL (SELECT COUNT (*)
                         FROM MF.LLAMADA LL INNER JOIN MF.TELEFONO T ON TF_ORIGEN= T.NUMERO
                         WHERE TO_CHAR(FECHA_HORA, 'DD/MM/YY')='16/10/06'
                         GROUP BY T.COMPAÑIA);    
       
       
       
       
       
       
       
       
       
       

       ----repaso examen
--#############crear tablas 
UNIQUE--NO PUEDE TENER CAMPOS DUPLICADOS
CREATE TABLE RALLY (
  codRally CHAR(4),
  Nombre VARCHAR2(50),
  Pis VARCHAR2(20),
  Fecha DATE,
  CONSTRAINT rallyClave PRIMARY KEY (codRally)
);
CREATE TABLE TRAMO (
  codRally CHAR(4),
  numeroTramo NUMBER(38, 0),
  totalKms NUMBER(5, 2),
  Dificultad CHAR(1) DEFAULT 'B' NOT NULL,
  CONSTRAINT tramoClave PRIMARY KEY (codRally, numeroTramo),
  CONSTRAINT tramoAjena FOREIGN KEY (codRally) REFERENCES RALLY (codRally),
  CONSTRAINT tramoDificultadesValidas CHECK(Dificultad IN ('A','B','C'))
);
---CHECK
CONSTRAINT ATRIBUTO CHECK(CONDICION);

CONSTRAINT nombre CHECK (campo1 > 100)
CONSTRAINT nombre CHECK (sexo IN ('Varón', 'Mujer'))
CONSTRAINT nombre CHECK (nombre1 <> nombre2)
CONSTRAINT nombre CHECK (fecha1 > to_date('11/10/1999','dd/mm/yyyy'))
CONSTRAINT nombre CHECK (fecha1 = fecha2)
--############# BORRAR tablas 
DROP TABLE NOMBRE;
--############# UPDATE
UPDATE ASIGNATURA
SET cuat = 2, esp = 'S'
WHERE nombre = 'Análisis Numérico';
--############# CAMBIAR tablas 
ALTER TABLE RALLY ADD CONSTRAINT rallyNombreUnico UNIQUE(nombre);
ALTER TABLE RALLY ADD CONSTRAINT rallyFechaValida CHECK(Fecha > to_date('01/01/2009', 'dd/mm/yyyy') AND Fecha < to_date('31/12/2009', 'dd/mm/yyyy'));
ALTER TABLE TRAMO DROP CONSTRAINT tramoAjena;
ALTER TABLE TRAMO ADD CONSTRAINT tramoAjena FOREIGN KEY (codRally) REFERENCES RALLY (codRally) ON DELETE CASCADE;

--############# INTRODUCIR DATOS 
INSERT INTO RALLY VALUES ('R001', 'Rally de Cataluña', 'España', to_date('05/09/2009', 'dd/mm/yyyy'));
INSERT INTO TRAMO VALUES ('R001', 1, 50.3, 'A');
INSERT INTO RALLY VALUES ('R004', 'Rally de Andalucia', 'España', to_date('01/10/1997', 'dd/mm/yyyy'));

--############# BORRAR DATOS 
DELETE FROM RALLY;
DELETE FROM RALLY WHERE codRally = 'R002';

-- CREAR MF#####
drop table LLAMADA;
drop table TELEFONO;
drop table CLIENTE;
drop table TARIFA;
drop table COMPAÑIA;


create table COMPAÑIA (
	cif	char(9),
	nombre	varchar(20) NOT NULL,
	web	varchar(30),
	CONSTRAINT ciaClave PRIMARY KEY (cif),
	CONSTRAINT ciaUnica UNIQUE(nombre));

create table TARIFA (
	tarifa		char(10),
	compañia	char(9),
	descripcion	varchar(50),
	coste		number(3, 2) NOT NULL,
	CONSTRAINT tarifaClave PRIMARY KEY (tarifa, compañia),
	CONSTRAINT tarifaAjena FOREIGN KEY (compañia) REFERENCES COMPAÑIA(cif) ON DELETE CASCADE,
	CONSTRAINT tarifaCoste CHECK (coste <= 1.50 AND coste >= 0.05));

create table CLIENTE (
	dni		char(9),
	nombre		varchar(50) NOT NULL,
	f_nac		date,
	direccion	varchar(100),
	cp		char(6),
	ciudad		varchar(50),
	provincia	varchar(50),
	CONSTRAINT clienteClave PRIMARY KEY (dni));

create table TELEFONO (
	numero		char(9),
	f_contrato	date,
	tipo		char(1),
	puntos		number(6, 0),
	compañia	char(9) NOT NULL,
	tarifa		char(10) NOT NULL,
	cliente		char(9),
	CONSTRAINT tfClave PRIMARY KEY (numero),
	CONSTRAINT tfTarifaAjena FOREIGN KEY (tarifa, compañia) REFERENCES TARIFA,
	CONSTRAINT tfCompañiaAjena FOREIGN KEY (compañia) REFERENCES COMPAÑIA(cif),
	CONSTRAINT tfClientejena FOREIGN KEY (cliente) REFERENCES CLIENTE(dni),
	CONSTRAINT tfTipo CHECK (tipo IN ('T', 'C')));

create table LLAMADA (
	tf_origen	char(9),
	tf_destino	char(9),
	fecha_hora	timestamp,
	duracion	number(5, 0) NOT NULL,
	CONSTRAINT llamadaClave PRIMARY KEY (tf_origen, fecha_hora),
	CONSTRAINT llamadaTfOAjena FOREIGN KEY (tf_origen) REFERENCES TELEFONO(numero),
	CONSTRAINT llamadaTfDAjena FOREIGN KEY (tf_destino) REFERENCES TELEFONO(numero),
	CONSTRAINT LlamadaDestUnica UNIQUE(tf_destino, fecha_hora),
	CONSTRAINT llamadaTfDistintos CHECK (tf_origen <> tf_destino));

commit;



insert into COMPAÑIA values ('A00000001','Kietostar','http://wwww.kietostar.com');
insert into COMPAÑIA values ('B00000002','Aotra','http://wwww.aotra.com');
insert into COMPAÑIA values ('C00000003','Petafón','http://wwww.petafon.com');


insert into TARIFA values ('joven', 'A00000001','menores de 25 años', 0.25);
insert into TARIFA values ('dúo', 'A00000001','la pareja también está en la compañía', 0.20);
insert into TARIFA values ('familiar', 'A00000001','4 miembros de la familia en la compañía', 0.15);
insert into TARIFA values ('autónomos', 'B00000002','trabajador autónomo', 0.18);
insert into TARIFA values ('dúo', 'B00000002','la pareja también está en la compañía', 0.15);
insert into TARIFA values ('autónomos', 'C00000003','trabajador autónomo', 0.23);
insert into TARIFA values ('empresa', 'C00000003','todos los empleados están en la compañía', 0.19);

insert into CLIENTE values ('35000001P', 'Ramón Martínez Sabina', '12/02/69', 'C/ Melancolía nº 7', '23400', 'Úbeda', 'Jaén');
insert into CLIENTE values ('42000002C', 'José García Márquez', '19/04/87', 'Avda. de Macondo nº 82', '11900', 'San Román', 'Cádiz');
insert into CLIENTE values ('59000003T', 'Ricardo Reyes Neruda', '10/01/73', 'Carretera de Isla Negra Km. 20', '15704', 'Santiago de Compostela', 'La Coruña');
insert into CLIENTE values ('17000004W', 'Antonio Hierro Santander', '15/03/85', 'Avda. Ciudad de Barcelona', '28015', 'Madrid', 'Madrid');
insert into CLIENTE values ('56000002M', 'Juan Jiménez Platero', '23/12/81', 'C/ Ribera nº 2', '21800', 'Moguer', 'Huelva');
insert into CLIENTE values ('67000002A', 'María Machado Ruiz', '26/07/75', 'C/ Campos de Castilla nº 12', '41004', 'Sevilla', 'Sevilla');
insert into CLIENTE values ('12000002Q', 'Jesús Ríos Lorca', '19/09/90', 'Camino de Bernarda Alba nº 36', '18340', 'Fuente Vaqueros', 'Granada');
insert into CLIENTE values ('89000002Z', 'Rita Martínez de Castro', '15/07/85', 'C/ Sar nº 84', '15900', 'Padrón', 'La Coruña');

insert into TELEFONO values ('654123321', '14/09/2003', 'C', 12750, 'A00000001', 'dúo', '35000001P');
insert into TELEFONO values ('666010101', '09/10/2005', 'T', 1040, 'C00000003', 'empresa', '35000001P');
insert into TELEFONO values ('654789789', '30/05/2006', 'C', 24590, 'A00000001', 'familiar', '42000002C');
insert into TELEFONO values ('678111222', '02/02/2002', 'T', 1010, 'B00000002', 'dúo', '59000003T');
insert into TELEFONO values ('654234234', '31/10/2006', 'T', 250, 'A00000001', 'joven', '17000004W');
insert into TELEFONO values ('666789789', '20/05/1999', 'C', 45250, 'C00000003', 'autónomos', '67000002A');
insert into TELEFONO values ('654012012', '10/03/2005', 'T', 1500, 'A00000001', 'joven', '12000002Q');
insert into TELEFONO values ('678234234', '30/08/2006', 'C', 15700, 'B00000002', 'autónomos', '89000002Z');
insert into TELEFONO values ('654345345', '10/09/2006', 'C', 170, 'A00000001', 'dúo', '89000002Z');
insert into TELEFONO values ('666456456', '19/07/98', 'C', 56280, 'C00000003', 'empresa', '56000002M');


insert into LLAMADA values ('654123321', '654345345', '26/09/06 23:05:55', 921);
insert into LLAMADA values ('654123321', '654345345', '16/10/06 18:45:35', 785);
insert into LLAMADA values ('654123321', '654345345', '16/10/06 19:07:10', 38);
insert into LLAMADA values ('654123321', '654345345', '18/10/06 09:35:50', 1053);
insert into LLAMADA values ('654123321', '654345345', '21/10/06 21:05:13', 257);
insert into LLAMADA values ('666010101', '666456456', '27/10/06 11:11:33', 435);
insert into LLAMADA values ('666010101', '654234234', '01/11/06 10:35:00', 124);
insert into LLAMADA values ('666010101', '666789789', '05/09/06 17:09:01', 210);
insert into LLAMADA values ('654789789', '654012012', '01/10/06 13:55:30', 75);
insert into LLAMADA values ('654789789', '666456456', '05/10/06 17:05:03', 430);
insert into LLAMADA values ('654789789', '678111222', '08/10/06 10:55:15', 1345);
insert into LLAMADA values ('678111222', '654789789', '07/10/06 19:25:51', 553);
insert into LLAMADA values ('678111222', '654234234', '03/11/06 17:45:31', 321);
insert into LLAMADA values ('678111222', '678234234', '12/09/06 11:52:19', 634);
insert into LLAMADA values ('678111222', '678234234', '23/09/06 19:17:44', 101);
insert into LLAMADA values ('666789789', '666010101', '11/09/06 10:19:03', 45);
insert into LLAMADA values ('666789789', '666456456', '15/09/06 14:12:44', 409);
insert into LLAMADA values ('666789789', '666456456', '15/09/06 18:13:24', 105);
insert into LLAMADA values ('654012012', '678234234', '13/09/06 10:32:07', 312);
insert into LLAMADA values ('654012012', '678111222', '01/09/06 21:08:59', 93);
insert into LLAMADA values ('654012012', '666010101', '21/09/06 11:12:13', 501);
insert into LLAMADA values ('678234234', '666010101', '30/09/06 08:49:55', 413);
insert into LLAMADA values ('678234234', '654123321', '01/10/06 13:12:11', 2045);
insert into LLAMADA values ('678234234', '654789789', '01/10/06 19:01:07', 703);
insert into LLAMADA values ('678234234', '666789789', '12/10/06 10:21:02', 827);
insert into LLAMADA values ('654345345', '654012012', '01/11/06 12:01:02', 311);
insert into LLAMADA values ('654345345', '654012012', '03/11/06 10:43:57', 207);
insert into LLAMADA values ('654345345', '654234234', '03/11/06 17:31:09', 421);
insert into LLAMADA values ('654345345', '654123321', '16/10/06 19:07:10', 38);
insert into LLAMADA values ('654345345', '654123321', '21/10/06 21:05:13', 257);


commit;
       
       
                          
                         
--Practica 3 ############# PL/SQL
--HOLA MUNDO 
SET SERVEROUTPUT ON;
CREATE OR REPLACE
PROCEDURE HOLA (NOMBRE VARCHAR)IS
BEGIN
DBMS_OUTPUT.PUT_LINE('HOLA MUNDO '|| NOMBRE);
END;

CALL HOLA ('PEPE');
call dbms_output.put_line(HOLA ('PEPE')) 
--EJERCICIO 1
/*
Diseñar  la  función  facturacion(),  la  cual  admite  dos  parámetros  de  entrada  (un 
teléfono  y  un  año)  y  devuelve  la  facturación  total  de  ese  número  en  ese  año.  La 
función debe controlar 2 tipos de excepciones: 
 el teléfono no existe o el teléfono no ha realizado llamadas ese año. 
 la facturación del teléfono es inferior a 1 euro.*/


CREATE OR REPLACE
FUNCTION FACTURACION(P_TF_ORIGEN MF.LLAMADA.TF_ORIGEN%TYPE, P_AÑO INTEGER) 
RETURN FLOAT IS

IMPORTE NUMBER(10,2);
FACTURACION_BAJA EXCEPTION;
--NO_DATA_FOUND EXCEPTION;

BEGIN
  SELECT SUM (LL.DURACION /60 * TA.COSTE)INTO IMPORTE
  FROM MF.TELEFONO T INNER JOIN MF.TARIFA TA USING (TARIFA, COMPAÑIA)
  INNER JOIN MF.LLAMADA LL ON LL.TF_ORIGEN = T.NUMERO 
  WHERE EXTRACT (YEAR FROM FECHA_HORA) = P_AÑO AND LL.TF_ORIGEN = P_TF_ORIGEN
  GROUP BY LL.TF_ORIGEN;
  
  IF IMPORTE < 1 THEN 
    RAISE FACTURACION_BAJA;
  END IF;
  
  RETURN IMPORTE;
  
  EXCEPTION
   WHEN FACTURACION_BAJA THEN 
    dbms_output.put_line('FACTURACION BAJA');
    RETURN -1;
   WHEN NO_DATA_FOUND THEN 
    dbms_output.put_line('EL TELEFONO NO EXISTE O NO SE HA REALIZADO LLAMADAS ESTE AÑO');
    RETURN -1; 
   WHEN OTHERS THEN 
    dbms_output.put_line('HA PASADO ALGO MALO');
    RETURN -1; 
END;

call dbms_output.put_line(facturacion('654123321', 2006)); 

 
--EJERCICIO 2
/*
Diseñar el procedimiento LlamadaFacturacion(año), el cual, para cada teléfono de 
la  tabla  LLAMADAS  debe  realizar  una  llamada a  la función facturación  y mostrar  la 
facturación de dicho teléfono en el año que se le pasa como parámetro. */

CREATE OR REPLACE PROCEDURE LlamadaFacturacionE2(P_AÑO INTEGER) IS

  CURSOR  C_TELEFONO(P_AÑO INTEGER)IS
    SELECT DISTINCT TF_ORIGEN FROM LLAMADA
    WHERE EXTRACT(YEAR FROM FECHA_HORA)=P_AÑO;
    
BEGIN 

   dbms_output.put_line('Nº TELEFONO'|| 'IMPORTE ESN €');
   
   FOR R_TELEFONO IN C_TELEFONO(P_AÑO) LOOP
     dbms_output.put_line(R_TELEFONO.TF_ORIGEN || ' ' || FACTURACION(R_TELEFONO.TF_ORIGEN, P_AÑO));
   END LOOP;
  
  EXCEPTION 
    WHEN OTHERS THEN
     dbms_output.put_line('ERROR');
END;

execute llamadaFacturacion(2006);      
       
       
       
       
Crear un procedimiento que tenga como parámetros de entrada el nombre de una
compañía y una fecha. Dicho procedimiento debe realizar las siguientes
operaciones:
  1. Comprobar que existen en la BD llamadas realizadas en la fecha que se pasa
  como parámetro. En caso contrario lanzar una excepción y mostrar el
  mensaje “No hay llamadas en la fecha <fecha> en la BD”.
  2. Para cada teléfono de la compañía que se pasa por parámetro, el
  procedimiento debe mostrar la siguiente información: número de teléfono,
  número total de llamadas realizadas en la fecha indicada, número de
  llamadas de duración mayor de 100 segundos realizadas en la fecha,
  porcentaje que suponen estas últimas respecto al total de las realizadas.
  3. Un resumen del número de llamadas realizadas por todos los teléfonos de la
  compañía indicada en la fecha pasada por parámetro.
*/
SET SERVEROUTPUT ON;
CREATE OR REPLACE
PROCEDURE ejercicio3(N_compañia mf.compañia.nombre%TYPE, fecha date) IS 
llamadas integer;
llamadas2 integer;
llamadas_100 integer;
sumador integer;
porcentaje NUMBER(5,2);
No_llamadas EXCEPTION;

cursor C_telefono (N_compañia mf.compañia.nombre%TYPE) is
select tf.numero
from mf.telefono tf inner join mf.compañia c on c.cif = tf.compañia
where c.nombre = N_compañia;

begin
sumador :=0;

  IF llamadas <1 THEN 
 RAISE No_llamadas;
 else
  dbms_output.put_line('-----------------------------------');
  dbms_output.put_line('telefono' || ' '||'Llamadas' || ' '||'Llamadas100' || '   '  || '%') ;

  SELECT DISTINCT count(*) into llamadas
    FROM mf.LLAMADA 
    WHERE TO_CHAR(fecha_hora,'dd/mm/yy')=fecha  ;
    
    FOR R_TELEFONO IN C_TELEFONO(N_compañia) LOOP
   
      select count (*) into llamadas2
      from mf.llamada
      where tf_origen=R_TELEFONO.numero and TO_CHAR(fecha_hora,'dd/mm/yy')=fecha ; 
      
      select count (*) into llamadas_100
      from mf.llamada
      where tf_origen=R_TELEFONO.numero and TO_CHAR(fecha_hora,'dd/mm/yy')=fecha and duracion>100 ; 
   
     
      iF (llamadas_100 <> 0) THEN porcentaje := (llamadas_100 / llamadas2)*100;
      ELSE porcentaje:=0;
      END IF;
     
     dbms_output.put_line(R_TELEFONO.numero || '     '||llamadas2 || '      '||llamadas_100 || '         '  || porcentaje) ;
     sumador := sumador + llamadas2;
   END LOOP;
   
   dbms_output.put_line('Numero de llamadas '|| sumador) ;
 
  END IF;

 EXCEPTION
   WHEN No_llamadas THEN 
    dbms_output.put_line('No hay llamadas en la fecha '||fecha||' en la BD');
    --RETURN -1;

end;


execute ejercicio3('Aotra', '01/10/06');  
    
    
 --disparador
 create or replace trigger ejerrcicio4 before insert on mf.llamada
 for each row
 declare 
  llamadas_orig INTEGER;
  llamadas_dest INTEGER;
 
 begin
  select count(*) into llamadas_orig
  from llamada 
  where (tf_origen =: new.tf_origen and new.fecha_hora =: fecha_hora) or (tf_destino= :new.tf_origenAND fecha_hora= :new.fecha_hora);

  if (llamadas_orig > 0) then 
    RAISE_APPLICATION_ERROR(-20001,'El teléfono origen' || :new.tf_origen|| ' está realizando o recibiendo una llamada a las ' || :new.fecha_hora);
  end if;
  
    select count(*) into llamadas_dest
  from llamada 
  where (tf_origen =: new.tf_origen and new.fecha_hora =: fecha_hora) or (tf_destino= :new.tf_origenAND fecha_hora= :new.fecha_hora);

  if (llamadas_dest > 0) then 
    RAISE_APPLICATION_ERROR(-20001,'El teléfono destino' || :new.tf_origen|| ' está realizando o recibiendo una llamada a las ' || :new.fecha_hora);
  end if;
 end; 
 
 
 insert into llamada values ('654345345', '678234234', '21/10/06 21:05:13', 123);
 insert into llamada values ('654345345', '678234234', '12/09/06 11:52:19', 123);       
       
       
       
