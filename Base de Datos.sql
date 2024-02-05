/* 
   Roberto Gijón Liétor         –     Usuario: GI207    Contraseña: usuario123
   Pedro Manuel García Amate    –     Usuario: GI206    Contraseña: GI206
   María José Gallardo Delgado  –     Usuario: GI307    Contraseña: GI307GI
*/
  
DROP TABLE ped_art;
DROP TABLE ped_tra;
DROP TABLE pedido;  
DROP TABLE comentario;  
DROP TABLE usuario;
DROP TABLE suscripcion; 
DROP TABLE hardware;    
DROP TABLE software;
DROP TABLE articulo;
DROP TABLE repartidor;
DROP TABLE administrador;
DROP TABLE trabajador;


/* CREACIÓN DE TABLAS */

CREATE TABLE suscripcion(
cod_sus   NUMBER(3)    CONSTRAINT pk_suscripcion    PRIMARY KEY,
precio    NUMBER(4,2)  CONSTRAINT nn_precio_su      NOT NULL,
f_ini     DATE         CONSTRAINT nn_f_ini_su       NOT NULL,
f_fin     DATE         CONSTRAINT nn_f_fin_su       NOT NULL
);


CREATE TABLE usuario(
email       VARCHAR(20)  CONSTRAINT pk_usuario      PRIMARY KEY,
nombre      VARCHAR(10)  CONSTRAINT nn_nom_us       NOT NULL,
apellidos   VARCHAR(20)  CONSTRAINT nn_ape_us       NOT NULL,
f_nac       DATE,
cod_sus     NUMBER(3)    CONSTRAINT fk_cod_sus_us   REFERENCES suscripcion
);


CREATE TABLE pedido(
cod_ped     VARCHAR(5)    CONSTRAINT pk_pedido      PRIMARY KEY,
fecha       DATE          CONSTRAINT nn_fecha_pe    NOT NULL,
p_envio     NUMBER(4,2),
email       VARCHAR(20)   CONSTRAINT fk_email_pe    REFERENCES usuario
);


CREATE TABLE articulo(
cod_art     NUMBER(5)     CONSTRAINT pk_articulo    PRIMARY KEY,
nombre      VARCHAR(10)   CONSTRAINT nn_nom_art     NOT NULL,
precio      NUMBER(5,2)   CONSTRAINT nn_pre_art     NOT NULL,
descrip     VARCHAR(250),
marca       VARCHAR(3)    CONSTRAINT ck_mar_art     CHECK(marca = 'MSI' OR marca = 'DEL' OR marca = 'HPS' OR marca = 'ASU' OR marca = 'APL')
);


CREATE TABLE hardware(
cod_art     NUMBER(5),
peso        NUMBER(5),
CONSTRAINT pk_hardware  PRIMARY KEY(cod_art),
CONSTRAINT fk_hardware  FOREIGN KEY(cod_art)  REFERENCES articulo
);


CREATE TABLE software(
cod_art     NUMBER(5),
version_s   VARCHAR(3),
CONSTRAINT pk_software  PRIMARY KEY(cod_art),
CONSTRAINT fk_software  FOREIGN KEY(cod_art)  REFERENCES articulo
);


CREATE TABLE trabajador(
dni         VARCHAR(9)    CONSTRAINT pk_trabajador      PRIMARY KEY,
nombre      VARCHAR(10)   CONSTRAINT nn_nombre_tra      NOT NULL,
apellidos   VARCHAR(20)   CONSTRAINT nn_apellidos_tra   NOT NULL,
sueldo      NUMBER(4,2)
);


CREATE TABLE repartidor(
dni         VARCHAR(9),
vehiculo    VARCHAR(7),
CONSTRAINT pk_repartidor   PRIMARY KEY(dni),
CONSTRAINT fk_repartidor   FOREIGN KEY(dni)  REFERENCES trabajador
);


CREATE TABLE administrador(
dni         VARCHAR(9),
n_puesto    VARCHAR(4)    CONSTRAINT nn_n_puesto_adm NOT NULL,
CONSTRAINT pk_administrador   PRIMARY KEY(dni),
CONSTRAINT fk_administrador   FOREIGN KEY(dni)  REFERENCES trabajador
);


CREATE TABLE comentario(
cod_com       NUMBER(3)       CONSTRAINT pk_comentario    PRIMARY KEY,
calific       NUMBER(2)       CONSTRAINT ck_calific_co    CHECK(calific > -1 AND calific < 11),
descrip       VARCHAR(250),
f_coment      DATE,
email         VARCHAR(20)     CONSTRAINT fk_email_co      REFERENCES usuario,
cod_art       NUMBER(5)       CONSTRAINT fk_cod_art_co    REFERENCES articulo
);


CREATE TABLE ped_art(
cod_art     NUMBER(5)     CONSTRAINT fk_cod_art_pa   REFERENCES articulo,
cod_ped     VARCHAR(5)    CONSTRAINT fk_cod_ped_pa   REFERENCES pedido, 
CONSTRAINT pk_ped_art   PRIMARY KEY(cod_art, cod_ped)
);


CREATE TABLE ped_tra(
cod_ped     VARCHAR(5)    CONSTRAINT fk_cod_ped_pt    REFERENCES pedido,
dni         VARCHAR(9)    CONSTRAINT fk_dni_pt        REFERENCES trabajador,
CONSTRAINT pk_ped_tra   PRIMARY KEY(cod_ped, dni)
);


/* INSERCIÓN DE TUPLAS */

INSERT INTO suscripcion VALUES(642, 7.50, '03-08-2019', '03-09-2019');
INSERT INTO suscripcion VALUES(179, 12.99, '21-10-2019', '01-12-2019');
INSERT INTO suscripcion VALUES(619, 15.00, '02-02-2020', '02-04-2020');
INSERT INTO suscripcion VALUES(777, 7.50, '16-03-2020', '16-04-2020');
INSERT INTO suscripcion VALUES(134, 17.99, '29-10-2019', '20-12-2019');


INSERT INTO usuario VALUES('maxitome@gmail.com', 'Maxi', 'Tome Fernandez', '07-11-1980', 642);
INSERT INTO usuario VALUES('andrea@gmail.com', 'Andrea', 'Martinez Paneda', '28-08-1997', 179);
INSERT INTO usuario VALUES('maribel@gmail.com', 'Maribel', 'Lopez Perez', '05-06-1997', 619);
INSERT INTO usuario VALUES('jluislomas@gmail.com', 'Jose Luis', 'Lomas Rojas', '04-09-2000', 777);


INSERT INTO pedido VALUES('24e11', '17-05-2019', 7.00, 'andrea@gmail.com');
INSERT INTO pedido VALUES('4190m', '12-03-2019', 7.00, 'maxitome@gmail.com');
INSERT INTO pedido VALUES('37a02', '28-03-2020', 1.00, 'maribel@gmail.com');
INSERT INTO pedido VALUES('3s641', '06-12-2019', 12.00, 'andrea@gmail.com');
INSERT INTO pedido VALUES('750x4', '06-01-2020', 10.00, 'andrea@gmail.com');
INSERT INTO pedido VALUES('2489p', '30-04-2020', 0.00, 'maxitome@gmail.com');
INSERT INTO pedido VALUES('z53b8', '24-08-2019', 0.00, 'jluislomas@gmail.com');


INSERT INTO articulo VALUES(12345, 'Placa Base', 46.98, 'Basada en el conjunto de chips AMD A320, la placa base MSI A320M-A PRO está diseñada para alojar procesadores AMD Ryzen en un socket AMD AM4', 'MSI');
INSERT INTO articulo VALUES(15401, 'Abast', 40.00, 'Protege no solo su PC, sino también toda su red doméstica; además, incluye funciones avanzadas como Actualizador de Software, Passwords', 'APL');
INSERT INTO articulo VALUES(37364, 'McAfree', 119.00, 'Compañía de software especializada en seguridad informática cuya sede se encuentra en Santa Clara, California.', 'HPS');
INSERT INTO articulo VALUES(19508, 'Ratón', 12.50, 'Gaming mouse perfecto para aquellos que busquen un ratón de gran calidad para todo tipo de juegos.', 'DEL');
INSERT INTO articulo VALUES(52527, 'Monitor', 120.00, 'Cuenta con los nuevos monitores de PC para e-sports, afinados para garantizar la experiencia más suave y sensible, y las imágenes más claras: tus armas para la competición.', 'ASU');
INSERT INTO articulo VALUES(90353, 'Disipador', 24.70, 'Refrigera el ordenador por completo, resistencia al polvo y bajo consumo.', 'HPS');
INSERT INTO articulo VALUES(65035, 'Ordenador', 536.99, 'Prepárate para sentir todo el poder del juego con el potente ordenador portátil de MSI GF63 Thin 9SC', 'MSI');


INSERT INTO hardware VALUES(12345, 700);
INSERT INTO hardware VALUES(19508, 225);
INSERT INTO hardware VALUES(52527, 3000);
INSERT INTO hardware VALUES(65035, 2200);


INSERT INTO software VALUES(15401, '1.5');
INSERT INTO software VALUES(37364, '2.0');


INSERT INTO trabajador VALUES('77966332R', 'Paco', 'García Pelaez', 20.50);
INSERT INTO trabajador VALUES('25344352V', 'Miguel', 'Castillo Hernandez', 23.00);
INSERT INTO trabajador VALUES('76470927X', 'Dolores', 'Carmona Rodriguez', 31.00);
INSERT INTO trabajador VALUES('12472398L', 'Beatriz', 'Torres Lopez', 25.50);
INSERT INTO trabajador VALUES('77287925T', 'Alberto', 'Roman Lobato', 35.20);
INSERT INTO trabajador VALUES('34147863M', 'Rosa', 'Cruz Molina', 24.50);
INSERT INTO trabajador VALUES('74418225I', 'Manuel', 'García Escudero', 32.00);
INSERT INTO trabajador VALUES('44175428O', 'Ursula', 'Moreno Morales', 26.70);


INSERT INTO repartidor VALUES('77966332R', '4070FHJ');
INSERT INTO repartidor VALUES('25344352V', 'GC6767A');
INSERT INTO repartidor VALUES('12472398L', 'PO3932V');
INSERT INTO repartidor VALUES('74418225I', 'GC6767A');
INSERT INTO repartidor VALUES('44175428O', 'SA0599E');


INSERT INTO administrador VALUES('76470927X', 'LP37');
INSERT INTO administrador VALUES('77287925T', 'LP18');
INSERT INTO administrador VALUES('34147863M', 'LP28');


INSERT INTO comentario VALUES(560, 5, 'Funona pero me lo esperaba mejor', '19-03-2019', 'maxitome@gmail.com', 12345);
INSERT INTO comentario VALUES(399, 2, 'Fatal, funciona cuando quiere', '25-08-2019', 'jluislomas@gmail.com', 15401);
INSERT INTO comentario VALUES(128, 7, 'Más pequeño que en la foto, pero funciona bien', '11-04-2020', 'maribel@gmail.com', 19508);
INSERT INTO comentario VALUES(247, 6, 'Un poco golpeado pero funciona muy bien', '06-01-2020', 'andrea@gmail.com', 52527);
INSERT INTO comentario VALUES(135, NULL, ' ', '01-05-2020', 'maxitome@gmail.com', 15401);
INSERT INTO comentario VALUES(245, 10, 'Perfecto', '18-05-2019', 'andrea@gmail.com', 37364);
INSERT INTO comentario VALUES(510, 3, ' ', '12-01-2019', 'andrea@gmail.com', 19508);
INSERT INTO comentario VALUES(459, 9, 'Muy bueno', '15-04-2020', 'maribel@gmail.com', 65035);


INSERT INTO ped_art VALUES(12345, '4190m');
INSERT INTO ped_art VALUES(15401, '2489p');
INSERT INTO ped_art VALUES(15401, 'z53b8');
INSERT INTO ped_art VALUES(37364, '24e11');
INSERT INTO ped_art VALUES(19508, '37a02');
INSERT INTO ped_art VALUES(19508, '750x4');
INSERT INTO ped_art VALUES(52527, '3s641');
INSERT INTO ped_art VALUES(65035, '37a02');


INSERT INTO ped_tra VALUES('4190m', '77966332R');
INSERT INTO ped_tra VALUES('2489p', '76470927X');
INSERT INTO ped_tra VALUES('z53b8', '77287925T');
INSERT INTO ped_tra VALUES('24e11', '34147863M');
INSERT INTO ped_tra VALUES('37a02', '25344352V');
INSERT INTO ped_tra VALUES('750x4', '12472398L');
INSERT INTO ped_tra VALUES('3s641', '74418225I');
INSERT INTO ped_tra VALUES('37a02', '44175428O');


/* VISTAS */

/* Los mejores productos (calificacion >= 7) */
CREATE OR REPLACE VIEW mejores_valoraciones
AS SELECT u.nombre, c.calific, c.descrip
    FROM comentario c, usuario u
    WHERE c.calific >= 7 AND  c.email = u.email;


/* Numero de pedidos por persona */
CREATE OR REPLACE VIEW num_pedidos_persona
AS SELECT u.nombre, COUNT(p.email) "Num pedidos"
    FROM usuario u, pedido p
    WHERE u.email = p.email
    GROUP BY u.nombre;



/* Articulos más vendidos */
CREATE OR REPLACE VIEW articulo_mas_vendido
AS SELECT cod_art, nombre
    FROM articulo
    WHERE cod_art IN (SELECT pa.cod_art
                      FROM ped_art pa, articulo a
                      WHERE pa.cod_art = a.cod_art
                      GROUP BY pa.cod_art
                      HAVING COUNT(pa.cod_art) = (SELECT MAX(COUNT(pa.cod_art))
                                                  FROM ped_art pa, articulo a
                                                  WHERE pa.cod_art = a.cod_art
                                                  GROUP BY pa.cod_art));
                              
                              
/* Precio gastado por pedido */
CREATE OR REPLACE VIEW precio_gastado_usuario
AS SELECT u.nombre || ' ' || u.apellidos "Nombre y apellidos", SUM(a.precio + p.p_envio) "Dinero gastado"
    FROM articulo a, pedido p, usuario u, ped_art pa
    WHERE u.email = p.email AND p.cod_ped = pa.cod_ped AND pa.cod_art = a.cod_art
    GROUP BY u.nombre || ' ' || u.apellidos;


/* CONSULTAS */

/* 1) Muestra los artículos en orden ascendente dependiendo de su valoración en comentarios. */
SELECT a.cod_art, nombre, calific "CALIFICACION"
FROM articulo a, comentario c
WHERE a.cod_art = c.cod_art
ORDER BY 3 ASC;


/* 2) Muestra los artículos que ha pedido Andrea y los comentarios que ha dejado. */
SELECT a.nombre "ARTICULO", c.descrip "COMENTARIO"
FROM articulo a, comentario c
WHERE a.cod_art = c.cod_art AND c.email = (SELECT email
                                            FROM usuario
                                            WHERE nombre = 'Andrea');


/* 3) Muestra el número de artículos comprados por los usuarios. */
SELECT u.nombre "USUARIO", COUNT(a.cod_art) "Nº ARTICULOS COMPRADOS"
FROM usuario u, pedido p, ped_art pa, articulo a
WHERE u.email = p.email AND p.cod_ped = pa.cod_ped AND pa.cod_art = a.cod_art
GROUP BY u.nombre
ORDER BY 1;


/* 4) Muestra la calificación media de cada articulo que se haya comprado más de una vez. */
SELECT a.cod_art, AVG(calific) "CALIFICACION MEDIA"
FROM articulo a, comentario c
WHERE c.cod_art = a.cod_art
GROUP BY a.cod_art
HAVING COUNT(a.cod_art) > 1;


/* 5) Muestra la compra más antigua y la más reciente. */
SELECT p1.cod_ped "PEDIDO 1", p1.fecha "FECHA MAS ANTIGUA", p2.cod_ped "PEDIDO 2", p2.fecha "FECHA MAS RECIENTE"
FROM pedido p1, pedido p2
WHERE p1.fecha = (SELECT MIN(fecha)
                  FROM pedido) AND p2.fecha = (SELECT MAX(fecha)
                                                FROM pedido);


/* 6) Muestra cuanto tiempo lleva suscrita Andrea. */
SELECT email "USUARIO", f_fin - f_ini "TIEMPO SUSCRITO"
FROM usuario u, suscripcion s
WHERE u.cod_sus = s.cod_sus AND nombre = 'Andrea';


/* 7) Muestra que usuario ha contratado más días de suscripción. */
SELECT nombre || ' ' || apellidos "USUARIO", email, f_ini "FECHA INICIO", f_fin "FECHA FIN"
FROM usuario u, suscripcion s
WHERE u.cod_sus = s.cod_sus AND f_fin - f_ini = (SELECT MAX(f_fin - f_ini)
                                                  FROM suscripcion);


/* 8) Muestra los trabajadores que han intervenido en pedidos de artículos de MSI. */
SELECT t.dni, t.nombre "TRABAJADOR"
FROM trabajador t, ped_tra pt, ped_art pa, articulo a
WHERE t.dni = pt.dni AND pt.cod_ped = pa.cod_ped AND pa.cod_art = a.cod_art AND marca = 'MSI'
ORDER BY 1;


/* 9) Muestra los pedidos que se han hecho el año pasado (2019). */
SELECT *
FROM pedido
WHERE fecha BETWEEN '01-01-2019' AND '31-12-2019';


/* 10) Muestra los repartidores que han trabajado entre 01/01/2020 hasta 30/04/2020. */
SELECT r.*
FROM repartidor r, trabajador t, ped_tra p
WHERE r.dni = t.dni AND t.dni = p.dni AND p.cod_ped IN (SELECT cod_ped
                                                        FROM pedido
                                                        WHERE fecha BETWEEN '01-01-2020' AND '30-04-2020');
                                                        
                                                        
/* 11) Muestra descripción(es) del articulo(s) con peor calificación en comentarios. */
SELECT a.descrip, c.calific, a.nombre
FROM articulo a, comentario c
WHERE a.cod_art = c.cod_art AND c.calific IN (SELECT MIN(c.calific)
                                              FROM comentario c );


/* 12) Muestra la media de las tarifas cobradas a usuarios. */
SELECT AVG(precio) "TARIFA MEDIA"
FROM suscripcion;


/* 13) Muestra los trabajadores con el sueldo igual o mayor a la media. */
SELECT nombre || ' ' || apellidos "NOMBRE Y APELLIDOS", sueldo
FROM trabajador
WHERE sueldo >= (SELECT AVG(sueldo)
                 FROM trabajador);


/* 14)	Muestra el repartidor que ha entregado el pedido más caro. */
SELECT t.nombre, SUM(a.precio) + p.p_envio "PRECIO TOTAL"
FROM trabajador t, pedido p, articulo a, ped_art pa, ped_tra pt, usuario u
WHERE t.dni = pt.dni AND pt.cod_ped = pa.cod_ped AND pa.cod_art = a.cod_art AND pt.cod_ped = p.cod_ped AND pa.cod_ped = p.cod_ped AND p.email = u.email
GROUP BY t.nombre, p.p_envio
HAVING (SUM(a.precio) + p.p_envio) = (SELECT MAX(SUM(a1.precio) + p1.p_envio)
                                      FROM pedido p1, articulo a1, ped_art pa1, usuario u1
                                      WHERE p1.cod_ped = pa1.cod_ped AND pa1.cod_art = a1.cod_art AND p1.email = u1.email
                                      GROUP BY p1.email, p1.p_envio);
                                      

/* 15) Muestra el número de pedidos hechos en cada año. */
SELECT DISTINCT (TO_CHAR(fecha, 'yyyy')) "AÑOS", COUNT (cod_ped) "Nº PEDIDOS"
FROM pedido 
GROUP BY TO_CHAR(fecha, 'yyyy');


/* 16) Muestra los artículos que no se han comprado nunca. */
SELECT *
FROM articulo 
WHERE cod_art NOT IN (SELECT a.cod_art
                  FROM  articulo a, ped_art pa, pedido p
                  WHERE  a.cod_art = pa.cod_art AND pa.cod_ped = p.cod_ped);
                            


/* 17) Muestra los repartidores que usan el mismo vehículo. */
SELECT r1.dni "DNI 1", t1.nombre "NOMBRE 1", r2.dni "DNI 2", t2.nombre "NOMBRE 2"
FROM repartidor r1, repartidor r2, trabajador t1, trabajador t2
WHERE r1.dni < r2.dni AND r1.vehiculo = r2.vehiculo AND t1.dni = r1.dni AND t2.dni = r2.dni;


/* 18) Muestra el sueldo medio de los repartidores y administradores por separado. */
SELECT AVG(t1.sueldo) "SUELDO MEDIO REPARTOR", AVG(t2.sueldo) "SUELDO MEDIO ADMINISTRADOR"
FROM trabajador t1, trabajador t2
WHERE t1.dni IN (SELECT dni
                 FROM repartidor)  AND t2.dni IN (SELECT dni
                                                  FROM administrador) AND t1.dni <> t2.dni;


/* 19) Muestra los comentarios que ha hecho Maribel y los artículos a los que corresponde */
SELECT c.descrip "COMENTARIO", a.nombre "ARTÍCULO"
FROM comentario c, articulo a
WHERE c.email = 'maribel@gmail.com' AND c.cod_art = a.cod_art;



/* 20) Muestra la máxima calificación de cada artículo. */
SELECT a.cod_art, a.nombre, MAX(c.calific) "CALIFICACIÓN MÁXIMA"
FROM articulo a, comentario c
WHERE a.cod_art = c.cod_art
GROUP BY a.cod_art, a.nombre;


/* 21) Muestra lo que se gasta la empresa en los salarios diariamente. */
SELECT SUM(sueldo) "SALARIO TOTAL"
FROM trabajador;


/* 22) Muestra al primer usuario que se suscribió. */
SELECT *
FROM usuario
WHERE cod_sus = (SELECT cod_sus
                 FROM suscripcion
                 WHERE f_ini = (SELECT MIN(f_ini)
                                FROM suscripcion));


/* 23) Muestra lo que cobran los administradores al año. */
        /*280 dias laborables al año aproximadamente*/
SELECT a.dni, t.nombre, t.sueldo * 280 "SUELDO AL AÑO (€)"     
FROM trabajador t, administrador a
WHERE t.dni = a.dni;


/* 24) Muestra las parejas de usuarios que han comprado el mismo producto. */
SELECT u1.nombre "USUARIO A", u2.nombre "USUARIO B"
FROM usuario u1, usuario u2, articulo a1, articulo a2, ped_art pa1, ped_art pa2, pedido p1, pedido p2
WHERE u1.email = p1.email AND p1.cod_ped = pa1.cod_ped AND pa1.cod_art = a1.cod_art AND 
      u2.email = p2.email AND p2.cod_ped = pa2.cod_ped AND pa2.cod_art = a2.cod_art AND u1.email < u2.email AND a1.cod_art = a2.cod_art;


/* 25) Muestra el comentario con la descripción más larga. */
SELECT cod_com, calific, descrip, email, LENGTH(descrip) "CARACTERES"
FROM comentario
WHERE LENGTH(descrip) = (SELECT MAX(LENGTH(descrip))
                         FROM comentario);


/*26) Muestra las marcas más vendida y el número de veces que se ha vendido. */
SELECT a.marca, COUNT(a.marca) "VECES VENDIDA"
FROM ped_art pa, articulo a
WHERE pa.cod_art = a.cod_art
GROUP BY a.marca
HAVING COUNT(a.marca) = (SELECT MAX( COUNT(a.marca))
                        FROM ped_art pa, articulo a
                        WHERE pa.cod_art = a.cod_art
                        GROUP BY a.marca);



/* SENTENCIAS DE INSERCION */

INSERT INTO usuario (SELECT 'jaimito@gmail.com', 'Jaime', apellidos, NULL, NULL
                      FROM usuario
                      WHERE apellidos = 'Lopez Perez');
                    

INSERT INTO trabajador (SELECT '21846952L','Manuel','Amate Campos', sueldo
                        FROM trabajador
                        WHERE sueldo = 23.00);
                        

INSERT INTO administrador (SELECT '21846952L', n_puesto
                             FROM administrador
                             WHERE  n_puesto = 'LP28');
                           
                           
                           

/* SENTENCIAS DE ACTUALIZACION */

UPDATE comentario SET descrip = 'Muy malo'
WHERE cod_com = (SELECT cod_com 
                 FROM comentario
                 WHERE f_coment = '12-01-2019' AND email = 'andrea@gmail.com' AND cod_art = 19508);
                 

UPDATE suscripcion SET f_fin = '08-03-2020'
WHERE cod_sus = (SELECT cod_sus
                 FROM usuario
                 WHERE email = 'maribel@gmail.com');
                

UPDATE trabajador SET sueldo = sueldo + 10
WHERE dni = (SELECT dni
             FROM administrador
             WHERE n_puesto = 'LP37');


/* SENTENCIAS DE BORRADO */

DELETE FROM repartidor
WHERE dni IN (SELECT dni
              FROM trabajador
              WHERE vehiculo = 'PO3932V');
            

DELETE FROM articulo
WHERE cod_art NOT IN (SELECT cod_art
                      FROM ped_art);


DELETE FROM comentario
WHERE email = (SELECT email 
               FROM usuario
               WHERE cod_sus = 777);
               
               

