\\ Stage 1: exact checks over Q(zeta_26) of the Section 4 setting and F2.
read("s1_common.gp");
supp(v) = apply(t->t-1, Vec(select(t->t!=0, Vec(v), 1)));
print("zeta == -omega^7: ", Z == -om^7);
print("#I,#J,#B: ", [#I0,#J0,#B0]);
print("a1 != 0, b1 != 0: ", [a1!=0, b1!=0]);
f = F*u;
print("supp u == I: ", supp(u) == I0, "   supp Fu == J: ", supp(f) == J0);
Id = matid(n);
print("U^2 == 1: ", Um^2 == Id, "   S^2 == 1: ", Sm^2 == Id);
print("F U == S^{-T} F: ", F*Um == (Sm^-1)~*F);
print("F S == U^{-T} F: ", F*Sm == (Um^-1)~*F);
print("U u == -u: ", Um*u == -u);
print("F symmetric: ", F == F~);
M = sub(F, D0, C0);
dM = matdet(M);
print("det M != 0: ", dM != 0);
print("det M under zeta->5215 mod 10037: ", red(dM, 10037, 5215), "  (5215^2 mod 10037 = ", Mod(5215,10037)^2, ")");
print("order of 5215 mod 10037: ", znorder(Mod(5215,10037)), "  10037 prime: ", isprime(10037));
A = sub(F, B0, I0);
print("rank F[B,I]: ", matrank(A));
print("A u_I == 0: ", A*vecextract(u, p1(I0)) == 0);
Gc = -M^-1 * sub(F, D0, T0);
G = matrix(#B0, 3);
{for(r=1,#B0, my(k=B0[r], pos=setsearch(T0,k));
  if(pos, G[r,pos]=1,
     my(c=setsearch(C0,k)); for(j=1,3, G[r,j]=Gc[c,j])));}
print("F[I,B] G == 0 (all 12 rows incl. row 20): ", sub(F, I0, B0)*G == 0);
print("rank G: ", matrank(G));
V = sub(F, Ic0, B0)*G;
Sg_test = 1;
{for(j=1,3,
  my(gf = vector(n)~);
  for(r=1,#B0, gf[B0[r]+1] = G[r,j]);
  my(sgf = Sm*gf);
  my(zz = vector(3,t, sgf[T0[t]+1])~);
  my(gg = vector(#B0, r, sgf[B0[r]+1])~);
  if(gg != G*zz, Sg_test = 0; print("Sg not in col G for e_",j));
  if(supp(sgf) != setintersect(supp(sgf), B0), Sg_test = 0; print("supp Sg not in B"));
  my(ej = vector(3,t,t==j)~);
  my(Rej = [Z^14*ej[3], ej[2], Z^12*ej[1]]~);
  if(zz != Rej, print("R mismatch on e_",j,": ", zz, " vs ", Rej); Sg_test=0));}
print("S preserves col(G) (support B) and induces R(z0,z1,z2)=(zeta^14 z2, z1, zeta^12 z0): ", Sg_test);
\\ l(z)=z0+6z1+zeta^14 z2; l(Rz) = zeta^14*zeta^12 z0 + 6 z1 + zeta^14 z2
print("chart form R-invariant: ", [Z^14*Z^12, 6, Z^14] == [1, 6, Z^14]);
\\ U maps I to I, S maps B to B
print("20-I == I mod 26: ", vecsort(apply(i->(20-i)%26, I0)) == I0, "  12-B == B mod 26: ", vecsort(apply(k->(12-k)%26, B0)) == B0);

print("done");
