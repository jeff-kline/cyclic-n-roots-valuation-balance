S = 60;
read("mu_balls.gp");
doit(c) = {
  my(Hc = hensel([c[2],c[3]],[c[4],c[5]]), m = mu_at(Hc[1], Hc[2], [4,20]));
  print("RESULT lift ", c[1], ": q2 v=", LASTQ2[4], " N=", LASTQ2[3], " lead ", lead(LASTQ2), " ; h.s v=", LASTHS[4], " N=", LASTHS[3], " lead ", lead(LASTHS), " ; mu lead ", lead(m));
}
doit([1,9,4,8,3]);
doit([-1,9,-4,8,-3]);
