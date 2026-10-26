# Cold examination: initial sealed report

STAGE: INITIAL
VERDICT: NOT-BROKEN
CLAIM: mu is nonzero at the two Hensel lifts specified in statement packet v1. This is only the prescribed local two-level direction claim, not M1 or a claim about all complex points.

## Exact probes and observations

I independently reconstructed F, U, W, u, f, h, G and V in PARI/GP, using exact rational cyclotomic arithmetic for fixed data. I formed the affine gradient and Hessian directly from the row forms. I used no author script, reported coefficient, other support set, enumeration, homotopy, or floating point arithmetic.

The successful positive-residue computation is examiner-independent.gp with examiner-independent-high.out. It starts with 100 digits of 13-adic coefficient precision, uses seven Newton steps, and obtains successive gradient valuations 1,2,4,8,16,32,64; every Hessian determinant has valuation zero. The independent fixed matrix determinant has valuation 31. The one-based support of u is [1,2,3,4,6,8,14,16,18,19,20,21], agreeing with the packet's zero-based I.

I set w20=0, fill w_Ic=1/v_Ic, and solve the eleven C equations through the transpose of the exact fixed inverse M^-1. The other B equations have observed residual valuation 128. The observed kappa valuation is 132. I solve for s using the 24 by 24 principal submatrix omitting original coordinates 4 and 20 and set these coordinates of s to zero. The observed full residual Ls+h has valuation 252. The three terms in mu have respective valuations -16,-16,-14. Their sum has valuation -14, with residue of pi^14 mu equal to 11+8t at the computed positive approximation. Its residue norm is 6, so this coefficient is nonzero. Conjugation t -> -t would give 11-8t for the other lift, provided the computation is certified at the exact lifts.

These are independently computed finite local evidence, not a sealed proof that the finite approximation evaluates the exact Hensel lift with sufficient accuracy. In particular I have not completed a bound transporting mu from the approximation to the exact root.

## Algebraic convention checks

The transpose in the w solve is essential: F is symmetric under the packet's bilinear convention and F[C,D]=M^T. No adjoints were used.

The principal submatrix choice has a direct exact justification under the supplied kernel premise. The restrictions of u,w to coordinates 20 and 4 are independent because u20 is nonzero, u4=0, w20=0, and w4=1/v4 is nonzero. For a symmetric matrix with radical span(u,w), the complementary principal form is nondegenerate. Thus this minor is appropriate at the exact root; one need not choose an arbitrary nonsingular minor computationally.

The stated gauge invariance of the first two mu terms is consistent: w -> w+c u changes their difference by 2c w^T h, since |I|=|J|=12 cancels the quadratic term. Also u^T h=12-12=0. Symmetry plus the supplied kernel and kappa=0 premises therefore gives solvability of Ls=-h. This checked the equation and sign -h^T s but did not re-audit the certified premises.

## Precision failure found in the examiner implementation

Native PARI inversion in the nested ramified polynomial quotient can lose substantial precision. An initial 16-digit run failed in inversions and is unusable. Two attempted explicit interval-ball runs with ten Newton steps and 140 input digits exhausted precision at the tenth gradient evaluation, before the error-ball argument could be completed. Their subsequent printed scalar values are invalid: GP continued after errors and left symbolic intermediate variables. The outputs examiner-interval.out and examiner-interval-minus.out must not be construed as mu=0 counterexamples or as successful checks. No actual negative-residue result was obtained independently in those failed runs.

A proof audit must check actual precision loss, certify input-root error and its propagation through reciprocals and the 24 by 24 solve, and reject any log containing computation errors. Merely increasing displayed precision or finding a stable leading coefficient is insufficient. The successful run is useful evidence but does not close this obligation by itself.

COVERAGE: fixed-data reconstruction; positive local Newton approximation; bilinear transpose; kernel-compatible principal gauge; full displayed residuals; cancellation of the first two leading terms. Missing: a completed interval proof for the exact lift, direct negative-lift computation, and author-proof audit.

DEPENDENCIES: The packet's prior existence, rank, nondegeneracy, R-fixedness and kappa=0 certificates remain accepted premises; their original proofs were not exposed or rechecked.

EXPOSURE: Only cold-examiner/SKILL.md, statement packet v1, and this examiner's own generated GP scripts/output. No author proof/result or sibling quarantine was read. Packet SHA256: 33b589d7a1ab628e305c0ca17271da482e6eb43f0d30e064af985ce644da44eb. Successful independent script SHA256: b60a96cfc459f5bb2c5b099102807b3cc26873b794511db4a3689ab5baecd1b0. Successful output SHA256: e29982439abb32774d19b2485ef509405668b226631c1f88e1d4120d7beec6c0.

RESOURCES: Stage began 2026-10-26 12:34:21 UTC and report prepared at approximately 12:41 UTC, within the 10-minute wall and 180-CPU-second ceiling. Four substantive scripted attempts: 16.46+0.11, 7.75+0.11, 2.69+0.02, and 2.69+0.02 CPU seconds (29.85 total). An immediate syntax/setup failure consumed 0.04+0.01 seconds. A tiny interactive arithmetic probe and isolated-venv file editing add well under one second. Total conservatively under 32 CPU seconds. No enumeration. Python file editing used only the explicitly designated quarantine .venv interpreter, with sys.prefix != sys.base_prefix checked. No email.

This INITIAL report is to remain unchanged after sealing. Later corrections and the proof audit belong in new files.
