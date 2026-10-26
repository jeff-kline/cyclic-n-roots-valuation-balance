\\ Stage 1: F3 at the ramified prime pi = 1 - omega above 13.
read("s1_common.gp");
\\ G, V from s1_common.gp
nf = nfinit(P26);
dec = idealprimedec(nf, 13);
print("primes above 13: ", #dec, "  e = ", dec[1].e, "  f = ", dec[1].f);
pr = dec[1];
piu = 1 - om;
print("v(1-omega) = ", nfeltval(nf, lift(piu), pr), "   v(1+zeta) = ", nfeltval(nf, lift(1+Z), pr));
modpr = nfmodprinit(nf, pr);
vl(a) = if(a==0, +oo, nfeltval(nf, lift(a), pr));
rd(a) = nfmodpr(nf, lift(a), modpr);
\\ row valuations and normalized reductions
rowred(Mx) = {
  my(out = vector(#Mx[,1]), vals = vector(#Mx[,1]));
  for(i=1,#Mx[,1],
    my(e = vecmin(vector(#Mx, j, vl(Mx[i,j]))));
    vals[i] = e;
    out[i] = vector(#Mx, j, rd(Mx[i,j]*piu^(-e))));
  [vals, out] };
[gv, Gb] = rowred(G);
[vv, Vb] = rowred(V);
print("G row valuations: ", gv);
print("G reduced rows (normalized by (1-omega)^-e): ", apply(t->lift(t), Gb));
print("V row valuations: ", vv);
print("V reduced rows: ", apply(t->lift(t), Vb));
ell = [1,6,1];
isprop(rw) = { my(k = 0); for(j=1,3, if(rw[j]!=0, k = rw[j]/Mod(ell[j],13); break)); if(k==0, return(0)); rw == k*Mod(ell,13) };
print("every V row a nonzero multiple of (1,6,1): ", vecmin(vector(#Vb, i, isprop(Vb[i]))) == 1);
\\ F_169 = F_13[t]/(t^2-2)
tt = ffgen(Mod(1,13)*('t^2-2), 't);
one = tt^0;
toff(a) = if(type(a)=="t_FFELT", polcoef(a.pol,0), lift(a))*one;
Gf = matrix(#Gb, 3, i, j, toff(Gb[i][j]));
Vf = matrix(#Vb, 3, i, j, toff(Vb[i][j]));
gradbar(z) = { my(gz = Gf*z, vz = Vf*z); Gf~*vector(#gz,k,1/gz[k])~ - Vf~*vector(#vz,k,1/vz[k])~ };
hessbar(z) = { my(gz = Gf*z, vz = Vf*z); Vf~*matdiagonal(vector(#vz,k,1/vz[k]^2))*Vf - Gf~*matdiagonal(vector(#gz,k,1/gz[k]^2))*Gf };
Tch = [1,0;0,1;-1,-6];   \\ tangent basis of z0 + 6 z1 + z2 = const
{for(sg = -1, 1, if(sg == 0, next);
  my(z = [9 + sg*4*tt, 8 + sg*3*tt, 9 + sg*4*tt]~);
  my(gz = Gf*z, vz = Vf*z);
  print("point sign ", sg, ": chart value l(z) = ", ell*z,
        "  all 28 reduced forms nonzero: ", vecmin(apply(t->t!=0, Vec(concat(gz,vz)))),
        "  grad = ", gradbar(z),
        "  chart Hessian det = ", matdet(Tch~*hessbar(z)*Tch),
        "  R-bar fixes: ", [z[3], z[2], z[1]]~ == z));}
\\ reduction of R and of the chart form
print("zeta^14 mod pi: ", rd(Z^14), "  zeta^12 mod pi: ", rd(Z^12));
\\ count all F_169 critical points on the chart (size 169^2 = 28561 points)
cnt = 0; crit = List();
{for(a0=0,12, for(a1=0,12, for(c0=0,12, for(c1=0,12,
  my(z0 = a0 + a1*tt, z1 = c0 + c1*tt, z2 = 1 - z0 - 6*z1);
  my(z = [z0, z1, z2]~, gz = Gf*z, vz = Vf*z);
  if(vecmin(apply(t->t!=0, Vec(concat(gz,vz)))) == 0, next);
  my(gr = gradbar(z));
  if(Tch~*gr == 0, cnt++; listput(crit, [z, matdet(Tch~*hessbar(z)*Tch)]))))));}
print("number of F_169 chart critical points with all forms nonzero: ", cnt);
for(i=1,#crit, print("  ", crit[i]));
