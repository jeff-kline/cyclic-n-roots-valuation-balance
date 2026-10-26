# Cold examiner, delta review of paper/main.tex

```text
STAGE: PROOF-AUDIT (delta)
REVIEWED: paper/main.tex SHA-256 367e531c063e389b49c5b75a878ad44cd2ce8c3bb893b6485e3112460a99a939
          (the whole file was re-read). This is compared with the version I audited, 445cbd51...d9080,
          whose reports are proof-stage1.md (edb244df...) and proof-stage2.md.
          The change markers in build/main.delta.diff were listed to make sure no hunk was missed.
EXPOSURE: no draft-*, quarantine, README or prior review read. Cited sources (FR, AV, SvdV, Zhou) not opened.
RESOURCES: no new computation was needed; well under 5 CPU-min. Earlier exact checks are reused where cited.
VERDICT: Item 1 VERIFIED (D1 and D3 closed). Item 2 VERIFIED, and my D2 remark is withdrawn.
         Item 3: mathematics VERIFIED and sources NOT CHECKED. Two new defects: a minor gap
         ("Rz is a second point") and documentation (the abstract overstates the residue link and the
         n = 6, 10 claim).
```

## 1. Theorem 3.2: the branch definition and the forward-direction fill. VERIFIED

**The definition matches what the converse produces.**
- The converse gives x(tau) = u + tau(w + eta(tau)) with eta in tau T[[tau]], convergent.
- Take t = tau, tau(t) = t and zeta(t) = t eta(t) in T[[t]]. Then nu(zeta) >= 2 > 1 = nu(tau).
- l_u(x) = 1, because l_u(u) = 1 and l_u(w) = l_u(T) = 0.
- The coordinates of x and Fx are nonzero Laurent series: u_i on I, t(w_i + ...) on I^c, f_j on J,
  and t((Fw)_j + ...) on J^c.
- E(x) = 0 holds identically.
- So the produced branch belongs to the defined class.

**The class does not depend on the choice of l_u, l_w and T.**
- Take another choice l'_u, l'_w, T'. Put eps = l'_u(zeta), so nu(eps) >= nu(zeta), and renormalise
  by the unit 1 + eps.
- Then tau' = (tau + l'_w(zeta))/(1+eps) has nu(tau') = nu(tau).
- Also zeta' = (zeta - eps u - l'_w(zeta) w)/(1+eps) has nu(zeta') >= nu(zeta) > nu(tau').
- So the forward reference "as in the proof" is harmless.

**The fill is complete.**
- eta_b = zeta/tau lies in tT[[t]], because nu(zeta) > nu(tau).
- Both partial derivatives vanish. The identities d_eta Q . delta = tau delta^T E(x) and
  d_tau Q = (w+eta)^T E(x) hold as rational identities whose denominators are units after
  substitution, and E(lambda x) = lambda^{-1} E(x) = 0.
- The expansion d_eta Q = L|_T eta + beta(tau) + O(tau eta) + O(eta^2) is correct:
  - beta(tau) = d_eta Q(tau, 0).
  - The t^k coefficient of the O(tau eta) and O(eta^2) terms involves only eta_j with j < k.
  - So L|_T eta_k is determined recursively, and the solution in tT[[t]] is unique.
- eta o tau lies in tT[[t]] and solves the same equation, so eta_b = eta o tau.
- Then Q_eff'(tau(t)) = d_tau Q(tau(t), eta_b(t)) = 0. Since tau(t) != 0 lies in tC[[t]], this gives
  Q_eff' == 0.
- Line 267 now cites (eq:w) for the vanishing eta-gradient (former D3).

**Residual documentation:** the statement reuses the symbol zeta for a series in T[[t]], while zeta is
e^{2 pi i/n} elsewhere (and in Section 4). Rename it, for example to rho(t).

## 2. Proposition 3.1: "Lw = N^T Lambda z = 0". VERIFIED. D2 (first half) is withdrawn
- Nw = (w_{I^c}, (Fw)_{J^c}) = (v^{-1}, g^{-1}), so DNw = (v_{I^c}, -g_{J^c}) = (Vz, -Gz) = Lambda z.
- Lambda's columns lie in ker N^T:
  - Put g~ = Gc on J^c. Then (F g~)_I = A^T G c = 0 and (F g~)_{I^c} = V c.
  - So N^T(Vc, -Gc) = Vc - Vc = 0 on I^c, and 0 on I.
  - This was also checked exactly mod 53 (s2_recompute.gp).
- Hence Lw = N^T D N w = N^T Lambda z = 0.
- My D2 claim that "Lw = 0 needs Hz = -grad Psi = 0" was wrong as a necessity claim.
  - Criticality enters only through the existence of w (eq:w).
  - Given w, Lw = 0 follows directly, and Hz = 0 then follows rather than being an input.
- D2 (second half, the count wording) is fixed by the new sentence
  "dim ker N^T = 2q - rank N = 2q-(n-1) = d; columns independent because those of G are". VERIFIED.

## 3. Section 1 and the Section 4 wording

| Item | Verdict | Label / note |
|---|---|---|
| Conjecture forms (unimodular with leading entry 1 [FR Conj. 1.1]; complex form is the standard restatement [Zhou]); abstract "in its usual complex form" | Consistent, so D4 is closed. Sources NOT CHECKED. | |
| n = 6, 10, 14 (intro): "the sources we read establish finiteness only for n = 6 and n = 10 ...; at n = 14 a count of isolated roots ... finiteness not established" | Hedge is appropriate. Source NOT CHECKED. | |
| n = 6, 10 (abstract): "among composite orders it is known only for n = 6 and n = 10" | Unhedged universal negative that is stronger than the intro. | **documentation** (D5 residual): make it match the intro's "the sources we read". |
| AV Sec. 5.1 ("test whether a second term exists, starting from a regular isolated root of the initial system"); CASC 2013 bibliographic data | NOT CHECKED | |
| Symmetry sentence: "up to a scalar factor, a composite of shifts, modulations and dilations ...; the same formulas act on all solutions" | VERIFIED (math). FR attribution NOT CHECKED. | See below. |
| Residue paragraph (SvdV Prop. 2.10) | Derivation sketch is mathematically sound. Body wording is accurate (if anything conservative). | **documentation**: the abstract says the theorem "is a special case of a residue principle", which is stronger than the body's "should give ... not checked". Align the abstract (e.g. "is closely related to"). |
| Thm 4.1 "at least two" points with kappa = 0 | VERIFIED | Consistent with the proof. My earlier numerics (not a certificate) found 14 R-fixed points with kappa = 0. Section 5's "the two fixed points" refers to the two Hensel lifts and is fine. |
| Section 4.1 "By (kappaodd), Rz is a second such point" | **GAP (minor)** | See below. |

**Symmetry sentence, mathematics.**
- 𝒰 = zeta^{-10} · (modulation x_i -> zeta^{-12i} x_i) · (shift and dilation by -1, i -> 20-i).
- For any complex solution, the cyclic correlations c_r = sum_j x_{j+r}/x_j transform as follows:
  - a shift leaves c_r unchanged;
  - modulation by zeta^{bi} gives zeta^{br} c_r;
  - dilation by a unit d gives c_{dr};
  - a scalar leaves c_r unchanged.
- So the vanishing of c_r for r != 0, which is (eq:critical), is preserved for all solutions, not only
  unimodular ones. The nonvanishing of f is also preserved, because f_k (F^{-1}x^{-1})_k = 1.

**Residue paragraph: the mathematics of the sketch.**
- Phi = prod_k (Fx)_k / prod_i x_i has total weight n - n = 0, so it is a rational function on P^{n-1}.
  Because F = F^T, its logarithmic gradient is E(x).
- For a Laurent solution x(t), put S_c = {l among the 2n forms : nu(l(x)) > c}.
  - S_c is flat-closed: any arrangement form in span S_c has valuation > c.
  - So S_c defines a flat X_c. As c varies, the X_c form a chain.
  - The valuation vector minus nu_min · 1 equals sum_c (gap length) · e_{S_c}. It therefore lies in
    the relative interior of the cone of that chain.
- In the maximal wonderful (De Concini-Procesi) model, which is the tropical compactification for
  that fan (Feichtner-Sturmfels), the limit point then lies on the intersection of the divisors D_{X_c}.
  This step is standard but it is the non-trivial input. I did not verify it from a source.
- At that point, in normal-crossings coordinates, Phi = unit · prod y_j^{e_j}, where
  e_j = sum over l in S_c of the weight of l.
- Criticality is an identity of covectors: e_j / y_j + (holomorphic) = 0 for each j, with y_j -> 0.
  So each e_j = 0 separately, not merely one combined relation along the curve.
- e_j = 0 means #{k : nu(f_k) > c} = #{i : nu(x_i) > c} at every threshold c, which is equivalent to
  equality of the multisets.
- Caveats the sketch leaves open:
  - It applies to convergent (geometric) curves; formal solutions need Artin approximation or the
    direct proof.
  - I did not check whether SvdV's hypotheses (for example, a limit on a single divisor or a general
    point of it) cover limits on intersections. The local covector argument above does cover them.
- Verdict:
  - "Should give ... we have not checked that derivation in detail" is accurate, not too strong, and
    at most slightly too weak.
  - The direct proof makes the theorem independent of the sketch.
  - Only the abstract's unhedged "is a special case" overstates.

**Section 4.1, why "Rz is a second such point" is a gap.**
- kappa(u,Rz) = -kappa(u,z) shows Rz != z as vectors. It does not show that Rz is a different
  projective point: kappa scales as b^{-1}, so Rz = -z would also give kappa(Rz) = -kappa(z).
- The paper itself warns about this scale issue in Section 4.2.
- One-line fill:
  - R is an involution, so Rz = lambda z forces lambda = +-1.
  - lambda = 1 is excluded because kappa != 0.
  - The (-1)-eigenspace of R is {z1 = 0, zeta^14 z2 = -z0}.
  - The lift of (1,8,19) has z1 = 8 mod 53, a unit, so z1 != 0.
  - R also preserves nondegeneracy and the nonvanishing of the forms (it is monomial).
- Theorem 4.1's plural "points" with kappa != 0 depends on this sentence only cosmetically.

## Other
- D6 (notation) was not adopted: L(z) in Section 4.3 still clashes with the matrix L. The new zeta(t)
  is noted above.
- Status of earlier items: D7 is addressed except for the gap above; D8 and D10 are not part of this delta.
