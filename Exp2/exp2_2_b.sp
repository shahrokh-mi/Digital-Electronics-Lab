Sample

.protect
.lib 'mm018.l' tt
.unprotect
vdd 1 0 vddval
vin1 2 0 pwl(0 vddval 'period1' vddval 'period1 + tf' 0 '2 * period1' 0 '2*period1 + tr' vddval '3*period1' vddval)
.subckt inverter in1 out1 1
*m1 out1 in1 1 1 pmos L=180n W=220n
rResistor1 out1 1 Resistance
m2 out1 in1 0 0 nmos L=180n W=220n
.ends
x1 2 v2 1 inverter
x2 v2 v3 1 inverter
x3 v3 v4 1 inverter
*cCapacitor1 v4 0 capacity1
x4 v4 v51 1 inverter
x5 v4 v52 1 inverter
x6 v4 v53 1 inverter
x7 v4 v54 1 inverter
.tran 0.001n '(3*period1)+(2*tr)' sweep data = dataset
.data dataset
+ period1 vddval 
+ 10n 1.6
+ 10n 1.7
+ 10n 1.8
+ 10n 1.9
+ 10n 2
*+ 10n 1.8
.enddata
.measure tran tp trig v(v3) val=0.9 cross=1 targ v(v4) val=0.9 cross=1
.measure tran tp2 trig v(v3) val=0.9 cross=2 targ v(v4) val=0.9 cross=2
.measure tran avg_power avg power from = 0 to = '(3*period1)+(2*tr)'
.param Resistance=50k
.param vddval=1.8
.param tr = 10p
.param tf = 10p
.param period1 = 10n
.end
