Sample

.protect
.lib 'mm018.l' tt
.unprotect
vdd 1 0 vddval
va 2 0 pwl(0 vddval 't + 2*trf' vddval '2*t+2*trf' vddval '2*t+3*trf' 0 '3*t+3*trf' 0 '4*t+5*trf' 0 '4*t+6*trf' vddval '5*t+6*trf' vddval 
+ '5*t+7*trf' 0 '6*t+7*trf' 0 '6*t+8*trf' vddval '7*t+8*trf' vddval '7*t+9*trf' 0 '7*t+10*trf' vddval '9*t+11*trf' vddval 
+ '9*t+12*trf' 0 '10*t+12*trf' 0 '10*t+13*trf' vddval '11*t+13*trf' vddval)
vb 3 0 pwl(0 0 trf vddval 't+trf' vddval 't+2*trf' 0 '2*t+3*trf' 0 '3*t+3*trf' 0 '3*t+4*trf' vddval '4*t+4*trf' vddval '4*t+5*trf' 0 
+ '5*t+6*trf' 0 '5*t+7*trf' vddval '7*t+9*trf' vddval '7*t+10*trf' 0 '8*t+10*trf' 0 '8*t+11*trf' vddval '9*t+11*trf' vddval 
+ '9*t+12*trf' 0 '10*t+12*trf' 0 '10*t+13*trf' vddval '11*t+13*trf' vddval)
.subckt inverter in1 out1 1
m1 out1 in1 1 1 pmos L=180n W=660n
m2 out1 in1 0 0 nmos L=180n W=220n
.ends
.subckt xor in1 in2 out1 1
m1 2 in2 1 1 pmos L=180n W=660n
m2 3 in1 2 1 pmos L=180n W=660n
m3 3 2 in1 1 pmos L=180n W=660n
m4 2 in2 0 0 nmos L=180n W=220n 
m5 3 in1 in2 0 nmos L=180n W=220n 
m6 3 in2 in1 nmos L=180n W=220n 
xinv1 3 out1 1 inverter
.ends
.subckt and x y out 1
mp1 2 x 1 1 pmos L=180n W=660n
mp2 2 y 1 1 pmos L=180n W=660n
mn1 2 x node1 0 nmos L=180n W=440n
mn2 node1 y 0 0 nmos L=180n W=440n
xinv1 2 out 1 inverter
.ends
xa1 2 va1 1 inverter
xa2 va1 va2 1 inverter
xb1 3 vb1 1 inverter
xb2 vb1 vb2 1 inverter
xxor1 va2 vb2 sum 1 xor
xand1 va2 vb2 cout 1 and
xfox1 sum fxo1 1 inverter
xfox2 sum fxo2 1 inverter
xfox3 sum fxo3 1 inverter
xfox4 sum fxo4 1 inverter
xfoa1 cout fao1 1 inverter
xfoa2 cout fao2 1 inverter
xfoa3 cout fao3 1 inverter
xfoa4 cout fao4 1 inverter

.tran 0.001n '12*t+11*trf'
.measure tran dfs1 trig v(vb2) val=1.65 rise=1 targ v(sum) val=1.65 fall=1
.measure tran drc1 trig v(vb2) val=1.65 rise=1 targ v(cout) val=1.65 rise=1
.measure tran drs1 trig v(vb2) val=1.65 fall=1 targ v(sum) val=1.65 rise=1
.measure tran dfc1 trig v(vb2) val=1.65 fall=1 targ v(cout) val=1.65 fall=1
.measure tran dfs2 trig v(va2) val=1.65 fall=1 targ v(sum) val=1.65 fall=2
.measure tran drs2 trig v(vb2) val=1.65 rise=2 targ v(sum) val=1.65 rise=2
.measure tran dfs3 trig v(va2) val=1.65 rise=2 targ v(sum) val=1.65 fall=3
.measure tran drc2 trig v(va2) val=1.65 rise=2 targ v(cout) val=1.65 rise=2
.measure tran drs3 trig v(vb2) val=1.65 fall=3 targ v(sum) val=1.65 rise=3
.measure tran dfc2 trig v(vb2) val=1.65 fall=3 targ v(cout) val=1.65 fall=2
.measure tran dfs4 trig v(vb2) val=1.65 rise=4 targ v(sum) val=1.65 fall=4
.measure tran drc3 trig v(vb2) val=1.65 rise=4 targ v(cout) val=1.65 rise=3
.measure tran dfc3 trig v(vb2) val=1.65 fall=4 targ v(cout) val=1.65 fall=3
.measure tran drc4 trig v(vb2) val=1.65 rise=5 targ v(cout) val=1.65 rise=4
.measure tran avg_power avg power from = 0 to = '12*t+11*trf'
.measure tran a0b0_power avg power from = 22n to = 28n
.measure tran a0b1_power avg power from = 32n to = 38n
.measure tran a1b0_power avg power from = 12n to = 18n
.measure tran a1b1_power avg power from = 2n to = 8n
.measure tran tp param = 'max(max(max(max(dfs1, drc1), max(drs1, dfc1)), max(max(dfs2, drs2), max(dfs3, drc2))), max(max(max(drs3, dfc2), max(dfs4, drc3)), max(dfc3, drc4)))' 
.measure tran energy param = 'avg_power * tp'
.param trf = 10p
.param t = '1/(100x)'
.param vddval = 3.3
.end
