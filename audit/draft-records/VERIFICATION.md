# Verification record — 2026-10-26

Status: fixed local draft checks passed. This is not a public-release audit.

## Environment and commands

Python 3.12.14, SymPy 1.14.0, mpmath 1.3.0, in the owning workstream's
isolated environment. Every Python workload used its explicit interpreter.
The checker rejects non-isolated and optimized Python and has a 90-second
CPU ceiling. It uses only fixed exact matrices and the stated finite points.

From this directory:

    ../.venv/bin/python scripts/check_certificates.py
    sh scripts/build-paper

The final certificate run returned PASS. Its output was byte-identical to
evidence/certificate-result.json. A separate reviewer also ran the arithmetic
body successfully. A proof reviewer independently reconstructed the finite
field calculations. Review scopes and limits are in reviews/.

The optimized invocation:

    ../.venv/bin/python -O scripts/check_certificates.py

was deliberately rejected with exit 1 before arithmetic began.

The paper built with pdfTeX 1.40.22 (TeX Live 2021/MacPorts). The documented
two-pass build resolved all references and left no TeX warnings or box
diagnostics. The Codex editor compiler also reported success. The seven-page
PDF was rendered with Poppler and visually checked for legibility, clipping,
formula layout, page numbering, and references. All final changed pages were
rendered and checked again.

## Exact arithmetic checks

The verifier reconstructs the example without imported output tables as inputs:

- Supports I and J, exact Fourier zeros, and exact kernel identities.
- Rank 11, minor 3759 modulo 10037, and pi-valuation 31.
- Exact G and V row reductions in the ramified field.
- Negative reflection eigenvalue on u, both Fourier intertwining identities,
  induced action on free coordinates, and invariant affine chart.
- F53 critical point: all denominators, gradient, Hessian, determinant 23,
  and kappa=4.
- Both F169 critical points: all 28 normalized denominators, gradients,
  Hessians, determinants 1 ± 7t, and norm 7.

Exact zero at the characteristic-zero lifts follows from the proof, not a
finite-precision output. No mu, further coefficient, or branch calculation ran.

## Quarantine and integrity

The four existing manifests were rechecked after drafting: 13, 39, 45, and
37 files respectively all matched. No sealed round changed.
The excluded workstream was not inspected. The user's D5 summary is recorded
as a report, not as an audit packet inspected here.

This draft's MANIFEST.sha256 covers the reading source/PDF, exact verifier
and output, dependency/build instructions, and review/status records.
Generated TeX auxiliaries, build logs, editor state, virtual environments,
and temporary raster previews are excluded. This is a local content manifest,
not an immutable release archive.

## Remaining release checks

The prior-art comparison is bounded and incomplete. No clean candidate archive
reproduction, deterministic PDF release build, public repository, release tag,
license decision for a publication bundle, DOI, or archive verification was
performed. No public-release permission was requested or used.
