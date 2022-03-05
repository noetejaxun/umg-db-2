--Creamos tablas necesarias
--Creaar tabla de productos
Create table Productos (
Clave_Producto varchar(20) UNIQUE,
Nombre_Producto varchar(100),
Invetario int,
Precio float,
);
--Creaar tabla ventas
Create table Ventas (
Clave_Producto varchar(20) ,
Cantidad int,
Subtotal float,
Total float,
);
--Insertamosregistros necesarios
--Productos
Begin Transaction
	Insert into Productos (Clave_Producto, Nombre_Producto, Invetario, Precio) 
	values 
		('1', 'Coca cola', 100, 5),
		('2', 'Pepsi', 150, 6),
		('3', 'Tortrix', 300, 1),
		('4', 'Lays', 45, 3),
		('5', 'Huevos', 75, 1)
Commit Transaction
/*
Atomicidad
 Todas las modificaciones a la Base de Datos 
 deben seguir la regla de todo o nada. 
 Si cualquier parte de la transacción falló, por más pequeña que sea dicha parte,
 toda la transacción falló.
*/
--Verificacion de tablas 
select * from Productos
select * from Ventas

--Transaccion exitosa
BEGIN TRANSACTION
	UPDATE Productos
		SET Invetario = 90
		WHERE Clave_Producto = 1

	INSERT INTO Ventas(Clave_Producto, Cantidad, Subtotal, Total)
	VALUES ('1', 10, 5*10, (5*10)+(5*10*0.12)) --Se suma el IVA
COMMIT TRANSACTION
--Transaccion fallida
BEGIN TRANSACTION
	UPDATE Productos
		SET Invetario = 10   
		WHERE Clave_Producto = 1
	INSERT INTO Ventas(Clave_Producto, Cantidad, Subtotal, Total)
	VALUES ('1', 'Dato erroneo', 5*10, (5*10)+(5*10*0.12)) --Se suma el IVA
COMMIT TRANSACTION
/*
Podemos observar que la consola nos confirmo que una fila fue afectada de la tabla proiductos 
y esta fue laninstruccion de cambiar el inverntario a 10 pero como la trasaccion fallo mas adelante
por principios de atomicidad se revertio este cambio
*/

/*
Consistencia
solamente datos válidos pueden ser escritos en la Base de Datos. 
Dentro de una transacción se pueden tener temporalmente datos inválidos
pero cuando la transacción termina, sea de la forma que sea,
la Base de Datos debe tener solamente datos válidos.
*/
/*
Utilizaremos el ejemplo anterior pero ahora verificaremos las tablas en el proceso de la transaccion
para demostrar que aunque en el momento de la transaccion se pueden tener datos, cuando esta finalize 
tienen que ser coherentes
*/
BEGIN TRANSACTION
	UPDATE Productos
		SET Invetario = 10   
		WHERE Clave_Producto = 1
		--Verificamos la tabla producto comprobando que se altero el inventario
	INSERT INTO Ventas(Clave_Producto, Cantidad, Subtotal, Total)
	VALUES ('1', 'Dato erroneo', 5*10, (5*10)+(5*10*0.12)) --Se suma el IVA
COMMIT TRANSACTION
--Verificamos la tabla producto y podemos constatar que se revertieron los cambios para tener coherencia 
/*
Aislamiento 
Una transacción no puede acceder al resultado de otras transacciones hasta que se complete la transacción. 
Para esta propiedad Acid en SQL Server, utiliza Locks para bloquear la tabla
*/
/*
Utilizaremos 2 instacioas separadas para este ejemplo
-Primera instancia: iniciamos la transacción y actualizamos el registro,
pero no hemos confirmado ni revertido la transacción.
-Segunda instancia: Uso de la instrucción Select para seleccionar los registros
presentes en la tabla Productos.
*/
BEGIN TRANSACTION
	UPDATE Productos
		SET Invetario = 80
		WHERE Clave_Producto = 1
		--Verificar la tabla desde otra instancia
	INSERT INTO Ventas(Clave_Producto, Cantidad, Subtotal, Total)
	VALUES ('1', 10, 5*10, (5*10)+(5*10*0.12)) --Se suma el IVA
COMMIT TRANSACTION
/*
Podemos observar como no devulve datos la instacia donde se consulta y nos indica que hay una transaccion
en proceso, al momento de terminar la transaccion inmedidatamente se muestran los datos del select
*/