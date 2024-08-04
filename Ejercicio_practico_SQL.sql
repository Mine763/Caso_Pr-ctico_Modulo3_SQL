
----------------------------*****************************************++++++EJERCICIO PRÁTICO*++++++++*******-----------------------
--****a) Crear la base de datos con el archivo create_restaurant_db.sql
--****b) Explorar la tabla “menu_items” para conocer los productos del menú.
SELECT * FROM menu_items;

--1.- Realizar consultas para contestar las siguientes preguntas:

--● Encontrar el número de artículos en el menú.
SELECT COUNT(menu_item_id) FROM menu_items;

--● ¿Cuál es el artículo menos caro y el más caro en el menú?
--Articulo más caro
SELECT MAX(price) FROM menu_items;
--Artículo menos caro
SELECT MIN(price) FROM menu_items;

--● ¿Cuántos platos americanos hay en el menú?
SELECT COUNT(category) FROM menu_items WHERE category = 'American';

--● ¿Cuál es el precio promedio de los platos?
SELECT AVG(price) FROM menu_items;

--****c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
SELECT * FROM order_details
--1.- Realizar consultas para contestar las siguientes preguntas:
--● ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT(DISTINCT(order_id)) FROM order_details;

--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT order_id as "Pedido", COUNT(item_id) as "Num.articulos" FROM order_details group by order_id ORDER BY (2) DESC LIMIT 5

--● ¿Cuándo se realizó el primer pedido y el último pedido?
SELECT MIN(order_date) as "Fecha primer pedido" ,MAX(order_date) as "Fecha último pedido" from order_details

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'
select count(distinct order_id) from order_details where order_date BETWEEN '2023-01-01' AND '2023-01-05';

--****d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
--1.- Realizar un left join entre entre order_details y menu_items con el identificador 
--item_id(tabla order_details) y menu_item_id(tabla menu_items).
SELECT * FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
--****e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
--preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
--objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
--restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
--utiliza los resultados obtenidos para llegar a estas conclusiones.) 

/****+*PUNTO CLAVE 1
Es posible identificar que la categoria que mas ventas reportó fue el de Asia, seguido por el Italiano y Mexicano, la categoría que está 
mas abajo en ventas es el Americano.*/
--Consultas:
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE T2.category = 'Asian'
--3470
SELECT  COUNT(T1.order_deails_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE T2.category = 'Mexican'
--2945
SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE T2.category = 'Italian'
--2948
SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE T2.category = 'American'
--2734

/****+*PUNTO CLAVE 2
Se obtiene como resultado que el mes en el que hubo mayores ventas fue el de marzo con un total de 4,186 pedidos 
mientras que en el mes de febrero se registraron las ventas mas bajas con solo 3,892 pedidos.
*/
--Consultas:

SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE (select extract (month from T1.order_date)) = 1
--ventas enero 4156

SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE (select extract (month from T1.order_date)) = 2
--ventas febrero 3892

SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE (select extract (month from T1.order_date)) = 3
-- ventas marzo 4186

/****+*PUNTO CLAVE 3
Se analiza top 10 de los platillos mas pedidos, enlistando se encuentra la Hamburguesa con 622 pedidos.
*/
--consultas
SELECT  T2.item_name, T2.Category, count(t2.item_name)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id group by t2.item_name, T2.category order by (3) DESC LIMIT 10

/****+*PUNTO CLAVE 4
Se analizan los 5 platillos menos pedidos, se observa que la mayoria son de categoría Mexicana.
*/
--consultas
SELECT  T2.item_name, T2.Category, count(t2.item_name)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id group by t2.item_name, T2.category order by (3) ASC LIMIT 6

/****+*PUNTO CLAVE 5
Se concluye que el horario en el que mas pedidos se realizan es despues del medio dia. 
*/
--consultas

SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE (SELECT EXTRACT (hour from T1.order_time)) <= 12
--Ventas realizadas en un horario matutino y hasta medio dia 2,307

SELECT  COUNT(T1.order_details_id)
FROM order_details T1 LEFT JOIN menu_items T2 ON T1.item_id = T2.menu_item_id WHERE (SELECT EXTRACT (hour from T1.order_time)) >12
--Ventas realizadas despues del medio dia 9,927





