S = 60;
read("mu_balls.gp");
default(timer,0);
t0 = getabstime();
print("=== lift z+ : x = 9+4t, y = 8+3t ===");
Hp = hensel([9,4],[8,3]);
print("  Hensel time ms: ", getabstime()-t0);
mup = mu_at(Hp[1], Hp[2], [4,20]);
print("  total ms: ", getabstime()-t0);
