--Utilizaremos nuestas tablas de productos y ventas (/parcial-1/actividad4.sql)
select * from Productos
select * from Ventas

-- LECTURA SUCIA
-- Proceso uno
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION UNO
	UPDATE Productos
		SET Invetario = 0
		WHERE Clave_Producto = 2
	INSERT INTO Ventas(Clave_Producto, Cantidad, Subtotal, Total)
	VALUES ('2', 150, 6*150, (6*150)+(6*150*0.12)) --Se suma el IVA
      --Tiempo de espera, 30 segundos
      WAITFOR DELAY '00:00:30'
ROLLBACK TRANSACTION UNO
select * from Productos
select * from Ventas
-- Fin proceso uno
-- Proceso 2 (ejecutar en otra ventana)-- Proceso 2 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION DOS
     select * from Productos
	 select * from Ventas
COMMIT TRANSACTION DOS
-- Fin proceso 2
-- LECTURA SUCIA
-- LECTURA FANTASMA
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
	select * from Productos
	UPDATE Productos
		SET Invetario = 70
		WHERE Clave_Producto = 1
	INSERT INTO Ventas(Clave_Producto, Cantidad, Subtotal, Total)
	VALUES ('1', 10, 5*10, (5*10)+(5*10*0.12)) --Se suma el IVA
	WAITFOR DELAY '00:00:30'
	select * from Productos
COMMIT TRANSACTION
-- Mientras el tiempo de espera ejecutamos un comando en paralelo 
-- para evidenciar la lectura fantasma
Begin Transaction
	Insert into Productos (Clave_Producto, Nombre_Producto, Invetario, Precio) 
	values 
		('6', 'Coca cola', 100, 5),
		('7', 'Pepsi', 150, 6)
Commit Transaction
-- LECTURA FANTASMA
-- ACTUALIZACIÓN PERDIDA
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION UNO
      SELECT * FROM Productos WHERE Clave_Producto = 3
	  --Tiempo de espera, 30 segundos
	  WAITFOR DELAY '00:00:30'
	  UPDATE Productos SET Invetario = Invetario + 100 WHERE Clave_Producto = 3
	  SELECT * FROM Productos WHERE Clave_Producto = 3
COMMIT TRANSACTION UNO
-- Proceso 3 actualiza pero no es reflejado debido a el proceso anterior
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION DOS
      SELECT * FROM Productos WHERE Clave_Producto = 3
	  --Tiempo de espera, 15 segundos
	  WAITFOR DELAY '00:00:15'
	  UPDATE Productos SET Invetario = Invetario - 100 WHERE Clave_Producto = 3
	  SELECT * FROM Productos WHERE Clave_Producto = 3
COMMIT TRANSACTION DOS
-- ACTUALIZACIÓN PERDIDA
-- BLOQUEO MUERTO (DEAD LOCK) 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION  
    --Paso 1
     UPDATE Productos SET Invetario = Invetario - 100 WHERE Clave_Producto = 5
     UPDATE Productos SET Invetario = Invetario + 100 WHERE Clave_Producto = 6
	WAITFOR DELAY '00:00:15' --10 SEGUNDOS
	 --Paso 3
     UPDATE Productos SET Invetario = Invetario + 100 WHERE Clave_Producto = 7	
COMMIT TRANSACTION 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION 
 --Paso 2
 UPDATE Productos 
 SET Invetario = Invetario - 100 WHERE Clave_Producto = 7
 --Paso 4
 UPDATE Productos
 SET Invetario = Invetario - 80 WHERE Clave_Producto = 6
COMMIT TRANSACTION 
-- BLOQUEO MUERTO (DEAD LOCK) 

USE CONCURRENCIA
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION  
    --Paso 1
    UPDATE CUENTAS SET SALDO = SALDO - 1500 WHERE NUMERO_CUENTA = 2	
    UPDATE CUENTAS SET SALDO = SALDO + 1500 WHERE NUMERO_CUENTA = 3	
	WAITFOR DELAY '00:00:05' --10 SEGUNDOS
	 --Paso 3
    UPDATE CUENTAS SET SALDO = SALDO + 300 WHERE NUMERO_CUENTA = 1	
COMMIT TRANSACTION 
