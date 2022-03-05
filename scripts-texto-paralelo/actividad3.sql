--Creaar tabla de transacciones
Create table Transacciones (
Cuenta_Deposita varchar(50),
Cuenta_Recibe varchar(50),
Fecha_Transaccion varchar(50),
Monto float,
);

--Actualizar a valores iniciales
Begin Transaction
	update CUENTAS set SALDO = 20000 where NUMERO_CUENTA = '1110000326';
	update CUENTAS set SALDO = 14000 where NUMERO_CUENTA = '1212003598';
	update CUENTAS set SALDO = 9000 where NUMERO_CUENTA = '1702350032';
	update CUENTAS set SALDO = 2500 where NUMERO_CUENTA = '106179757';
	update CUENTAS set SALDO = 3000 where NUMERO_CUENTA = '106369893';
Commit Transaction

--Registro de trasferencias bancarias con registro de transaccion
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1110000326';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '106179757';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('1110000326','106179757',2000, '2/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 1500 where NUMERO_CUENTA = '1110000326';
	update CUENTAS set SALDO = SALDO + 1500 where NUMERO_CUENTA = '106369893';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('1110000326','106369893',1500, '6/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1212003598';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '1702350032';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('1212003598','1702350032',2000, '10/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1212003598';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '1110000326';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('1212003598','1110000326',2000, '10/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 800 where NUMERO_CUENTA = '106179757';
	update CUENTAS set SALDO = SALDO + 800 where NUMERO_CUENTA = '1212003598';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('106179757','1212003598',800, '14/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 750 where NUMERO_CUENTA = '106369893';
	update CUENTAS set SALDO = SALDO + 750 where NUMERO_CUENTA = '1212003598';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('106369893','1212003598',750, '16/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1702350032';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '1110000326';
	insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('1702350032','1110000326',2000, '18/02/2022');
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 350 where NUMERO_CUENTA = '106369893';
	update CUENTAS set SALDO = SALDO + 350 where NUMERO_CUENTA = '106179757';
		insert into Transacciones (Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion)
	Values('106369893','106179757',350, '19/02/2022');
Commit Transaction

--Obtener registros
select * from Cuentas
select * from Transacciones
--Transacciones por fecha 
select Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion from Transacciones 
where Fecha_Transaccion = '2/02/2022'
--Transacciones por cuenta 
select Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion from Transacciones 
where Cuenta_Deposita = '106369893'
--select Cuenta_Deposita, Cuenta_Recibe, Monto, Fecha_Transaccion from Transacciones where Cuenta_Deposita = '106369893' or Cuenta_Recibe = '106369893'