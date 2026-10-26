# Verification record

Draft of version 0.1.0, October 26, 2026. Not released; not peer reviewed.

## What the checker verifies

`scripts/check_certificates.py` reconstructs the order-26 example from the
paper's formulas in exact arithmetic over $K=\mathbb{Q}(\omega)$,
$\Phi_{13}(\omega)=0$, with $\zeta=-\omega^7$. It imports no output tables.
It checks:

- the supports $I$ and $J$ of $u$ and $Fu$, and the exact kernel relations
  for the basis $G$; the $11\times11$ minor is nonzero (3759 modulo 10037)
  and has $\pi$-valuation 31, so the relevant rank is 11;
- the reflection identities: $I=20-I$, $J=12-J$, $\mathcal U u=-u$, the
  exponent identities behind both intertwining relations, the induced map $R$
  on the free coordinates and the exact $R$-invariance of the affine chart;
- the normalized $\pi$-adic reductions of all rows of $G$ and $V$, using the
  fact that term valuations in the $\pi$ basis are distinct modulo 12;
- at the split prime 53 ($\omega\mapsto16$, $\zeta\mapsto4$) and
  $z=(1,8,19)$: all 28 denominators nonzero, zero gradient, the Hessian,
  chart determinant 23, the solve for $w$, and $\kappa=4$;
- over $\mathbb{F}_{169}=\mathbb{F}_{13}[t]/(t^2-2)$, at both residual points:
  all 28 normalized denominators nonzero, zero gradient, the chart Hessians,
  determinants $1\pm7t$ and their norm 7.

It does not compute Hensel lifts, $\mu$, further coefficients or branches.
Exact vanishing of $\kappa$ at the two lifts follows from the symmetry and
Hensel-uniqueness argument in the paper, not from a numerical zero.

## Runs

| Date (UTC) | Check | Result |
|---|---|---|
| 2026-10-26 | `make verify` with `$HOME/.venvs/claude/bin/python` (Python 3.9.6, SymPy 1.14.0, mpmath 1.3.0) | PASS; output byte-identical to `evidence/certificate-result.json`; 23.9 s wall |
| 2026-10-26 | `make paper` with pdfTeX 1.40.22 | PASS; two clean builds byte-identical; no warnings; 8 pages |
| 2026-10-26 | README rendered by the GitHub Markdown API and `scripts/check_readme.py` | PASS: all 71 inline math spans render as math; 15 local links exist |

The checker's evidence file was produced by the draft's author environment
(Python 3.12.14) and reproduced byte for byte here under Python 3.9.6.
