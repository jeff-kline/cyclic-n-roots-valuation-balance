\\ Stage 2 (optional, non-certificate, 80-digit floating point): kappa and mu at every
\\ R-fixed complex critical point found on the fixed line (zeta^14 s, 1, s).
\\ Observation only; the manuscript makes no claim about mu.
read("s1_series.gp");
default(realprecision, 80);
cnt = 0;
{for(k=1,#rts, my(s = rts[k], z = [zc^14*s, 1, s]~);
  my(gz = Gn*z, vz = Vn*z, mn = vecmin(apply(abs, Vec(concat(gz,vz)))));
  if(mn < 1e-30, next);
  z = nrm(z); cnt++;
  my(D = data(z));
  printf("fixed %2d: |kappa|=%.1e  |Ls+h|=%.1e  mu=%.6e%+.6ei  |mu|=%.4e\n", cnt, abs(D[3]), D[5], real(D[4]), imag(D[4]), abs(D[4])));}
