\\ Stage 2: independent recomputation (my own code, not the author's checker) of
\\ the F53 Hessian matrix, the F169 chart Hessians, and the Prop 3.1 factorizations.
read("s1_common.gp");
\\ (1) 10037 map: omega -> 5992 is a root of Phi_13, and -5992^7 = 5215
print("Phi13(5992) mod 10037 = ", subst(polcyclo(13,'x),'x,Mod(5992,10037)), "   -5992^7 = ", -Mod(5992,10037)^7);
print("det M via omega->5992 (= zeta -> -5992^7): ", subst(lift(matdet(M)),'y, -Mod(5992,10037)^7));
\\ (2) F53 data
p = 53; r = 4;
Fp = matrix(n,n,i,j, Mod(r,p)^((i-1)*(j-1)));
Gp = redM(G, p, r); Vp = redM(V, p, r); up = redV(u, p, r);
print("reduced exact G spans ker A^T mod 53: F[I,B] G == 0: ", sub(Fp,I0,B0)*Gp == 0, "  rank ", matrank(Gp));
z = [1,8,19]~; gB = Gp*z; vI = Vp*z;
H = Vp~*matdiagonal(vector(14,k,1/vI[k]^2))*Vp - Gp~*matdiagonal(vector(14,k,1/gB[k]^2))*Gp;
print("H mod 53 = ", lift(H));
\\ Prop 3.1 objects: N r = (r_{I^c}, (F r)_{J^c}), D = diag(v^2, -g^2), Lambda = [V; -G]
g = vector(n)~; for(t=1,#B0, g[B0[t]+1] = gB[t]);
v = Fp*g;
Pic = matrix(14, n, a, b, b == Ic0[a]+1);
Pjc = matrix(14, n, a, b, b == B0[a]+1);
Nm = matconcat([Pic; Pjc*Fp]);
Dm = matdiagonal(concat(vector(14,k,vI[k]^2), vector(14,k,-gB[k]^2)));
Lm = matdiagonal(vector(n,k,v[k]^2)) - Fp*matdiagonal(vector(n,k,g[k]^2))*Fp;
Lam = matconcat([Vp; -Gp]);
print("L == N^T D N: ", Lm == Nm~*Dm*Nm, "   N^T Lambda == 0: ", Nm~*Lam == 0, "   rank N = ", matrank(Nm), "  rank Lambda = ", matrank(Lam));
print("Lambda^T D^{-1} Lambda == H: ", Lam~*Dm^-1*Lam == H, "   ker N = span u: ", matker(Nm) == matker(Nm) && matrank(matconcat([matker(Nm), up])) == 1);
print("H z == -grad Psi (== 0 here): ", H*z == -(Gp~*vector(14,k,1/gB[k])~ - Vp~*vector(14,k,1/vI[k])~));
\\ (3) F169 chart Hessians on z2 = 1 - z0 - 6 z1, computed from MY normalized rows
nf = nfinit(P26); pr = idealprimedec(nf,13)[1]; modpr = nfmodprinit(nf, pr);
piu = 1 - om;
rowred(Mx) = { my(out = vector(#Mx[,1])); for(i=1,#Mx[,1], my(e = vecmin(vector(#Mx, j, if(Mx[i,j]==0, 10^6, nfeltval(nf, lift(Mx[i,j]), pr)))));
    out[i] = vector(#Mx, j, nfmodpr(nf, lift(Mx[i,j]*piu^(-e)), modpr))); out };
Gb = rowred(G); Vb = rowred(V);
tt = ffgen(Mod(1,13)*('t^2-2), 't); one = tt^0;
toff(a) = if(type(a)=="t_FFELT", polcoef(a.pol,0), lift(a))*one;
Gf = matrix(14,3,i,j,toff(Gb[i][j])); Vf = matrix(14,3,i,j,toff(Vb[i][j]));
Tch = [1,0;0,1;-1,-6];
{for(sg=-1,1, if(sg==0, next);
  my(zz = [9+sg*4*tt, 8+sg*3*tt, 9+sg*4*tt]~, gz = Gf*zz, vz = Vf*zz);
  my(Hb = Vf~*matdiagonal(vector(14,k,1/vz[k]^2))*Vf - Gf~*matdiagonal(vector(14,k,1/gz[k]^2))*Gf);
  my(Hc = Tch~*Hb*Tch);
  print("sign ", sg, ": chart Hessian = ", Hc, "  det = ", matdet(Hc), "  norm(det) = ", norm(matdet(Hc))));}
