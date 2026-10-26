\\ Stage 1 cold-examiner checks: common exact setup for the order-26 example.
\\ Built only from audit/packets/claims.md (statements). Indices in the paper are 0-based;
\\ GP vectors are 1-based, so paper index j is GP position j+1.
\\ run with: gp -q -D parisizemax=2000000000 <script>
P26 = polcyclo(26,'y);
Z = Mod('y, P26);            \\ zeta_26 (standard embedding y -> exp(2 Pi I/26))
om = Z^2;                    \\ omega = zeta^2 = exp(2 Pi I/13)
n = 26;
Ev = [0,1,2,3,4,5,6]; Ov = [2,3,4,7,9,10,12];
Up = prod(k=1,#Ev, 'x - om^Ev[k]);
Wp = prod(k=1,#Ov, 'x + om^Ov[k]);
a1 = polcoef(Up,1,'x); b1 = polcoef(Wp,1,'x);
Pu = b1*Up + a1*Wp + 'x^13*(b1*Up - a1*Wp);
u = vector(n, j, polcoef(Pu, j-1, 'x))~;
F = matrix(n,n,i,j, Z^((i-1)*(j-1)));
I0 = [0,1,2,3,5,7,13,15,17,18,19,20];
J0 = [3,9,13,14,15,16,18,20,22,23,24,25];
B0 = setminus([0..25], J0);
Ic0 = setminus([0..25], I0);
D0 = setminus(I0, [20]);
T0 = [17,19,21];
C0 = setminus(B0, T0);
p1(v) = apply(t->t+1, v);    \\ 0-based -> 1-based
sub(Mx, r, c) = vecextract(Mx, p1(r), p1(c));
\\ monomial matrices U and S from F2
Um = matrix(n,n); for(i=0,n-1, Um[i+1, ((20-i)%26)+1] = Z^(-10-12*i));
Sm = matrix(n,n); for(k=0,n-1, Sm[k+1, ((12-k)%26)+1] = Z^(-10-20*k));
\\ reduction map Z[zeta] -> F_p sending zeta -> r
red(a, p, r) = if(type(a)=="t_POLMOD", subst(lift(a),'y,Mod(r,p)), Mod(a,p));
redM(Mx, p, r) = matrix(#Mx[,1], #Mx, i,j, red(Mx[i,j],p,r));
redV(v, p, r) = vector(#v, i, red(v[i],p,r))~;
\\ exact G (columns span ker A^T, G_{T0}=Id) and V = F[I^c,B] G
M = sub(F, D0, C0);
Gc = -M^-1 * sub(F, D0, T0);
G = matrix(#B0, 3);
{for(r=1,#B0, my(k=B0[r], pos=setsearch(T0,k));
  if(pos, G[r,pos]=1,
     my(c=setsearch(C0,k)); for(j=1,3, G[r,j]=Gc[c,j])));}
V = sub(F, Ic0, B0)*G;
