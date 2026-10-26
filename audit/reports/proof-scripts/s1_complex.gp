\\ Stage 1: independent check in C (standard embedding) of Theorem 4.1's content.
\\ (a) R-fixed critical points: build exactly the 1-variable critical equation on the fixed line
\\     z(s) = (zeta^14 s, 1, s), find its roots numerically, check full gradient, Hessian rank, kappa.
\\ (b) Newton from random starts for further critical points; check kappa(Rz) = -kappa(z).
read("s1_common.gp");
default(realprecision, 80);
zc = exp(2*Pi*I/26);
emb(a) = if(type(a)=="t_POLMOD", subst(lift(a),'y,zc), a*1.);
Gn = matrix(#G[,1],3,i,j,emb(G[i,j]));
Vn = matrix(#V[,1],3,i,j,emb(V[i,j]));
Fn = matrix(n,n,i,j,zc^((i-1)*(j-1)));
un = vector(n,j,emb(u[j]))~;
\\ exact one-variable equation on the R-fixed line
zs = [Z^14*'x, 1, 'x]~;
PG = prod(k=1,#G[,1], (G*zs)[k]);
PV = prod(k=1,#V[,1], (V*zs)[k]);
N = deriv(PG,'x)*PV - deriv(PV,'x)*PG;
print("degree of N: ", poldegree(N,'x));
Nn = Pol(apply(c->emb(c), Vec(N)),'x);
rts = polroots(Nn);
grad(z) = { my(gz = Gn*z, vz = Vn*z); Gn~*vector(#gz,k,1/gz[k])~ - Vn~*vector(#vz,k,1/vz[k])~ };
hess(z) = { my(gz = Gn*z, vz = Vn*z); Vn~*matdiagonal(vector(#vz,k,1/vz[k]^2))*Vn - Gn~*matdiagonal(vector(#gz,k,1/gz[k]^2))*Gn };
Ichart = [1,0;0,1;-1/zc^14,-6/zc^14];   \\ tangent of z0 + 6 z1 + zeta^14 z2 = const
kapn(z) = {
  my(gB = Gn*z, g = vector(n)~, v, w, rhs, A, Ap, wIp, f, phi, psi, h, i0);
  for(rr=1,#B0, g[B0[rr]+1] = gB[rr]);
  v = Fn*g;
  w = vector(n)~; for(t=1,#Ic0, w[Ic0[t]+1] = 1/v[Ic0[t]+1]);
  A = sub(Fn, B0, I0);
  rhs = vector(#B0, k, 1/gB[k])~ - sub(Fn, B0, Ic0)*vecextract(w, p1(Ic0));
  Ap = vecextract(A, [1..14], [2..12]);   \\ set w_{I[0]} = 0 (u_I has no zero entries)
  wIp = matsolve(conj(Ap)~*Ap, conj(Ap)~*rhs);
  w[I0[1]+1] = 0; for(t=2,#I0, w[I0[t]+1] = wIp[t-1]);
  my(resid = norml2(vecextract(Fn*w, p1(B0)) - vector(#B0,k,1/gB[k])~));
  f = Fn*un;
  phi = vector(n)~; for(t=1,#J0, phi[J0[t]+1] = 1/f[J0[t]+1]);
  psi = vector(n)~; for(t=1,#I0, psi[I0[t]+1] = 1/un[I0[t]+1]);
  h = Fn*phi - psi;
  [w~*h, resid, abs(v[I0[1]+1])] };
nrm(z) = z / (z[1] + 6*z[2] + zc^14*z[3]);
cntfix = 0;
{for(k=1,#rts, my(s = rts[k], z = [zc^14*s, 1, s]~);
  my(gz = Gn*z, vz = Vn*z, mn = vecmin(apply(abs, Vec(concat(gz,vz)))));
  if(mn < 1e-30, next);
  z = nrm(z);
  my(gr = norml2(grad(z)), hd = abs(matdet(Ichart~*hess(z)*Ichart)), kp = kapn(z));
  cntfix++;
  printf("fixed crit %2d: |grad|^2=%.2e  |chart Hess det|=%.3e  |kappa|=%.3e  resid=%.1e  min|form|=%.2e\n", cntfix, gr, hd, abs(kp[1]), kp[2], mn));}
\\ also the projective point with z1 = 0 on the fixed line
z0p = [zc^14, 0, 1]~; print("fixed point z1=0: min |form| = ", vecmin(apply(abs, Vec(concat(Gn*z0p, Vn*z0p)))));
\\ (b) Newton on the chart from random starts
newton(z) = { for(it=1,200, my(gr = Ichart~*grad(z), Hc = Ichart~*hess(z)*Ichart, d);
    if(norml2(gr) < 1e-140, return(z));
    d = matsolve(Hc, gr); z = z - Ichart*d; z = nrm(z)); 0 };
setrand(12345);
found = List();
{for(trial=1,60,
  my(z = nrm([random(1.)+I*random(1.)-0.5-0.5*I, random(1.)+I*random(1.)-0.5-0.5*I, random(1.)+I*random(1.)-0.5-0.5*I]~));
  my(zz = iferr(newton(z), e, 0));
  if(zz === 0, next);
  if(norml2(grad(zz)) > 1e-100, next);
  my(new = 1); for(j=1,#found, if(norml2(found[j]-zz) < 1e-40, new = 0; break));
  if(new, listput(found, zz)));}
print("distinct critical points found by Newton: ", #found);
Rn(z) = [zc^14*z[3], z[2], zc^12*z[1]]~;
{for(j=1,#found, my(z = found[j], kz = kapn(z)[1], kr = kapn(nrm(Rn(z)))[1], scl = nrm(Rn(z))[1]/Rn(z)[1]);
  printf("crit %2d: |z-Rz|=%.2e |kappa|=%.4e  kappa(Rz)+kappa(z)=%.2e  |chartHess|=%.3e\n", j, sqrt(norml2(z-nrm(Rn(z)))), abs(kz), abs(kr + kz), abs(matdet(Ichart~*hess(z)*Ichart))));}
