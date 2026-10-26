# mu cold examination, Stage 1 (INITIAL)

```text
STAGE: INITIAL
VERDICT: NOT-BROKEN (and independently reproduced: v(mu_+-) = -14, pi^14 mu_+- == 11 +- 8t mod pi)
EXPOSURE: audit/packets/mu-cold-packet.md version 1, SHA-256
          33b589d7a1ab628e305c0ca17271da482e6eb43f0d30e064af985ce644da44eb; the
          cold-examiner SKILL.md; repository AGENTS.md (the harness injected it when
          the packet was read; it has no computation). No author script, proof,
          certificate, review or run record seen. Examiner: Claude (Anthropic).
TOOLS:    PARI/GP 2.17.4 (/usr/local/bin/gp). No Python.
RESOURCES: about 22 CPU-s in total for all Stage-1 runs (the main run takes 1.8 CPU-s per lift).
```

## Independent computation

The scripts are in `audit/reports/mu-scripts/`: `mu_exact.gp`, `mu_balls.gp`, and the
`run_plus.gp`, `run_checks.gp`, `run_controls.gp`, `run_controls2.gp` and `run_lead.gp` drivers.
They are my own code. I did not use or read `check_certificates.py`.

* **Exact layer, over Q(omega) as GP polmods.** From the packet's definitions alone, I rebuilt
  F, u, f = Fu, M, M^-1, G, V and h, and checked every stated input fact:
  * supp u = I and supp Fu = J exactly;
  * rank F[I,B] = 11, v(det M) = 31 and F[I,B]G = 0;
  * every G row is integral with row valuation 0;
  * V row valuations are 4 at even i and 8 at odd i, and every normalised residue row is
    proportional to (1,6,1);
  * u^T h = 0 exactly and u_20 != 0.

  Valuations come from v_pi(a) = v_13(N_{Q(omega)/Q}(a)).
  The supports alone tie down the readings a_i <-> U and b_i <-> W, coefficient-vector
  indexing u_k = [X^k], and zeta = -omega^7.
* **Arithmetic in K.** I represent O_K as Z[omega][t] in the omega power basis, with
  coordinates mod 13^S (S = 60, that is pi^720). This is exact ring arithmetic in O_K/pi^720.
  The valuation of an element comes from its exact pi-expansion (substitute omega = 1 - p),
  using min(12 v_13(c_k) + k), which is exact because 0 <= k <= 11.
  A ball is (13^E * mantissa, absolute precision N). The rules are:
  * mul: N = min(N1+v2, N2+v1, N1+N2);
  * add: N = min(N1, N2);
  * inverse: N - 2v, and only when v < N;
  * every mantissa truncation caps N at 12(E+S);
  * non-unit inverses use pi^-a = P^a/13^a with P = prod_{j>=2}(1-omega^j);
  * unit inverses use Newton iteration mod 13^S.
* **Hensel.** I ran Newton iteration on the chart gradient in O_K/13^60. It used only
  unit inverses, so it is exact ring arithmetic. The residue gradient is 0, and the residue
  Hessian of Psi is [[7+-9t, 8+-t],[8+-t, 4]], as stated. Ten iterations give
  grad == 0 mod 13^60. Because the Hessian is a unit and the gradient is integral-analytic on
  the disc, z* == z mod pi^720.
* **mu on the ball.**
  * Gauge for w: w_20 = 0, w_D = (M^-1)^T (1/g_C - F[C,Ic] w_Ic).
  * L is assembled from the Hankel form (F diag(g^2) F)_{ab} = (F g^2)_{a+b}.
  * Gauge for s: s_a = s_b = 0. The reduced 24x24 system L[R,R] s_R = -h_R is solved by
    complete-pivot elimination on balls.
  * Finally mu = T1 - T2 - h.s.

### Results (S = 60)

| lift | s-gauge | v(center) | N | pi^14 mu mod pi |
|---|---|---|---|---|
| z+ | s4=s20=0 | -14 | 582 | 11 + 8t |
| z+ | s20=s25=0 | -14 | 582 | 11 + 8t |
| z+ | s6=s20=0, with w -> w+u | -14 | 582 | 11 + 8t |
| z- | s4=s20=0 | -14 | 582 | 11 + 5t = 11 - 8t |
| z- | s20=s25=0 | -14 | 582 | 11 - 8t |

* The differences between gauges and w-choices are balls that contain 0, with v(center) = 588
  and N = 582.
* The residue was also checked by multiplying the ball by an exact pi^14 and reducing a unit:
  the result is 11 + 8t.
* The term valuations are v(T1) = v(T2) = -16 and v(-h.s) = -14.
* The pivot valuations of the 24x24 solve are 0,0,2,2,4,4,6,6,8 (x8),10,12,16 (x6).
* v(w) is -4 at even indices and -8 at odd indices; v(s) lies between -16 and -10.

### Consistency probes at the lifts (all balls contain 0)

These quantities should vanish at the lifts, and every ball contains 0:

* (Fw - 1/g)_T on the three rows not used to solve for w;
* every row of Lu and of Lw;
* kappa = w^T h, with v(center) = 624 and N = 611. This is consistent with the kappa = 0
  premise, but it is not a proof of it.

The 24 certified pivots show that rank L = 24 at both lifts, so ker L = span{u,w}
holds at the lifts directly.

## Controls

* **Unlifted point (control A).** At the exact residue point (9+4t, 8+3t), which is not
  critical, mu has valuation -14 but leading term **9 + 4t**, and the kappa ball excludes 0
  (v = 5). So the claimed leading term depends on the lift: an implementation that evaluated
  mu at an unlifted or barely lifted point would report a wrong residue.
* **Precision ladder (control B and C).** I truncated z* to O(13^k) and gave it ball
  radius pi^12k:

  | k | outcome |
  |---|---|
  | 0 (radius pi) | refused: no certified pivot |
  | 1 | refused |
  | 2 | NOT certified (N = -14 = v) |
  | 3 | certified, 11 + 8t (N = -2) |
  | 8, 10, 11, 12, 15 | certified, 11 + 8t (N = N0 - 38) |

  The tracker never certified a wrong value. The lift-induced loss is about 38 pi-digits, so
  any lift accurate to about pi^25 suffices. At S = 60 the final N = 582 is set by storage caps,
  not by the lift.

## Attack points

1. **Conventions.** Bilinear transposes are used throughout. With them L is symmetric (F is
   symmetric) and Lu = Lw = 0 holds identically. zeta = -omega^7 has order 26. The chart
   satisfies z0 + 6 z1 + zeta^14 z2 = 1 because zeta^26 = 1. z = (g_17, g_19, g_21), because
   G[T,:] = Id. No mismatch was found: every stated input fact reproduces, and so does the
   Hessian sign, which is the Hessian of Psi, not of -Psi.
2. **Well-definedness.** Changing w to w + cu changes the first two sums by
   2c*kappa + c^2(|J| - |I|). So invariance needs |I| = |J|, which holds here (12 = 12), as
   well as kappa = 0. The packet says only "when kappa = 0"; it should also mention the
   cardinality condition (documentation). Changing s to s + k with k in ker L leaves s^T L s
   unchanged because L is symmetric. -h^T s changes by -beta*kappa, so the two forms of the
   last term agree only when kappa = 0. In my code the gauge-fixed s gives
   s^T L s = -h^T s identically. Numerically, mu agreed across three s-gauges and a w-shift
   to within pi^582.
3. **Normalisation.** mu has weight -2 in u and weight -2 in g (z). Changing the uniformiser
   multiplies the leading residue by an even power of a unit. So "v = -14, residue 11 +- 8t"
   is normalisation-dependent, as the packet says. The normalisation-free content is
   mu != 0. A small sharpening the packet does not state: the parity of v(mu) and the
   square class of the leading residue are also invariant. N(11+8t) = -7 = 6 mod 13 is a
   non-square, so 11 +- 8t is a non-square in F_169.
4. **Silent precision loss.** No sign of it in my independent tracker, and the margin is
   large (about 600 digits at pi^720). Stage 2 must still check how precise the root fed to
   mu is in the author's code, because the leading term differs at unlifted points
   (control A).
5. **Vacuity and scope.** The hypotheses are realised: both lifts exist (constructed above),
   the reduced L-system is invertible, and the kappa ball contains 0. The statement is finite
   and concerns only these two lifts. Because the lifts are Galois-conjugate under t -> -t,
   mu_- = sigma(mu_+), and the computed pair (11 + 8t, 11 - 8t) is consistent with that.

## Coverage

* **Checked:** every numbered input fact in the packet, both lifts, three s-gauges, a
  w-shift, the precision controls and a residue cross-check.
* **Not checked:** kappa = 0, R-fixedness and the R-action. These are premises; the kappa
  ball is merely consistent with them.
* **Not attempted:** any other support set, any other point, and any statement about mu at
  other branches.
