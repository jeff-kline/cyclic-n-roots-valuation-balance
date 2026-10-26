# Cold examiner, Stage 1 (isolated failure search)

```text
STAGE: INITIAL
VERDICT: NOT-BROKEN (Thm 2.1, Cor 2.2, Rem 2.3, Prop 3.1, kappa/mu well-definedness,
         Thm 4.1, F1-F4); UNRESOLVED (Thm 3.2: Q_eff is not defined in the packet)
EXPOSURE: audit/packets/claims.md only
          (SHA-256 b621d0efc4c0bd468f6b3f5552d98dc4e24ba5c618d23332aaea26b830b3c945, checked).
          Also read: ~/.claude/skills/cold-examiner/SKILL.md, and ROOT/AGENTS.md (the harness
          showed it automatically when I opened a script file; it holds release rules, not proofs).
          Not opened: paper/, scripts/, evidence/, README, draft-reviews/, draft-records/, quarantine.
TOOLS: PARI/GP 2.17.4 (exact arithmetic in Q(zeta_26), F_53, F_13, F_169; 80-digit floating point
       only for non-certificate cross-checks). Scripts: audit/reports/proof-scripts/s1_*.gp
RESOURCES: about 12 CPU-s in total. Largest enumeration: 13^4 = 28,561 chart points over F_169
           (size estimated before running).
```

Convention check (setting). F^{-1} = (1/n) conj(F). For f = Fx and y = x^{-1},
f_k (F^{-1}y)_k = (1/n) sum_r zeta^{rk} c_r with c_r = sum_j x_{j+r}/x_j and c_0 = n. So
(Fx)^{-1} = F^{-1}x^{-1} holds exactly when c_r = 0 for every r != 0. With a_j = x_{j+1}/x_j these are the
cyclic n-roots equations. E(x) = grad Phi with Phi(x) = sum_k log(Fx)_k - sum_i log x_i; this uses F = F^T.
The relation zeta = -omega^7 = e^{2 pi i/26} holds; it is checked exactly in s1_exact.gp.

## Per-claim verdicts

**Theorem 2.1 (valuation multiset): NOT-BROKEN.** Proof found. For any constant y,
y^T x^{-1} = y^T F f^{-1} = (Fy)^T f^{-1}, using F = F^T. Put y = theta^r x with theta = t d/dt.
Because F is constant, F theta^r x = theta^r f. This gives
sum_i theta^r x_i / x_i = sum_k theta^r f_k / f_k. The constant term of each quotient is nu^r, so
sum_i nu(x_i)^r = sum_k nu(f_k)^r for every r >= 0. Newton's identities then give equal multisets.
The argument needs symmetry (or F^T in the equation) but does not need invertibility. The Puiseux
case follows by substituting t = s^N. Hand check with n = 4: x = (1,s,1,-s) is a cyclic 4-root curve and
f = (2, 2si, 2, -2si). Both have valuations {0,1,0,1} at s = 0 and {0,-1,0,-1} at s = infinity.

**Corollary 2.2: NOT-BROKEN.** Proof found. Let S be the span of the coefficient vectors x^{(e)} with
e < c (finitely many). Each such vector has support in I, and its image under F has support in J.
For each i in I, some element of S has i-th coordinate nonzero, and for each k in J, some element
has (F.)_k nonzero. So a generic element u of S has supp u = I and supp Fu = J. For v, run the same
argument on the pair (f^{-1}, x^{-1} = F f^{-1}) with cut -c. This gives g with supp g = J^c and
supp Fg = I^c. Put v = Fg. The equality |I| = |J| follows from Theorem 2.1.

**Remark 2.3: NOT-BROKEN.** An infinite affine variety contains an irreducible curve. A nonconstant
coordinate function has a pole on the smooth projective model. At that pole x_0 = 1 has valuation 0
and some x_i has negative valuation, so some real c strictly between them is not a valuation.
Every f_k is a nonzero rational function on the curve, because f_k (F^{-1}x^{-1})_k = 1 holds on
the cyclic-root locus.

**Proposition 3.1: NOT-BROKEN.** Proof found.
- The solvability condition for A w_I = 1/g - F[J^c,I^c] v^{-1} is
  G^T(1/g) - V^T(1/v) = 0. This uses G^T F[J^c,I^c] = V^T, which needs F = F^T, and the result is
  grad Psi(z). Uniqueness modulo u follows from ker A = span u_I.
- For y in ker L, put p = g^2 o Fy. Then (Fp)_I = 0 forces p = Ga, and the solvability of the
  I-block is exactly Ha = 0. So ker L / span u is isomorphic to ker H, and at the critical point w
  corresponds to a = z.
- The dimension formula holds at every z with nonzero forms, not only at critical points. That is
  a harmless conservative scope.
- Exact check mod 53 at F1's point: rank H = 2 and dim ker L = 2.

**kappa and mu well-definedness and scaling: NOT-BROKEN.**
- u^T h = f^T(1/f on J) - |I| = |J| - |I| = 0.
- L is symmetric, so im L = (ker L)^perp (bilinear), and L s = -h is solvable exactly when
  w^T h = 0 (given ker L = span{u,w}, which needs rank H = d-1).
- s -> s + k with k in ker L leaves s^T L s unchanged. The shift w -> w + c u changes the sums by
  2c kappa + c^2(|J|-|I|).
- Under u -> au, g -> bg: f -> af, v -> bv, w -> w/b, h -> h/a, L -> b^2 L and s -> s/(a b^2). Hence
  kappa -> kappa/(ab) and mu -> mu/(ab)^2.

**Theorem 3.2 (local scalar reduction): UNRESOLVED.** The packet does not define Q_eff, so the claims
Q_eff'(0) = kappa, Q_eff''(0) = -mu and the "exactly when" equivalence cannot be tested as stated.
I derived the computable content myself and checked it:
- Expand x = u + t x1 + t^2 x2 + t^3 x3 + ... with I^c and J^c coordinates of valuation 1.
- Order t^{-1} gives the normal system: x1 = w (mod u) and grad Psi(z) = 0.
- Order t^0 is exactly L x2 = -h, so kappa is the first obstruction.
- At order t^1, w^T(residual) = sum_J((Fw)/f)^2 - sum_I(w/u)^2 + x2^T L x2 + c kappa. When kappa = 0
  this is mu, independent of the free choices.
- With the sign convention E = F(Fx)^{-1} - x^{-1}: w^T E_0 = kappa and w^T E_1 = -mu. This matches
  "Q_eff'(tau) = kappa - mu tau + ..." if Q_eff' is the w-component of E along the reduced branch.
- Numerical confirmation (s1_series.gp, 80 digits, not a certificate), at a non-fixed critical point
  (kappa != 0) and an R-fixed one (kappa = 0): E_{-1} ~ 1e-91, w^T E_0 = kappa to 1e-91, and
  w^T E_1 + mu ~ 1e-92 for two random x3.
- Open for Stage 2: whether the convergent Q_eff exists, the converse ("formal branch => Q_eff' == 0"),
  and the role of the reparametrisation freedom at higher orders.

**Section 4 setting (exact, s1_exact.gp): NOT-BROKEN.**
- a1, b1 != 0; supp u = I; supp Fu = J.
- F[I,B] G = 0, including row 20; rank F[B,I] = 11; rank G = 3.
- det M != 0 in Q(zeta_26). Under zeta -> 5215 mod 10037, det M = 3759, with 10037 prime and
  ord(5215) = 26, so this is a valid prime above 10037. Also 5215^2 = 5992, so it matches omega -> 5992.

**F1: NOT-BROKEN (confirmed exactly).** Over F_53 with zeta -> 4:
- ord 4 = 26 and -16^7 = 4.
- Reducing the exact u agrees with u rebuilt from omega -> 16.
- det M = 46 != 0.
- At z = (1,8,19): all 28 forms are nonzero, grad Psi = 0, Hz = 0 and rank H = 2.
- The chart z0 = 1 Hessian determinant is 23. Other charts give 41 and 35, so the value 23 depends on
  the chart and the paper should name it.
- kappa = 4, u^T h = 0 and dim ker L = 2.

**F2: NOT-BROKEN (confirmed exactly in Q(zeta_26)).**
- U^2 = S^2 = 1, F U = S^{-T} F, F S = U^{-T} F and U u = -u.
- U preserves I and S preserves B.
- S maps col(G) to itself and acts on (g17,g19,g21) as R.
- The chart form z0 + 6 z1 + zeta^14 z2 is R-invariant.
- Consequence checked by hand: monomial maps satisfy (Mf)^{-1} = M^{-T} f^{-1}. So (U,S) maps solutions
  to solutions, h -> U^{-T}h and w -> Uw, which makes kappa invariant. Then
  kappa(u,Rz) = (-1)^{-1} kappa(Uu,Sg) = -kappa(u,z).
- Numerically, for a non-fixed pair, |kappa(Rz) + kappa(z)| ~ 1e-93 (s1_complex.gp).

**F3: NOT-BROKEN (confirmed exactly).**
- There is one prime above 13, with e = 12 and v(1-omega) = 1.
- All 14 G rows have valuation 0. The V row valuations are 4 or 8, and every reduced V row is a
  nonzero multiple of (1,6,1).
- Enumerating all 13^4 chart points over F_169 (z0 + 6z1 + z2 = 1) finds exactly two critical points
  with all 28 reduced forms nonzero: (9 +- 4t, 8 +- 3t, 9 +- 4t). Their chart Hessian determinants are
  1 + 7t and 1 + 6t, both nonzero, and R-bar = swap fixes both.
- zeta^14 = zeta^12 = 1 mod pi.
- The reduced gradient equals G-bar^T(1/G-bar z) - V-bar^T(1/V-bar z). After row normalisation the
  V-part reduces to 14 l/l(z), because V_i/(V_i z) = l/l(z) + O(pi). So Hensel applies in the
  unramified quadratic extension of Q_13(omega).
- Uniqueness of the lift, R-invariance of the chart and R-bar fixing both points give R(lift) = lift
  in the chart, with no projective scalar. Then kappa = -kappa forces kappa = 0.

**F4: NOT-BROKEN.** A nondegenerate solution is an isolated (zero-dimensional) component of a
K-variety, so its coordinates are algebraic over K. Nonvanishing, det(chart Hessian) != 0 and kappa
(= 0 or != 0) are field-theoretic conditions, so any embedding preserves them.

**Theorem 4.1: NOT-BROKEN.** An independent cross-check in C (s1_complex.gp, 80 digits, not a
certificate):
- The exact one-variable critical equation on the R-fixed line has degree 26 and gives 14 R-fixed
  critical points with all forms nonzero. All have |grad|^2 < 1e-126, nondegenerate chart Hessian
  and |kappa| < 1e-91.
- Newton also found non-fixed critical points with |kappa| = 6.81 and 4.71.
- Observation only, not a claim: at one R-fixed point, mu evaluates numerically to about -1.07 - 5.48i.
  It is unknown whether this is one of the paper's two Hensel points.

## Coverage and limits
- Not checked: the literature and credit sentences (finiteness for n = 6, 10 and for primes).
- Not checked: the existence and convergence of Q_eff, and the converse direction in Theorem 3.2.
- My derivations are proofs I constructed myself, not audits of the author's proofs.
