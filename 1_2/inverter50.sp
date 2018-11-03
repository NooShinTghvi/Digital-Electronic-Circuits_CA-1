* CA I / Inverter 50

************ Library *************
.inc '32nm_bulk.pm'

********* Params*******
.param			Lmin=32n
+beta=2
+Wp='2*Lmin*beta'
+Wn='2*Lmin'
+Vdd=1.1V

****** Sources ******
V			1		0		DC		Vdd
*V(name)  		N+ 		N- 		Pulse   V1  	V2  	TD  	TR  	TF 	 PW  	PER
Vin			2		0		pulse	0	Vdd	5n	10p	10p	20n	100n


***** Transistor ******
* M(name)   ND		NG 		NS		NB		Model name   W   
Mp			3		2		1		1		pmos		l='Lmin'		w='Wp'
Mn			3		2		0		0		nmos		l='Lmin'		w='Wn'	

*** Capacitor ******
*CL	out		gnd		50f
C1	3		0		50ff

*************Type of Analysis********

* br tahlil gozara :
** .tran	start	stop	step
.tran 		1p 		200n 	1p
	
* br tahlil dc , Vi = input source 
** .dc	Vi	start	stop	step	
.dc		vin		0	Vdd		0.01

*******************Measurements*************************************

* Calculation of average power over a given time period :
.meas		tran	AVGpower avg	Power	from=0		to=6u

.meas tran tpHL
+trig V(2) td=100n val='Vdd/2'	rise=1
+targ V(3) td=100n val='Vdd/2' fall=1

.meas tran tpLH
+trig V(2) td=20n val='Vdd/2'	fall=1
+targ V(3) td=20n val='Vdd/2' rise=1

.meas	tran tpd	PARAM=('(tpHL+tpLH)/2')

.END