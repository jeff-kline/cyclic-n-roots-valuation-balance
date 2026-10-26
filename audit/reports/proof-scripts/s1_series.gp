\\ Stage 1: test the computable content of Theorem 3.2 with my own expansion.
\\ For x(t) = u + t w + t^2 s + t^3 x3 (x3 random), compute w^T E(x(t)) as a Laurent series.
\\ My derivation predicts: t^{-1} coefficient of E is 0 at a critical point, w^T E_0 = kappa,
\\ and (when kappa = 0, L s = -h) w^T E_1 = -mu, independent of x3.
\\ Done at (i) an R-fixed critical point (kappa = 0) and (ii) a non-fixed one (kappa != 0).
read("s1_complex.gp");
default(realprecision, 80);
data(z) = {
  my(gB = Gn*z, g = vector(n)~, v, w, rhs, A, Ap, wIp, f, phi, psi, h, L, s, mu, kap);
  for(rr=1,#B0, g[B0[rr]+1] = gB[rr]);
  v = Fn*g;
  w = vector(n)~; for(t=1,#Ic0, w[Ic0[t]+1] = 1/v[Ic0[t]+1]);
  A = sub(Fn, B0, I0);
  rhs = vector(#B0, k, 1/gB[k])~ - sub(Fn, B0, Ic0)*vecextract(w, p1(Ic0));
  Ap = vecextract(A, [1..14], [2..12]);
  wIp = matsolve(conj(Ap)~*Ap, conj(Ap)~*rhs);
  w[I0[1]+1] = 0; for(t=2,#I0, w[I0[t]+1] = wIp[t-1]);
  f = Fn*un;
  phi = vector(n)~; for(t=1,#J0, phi[J0[t]+1] = 1/f[J0[t]+1]);
  psi = vector(n)~; for(t=1,#I0, psi[I0[t]+1] = 1/un[I0[t]+1]);
  h = Fn*phi - psi;
  kap = w~*h;
  L = matdiagonal(vector(n,k,v[k]^2)) - Fn*matdiagonal(vector(n,k,g[k]^2))*Fn;
  my(Aug = matconcat([L; un~; w~]), b = concat(-h, [0,0]~));
  s = matsolve(conj(Aug)~*Aug, conj(Aug)~*b);
  my(res = sqrt(norml2(L*s + h)));
  mu = sum(t=1,#J0, ((Fn*w)[J0[t]+1]/f[J0[t]+1])^2) - sum(t=1,#I0,(w[I0[t]+1]/un[I0[t]+1])^2) + s~*L*s;
  [w, s, kap, mu, res, L, h] };
mkx(w,s,x3) = vector(n, k, if(setsearch(I0,k-1), un[k], 0) + 't*w[k] + 't^2*s[k] + 't^3*x3[k] + O('t^6))~;
mkf(w,s,x3) = { my(f0 = Fn*un, fw = Fn*w, fs = Fn*s, f3 = Fn*x3); vector(n, k, if(setsearch(J0,k-1), f0[k], 0) + 't*fw[k] + 't^2*fs[k] + 't^3*f3[k] + O('t^6))~ };
series_test(z, label) = {
  my(D = data(z), w = D[1], s = D[2], x3, x, fx, Ex, wE);
  x3 = vector(n, k, random(1.) + I*random(1.))~;
  x = mkx(w, s, x3); fx = mkf(w, s, x3);

  Ex = Fn*vector(n,k,1/fx[k])~ - vector(n,k,1/x[k])~;
  my(cm1 = vector(n,k,polcoef(Ex[k],-1,'t)));
  wE = w~*Ex;
  printf("%s: kappa=%.6e%+.6ei  mu=%.6e%+.6ei  |Ls+h|=%.1e\n", label, real(D[3]), imag(D[3]), real(D[4]), imag(D[4]), D[5]);
  printf("   max|E_{-1}|=%.2e  w^T E_0=%.6e%+.6ei  w^T E_1=%.6e%+.6ei  w^T E_1 + mu=%.2e\n",
     vecmax(apply(abs,cm1)), real(polcoef(wE,0,'t)), imag(polcoef(wE,0,'t)), real(polcoef(wE,1,'t)), imag(polcoef(wE,1,'t)), abs(polcoef(wE,1,'t)+D[4]));
  \\ second random x3: w^T E_1 should not change
  x3 = vector(n, k, random(1.) + I*random(1.))~;
  x = mkx(w, s, x3); fx = mkf(w, s, x3);
  Ex = Fn*vector(n,k,1/fx[k])~ - vector(n,k,1/x[k])~; wE = w~*Ex;
  printf("   (other x3) w^T E_1 + mu = %.2e\n", abs(polcoef(wE,1,'t)+D[4]));
};
\\ (i) the Newton-found R-fixed point and (ii) the first non-fixed one
series_test(found[2], "R-fixed crit");
series_test(found[1], "non-fixed crit");
