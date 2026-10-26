\\ mu Stage-1 examiner: exact objects over Q(omega), omega = primitive 13th root.
\\ Independent code (cold examiner). Indices follow the packet (0-based); GP vectors are 1-based.
Phi = polcyclo(13,'x);
om = Mod('x, Phi);
zt = -om^7;
zp = vector(26, k, zt^(k-1));            \\ zp[k+1] = zeta^k
Fe(i,j) = zp[((i*j) % 26) + 1];
F = matrix(26,26,i,j, Fe(i-1,j-1));
Iset = [0,1,2,3,5,7,13,15,17,18,19,20];
Jset = [3,9,13,14,15,16,18,20,22,23,24,25];
Bset = setminus(Set([0..25]), Set(Jset));
Icset = setminus(Set([0..25]), Set(Iset));
Dset = setminus(Set(Iset), Set([20]));
Tset = [17,19,21];
Cset = setminus(Set(Bset), Set(Tset));
sub(Mx, R, Cc) = matrix(#R, #Cc, a, b, Mx[R[a]+1, Cc[b]+1]);
vp(a) = a = a*Mod(1,Phi); if(a == 0, 10^9, valuation(norm(a), 13));   \\ v_pi on Q(omega): f=1
res13(a) = Mod(subst(lift(a*Mod(1,Phi)), 'x, 1), 13);                  \\ residue of an integral element

\\ U, W and u
polmul1(c, r) = my(n=#c, d=vector(n+1)); for(k=1,n+1, d[k] = if(k>=2, c[k-1], 0) - if(k<=n, r*c[k], 0)); d;
Uc = [Mod(1,Phi)]; for(e=0,6, Uc = polmul1(Uc, om^e));
Wc = [Mod(1,Phi)]; foreach([2,3,4,7,9,10,12], o, Wc = polmul1(Wc, -om^o));
a1 = Uc[2]; b1 = Wc[2];
u = vector(26, k, Mod(0,Phi));
for(k=0,7, u[k+1] = b1*Uc[k+1] + a1*Wc[k+1]; u[14+k] = b1*Uc[k+1] - a1*Wc[k+1]);
f = F*u~;
suppu = select(k->u[k+1]!=0, [0..25]);
suppf = select(k->f[k+1]!=0, [0..25]);
print("supp u = ", suppu, "  == I ? ", suppu == Iset);
print("supp Fu = ", suppf, "  == J ? ", suppf == Jset);
print("v(u_I) = ", vector(#Iset,k,vp(u[Iset[k]+1])));
print("v(f_J) = ", vector(#Jset,k,vp(f[Jset[k]+1])));

\\ G, V
FIB = sub(F, Iset, Bset);
print("rank F[I,B] = ", matrank(FIB));
M = sub(F, Dset, Cset);
dM = matdet(M);
print("v(det M) = ", vp(dM));
Minv = M^-1;
GC = -Minv * sub(F, Dset, Tset);
G = matrix(#Bset, 3, r, c, my(k=Bset[r], pT=setsearch(Set(Tset),k)); if(pT, (pT==c)*Mod(1,Phi), GC[setsearch(Cset,k), c]));
print("G row valuations = ", vector(#Bset, r, vecmin(vector(3,c,vp(G[r,c])))));
print("F[I,B]*G == 0 ? ", FIB*G == 0);
V = sub(F, Icset, Bset) * G;
cV = vector(#Icset, r, vecmin(vector(3,c,vp(V[r,c]))));
print("V row valuations (Ic order ", Icset, ") = ", cV);
P13 = prod(j=2,12, 1 - om^j);       \\ pi * P13 = 13
print("pi*P13 == 13 ? ", (1-om)*P13 == 13);
Vn = matrix(#Icset, 3, r, c, V[r,c] * P13^cV[r] / 13^cV[r]);   \\ V row / pi^c
print("normalized V row residues / first entry:");
for(r=1,#Icset, my(rr = vector(3,c,res13(Vn[r,c]))); print("  i=",Icset[r],": ", rr, "  proj ", rr/rr[1]));

\\ h
hf = vector(26, j, if(setsearch(Set(Jset), j-1), 1/f[j], Mod(0,Phi)));
hu = vector(26, i, if(setsearch(Set(Iset), i-1), 1/u[i], Mod(0,Phi)));
h = F*hf~ - hu~;
print("u^T h == 0 ? ", u*h == 0);
print("v(h) = ", vector(26,k,vp(h[k])));
print("u_20 = ", u[21] != 0);
