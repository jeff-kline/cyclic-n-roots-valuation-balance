proof-stage1.md SHA-256: edb244df18d972804a327353f10aad9006aba84ab9de7d3956bb7b2628eb49b5

# Cold examiner, Stage 2 (proof and certificate audit)

```text
STAGE: PROOF-AUDIT
VERDICT: Thm 2.1 VERIFIED; Cor 2.2 VERIFIED; Rem 2.3 VERIFIED (as a sketch); Prop 3.1 VERIFIED;
         kappa/mu definitions VERIFIED; Thm 3.2 GAP (one minor, fillable step: "branch => Q_eff' == 0");
         Thm 4.1 VERIFIED. No error found. No statement refuted.
CLAIM: paper/main.tex, Draft 0.1.0, 2026-10-26 (SHA-256 445cbd51...d9080), whole manuscript.
EXPOSURE: Stage 1 report sealed first (hash on line 1). Then read paper/main.tex end to end,
          scripts/check_certificates.py (8ac5791f...45a1) and evidence/certificate-result.json
          (9a02a36f...9ed7). Not read: draft-reviews/, draft-records/, README, quarantine,
          scripts/build_paper.py, scripts/check_readme.py, paper/main.pdf.
RESOURCES: checker 31.6 CPU-s (one run). My GP scripts about 25 CPU-s in total (both stages).
           Total about 60 CPU-s, well under the 10-minute allocation.
```

## Checker run
I ran the checker once:
`~/.venvs/claude/bin/python -I scripts/check_certificates.py`, output written to
`<session scratchpad>/proof-audit-check.json`.
- Exit status 0 and 31.6 CPU-s.
- The output is byte-identical to evidence/certificate-result.json.

## Independent recomputation (my code, PARI/GP, not the author's checker)
The scripts are in audit/reports/proof-scripts/: s1_common.gp, s1_exact.gp, s1_mod53.gp,
s1_padic13.gp, s1_complex.gp, s1_series.gp, s2_recompute.gp, s2_qeff.gp, s2_mu_fixed.gp.

- **Section 4 setting, exact in Q(zeta_26):**
  - Supports, rank 11 and G are as stated, including F[I,B] G = 0 on row 20.
  - All of F2 holds: U^2 = S^2 = 1, F U = S^{-T} F, F S = U^{-T} F, U u = -u, S G = G R, and the
    chart form is R-invariant.
- **F1 over F_53, computed directly with zeta -> 4:**
  - H = [6,47,5; 47,3,13; 5,13,11]. This is identical to the paper and to the checker.
  - grad = 0, Hz = 0, rank H = 2, det M = 46, chart det on z0 = 1 is 23, kappa = 4 and dim ker L = 2.
- **Proposition 3.1 identities, exact mod 53:**
  - L = N^T D N, N^T Lambda = 0, rank N = 25 = n-1, rank Lambda = 3 = d.
  - Lambda^T D^{-1} Lambda = H, ker N = span u, and Hz = -grad Psi.
- **F3, using PARI nfeltval/nfmodpr at the unique prime above 13:**
  - G rows have valuation 0 and normalise to exactly the paper's list (eq:rows).
  - V row valuations are 4 at the 9 even indices of I^c and 8 at the 5 odd ones, and every V row is
    a multiple of (1,6,1).
  - Chart Hessians over F_169 are [7+-9t, 8+-t; 8+-t, 4], with det 1+-7t and norm 7.
  - An exhaustive search of all 13^4 chart points over F_169 finds exactly these two critical points
    with all 28 forms nonzero.
- **Map at 10037:**
  - Phi_13(5992) = 0 mod 10037 and -5992^7 = 5215. So the paper's zeta -> 5215 and the checker's
    omega -> 5992 are the same ring homomorphism.
  - My exact det M maps to 3759.
- **Theorem 3.2 sign and value (80-digit floating point, not a certificate), using the paper's own
  slice construction** (l_u, l_w, T, eta(tau) from T^T E = 0, then Q_eff'(tau) = (w+eta)^T E):
  - At a non-fixed critical point, Q_eff'(0) agrees with kappa to 9 digits.
  - At an R-fixed point, Q_eff'(0) is about 1e-16 (finite-difference error) and Q_eff''(0) agrees with
    -mu to 9 digits.
  - The series check gives w^T E_0 = kappa and w^T E_1 = -mu to about 1e-91.

## Per-step table

| ID | Step | Verdict | Note |
|---|---|---|---|
| T2.1-a | F^{-1}y = f^{-1} from (1) | VERIFIED | |
| T2.1-b | power-sum identity sum D^r f/f = (F D^r x)^T F^{-1} y = sum D^r x/x | VERIFIED | Re-derived. Uses F^T = F. |
| T2.1-c | D^r h/h = a^r + O(t); Newton's identities; Puiseux case | VERIFIED | |
| C2.2-a | x^{[r]}, r < c: support in I, transform in J; finitely many | VERIFIED | |
| C2.2-b | each coordinate of I and of J occurs; generic combination avoids a finite union of hyperplanes | VERIFIED | |
| C2.2-c | complements from y = x^{-1}, F^{-1}y = f^{-1} at orders < -c | VERIFIED | Gives supp v = I^c and supp F^{-1}v = J^c directly. |
| R2.3 | curve, pole, x_0 = 1, proper gap | VERIFIED | f_k != 0 on the curve is implicit; it follows from f_k (F^{-1}x^{-1})_k = 1. |
| P3.1-a | A-system solvable iff G^T g^{-1} - V^T v^{-1} = 0 | VERIFIED | Uses G^T F[J^c,I^c] = V^T, which needs symmetry. |
| P3.1-b | uniqueness mod u | VERIFIED | |
| P3.1-c | L = N^T D N, ker N = C u | VERIFIED | Re-derived and checked exactly. |
| P3.1-d | Lambda spans ker N^T; 2q-(n-1) = d | VERIFIED | Lambda's columns are independent because G's are. dim ker N^T = 2q - rank N = 2q-(n-1) = q-m+1. See D2. |
| P3.1-e | Lambda^T D^{-1} Lambda = H | VERIFIED | |
| P3.1-f | Lr = 0 iff DNr = Lambda b; solvable iff Hb = 0; unique mod u | VERIFIED | |
| P3.1-g | Lu = Lw = 0; u, w independent | VERIFIED | Lw = 0 needs Hz = -grad Psi(z) = 0, which is not stated. See D2. |
| K-a | u^T h = \|J\|-\|I\| = 0 | VERIFIED | |
| K-b | Ls = -h solvable iff kappa = 0 | VERIFIED | Needs ker L = span{u,w}, which the hypothesis gives. |
| K-c | mu independent of s (mod ker L) and of w (mod u); scaling (ab)^{-1}, (ab)^{-2} | VERIFIED | Re-derived. |
| Q-a | slice l_u = 1, x = u + tau(w+eta), eta in T | VERIFIED | |
| Q-b | grad log R = E; tau^q cancels; Q_N, Q_R formulas | VERIFIED | Re-derived. |
| Q-c | eta-gradient zero at (0,0) | VERIFIED | Uses the normal system, (Fw)_{J^c} = g^{-1} and w_{I^c} = v^{-1}, implicitly. See D3. |
| Q-d | eta-Hessian = L\|_T; radical lies in ker L cap T = 0 | VERIFIED | |
| Q-e | IFT gives analytic eta(tau) in tau T[[tau]]; Q_eff convergent | VERIFIED | |
| Q-f | slice criticality iff E(x) = 0 (degree-0 homogeneity, l_u(x) = 1) | VERIFIED | |
| Q-g | "A branch therefore implies Q_eff' == 0" | **GAP (minor)** | See D1. |
| Q-h | Q_eff' == 0 gives the convergent branch with nonzero coordinates | VERIFIED | |
| Q-i | Q_tau(0,0) = w^T h = kappa | VERIFIED | Re-derived and numerically confirmed. |
| Q-j | transverse equation gives (Ls+h)\|_T = 0, plus u and w, so Ls = -h | VERIFIED | |
| Q-k | Q_eff''(0) = Q_tautau + 2h^T s + s^T L s = -mu | VERIFIED | Re-derived. Equivalent to Q_tautau + h^T s, because s^T(Ls+h) = 0. Numerically confirmed with the paper's slice. |
| S4-a | zeta = -omega^7 = e^{2 pi i/26}; supp u = I; supp Fu = J | VERIFIED | Exact, own code. |
| S4-b | det M = 3759 under zeta -> 5215 mod 10037; rank F[B,I] = 11 | VERIFIED | ord(5215) = 26; matches omega -> 5992. |
| 4.1-a | 53 split, zeta -> 4, omega -> 16 consistent with zeta = -omega^7 | VERIFIED | |
| 4.1-b | grad = 0, H matrix, kappa = 4, 28 forms nonzero, det M = 46, det on z0 = 1 is 23 | VERIFIED | Independently recomputed. |
| 4.1-c | Hensel over Q_53; kappa a unit; cleared system nonsingular, so algebraic over K; embedding | VERIFIED | kappa's formula is 53-integral because u_I, f_J, g and v are units and M^T is invertible mod 53. |
| 4.2-a | U^2 = S^2 = 1, intertwining, I = 20-I, J = 12-J | VERIFIED | Exact. |
| 4.2-b | U u = -u; U_0 acts by -zeta^10 | VERIFIED | |
| 4.2-c | S induces R on the free coordinates | VERIFIED | The text does not say S preserves col G. It follows from FS = U^{-T}F and U(I) = I. The checker asserts S G = G R. |
| 4.2-d | (Uu, Sg, Uw) satisfies (w); h(Uu) = U^{-T}h(u); kappa invariant | VERIFIED | Re-derived via (Mf)^{-1} = M^{-T} f^{-1} for monomial M. |
| 4.2-e | kappa(u,Rz) = -kappa(u,z); exact R-fixed representative gives kappa = 0 | VERIFIED | Numerically \|kappa(Rz)+kappa(z)\| ~ 1e-93. |
| 4.3-a | G integral at pi; rows (eq:rows); V valuations 4/8, proportional to (1,6,1) | VERIFIED | Own nf computation. |
| 4.3-b | pi-basis valuation: term valuations 12 v_13(c_j)+j distinct mod 12 | VERIFIED | {pi^j} is a Q-basis; v_pi(13) = 12. |
| 4.3-c | 13/pi^12 = -1 mod pi | VERIFIED | 13 = prod(1-omega^k) = pi^12 * 12! (mod pi^13), and Wilson's theorem. |
| 4.3-d | Psi-bar gives the reduced log-derivative | VERIFIED | V_i/(V_i z) = l/l(z) + O(pi) after row normalisation. |
| 4.3-e | z-bar_+-: on l z = 1, forms nonzero, gradient 0, Hessian [7+-9t, 8+-t; 8+-t, 4], det 1+-7t, norm 7 | VERIFIED | Own code. These are the only two such points on the chart. |
| 4.3-f | chart L(z) = z0+6z1+zeta^14 z2 R-invariant, reduces to l z = 1; R-bar = swap fixes both | VERIFIED | In chart coordinates R is the integral affine map (z0,z1) -> (1-z0-6z1, z1). |
| 4.3-g | Hensel uniqueness gives exact R-fixed lifts, so kappa = 0; algebraic; distinct after embedding | VERIFIED | |
| I-a | cyclic n-roots definition; Fourier form E(x) = 0 with x_0 = 1 is equivalent | VERIFIED | Re-derived, including the 1/n in F^{-1}. |
| I-b | Backelin (m^2 \| n gives infinitely many); BS95 unimodular | NOT CHECKED | Sources not opened. Consistent with my background knowledge. |
| I-c | Haagerup: prime order finite, with count | NOT CHECKED | Consistent with background knowledge. |
| I-d | "finiteness is known only for n = 6 and n = 10" | NOT CHECKED | See D5. |
| I-e | Zhou arXiv:2608.06335v2; AV Prop 5.1; FR Sec. 10.3; CDFV | NOT CHECKED | Sources not opened. |
| I-f | reflection is a composite of shift, modulation, dilation by -1 and scalar | VERIFIED (math) | U = zeta^{-10} * (modulation zeta^{-12i}) * (i -> 20-i). The FR attribution is not checked. |
| I-g | abstract and Section 5 scope statements; "mu not determined" | VERIFIED | Consistent with the proved content. Abstract wording: see D4. |
| X-1 | checker assertions match the paper's statements | VERIFIED | See the next section. |

## Does each checker assertion check what the paper says?
- **Supports and G.** Supports come from exact nonzero tests in Q(omega). G comes from exact M.inv(),
  which also proves det M != 0 on its own. F[I,B]G = 0 is asserted on all 12 rows of I.
- **Intertwining.** These are checked as exponent identities mod 26:
  - F U = S^T F: the (k,j) exponents are (k-12)(20-j)-10 and -10-20(12-k)+(12-k)j.
  - F S = U^T F: by the same method.
  - Since S^2 = U^2 = 1, these are exactly (eq:intertwine).
  - U u = -u is asserted entrywise.
  - S G = G R is asserted entrywise, with the R matrix matching (eq:R).
  - The chart invariance l R = l is asserted.
- **Valuations.** The power basis is converted to the pi basis by the binomial expansion of
  (1-pi)^j. The leading residue includes the factor (-1)^e from 13/pi^12 = -1. The asserted rows and
  valuations equal the paper's, and they also equal my independent PARI result.
- **10037.** The checker evaluates at omega -> 5992. It does not assert that Phi_13(5992) = 0 mod 10037,
  nor that -5992^7 = 5215 (the paper's map). Both hold (s2_recompute.gp). See D8.
- **53.** The checker asserts that 53 is prime, that 4 has order 26 and that 4 = -16^7, so the
  residues with omega -> 16 are the paper's map.
  - H is the full 3x3 Hessian, matching the paper's display, and the chart determinant 23 is the
    (1,2) block, i.e. the chart z0 = 1.
  - w solves the 11 C0-rows with w_20 = 0. The assertion (Fw)_B = 1/g on all 14 rows verifies the
    full normal system.
  - h and kappa = w.h = 4 follow the paper's definitions.
- **F169.**
  - ds = (r0-r2, r1-6r2) is the derivative on z2 = 1-z0-6z1, and the weights (+1 for G, -1 for V)
    give the Hessian of Psi-bar. This is the paper's matrix.
  - V rows equal to l contribute 0 on the chart, which is consistent.
  - z0 == z2 is asserted, i.e. R-bar fixes each point. The congruences zeta^14 = zeta^12 = 1 mod pi
    are not asserted; they are trivial because zeta = -1 mod pi.
- **Scope.** By design, the checker does not test the Hensel lifts or kappa = 0 at the lifts. Its scope
  string says so, and the manuscript proves them.

## Defects (each with one label)
- **D1, gap** (Thm 3.2 proof, second paragraph).
  - The text derives "a branch implies Q_eff' == 0" from the uniqueness of eta(tau) in
    tau T[[tau]]. A formal branch is parametrised by t, with tau(t) of arbitrary order e.
  - After normalising to l_u(x) = 1, its transverse part is eta_b(t) in t T[[t]], with
    d_eta Q(tau(t), eta_b(t)) = 0. That eta_b(t) = eta(tau(t)) is not shown.
  - Fill: d_eta Q(tau, eta) = L|_T eta + O(tau) + O(eta^2), and tau(t) = O(t). So the t^k coefficient
    determines eta_k uniquely from lower coefficients, through the invertible L|_T. Hence
    eta_b = eta o tau, and d_tau Q = (w+eta)^T E(x) = 0 gives Q_eff'(tau(t)) = 0.
  - The reduction of a general branch (scaling, then l_u = 1, then "first transverse direction w"
    meaning eta_b(0) = 0) should be stated with it.
  - The theorem is not in doubt.
- **D2, documentation** (Prop 3.1 proof).
  - "Finally Lw = 0" needs Hz = -grad Psi(z) = 0 (degree-0 homogeneity, or direct substitution), and
    the text does not say so.
  - "Their number is 2q-(n-1)" should say that dim ker N^T = 2q - rank N = 2q-(n-1) = d and that the d
    columns of Lambda are independent.
- **D3, documentation** (Thm 3.2).
  - "Formal solution branch with boundary direction u and first transverse direction w" is never
    defined.
  - "At (0,0) the eta-gradient is zero" silently uses the normal system (eq:w).
- **D4, documentation** (abstract vs Section 1).
  - The abstract says the conjecture "is proved only for prime n", while Section 1 says finiteness is
    known for n = 6 and n = 10.
  - The abstract also presents the all-complex form as the Bjorck-Saffari conjecture, while Section 1
    says BS conjectured the unimodular form and the complex form is a restatement.
- **D5, documentation** (Section 1). "Finiteness is known only for n = 6 and n = 10" is a universal
  negative about the literature. I did not check it. It needs a dated source or a hedge
  (e.g. "to our knowledge, as of ...").
- **D6, documentation.** Several symbols are overloaded:
  - L is both the matrix (Section 3) and the chart form L(z) (Section 4.3).
  - D is both t d/dt (Thm 2.1) and diag(...) (Prop 3.1); there is also D_0.
  - E is both the equation map and the exponent set.
  - U(X) is a polynomial and 𝒰 is the involution.
  - T is the slice complement, and T_0 is a different set.
- **D7, documentation** (Thm 4.1 vs Section 4.1). The theorem says "points" with kappa != 0, but
  Section 4.1 constructs "the required point". Add that Rz != z is a second such point, since
  kappa(Rz) = -kappa(z) != 0.
- **D8, documentation** (checker).
  - The 10037 assertion uses omega -> 5992 without asserting Phi_13(5992) = 0 mod 10037, and without
    linking it to the paper's zeta -> 5215.
  - Both facts are true (verified), and det M != 0 is anyway proved by exact inversion and by the
    F_53 reduction. A one-line assertion would close this.
- **D9, sharpening** (Thm 2.1, Prop 3.1).
  - Invertibility of F is not needed in Thm 2.1: (D^r x)^T x^{-1} = (D^r x)^T F f^{-1} = (F D^r x)^T f^{-1}.
    It is still needed for F^{-1}v in Cor 2.2.
  - The dimension formula in Prop 3.1 holds at every z with nonzero forms, not only at critical
    points.
  - These are optional.
- **D10, sharpening.** This is optional and rests on a floating-point observation, not a certificate.
  - Over C, the exact degree-26 one-variable critical equation on the R-fixed line gives 14 R-fixed
    nondegenerate critical points with all forms nonzero. All 14 have kappa = 0 (|kappa| < 1e-91), so
    "two" in Thm 4.1 is a lower bound.
  - At all 14 points mu is numerically nonzero: |mu| ranges from 5.58 to about 3.15e3 in the
    normalisation z0+6z1+zeta^14 z2 = 1.
  - An exact certificate that mu != 0 would let Thm 3.2 rule out branches in these directions at
    these endpoints.
  - The manuscript correctly makes no claim about mu, and AGENTS.md forbids such a claim without
    proof. This is reported only as a lead.

## Overall verdict per numbered result
- **Theorem 2.1:** VERIFIED.
- **Corollary 2.2:** VERIFIED.
- **Remark 2.3:** VERIFIED as a sketch.
- **Proposition 3.1:** VERIFIED (D2 is documentation).
- **kappa and mu, including well-definedness and scaling:** VERIFIED.
- **Theorem 3.2:**
  - Q_eff exists, Q_eff'(0) = kappa and Q_eff''(0) = -mu: VERIFIED. This includes the sign, which I
    re-derived and confirmed numerically.
  - The converse ("Q_eff' == 0 implies a branch"): VERIFIED.
  - The forward direction: GAP D1, minor and fillable; the fill is given above.
- **Theorem 4.1:** VERIFIED, both the kappa != 0 part (F1) and the two kappa = 0 points (F2-F4).
  The certificates were re-run (byte-identical output) and independently recomputed.
- **Introduction literature and credit claims:** NOT CHECKED (sources not opened). D4 and D5 concern
  wording.
