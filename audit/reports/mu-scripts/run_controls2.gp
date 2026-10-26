S = 60;
read("mu_balls.gp");
t0 = getabstime();
Hp = hensel([9,4],[8,3]);
trunc(X, k) = [liftall(X[1]*Mod(1,13^k)), liftall(X[2]*Mod(1,13^k))];
print("=== control C: residue point as a ball of radius pi^1 ===");
N0OVR = 1; iferr(mu_at([9,4],[8,3],[4,20]), E, print("  ERROR: ", component(E,1)));
foreach([1,2,3], k, N0OVR = 12*k; print("--- k = ", k, " (N0 = ", 12*k, ")"); iferr(my(m = mu_at(trunc(Hp[1],k), trunc(Hp[2],k), [4,20])), E, print("  ERROR: ", component(E,1))));
print("total ms: ", getabstime()-t0);
