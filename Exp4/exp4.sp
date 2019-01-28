Sample

.protect
.lib 'mm018.l' tt
.unprotect
vdd 1 0 vddval
Vina0 A0 0 pwl(0 vddval '16 * period' vddval) 
Vina1 A1 0 pwl(0 vddval '16 * period' vddval) 
Vina2 A2 0 pwl(0 vddval '16 * period' vddval) 
Vina3 A3 0 pwl(0 vddval '16 * period' vddval) 
Vinb0 B0 0 pwl(0 0 '16 * period' 0) 
Vinb1 B1 0 pwl(0 0 '16 * period' 0) 
Vinb2 B2 0 pwl(0 0 '16 * period' 0) 
Vinb3 B3 0 pwl(0 0 '16 * period' 0) 
Vcin0 Cin 0 pwl(0 0 'period' 0 'period + trf' vddval '2*period+trf' vddval '2*period+2*trf' 0 '16*period' 0)

.subckt inverter in1 out1 1
mp1 out1 in1 1 1 pmos L=180n W=660n
mn2 out1 in1 0 0 nmos L=180n W=220n
.ends

.subckt full_adder x y cin cout sum 1
mp1 2 x 1 1 pmos L=180n W=660n
mp2 2 y 2 1 pmos L=180n W=660n
mp3 coutn cin 1 1 pmos L=180n W=660n
mp7 5 y 1 1 pmos L=180n W=660n
mp8 coutn x 5 1 pmos L=180n W=660n
mp11 3 x 1 1 pmos L=180n W=660n
mp14 sumn coutn 3 1 pmos L=180n W=660n
mp12 3 y 1 1 pmos L=180n W=660n
mp13 3 cin 1 pmos L=180n W=660n
mp19 8 x 1 1 pmos L=180n W=660n
mp20 9 y 8 1 pmos L=180n W=660n
mp21 sumn cin 9 1 pmos L=180n W=660n
mn4 coutn cin 4 0 nmos L=180n W=440n
mn5 4 x 0 0 nmos L=180n W=440n
mn6 4 y 0 0 nmos L=180n W=440n
mn9 coutn x 6 0 nmos L=180n W=440n
mn10 6 y 0 0 nmos L=180n W=440n
mn15 sumn coutn 7 0 nmos L=180n W=440n
mn16 7 x 0 0 nmos L=180n W=440n
mn17 7 y 0 0 nmos L=180n W=440n
mn18 7 cin 0 0 nmos L=180n W=440n
mn22 sumn cin 10 0 nmos L=180n W=440n
mn23 10 y 11 0 nmos L=180n W=440n
mn24 11 x 0 0 nmos L=180n W=440n
xinv1 coutn cout 1 inverter
xinv2 sumn sum 1 inverter
.ends

xfa0 A0 B0 Cin Cout0 Sum0 1 full_adder
xfa1 A1 B1 Cout0 Cout1 Sum1 1 full_adder
xfa2 A2 B2 Cout1 Cout2 Sum2 1 full_adder
xfa3 A3 B3 Cout2 Cout3 Sum3 1 full_adder

.tran 0.001n '16 *period + 16 * trf'
.measure tran worstDelayCoutRise trig v(Cin) val=0.9 rise=1 targ v(Cout3) val=0.9 cross=1
.measure tran worstDelaySum3Rise trig v(Cin) val=0.9 rise=1 targ v(Sum3) val=0.9 cross=1
.measure tran worstDelayCoutFall trig v(Cin) val=0.9 fall=1 targ v(Cout3) val=0.9 cross=2
.measure tran worstDelaySum3Fall trig v(Cin) val=0.9 fall=1 targ v(Sum3) val=0.9 cross=2

.param trf = 10p
.param t = '1/(100x)'
.param vddval = 1.8
.param period = 10n
.end
