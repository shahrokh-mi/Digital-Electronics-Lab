Sample

.protect
.lib 'mm018.l' tt
.unprotect

vdd 1 0 vddval
vin1 2 0 vddval
m1 3 2 1 1 pmos L=180n W=wpmos
m2 3 2 0 0 nmos L=180n W=220n
.DC vin1 0 1.8 0.001 wpmos 1.0255u 1.0256u 0.001n
.measure DC out1 Find V(3) at 0.9
.param vddval=1.8
.param wpmos = 1.0256u
.end
