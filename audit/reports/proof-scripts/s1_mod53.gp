\\ Stage 1: F1 at the split prime 53 (zeta -> 4), computed directly over F_53.
read("s1_common.gp");
p = 53; r = 4;
print("4 has order ", znorder(Mod(4,53)), " mod 53; 4^2 = ", Mod(4,53)^2, "; -16^7 = ", -Mod(16,53)^7);
Fp = matrix(n,n,i,j, Mod(r,p)^((i-1)*(j-1)));
\\ u mod p: rebuild from U, W with omega -> 16 (ring hom), and compare with reduced exact u
omp = Mod(r,p)^2;
Upp = prod(k=1,#Ev, 'x - omp^Ev[k]); Wpp = prod(k=1,#Ov, 'x + omp^Ov[k]);
a1p = polcoef(Upp,1); b1p = polcoef(Wpp,1);
Pup = b1p*Upp + a1p*Wpp + 'x^13*(b1p*Upp - a1p*Wpp);
up = vector(n, j, polcoef(Pup, j-1))~;
print("u mod 53 agrees with reduction of exact u: ", up == redV(u, p, r));
fp = Fp*up;
print("supp u, Fu mod 53: ", [#select(t->t!=0, Vec(up)), #select(t->t!=0, Vec(fp))]);
Mp = sub(Fp, D0, C0);
print("det M mod 53: ", matdet(Mp));
Gcp = -Mp^-1 * sub(Fp, D0, T0);
Gp = matrix(#B0, 3);
{for(rr=1,#B0, my(k=B0[rr], pos=setsearch(T0,k));
  if(pos, Gp[rr,pos]=Mod(1,p), my(c=setsearch(C0,k)); for(j=1,3, Gp[rr,j]=Gcp[c,j])));}
Vp = sub(Fp, Ic0, B0)*Gp;
z = [1,8,19]~;
gB = Gp*z; vI = Vp*z;
print("all 28 forms nonzero: ", vecmin(apply(t->t!=0, Vec(concat(gB, vI)))) == 1);
grad = Gp~*vector(#gB,k,1/gB[k])~ - Vp~*vector(#vI,k,1/vI[k])~;
print("gradient: ", lift(grad));
H = Vp~*matdiagonal(vector(#vI,k,1/vI[k]^2))*Vp - Gp~*matdiagonal(vector(#gB,k,1/gB[k]^2))*Gp;
print("H z == 0: ", H*z == 0, "  rank H: ", matrank(H));
print("principal 2x2 minors (charts z0=1, z1=1, z2=1): ", lift([matdet(vecextract(H,[2,3],[2,3])), matdet(vecextract(H,[1,3],[1,3])), matdet(vecextract(H,[1,2],[1,2]))]));
\\ kappa
kap(Fm, um, gBv) = {
  my(nn=#um, g=vector(nn)~, v, w, rhs, A, wI, f, phi, psi, h, L, s, mu, res);
  for(rr=1,#B0, g[B0[rr]+1] = gBv[rr]);
  v = Fm*g;
  if(vecextract(v, p1(I0)) != 0, error("v_I != 0"));
  w = vector(nn)~;
  for(t=1,#Ic0, w[Ic0[t]+1] = 1/v[Ic0[t]+1]);
  A = sub(Fm, B0, I0);
  rhs = vector(#B0, k, 1/gBv[k])~ - sub(Fm, B0, Ic0)*vecextract(w, p1(Ic0));
  wI = matinverseimage(A, rhs);
  if(#wI == 0, error("normal system not solvable"));
  for(t=1,#I0, w[I0[t]+1] = wI[t]);
  if(vecextract(Fm*w, p1(B0)) != vector(#B0,k,1/gBv[k])~, error("Fw check"));
  f = Fm*um;
  phi = vector(nn)~; for(t=1,#J0, phi[J0[t]+1] = 1/f[J0[t]+1]);
  psi = vector(nn)~; for(t=1,#I0, psi[I0[t]+1] = 1/um[I0[t]+1]);
  h = Fm*phi - psi;
  res = [w~*h, um~*h];
  L = matdiagonal(vector(nn,k,v[k]^2)) - Fm*matdiagonal(vector(nn,k,g[k]^2))*Fm;
  res = concat(res, [nn - matrank(L)]);
  s = matinverseimage(L, -h);
  if(#s, mu = sum(t=1,#J0, ((Fm*w)[J0[t]+1]/f[J0[t]+1])^2) - sum(t=1,#I0,(w[I0[t]+1]/um[I0[t]+1])^2) + s~*L*s; res = concat(res,[mu]));
  res };
K53 = kap(Fp, up, gB);
print("[kappa, u^T h, dim ker L, (mu if defined)] mod 53: ", lift(K53));
