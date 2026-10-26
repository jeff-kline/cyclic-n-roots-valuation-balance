# Statement-only mu packet, version 1

No author computation, proposed leading coefficient, or claimed review outcome
is supplied. The claim to attack is **mu is nonzero at each of the following
two exact Hensel lifts**. This is a finite claim, not M1. The permitted inference
is exclusion of a branch with these prescribed two-level directions u and w.

Let K=Q_13(omega), omega a primitive 13th root, pi=1-omega, v(pi)=1,
v(13)=12. Adjoin t with t^2=2, the unramified quadratic extension. The residue
field is F_169=F_13[t]/(t^2-2). Set zeta=-omega^7, F_ij=zeta^(ij), 0<=i,j<26.
All transposes are bilinear, not conjugate transposes.

Define U(X)=product_{e=0,...,6}(X-omega^e),
W(X)=product_{o in {2,3,4,7,9,10,12}}(X+omega^o), with coefficients a_i,b_i.
Let u be the coefficient vector of
b_1 U+a_1 W+X^13(b_1 U-a_1 W), and f=Fu.

I=[0,1,2,3,5,7,13,15,17,18,19,20].
J=[3,9,13,14,15,16,18,20,22,23,24,25].
B=J complement=[0,1,2,4,5,6,7,8,10,11,12,17,19,21].
Ic=I complement=[4,6,8,9,10,11,12,14,16,21,22,23,24,25].

Put D=I minus {20}, T=[17,19,21], C=B minus T. M=F[D,C].
G has rows indexed by B, columns by T: G[T,:]=Id_3 and
G[C,:]=-M^{-1}F[D,T]. V=F[Ic,B]G.
The exact fixed input has rank F[I,B]=11 and det M of valuation 31.
Every G row has valuation 0. V row i has valuation 4 for even i and 8 for
odd i. After dividing by that power of pi, its projective residue is (1,6,1).

Psi(z)=sum_{k in B} log(Gz)_k-sum_{i in Ic} log(Vz)_i.
Use affine chart z0+6*z1+zeta^14*z2=1, i.e.
z=(x,y,zeta^12*(1-x-6*y)). The two starting residues are
z+=(9+4t,8+3t,9+4t), z-=(9-4t,8-3t,9-4t).
All G-row and normalized V-row forms are units throughout these discs.
The reduced chart gradient is zero at both points and the reduced chart
Hessian is [[7+/-9t,8+/-t],[8+/-t,4]], with determinant 1+/-7t, norm 7.
Thus each has a unique exact Hensel lift z* of grad Psi=0.

The following are previously certified premises, not new claims to establish:
Rz=(zeta^14*z2,z1,zeta^12*z0) preserves Psi up to a constant and the chart.
Both exact lifts are R-fixed. At a critical point let g be Gz on B and 0 on J,
and v=Fg. The vector w, unique modulo u, satisfies
w_Ic=1/v_Ic and (Fw)_B=1/g_B. Fix w20=0.
Let h=F(1/f on J, zero elsewhere)-(1/u on I, zero elsewhere).
Then kappa=w^T h is odd under R and hence kappa=0 at both exact lifts.

Define L=diag(v^2)-F diag(g^2)F. Its kernel is span{u,w}, by the
nondegenerate projective Hessian. Solve Ls=-h. Define

mu = sum_{j in J} ((Fw)_j/f_j)^2
     -sum_{i in I} (w_i/u_i)^2 + s^T Ls.

This is independent of the choices of w mod u and s mod ker L when kappa=0.
Equivalent last term is -h^T s. The normalization of u and g above is fixed;
only the vanishing of mu would be invariant under rescaling them.

Attack missing assumptions, convention errors, precision loss, or the claim
mu!=0. Initial stage: at most 10 minutes wall, 180 CPU seconds, no enumeration,
Groebner/homotopy, other support sets or other complex points. Only exact or
rigorously bounded local arithmetic. Seal INITIAL report before receiving
the author script/result. Subsequent proof audit has a separate allocation.

Write only files named examiner-* in this new follow-up directory. Do not read
other new follow-up files until stage 2. The sibling Claude quarantine is
forbidden. No email. Python must be the owning quarantine's explicit .venv/bin/python.
