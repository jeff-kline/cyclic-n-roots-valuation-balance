S = 60;
read("mu_balls.gp");
Hp = hensel([9,4],[8,3]);
m = mu_at(Hp[1], Hp[2], [4,20]);
p14 = toball((1-om)^14);
y = bmul(p14, m);
print("pi^14*mu ball: v(center)=", y[4], " N=", y[3], " E=", y[1]);
\\ y is a unit ball (v=0): residue of center = residue of mantissa times 13^E (E must be 0 for a unit)
print("residue of pi^14 mu = ", eres(y[2]), "   (expect [11, 8])");
print("norm of 11+8t to F_13 = ", Mod(11^2 - 2*8^2, 13), " ; squares mod 13: ", Set(vector(12,k,k^2%13)));
