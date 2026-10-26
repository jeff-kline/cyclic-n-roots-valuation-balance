# Gate A1-F: final end-to-end read and cross-surface consistency

Auditor: Claude Opus, fresh context, read-only (one report write; see "Side effect").
Date: 2026-10-26. Scope: assembled paper/main.tex (SHA-256 53b8b748…063ee6,
544 lines) and paper/main.pdf (9 pages, rendered at 70 dpi), against README.md
(SHA-256 2e2e6c40…ef18a9), CITATION.cff, ADMISSION.md, AUDIT_LEDGER.md,
VERIFICATION.md, BUILD.md, CORRECTIONS.md, NOTICE, AGENTS.md, audit/PRIOR_WORK.md,
audit/EVIDENCE.md. No network, no subagents.

## What was re-checked by hand (not delegated to earlier reports)

- Thm 2.1 proof (power-sum identity uses only F = F^T, F invertible); Cor 2.2
  supports, including the complement side via y = x^{-1} at orders < -c.
- Prop 3.1: d = q-m+1; v_I = 0 from F[I,J^c]G = 0; L = N^T D N; Lambda^T D^{-1} Lambda = H;
  Hz = -grad Psi = 0, so rank H = d-1 is the right nondegeneracy; DNw = Lambda z.
- Section 3 scalars: u^T h = |J|-|I| = 0; kappa well defined; mu invariant under
  s -> s + ker L and w -> w + cu (cross term 2c kappa); scaling law
  kappa -> (ab)^{-1} kappa, mu -> (ab)^{-2} mu re-derived (w -> b^{-1}w, s -> a^{-1}b^{-2}s).
- Thm 3.2: Q_N gradient/Hessian at (0,0) equal 0 and L|_T; radical argument needs
  ker L = span{u,w} (supplied by nondegeneracy); Q_tau(0,0) = kappa;
  Q_eff''(0) = Q_tautau + 2h^T s + s^T L s = -mu using Ls = -h; branch definition,
  xi/tau in tT[[t]], coefficient recursion, and the converse are consistent with the
  statement. Hypotheses |I| = |J| (line 180), (2), nonzero coordinates and rank H = d-1
  are all present.
- Section 4 arithmetic: set sizes (|I| = |J| = 12, |B| = 14, d = 3; I^c has 9 even
  and 5 odd indices); 10037 = 26*386+1; zeta -> 4, omega -> 16 at 53 (16^7 = 49 = -4);
  Hz = 0 mod 53 for the displayed H and z = (1,8,19); 2x2 minor 33-169 = 23 mod 53;
  U^2 = S^2 = 1; F U = S^{-T} F; I = 20-I, J = 12-J; R from S at indices 17, 19, 21
  gives (zeta^14 z_2, z_1, zeta^12 z_0); kappa(u,Rz) = -kappa(u,z) via a = -1;
  ell z-bar = 66 +- 26t = 1 in F_169; chart Hessian det 1 +- 7t, norm 7; zeta^14 = omega^7 = 1 mod pi;
  L(Rz) = L(z); 13/pi^12 = -1 mod pi (Wilson); norm(11+8t) = 121-128 = 6 mod 13;
  evaluation at coordinates 4, 20 is injective on span{u,w} (det -u_20 w_4).
- zeta = -omega^7 = e^{2 pi i/26} matches Section 1's zeta = e^{2 pi i/n}.
- Transfer to C: every property used (nonzero coordinates, nondegeneracy, kappa = 0,
  mu != 0, distinctness, R-fixedness) is a polynomial (non)vanishing statement over a
  number field of definition, so it survives the embedding extending omega -> e^{2 pi i/13}.
- Bridge paragraph (main.tex:97-117) against audit/mu/bridge-source-audit.md and
  -addendum.md: weights, total weight 0, maximal model, divisors indexed by nonempty
  proper flats, upper level sets are flats, order 1 along D_A exactly for forms in A,
  residue = count equality. Accurate; not overclaimed (it is cited as a consequence,
  direct proof kept, no priority).
- All \ref/\eqref/\cite targets resolve to the intended objects (eq. 1-14, Thm 2.1,
  Cor 2.2, Prop 3.1, Thm 3.2, Thm 4.1); every bibliography entry is cited; no "??".
- Counts agree on every surface where they appear: at least two kappa = 0 points;
  v_pi(mu) = -14; residues 11 +- 8t; 9 pages (pdfinfo); 28 forms; rank 11; 53, 169,
  10037; 3759; kappa = 4; title, author, version 0.1.0, "draft, not released", license.
- No process-history phrases in the paper, README or CITATION.cff. The AI-assistance
  paragraph is identical in paper and README (author name substituted).

## Findings

| # | Label | Location and exact text | Issue | Suggested fix |
|---|---|---|---|---|
| 1 | gap (claim surface) | paper/main.tex:89-91 "The order-$26$ example shows both nonvanishing and symmetry-forced vanishing of the first scalar." and :114-116 | Section 1 never states the new principal clause of Theorem 4.1 ($\mu\ne0$ at the two symmetric points, hence no branch in the prescribed directions). Abstract, README, CITATION and Sec. 4-5 do. A1 requires the introduction to carry the principal claim. | Add one sentence after :91, e.g. "At two of the symmetric points a $\pi$-adic certificate gives $\mu\ne0$, so no branch leaves them in the prescribed directions." |
| 2 | documentation (count rule) | paper/main.tex:114-117 "Its use for cyclic $n$-roots, the exact supports at every gap, the scalars $\kappa,\mu$, and the order-$26$ example are what this note adds; a bounded search ... found none of them stated" vs README.md:59 "New for cyclic $n$-roots:" (three bullets) and :99 "none of the three items" | Paper lists four additions, README three (README places the valuation theorem under "Not new"). Same issue as consistency F8(i), still open. | Drop "Its use for cyclic $n$-roots," from the paper's list, or count it on every surface. |
| 3 | sharpening (novelty calibration) | README.md:90-91 "the second-term test in the form of Adrovic and Verschelde, of which $\kappa$ and $\mu$ are explicit instances" vs paper/main.tex:88-89 "$\kappa$ and $\mu$ are compatibility conditions of this kind" | "Instances" is stronger than the paper and sits awkwardly with the README bullet listing the scalars as new for cyclic n-roots and with :99 "none ... stated for cyclic $n$-roots" (AV's test is stated for cyclic n-roots, under a regular-isolated-root hypothesis; prior-art.md rates K PARTIAL). | Use the paper's "conditions of this kind" in README; optionally say what is new is the explicit form at nondegenerate normal critical points. |
| 4 | documentation (stale) | AGENTS.md "Do not claim finiteness for any composite order, a value of mu at the symmetric endpoints, ..." | The paper now claims $v_\pi(\mu)=-14$ and $\mu\ne0$ there (Thm 4.1, Sec. 4.4). | Replace with "do not claim mu at other R-fixed points or other directions". |
| 5 | documentation (stale count) | VERIFICATION.md:52 "all 71 inline math spans render as math" | Current README has 81 inline spans (scripts/check_readme.py on the existing build/readme.html: "PASS README: 81 inline + 0 display"). | Update the row after the final render. |
| 6 | documentation (pre-freeze) | MANIFEST.sha256 | `shasum -c` fails for README.md, paper/main.tex, paper/main.pdf, CITATION.cff, BUILD.md, Makefile, AUDIT_LEDGER.md, audit/*, etc. | Regenerate at freeze (expected). |
| 7 | documentation (stale) | ADMISSION.md:11 "Two-stage cold examination and delta review (no errors; gap closed); consistency audit fixes applied." and :12 "Checker (byte-identical output) and reproducible build pass" | Omits the B1 bridge/mu audit, the A1-mu cross-provider check and `make verify-mu`, which now carry Theorem 4.1's mu clause. | Add them to the A1 and R1 evidence cells. |
| 8 | documentation (superseded wording) | AUDIT_LEDGER.md:25 "Thm 2.1 presented as expected to follow from the residue principle" | Superseded by :37 ("is a consequence of"); a reader of :25 alone gets the old status. | Append "(superseded by B1)". |
| 9 | documentation | BUILD.md:30 and audit/EVIDENCE.md:61 "except for CPU time, interpreter path and the hash"; scripts/compare_mu.py:3 | The ignored `python` field now holds the Python version (evidence/mu-certificate.json:267 "3.9.6"), not a path (ledger :41). | Say "Python version". |
| 10 | sharpening (notation clash) | paper/main.tex:437 "$L(z)=z_0+6z_1+\zeta^{14}z_2=1$", :451 "in the chart $L(z)=1$", :452-453 "solve $Ls=-h$ ... $\ker L$" | $L$ is the matrix of Prop. 3.1 and also the chart form, in consecutive sentences of Sec. 4.4. | Rename the chart (e.g. $\lambda(z)$). |
| 11 | sharpening (notation clash) | paper/main.tex:423 "$\F_{13}[t]/(t^2-2)$", :456 "$\Z_{13}[\pi,t]$", :464 "$11\pm8t$"; README.md:82 "leading residues $11\pm8t$" | $t$ is the Laurent parameter in Thm 2.1/3.2 (which Sec. 4.4 invokes) and $\sqrt2$ in Sec. 4.3-4.4; README never defines this $t$ (its only other $t$, :27, is the Laurent parameter). Also $E$ = eq. (1), boundary divisors (:99), and a subset (:317). | Use e.g. $\theta$ with $\theta^2=2$; in README write "$11\pm8\sqrt2$". |
| 12 | sharpening | paper/main.tex:22-24 abstract "among composite orders, the sources we read settle only $n=6$ and $n=10$" | Non-square-free composite orders are settled (infinite, Backelin). Sec. 1 :57 and README :14 say "composite square-free orders". | Insert "square-free". |
| 13 | sharpening | paper/main.tex:37 abstract "an exact $\pi$-adic certificate"; CITATION.cff:27 "an exact pi-adic certificate"; README.md:39 "an exact computation" | Sec. 4.4 and README table describe conservative ball arithmetic with guaranteed precision: rigorous, not exact arithmetic. | "a certified $\pi$-adic computation". |
| 14 | sharpening | paper/main.tex:100 "smooth normal-crossings compactification"; :108 "Each set $\{\ell:\nu(\ell)>c\}$ is a flat" | Source uses reduced simple normal crossings; the residue step needs the set to be a nonempty proper flat, i.e. $c$ strictly between the least and greatest valuations (else no divisor). | "simple normal-crossings"; "For $c$ strictly between the extreme valuations, each set ...". |
| 15 | sharpening (unclear leftover) | paper/main.tex:307 "This does not restrict intermediate powers in a Laurent parameter." | Meaning unclear after the branch definition was added; no audit report discusses it. | Delete or state what is meant. |
| 16 | sharpening (redundancy) | paper/main.tex:217-220 "their number is $2q-(n-1)=d$ ... Indeed $\dim\ker N^T=2q-\rank N=2q-(n-1)=d$" | Same count stated twice. | Keep the second sentence only. |
| 17 | missing hypothesis (README) | README.md:71-73 "Suppose the boundary vector $u$ has a one-dimensional kernel in the sense of the paper's Section 3" | The paper's Section 3 also fixes $|I|=|J|$ (main.tex:180), used for $u^Th=0$ and the projective problem; the bullet omits it, and "$u$ has a kernel" is loose ($u_I$ spans $\ker F[J^c,I]$). | "Suppose $|I|=|J|$ and $u$ spans the kernel of $F[J^c,I]$ (Section 3) ...". |
| 18 | documentation (sourcing) | README.md:49-51 "using Chebotarev's theorem ... and the uncertainty principle of Tao (found independently by Haagerup)" | Not in the paper, PRIOR_WORK.md or prior-art.md; only partial support in the quarantine NOVELTY.md:50 ("Chebotarev/Tao closing at prime n (Haagerup Prop. 3.3, Thm 3.2)"); "found independently by Haagerup" has no recorded source. | Record a source/locator in PRIOR_WORK.md or drop the parenthesis. |
| 19 | sharpening (bibliography) | paper/main.tex:523-529 [Fei], [FS] given as arXiv only | Both appeared in print (from memory, not verified here: FS in Port. Math. 62 (2005); Feichtner in MSRI Publ. 52 (2005)). The addendum cites math/0403183v2. | Verify and add venues or versions. |

No error was found in any theorem statement, proof step re-checked above, cross-reference,
or count. No sentence contradicts the new mu clause inside the paper (the only stale
"no mu claim" text is AGENTS.md, finding 4).

## Side effect

Running `scripts/check_readme.py` to count math spans rewrote the ignored file
build/readme-check.json (same script, same inputs as the root's run). No other file
outside this report and the scratchpad was written.

## Verdict

PASS-WITH-FIXES. Findings 1 and 2 should be fixed before freeze (principal claim
missing from Section 1; four-versus-three novelty count). Findings 4-9 are
documentation syncs; 10-19 are optional sharpenings. Any edit to main.tex beyond
wording requires re-running this check on the changed lines.
