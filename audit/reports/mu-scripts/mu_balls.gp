\\ mu Stage-1 examiner: Hensel lift and ball evaluation of mu over K = Q_13(omega, t), t^2 = 2.
\\ Elements: mantissa X = [A,B] meaning A(omega) + B(omega) t, A,B integer polys of degree <= 11.
\\ Ball [E, X, N, v]: true value lies in 13^E * X + pi^N O_K; v = exact valuation of the center (INF if 0).
\\ Truncating a mantissa mod q = 13^S moves the center by 13^(E+S) O_K = pi^(12(E+S)) O_K; every op caps N there.
read("mu_exact.gp");
INF = 10^9;
if(type(S) != "t_INT", S = 60);
q = 13^S;
PP = lift(P13);                         \\ integer poly with pi*PP = 13
rq(A) = liftall(Mod(A, Phi)*Mod(1,q));
rx(A) = lift(Mod(A, Phi));              \\ exact reduction mod Phi (no truncation)
em(X,Y) = [rq(X[1]*Y[1] + 2*X[2]*Y[2]), rq(X[1]*Y[2] + X[2]*Y[1])];
ea(X,Y) = [rq(X[1]+Y[1]), rq(X[2]+Y[2])];
vA(A) = if(A == 0, INF, my(Pp = subst(A, 'x, 1 - 'p), m = INF); for(k=0, poldegree(Pp), my(c = polcoef(Pp,k)); if(c != 0, m = min(m, 12*valuation(c,13) + k))); m);
ev(X) = min(vA(X[1]), vA(X[2]));
div13(X) = (X[1]==0 || content(X[1]) % 13 == 0) && (X[2]==0 || content(X[2]) % 13 == 0);
eres(X) = [Mod(subst(X[1],'x,1),13), Mod(subst(X[2],'x,1),13)];   \\ residue (unit) in F_13[t]/(t^2-2)
einvunit(X) = {
  my(r = eres(X), d = (r[1]^2 - 2*r[2]^2), y, k = 0);
  if(d == 0, error("einvunit: not a unit"));
  y = [lift(r[1]/d), lift(-r[2]/d)];
  while(em(X,y) != [1,0], y = em(y, ea([2,0], em([-1,0], em(X,y)))); k++; if(k > 20, error("einvunit: no convergence")));
  y;
}
mkball(E, X, N) = {
  if(X[1] == 0 && X[2] == 0, return([0, [0,0], N, INF]));
  while(div13(X), X = [X[1]/13, X[2]/13]; E++);
  [E, X, N, 12*E + ev(X)];
}
bmul(a, b) = { my(E = a[1]+b[1]); mkball(E, em(a[2], b[2]), vecmin([a[3]+b[4], b[3]+a[4], a[3]+b[3], 12*(E+S)])); }
badd(a, b) = {
  my(E = min(a[1], b[1]));
  mkball(E, ea([a[2][1]*13^(a[1]-E), a[2][2]*13^(a[1]-E)], [b[2][1]*13^(b[1]-E), b[2][2]*13^(b[1]-E)]), vecmin([a[3], b[3], 12*(E+S)]));
}
bneg(a) = [a[1], [-a[2][1], -a[2][2]], a[3], a[4]];
bsub(a, b) = badd(a, bneg(b));
binv(a) = {
  my(E = a[1], X = a[2], al, Pa, Y, eps, y, Ep);
  if(a[4] >= a[3], error("binv: ball contains 0, v=", a[4], " N=", a[3]));
  al = ev(X);  \\ 0..11 since mantissa normalized
  Pa = rx(PP^al);
  Y = [rx(X[1]*Pa), rx(X[2]*Pa)];
  if(!((Y[1]==0 || content(Y[1]) % 13^al == 0) && (Y[2]==0 || content(Y[2]) % 13^al == 0)), error("binv: divisibility"));
  eps = [rq(Y[1]/13^al), rq(Y[2]/13^al)];
  y = einvunit(eps);
  Ep = -E - al;
  mkball(Ep, em([Pa,0], y), min(a[3] - 2*a[4], 12*(Ep+S)));
}
bdiv(a, b) = bmul(a, binv(b));
\\ exact Q(omega) element -> ball
toball(c) = {
  my(lc = lift(c*Mod(1,Phi)), d, k, d1, num);
  if(lc == 0, return([0,[0,0],INF,INF]));
  d = denominator(content(lc)); k = valuation(d,13); d1 = d/13^k; num = lc*d;
  mkball(-k, [rq(num*lift(Mod(1,q)/d1)), 0], 12*(-k+S));
}
bzero = [0,[0,0],INF,INF];
bsum(v) = my(s = bzero); for(i=1,#v, s = badd(s, v[i])); s;
\\ residue of pi^(-v) * center, for a ball with v < N.  center = 13^E X, 13 = pi^12 * eta, eta == -1 mod pi.
lead(a) = {
  my(X = a[2], al = ev(X), A = subst(X[1],'x,1-'p), B = subst(X[2],'x,1-'p), sg = (-1)^a[1]);
  \\ X = sum c_k pi^k ; residue of X/pi^al = c_al mod 13 (lower coefficients carry a factor 13 = pi^12 eta)
  [Mod(sg*polcoef(A,al),13), Mod(sg*polcoef(B,al),13)];
}

\\ ---------------- Hensel lift on the chart ----------------
z12 = toball(zt^12); z14 = toball(zt^14);
Gb = matrix(#Bset,3,r,c, toball(G[r,c]));
Vnb = matrix(#Icset,3,r,c, toball(Vn[r,c]));
Vb = matrix(#Icset,3,r,c, toball(V[r,c]));
\\ ring-level (integral, mod q) mantissas of the exact forms: E must be 0 (integral, non-13 denominators only)
ring(b) = { if(b[4] == INF, return([0,0])); if(b[1] < 0, error("ring: not integral")); [rq(b[2][1]*13^b[1]), rq(b[2][2]*13^b[1])]; }
Gr = matrix(#Bset,3,r,c, ring(Gb[r,c]));
Vr = matrix(#Icset,3,r,c, ring(Vnb[r,c]));
z12r = ring(z12);
ex = [[1,0],[0,0],em([-1,0],z12r)];
ey = [[0,0],[1,0],em([-6,0],z12r)];
form(row, z) = ea(ea(em(row[1],z[1]), em(row[2],z[2])), em(row[3],z[3]));
chart(xv, yv) = [xv, yv, em(z12r, ea([1,0], em([-1,0], ea(xv, em([6,0],yv)))))];
gradhess(xv, yv) = {
  my(z = chart(xv,yv), g1=[0,0], g2=[0,0], h11=[0,0], h12=[0,0], h22=[0,0]);
  for(r=1,#Bset, my(row = Gr[r,], L = form(row,z), li = einvunit(L), ax = em(form(row,ex),li), ay = em(form(row,ey),li));
    g1 = ea(g1, ax); g2 = ea(g2, ay);
    h11 = ea(h11, em([-1,0], em(ax,ax))); h12 = ea(h12, em([-1,0], em(ax,ay))); h22 = ea(h22, em([-1,0], em(ay,ay))));
  for(r=1,#Icset, my(row = Vr[r,], L = form(row,z), li = einvunit(L), ax = em(form(row,ex),li), ay = em(form(row,ey),li));
    g1 = ea(g1, em([-1,0],ax)); g2 = ea(g2, em([-1,0],ay));
    h11 = ea(h11, em(ax,ax)); h12 = ea(h12, em(ax,ay)); h22 = ea(h22, em(ay,ay)));
  [g1, g2, h11, h12, h22];
}
hensel(x0, y0) = {
  my(xv = x0, yv = y0, gh, d, di, dx, dy, it = 0);
  gh = gradhess(xv, yv);
  print("  residue grad = ", [eres(gh[1]), eres(gh[2])]);
  print("  residue Hessian = ", [eres(gh[3]), eres(gh[4]); eres(gh[4]), eres(gh[5])]);
  while(gh[1] != [0,0] || gh[2] != [0,0],
    d = ea(em(gh[3],gh[5]), em([-1,0], em(gh[4],gh[4]))); di = einvunit(d);
    dx = em(di, ea(em(gh[5],gh[1]), em([-1,0], em(gh[4],gh[2]))));
    dy = em(di, ea(em(gh[3],gh[2]), em([-1,0], em(gh[4],gh[1]))));
    xv = ea(xv, em([-1,0],dx)); yv = ea(yv, em([-1,0],dy));
    gh = gradhess(xv, yv); it++; if(it > 30, error("hensel: no convergence")));
  print("  Newton iterations: ", it, "; gradient == 0 mod 13^", S, " (pi^", 12*S, ")");
  [xv, yv, d];
}

\\ ---------------- mu on a ball around the lift ----------------
Fb = matrix(26,26,i,j, toball(F[i,j]));
ub = vector(26,k, toball(u[k])); fb = vector(26,k, toball(f[k])); hb = vector(26,k, toball(h[k]));
Minvb = matrix(11,11,i,j, toball(Minv[i,j]));
Ib(k) = setsearch(Set(Iset),k); Jb(k) = setsearch(Set(Jset),k);

solve_complete(A, rhs) = {
  \\ complete-pivot Gaussian elimination in ball arithmetic; pivot = least center valuation among entries with v < N
  my(n = #rhs, perm = vector(n,i,i), A2 = A, b2 = rhs, piv, bi, bj, bv, x, minpN = INF, pivv = vector(n));
  for(k=1,n,
    bv = INF; bi = 0; bj = 0;
    for(i=k,n, for(j=k,n, my(e = A2[i,j]); if(e[4] < e[3] && e[4] < bv, bv = e[4]; bi = i; bj = j)));
    if(bi == 0, error("solve: no certified pivot at step ", k));
    pivv[k] = bv;
    if(bi != k, my(tmp = A2[k,]); A2[k,] = A2[bi,]; A2[bi,] = tmp; tmp = b2[k]; b2[k] = b2[bi]; b2[bi] = tmp);
    if(bj != k, my(tmp = A2[,k]); A2[,k] = A2[,bj]; A2[,bj] = tmp; tmp = perm[k]; perm[k] = perm[bj]; perm[bj] = tmp);
    piv = binv(A2[k,k]);
    for(i=k+1,n, my(m = bmul(A2[i,k], piv));
      if(m[4] != INF || m[3] < INF,
        for(j=k+1,n, A2[i,j] = bsub(A2[i,j], bmul(m, A2[k,j])));
        b2[i] = bsub(b2[i], bmul(m, b2[k])))));
  x = vector(n);
  forstep(k=n,1,-1, my(s = b2[k]); for(j=k+1,n, s = bsub(s, bmul(A2[k,j], x[j]))); x[k] = bmul(s, binv(A2[k,k])));
  my(y = vector(n)); for(k=1,n, y[perm[k]] = x[k]);
  [y, pivv];
}

mu_at(xv, yv, drop) = {
  my(N0 = if(type(N0OVR)=="t_INT", N0OVR, 12*S), zb, g, v, w, wD, rhsC, Fw, ghat, L, R, Ar, hr, sol, s, mu, kap, t1, t2, t3, chk);
  zb = vector(3); zb[1] = mkball(0, xv, N0); zb[2] = mkball(0, yv, N0);
  zb[3] = bmul(z12, bsub(mkball(0,[1,0],INF), badd(zb[1], bmul(toball(6), zb[2]))));
  g = vector(26, k, bzero); for(r=1,#Bset, g[Bset[r]+1] = bsum(vector(3,c, bmul(Gb[r,c], zb[c]))));
  v = vector(26, k, bzero); for(r=1,#Icset, v[Icset[r]+1] = bsum(vector(3,c, bmul(Vb[r,c], zb[c]))));
  print("  v(g_B) = ", vector(#Bset,r,g[Bset[r]+1][4]), "  v(v_Ic) = ", vector(#Icset,r,v[Icset[r]+1][4]));
  w = vector(26, k, bzero);
  for(r=1,#Icset, w[Icset[r]+1] = binv(v[Icset[r]+1]));
  rhsC = vector(#Cset, r, my(k = Cset[r]); bsub(binv(g[k+1]), bsum(vector(#Icset, c, bmul(Fb[k+1, Icset[c]+1], w[Icset[c]+1])))));
  \\ F[C,D] w_D = rhsC, F[C,D] = M^T, so w_D = (M^-1)^T rhsC
  for(r=1,#Dset, w[Dset[r]+1] = bsum(vector(#Cset, c, bmul(Minvb[c,r], rhsC[c]))));
  if(type(WSHIFT)=="t_INT" && WSHIFT != 0, for(k=1,26, w[k] = badd(w[k], bmul(toball(WSHIFT), ub[k]))); print("  [w shifted by ", WSHIFT, "*u]"));
  print("  v(w) = ", vector(26,k,w[k][4]), "  min N(w) = ", vecmin(vector(26,k,w[k][3])));
  Fw = vector(26, j, bsum(vector(26, i, bmul(Fb[j,i], w[i]))));
  chk = vector(#Bset, r, my(k=Bset[r]); my(d = bsub(Fw[k+1], binv(g[k+1]))); [d[4], d[3]]);
  print("  (Fw-1/g)_B [v(center), N] = ", chk);
  ghat = vector(26, m, bsum(vector(#Bset, r, my(k = Bset[r]); bmul(bmul(g[k+1],g[k+1]), Fb[k+1, m]))));  \\ ghat[m+1] = sum_k g_k^2 zeta^(k m)
  L = matrix(26,26,a,b, my(e = bneg(ghat[((a-1)+(b-1)) % 26 + 1])); if(a==b, badd(e, bmul(v[a],v[a])), e));
  \\ sanity: L u, L w
  my(Lu = vector(26,a, bsum(vector(26,b, bmul(L[a,b], ub[b])))), Lw = vector(26,a, bsum(vector(26,b, bmul(L[a,b], w[b])))));
  print("  L u : min over rows of (v(center)-N) [>=0 means every row ball contains 0] = ", vecmin(vector(26,a, if(Lu[a][4]==INF, INF, Lu[a][4]-Lu[a][3]))), "   L w : ", vecmin(vector(26,a, if(Lw[a][4]==INF, INF, Lw[a][4]-Lw[a][3]))));
  kap = bsum(vector(26,i, bmul(w[i], hb[i])));
  print("  kappa ball: v(center)=", kap[4], " N=", kap[3], (if(kap[4] >= kap[3], "  (contains 0)", "  (EXCLUDES 0!)")));
  R = setminus(Set([0..25]), Set(drop));
  Ar = matrix(24,24,a,b, L[R[a]+1, R[b]+1]);
  hr = vector(24, a, bneg(hb[R[a]+1]));
  sol = solve_complete(Ar, hr);
  print("  pivot valuations: ", sol[2]);
  s = vector(26, k, bzero); for(a=1,24, s[R[a]+1] = sol[1][a]);
  print("  v(s) = ", vector(26,k,s[k][4]), "  min N(s) = ", vecmin(vector(26,k,s[k][3])));
  t1 = bsum(vector(#Jset, r, my(j = Jset[r], e = bdiv(Fw[j+1], fb[j+1])); bmul(e,e)));
  t2 = bsum(vector(#Iset, r, my(i = Iset[r], e = bdiv(w[i+1], ub[i+1])); bmul(e,e)));
  t3 = bneg(bsum(vector(26, k, bmul(hb[k], s[k]))));
  mu = badd(bsub(t1, t2), t3); LASTQ2 = bsub(t1, t2); LASTHS = bneg(t3);
  print("  terms: v(T1)=", t1[4], " N=", t1[3], "; v(T2)=", t2[4], " N=", t2[3], "; v(-h.s)=", t3[4], " N=", t3[3]);
  print("  mu ball: v(center) = ", mu[4], ", N = ", mu[3], if(mu[4] < mu[3], Str("  => mu != 0, v(mu) = ", mu[4]), "  => NOT certified"));
  if(mu[4] < mu[3], print("  leading residue of pi^(-v) mu = ", lead(mu), "  (as a + b t)"));
  mu;
}
