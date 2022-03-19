-- IMPORTANTE - CREAR BASE DE DATOS LLAMADA BANCOS
-- PARTE 1
--Creaar tabla de cuentas
Create table Cuentas (
Numero_Cuenta varchar(20),
Cuenta_Habiente varchar(50),
Saldo float,
);
--Crear cuentas con saldos iniciales
Begin Transaction
	insert CUENTAS(NUMERO_CUENTA, CUENTA_HABIENTE, SALDO) values ('001', 'Luis', 1000);
	insert CUENTAS(NUMERO_CUENTA, CUENTA_HABIENTE, SALDO) values ('002', 'Carlos', 2000)
Commit Transaction
--Transaccion entre Luis y Carlos
Begin Transaction
	update CUENTAS set SALDO = SALDO - 500 where NUMERO_CUENTA = '001';
	update CUENTAS set SALDO = SALDO + 500 where NUMERO_CUENTA = '002'
	rollback
Commit Transaction
--
select * from CUENTAS

--PARTE 2
--Crear cuentas con saldos iniciales
Begin Transaction
	insert CUENTAS(NUMERO_CUENTA, CUENTA_HABIENTE, SALDO) 
	values 
		('1110000326', 'Carlos Ruiz', 20000),
		('1212003598', 'Veronica Perez', 14000),
		('1702350032', 'Paulino Contreras', 9000),
		('106179757', 'Nestor Benitez', 2500),
		('106369893', 'Pablo contreras', 3000);
Commit Transaction
--Registro de trasferencias bancarias
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1110000326';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '106179757'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 1500 where NUMERO_CUENTA = '1110000326';
	update CUENTAS set SALDO = SALDO + 1500 where NUMERO_CUENTA = '106369893'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1212003598';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '1702350032'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1212003598';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '1110000326'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 800 where NUMERO_CUENTA = '106179757';
	update CUENTAS set SALDO = SALDO + 800 where NUMERO_CUENTA = '1212003598'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 750 where NUMERO_CUENTA = '106369893';
	update CUENTAS set SALDO = SALDO + 750 where NUMERO_CUENTA = '1212003598'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 2000 where NUMERO_CUENTA = '1702350032';
	update CUENTAS set SALDO = SALDO + 2000 where NUMERO_CUENTA = '1110000326'
Commit Transaction
--
Begin Transaction
	update CUENTAS set SALDO = SALDO - 350 where NUMERO_CUENTA = '106369893';
	update CUENTAS set SALDO = SALDO + 350 where NUMERO_CUENTA = '106179757'
Commit Transaction
