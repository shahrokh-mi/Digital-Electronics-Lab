Sample

.protect
.lib 'mm018.l' tt
.unprotect
vdd 1 0 vddval
vA 2 0 pwl (0 0 10n 0 '10n+tr' vddval 15n vddval '15n+tf' 0 20n 0 '20n+tr' vddval 25n vddval '25n+tf' 0 35n 0 '35n+tr' vddval 50n vddval '50n+tf' 0 55n 0 '55n+tr' vddval 60n vddval '60n+tf' 0 65n 0)
vAbar 3 0 pwl (0 vddval 10n vddval '10n+tf' 0 15n 0 '15n+tr' vddval 20n vddval '20n+tf' 0 25n 0 '25n+tr' vddval 35n vddval '35n+tf' 0 50n 0 '50n+tr' vddval 55n vddval '55n+tf' 0 60n 0 '60n+tr' vddval 65n vddval)
vB 4 0 pwl (0 0 5n 0 '5n+tr' vddval 10n vddval '10n+tf' 0 15n 0 '15n+tr' vddval 30n vddval '30n+tf' 0 40n 0 '40n+tr' vddval 45n vddval '45n+tf' 0 55n 0 '55n+tr' vddval 60n vddval '60n+tf' 0 65n 0)
vBbar 5 0 pwl (0 vddval 5n vddval '5n+tf' 0 10n 0 '10n+tr' vddval 15n vddval '15n+tf' 0 30n 0 '30n+tr' vddval 40n vddval '40n+tf' 0 45n 0 '45n+tr' vddval 55n vddval '55n+tf' 0 60n 0 '60n+tr' vddval 65n vddval)


.subckt inverter in1 out1 1
mp1 out1 in1 1 1 pmos L=180n W=660n
mn2 out1 in1 0 0 nmos L=180n W=220n
.ends

.subckt shahrokh in1 x y out1 1
m1 out1 x in1 1 pmos L=180n W=220n
m2 out1 y in1 0 nmos L=180n W=220n
.ends

.subckt DPL A Abar B Bbar xor xnor 1
xShahrokh1 B Abar A n1 1 shahrokh
xShahrokh2 Bbar A Abar n1 1 shahrokh
xShahrokh3 Bbar Abar A n2 1 shahrokh
xShahrokh4 B A Abar n2 1 shahrokh
xinv1 n1 xor 1 inverter
xinv2 n2 xnor 1 inverter
.ends

.subckt CPL A Abar B Bbar xor xnor 1
m1 n1 Abar Bbar 0 nmos L=180n W=220n
m2 n1 A B 0 nmos L=180n W=220n
m3 n1 n2 1 1 pmos L=180n W=220n
m4 n2 Abar B 0 nmos L=180n W=220n
m5 n2 A Bbar 0 nmos L=180n W=220n
m6 n2 n1 1 1 pmos L=180n W=220n
xinv1 n1 xor 1 inverter
xinv2 n2 xnor 1 inverter
.ends

.subckt Leap A Abar B Bbar xor xnor 1
m1 xnor Abar Bbar 0 nmos L=180n W=220n
m2 xnor A B 0 nmos L=180n W=220n
m3 xnor xor 1 1 pmos L=180n W=220n
xinv1 xnor xor 1 inverter
.ends

xDPL1 2 3 4 5 xorDPL xnorDPL 1 DPL
xCPL1 2 3 4 5 xorCPL xnorCPL 1 CPL
xLeap1 2 3 4 5 xorLeap xnorLeap 1 Leap


.tran 0.01n 65n
.measure tran worstDelayCPL trig v(2) val=0.9 rise=2 targ v(xorCPL) val=0.9 fall=1
.measure tran worstDelayDPL trig v(2) val=0.9 rise=2 targ v(xorDPL) val=0.9 fall=1
.measure tran worstDelayLeap trig v(2) val=0.9 rise=2 targ v(xorLeap) val=0.9 fall=1
.measure tran tp param = 'max(worstDelayCPL, max(worstDelayLeap, worstDelayDPL))' 

.param trf = 10p
.param tr = 10p
.param tf = 10p
.param t = '1/(100x)'
.param vddval = 1.8
.param period = 10n
.end
