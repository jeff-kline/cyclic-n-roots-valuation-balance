\\ Stage 2: numerical (non-certificate) check of the paper's own Q_eff construction (proof of Thm 3.2).
\\ Slice l_u(x)=1, x = u + tau (w + eta), eta in T = ker l_u cap ker l_w; eta(tau) solves d_eta Q = 0,
\\ i.e. T^T E(x) = 0; then Q_eff'(tau) = (w+eta)^T E(x). Expect Q_eff'(0)=kappa, Q_eff''(0) = -mu.
read("s1_series.gp");
default(realprecision, 80);
Eval(x) = { my(fx = Fn*x); Fn*vector(n,k,1/fx[k])~ - vector(n,k,1/x[k])~ };
qeff_test(z, label) = {
  my(D = data(z), w = D[1], kap = D[3], mu = D[4], L = D[6], h = D[7], UW, P, Tb, J0m, out = List());
  my(u0 = vector(n,k, if(setsearch(I0,k-1), un[k], 0))~);
  UW = matconcat([u0, w]);
  P = matsolve(conj(UW)~*UW, conj(UW)~);      \\ rows l_u, l_w (dual to u, w)
  Tb = matker(P);                              \\ basis of T
  J0m = Tb~*L*Tb;                              \\ Hessian of Q_N at 0 on T
  foreach([10^-8, 2*10^-8, -10^-8], tau,
    my(c = vector(#Tb,k,0)~, x, e);
    for(it=1,80, x = u0 + tau*(w + Tb*c); e = Eval(x); c = c - matsolve(J0m, tau*(Tb~*e)));
    x = u0 + tau*(w + Tb*c); e = Eval(x);
    listput(out, [tau, (w + Tb*c)~*e, sqrt(norml2(Tb~*e))]));
  my(d1 = out[1][2], d2 = out[2][2], d3 = out[3][2]);
  \\ Q'(tau) = kappa + Q''(0) tau + O(tau^2): estimate from symmetric difference
  my(q2 = (d1 - d3)/(2*10^-8), q0 = (d1 + d3)/2);
  printf("%s: kappa=%.8e%+.8ei  Q_eff'(0)~%.8e%+.8ei | -mu=%.8e%+.8ei  Q_eff''(0)~%.8e%+.8ei  max|T^T E|=%.1e\n",
     label, real(kap), imag(kap), real(q0), imag(q0), real(-mu), imag(-mu), real(q2), imag(q2), vecmax([out[1][3],out[2][3],out[3][3]]));
};
qeff_test(found[2], "R-fixed crit (kappa=0)");
qeff_test(found[1], "non-fixed crit (kappa!=0)");
