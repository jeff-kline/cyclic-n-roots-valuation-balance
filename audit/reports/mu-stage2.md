1c74fbb950809ff9da4e41a689c724e38360cc0494645408b57b66df389ffa74  mu-stage1.md (Stage-1 report SHA-256, recorded before reading any Stage-2 material)

# mu certificate, Stage 2 (PROOF-AUDIT)

```text
STAGE: PROOF-AUDIT
VERDICT: VERIFIED for the finite claim, given the declared premises (kappa = 0 at the lifts,
         existence and R-fixedness of the lifts). No error and no gap was found. The defects
         below are documentation and sharpening items.
CLAIM: at the two exact Hensel lifts z+- (packet v1 normalisation: u fixed, g = Gz,
       z0 + 6 z1 + zeta^14 z2 = 1, pi = 1 - omega), v_pi(mu_+-) = -14 and
       pi^14 mu_+- == 11 +- 8t mod pi. In particular mu_+- != 0.
EXPOSURE: Stage-1 report mu-stage1.md, SHA-256 on line 1, sealed before any of the following
          was read:
            audit/mu/MU-PROOF.md          a98871d2cded5dce8265af2f54ff6607051b819be77c03c66beb439b12c0b929
            scripts/local_field.py        172a8e1e830fe11c6ad1934f07e0d569201c9d9a37623d8cb3d4cae7f0307568
            scripts/certify_mu.py         1abbcd45741fed5a69e89de95c63cf4c76264a0b940c6c0074486d4931241167
            build/mu-certificate.json     ffdce1e27e30cd899e3b521ab048b2a5f1789d1c5369d390f7186d11b8a85d44
                                          (before the rerun)
            paper/main.tex                lines 226-262 only (eq. (6), eq. (7) and its paragraph,
                                          Theorem 3.2's statement)
          scripts/check_certificates.py (SHA 90dbc2a5..., recorded in the JSON) was not read.
          Its exec'd prefix supplies the exact data; its correctness is covered by the
          independent replication below. Not read: examiner-*.md, REGROUP.md, RUN-RECORD.md,
          proof-*.md, README.md, the quarantine.
RESOURCES: about 64 CPU-s across both stages (Stage 1 about 22 s; the rerun 33.9 s; cross-checks
           and property tests about 8 s). Limit 480 s.
```

## Rerun

`~/.venvs/claude/bin/python -I scripts/certify_mu.py` exited 0 in 33.9 CPU-s. The log is at
<session scratchpad>/mu-audit-run.log.
The rewritten `build/mu-certificate.json` is byte-identical to the previous copy except for
`cpu_seconds`.

## Independent replication

Stage 1 used my own PARI/GP code with a different representation: the omega power basis, a
13^E mantissa and a 12(E+S) storage cap at S = 60, giving pi^720 instead of pi^240. It agrees
with the certificate on every comparable field:

| quantity | certificate | examiner (GP) |
|---|---|---|
| g valuations | all 0 | all 0 |
| v valuations | 4/8 pattern | same |
| w min valuation | -8 | -8 |
| s min valuation | -16 | -16 |
| L[R,R] pivot valuations, gauge {4,20} | 0,0,2,2,4,4,6,6,8x8,10,12,16x6 | identical sequence |
| q2, plus lift | pi^-14 (5+3t) | pi^-14 (5+3t) |
| h.s, plus lift | pi^-14 (7+8t) | pi^-14 (7+8t) |
| mu, plus lift | pi^-14 (11+8t), P = 193 | pi^-14 (11+8t), N = 582 |
| q2, h.s, mu, minus lift | (5+10t), (7+5t), (11+5t) | identical |

My code also gives the same mu under the gauges {20,25} and {6,20} and under w -> w + u.

After Stage 1 was sealed, I made one change: `mu_balls.gp` now also stores q2 and h.s in
globals (LASTQ2, LASTHS) so that `run_q2.gp` can print them. The change is additive, and every
Stage-1 output is unchanged.

## Per-step audit

| # | step | finding | label |
|---|---|---|---|
| 1 | Representation, cap pi^240 | Coordinates in basis pi^i, t pi^i, i < 12, are taken mod 13^20. 13^20 O_K = pi^240 O_K, so this is exact ring arithmetic in O_K/pi^240. E_i = (-1)^i C(13,i+1) are the coefficients of Phi_13(1-pi), and pi^12 = -sum E_i pi^i. The `rmul` reduction loop runs from degree 22 down to 12, so the cascade is complete. | correct |
| 2 | `rval`, and "terms cannot cancel" | min(12 v_13(c_i) + i): components at different i have valuations in different classes mod 12, and the 1 and t components at the same i cannot cancel because 1 and t are independent mod 13. The valuation of the stored representative is therefore exact. A zero coordinate gets vp = 20 and is skipped, and rval = 240 for 0. | correct |
| 3 | `rdivpi`, `rshift` | Both are exact identities in O_K with integer coordinates. `rdivpi` uses 13/pi = -pi^11 - sum_{i>=1} E_i pi^{i-1} and floor division of a multiple of 13. Coordinate reduction moves the representative by at most pi^240. | correct |
| 4 | Ball constructor | It caps P at s_caller + 240 *before* normalising, which covers every caller's mod-13^20 truncation. Normalising by pi^v changes the center only modulo pi^{s+v+240}. If v + s >= P, the ball becomes an explicit uncertain zero (s = P). MU-PROOF says division by pi "lowers its guaranteed absolute precision by one". In the code it lowers *relative* precision; P is unchanged, which is correct because of the earlier cap. | documentation (description imprecise; code sound) |
| 5 | add | P = min(P_a, P_b), plus the cap. When either operand is a zero ball, the other is returned truncated to min(P_a, P_b). | correct |
| 6 | mul | P = min(P_a + s_b, P_b + s_a). The P_a + P_b term may be dropped because s < P for nonzero balls. For zero balls, P_a + s_b is the exact bound. | correct |
| 7 | inverse | Inverts only when s < P. P' = P - 2s, s' = -s, with a cap at -s + 240. | correct |
| 8 | `rinv` | Starts from the exact F_169 inverse. Eight Newton steps take the error valuation from 1 to 256 >= 240, and `rmul(a,x) == RONE` mod 13^20 is then asserted. `assert __debug__` guarantees the assertions run. | correct |
| 9 | shift, truncate | These are exact rescaling and weakening. | correct |
| 10 | Rules 4-9, checked empirically | `ball_property_test.py`: 400 random balls with s in [-20,20], each tested for add, mul, inverse and shift, plus 100 cancellation probes. There were 0 enclosure failures and 0 over-claims. Mutation control: weakening the inverse rule to P - s is caught (198 failures). | supports 4-9 |
| 11 | Conversion of exact data | `from_fraction` and Horner `from_anp` use the same ball operations, so denominators divisible by 13 lose 24 digits per power of 13, conservatively. The coefficient order of `to_list()` is not visibly checked, but the full agreement with independent data rules out a reversal. | correct |
| 12 | Hensel enclosure | All 28 normalised forms are integral and units on the iterate ball, hence units on the whole residue disc, so the chart gradient is integral-analytic there. det H is asserted to be a unit at the final iterate. The gradient ball's s >= r = 232 bounds v(grad) at the ball's center point, and unit-Jacobian Hensel then gives |(x*,y*) - (x_c,y_c)| <= pi^232. Truncating all three chart coordinates to P <= r gives balls that contain z*; z2 is covered by the ultrametric inequality, since the chart is integral affine. I independently confirmed the residue gradient 0 and residue Hessian [[7+-9t, 8+-t],[8+-t, 4]]. | correct |
| 13 | w | The gauge w20 = 0 is valid because u20 != 0. w_D = M^{-T}(1/g_C - F[C,Ic] w_Ic). The remaining three B-equations hold to valuation >= 208, as a control. | correct |
| 14 | Gauge s4 = s20 = 0 | det[[u4,u20],[w4,w20]] = -u20 w4 != 0 because u4 = 0 and w20 = 0. The argument that L[R,R] is invertible (range L = (ker L)^perp for symmetric L) is correct. Compatibility needs u^T h = 0 (exact) and kappa = 0 (premise). The 24 certified pivots also show rank L = 24 directly. | correct (kappa = 0 is a premise) |
| 15 | Complete-pivot ball solve | Gauss-Jordan with the same row operations on the rhs. Every pivot is asserted to satisfy s < P. Each ball encloses the exact value of the same exact algorithm, so the solution balls enclose s. The pivot rule takes min s over *all* entries, so an uncertain zero with small P could be chosen and trip the assertion even when a valid pivot exists. That is fail-safe, not silent, and it did not occur. | sharpening (robustness) |
| 16 | mu, and the exclusion of 0 | mu = q2 - h.s has s = -14 < P = 193, so it excludes 0. The alternative q2 + s^T L s agrees to order 184. Both lifts are computed separately, and the code asserts the t-conjugate residues. | correct |
| 17 | Same mu as paper eq. (7) | Same terms and signs. h matches eq. (6). The script's -h.s equals s^T L s for a genuine solution, and the script also checks the s^T L s form. The definitions of L, F and w in the paper's Prop 3.1 were outside my reading scope, so I took them from the packet. | correct within scope |
| 18 | MU-PROOF reproduce line | "../.venv/bin/python certify_mu.py from this directory" does not exist in this root. The working command is `~/.venvs/claude/bin/python -I scripts/certify_mu.py`. The CPU figure is 41.6 s (author) against 33.9 s (rerun). | documentation |
| 19 | MU-PROOF "Exact scope" | Branch exclusion uses Theorem 3.2, which is stated over C((t)), but the data and z* here live in K = Q_13(omega,t). The transfer is routine (z* is an isolated critical point and therefore algebraic, mu(z*) != 0 is an algebraic statement, and the formal argument works over any algebraically closed field of characteristic 0), but MU-PROOF does not say so. The mu claim itself is unaffected. | documentation (missing stated transfer) |
| 20 | Packet wording | The packet's well-definedness sentence omits \|I\| = \|J\|, which the c^2 term needs. The paper's paragraph after eq. (7) states it. | documentation (packet only) |
| 21 | Invariant content | The packet and paper correctly say that only vanishing is scale-invariant. A sharpening: under u -> au, g -> bg and a change of uniformiser, the parity of v(mu) and the square class of the leading residue are also invariant. N(11+8t) = 6 is a non-square mod 13, so 11 +- 8t is a non-square in F_169. | sharpening (optional) |

## Defects by class

- Errors: none.
- Gaps: none in the argument for the stated claim.
- Missing hypothesis: none for the mu claim. The 13-adic-to-C((t)) transfer is unstated, but
  only for the downstream branch-exclusion sentence (row 19).
- Sharpening: the pivot-rule robustness (row 15) and the extra invariants (row 21).
- Documentation: MU-PROOF's description of division by pi (row 4), its reproduce path and CPU
  figure (row 18), its scope transfer (row 19), and the packet's |I| = |J| omission (row 20).

## Dependencies

- **Discharged:** every packet input fact (independently rebuilt), the Hensel existence and
  enclosure, rank L = 24 and ker L = span{u,w} at the lifts, the gauge validity, and the ball
  soundness.
- **Remaining premises, not audited:** kappa = 0 exactly at the lifts, and R-fixedness. Both
  implementations' kappa balls contain 0 (certificate v >= 202, examiner N = 611), which is
  consistent with the premises but does not prove them.
