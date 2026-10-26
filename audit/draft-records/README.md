# Valuation balance and local lifting for cyclic roots

**Status: local draft, October 26, 2026. Not admitted or published. M1 remains parked.**

The Fourier equations for cyclic roots force the coordinate valuations of a
Laurent-series solution to agree, as a multiset, with those of its Fourier
transform. Every proper gap gives exact complementary supports of equal size.
For a one-dimensional endpoint kernel and a nondegenerate projective normal
critical point, a local reduction gives scalar conditions $\kappa=0$ and
$\mu=0$, followed by higher coefficients. At order 26, the same supports admit
nondegenerate normal critical points with $\kappa\ne0$ and with $\kappa=0$.
An affine reflection forces the latter cancellation exactly.

## What is new

The proposed contribution is the valuation-multiset lemma and its
every-gap consequence, the explicit local compatibility scalars, and the
order-26 example explaining why the first scalar alone cannot exclude all
endpoints. A bounded comparison has not found the multiset lemma in this form;
priority and the wider literature comparison remain unresolved.

There is no uniform stopping theorem for the coefficient conditions, no claim
about $\mu$ at the fixed endpoints, and no claim that those endpoints lift to
cyclic-root branches. The work does not prove finiteness at order $2p$.

## Earlier work

[Haagerup](https://arxiv.org/abs/0803.2629) supplies prime-order finiteness and
the Fourier/support framework.
[Zhou](https://arxiv.org/abs/2608.06335v2) shows that the original disjoint-support
condition is available at every composite order.
[Cohen–Denham–Falk–Varchenko](https://doi.org/10.4153/CJM-2011-028-8) provide
related master-function context. The Fourier symmetries, Fourier
correspondence, and implicit-function theorem are not claimed as new.

## Read and check

- [Paper PDF](paper/main.pdf) and [TeX source](paper/main.tex).
- [Admission status](ADMISSION.md), [provenance](PROVENANCE.md), and
  [verification record](VERIFICATION.md).

From this directory, use the owning workstream's isolated environment:

    ../.venv/bin/python scripts/check_certificates.py
    sh scripts/build-paper

The certificate program uses exact arithmetic and fixed matrices. It does
not search for branches or evaluate further effective coefficients. It
prints checks without modifying earlier research records. Required versions
are in requirements.txt; the owning workstream already has that environment.

## Authorship and release boundary

Author: Jeff Kline. This local draft was prepared with substantial assistance
from AI systems under his direction. Separate agent reviews are process
evidence, not expert peer review. There is no release tag, DOI, stable citation,
or public deposit for this draft. No publication action is authorized here.
