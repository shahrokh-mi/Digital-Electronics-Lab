Sample

.protect
.lib 'mm018.l' tt
.unprotect

vdd 1 0 vddval
vin1 2 0 vddval
m1 3 2 1 1 pmos L=180n W=wp
m2 3 2 0 0 nmos L=180n W=220n
.DC vin1 0 1.8 0.001 wp '0.7*wpmos' '1.3*wpmos' '0.1*wpmos'
.measure DC out1 Find V(3) at 0.9
.measure DC ol Find V(2) at 1.8
.measure DC oh Find V(2) at 0
.measure DC ih Find V(3) when deriv('V(3)')=-1 cross=2
.measure DC il Find V(3) when deriv('V(3)')=-1 cross=1
.measure DC nml param = 'ol - ih'
.measure DC nmh param = 'il - oh'
.param vddval=1.8
.param wpmos = 1.0256u
.param wp = wpmos
.end
