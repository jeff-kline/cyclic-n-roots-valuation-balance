# Cold examiner: proof and certificate audit

STAGE: PROOF-AUDIT
VERDICT: VERIFIED

CLAIM: In precisely the normalization and two residue discs of mu-cold-packet.md v1, the exact Hensel lifts satisfy

    v_pi(mu_+) = v_pi(mu_-) = -14,
    pi^14 mu_+ = 11+8t mod pi,
    pi^14 mu_- = 11-8t mod pi.

Both residues have norm 6 in F_13 and therefore are nonzero. This verdict is for this finite local arithmetic claim, conditional on the explicitly supplied earlier kernel, nondegeneracy, existence, reflection and kappa=0 premises. It does not establish M1 or classify other endpoint directions.

## Sealed initial and exposure boundary

The INITIAL report was saved and its hash delivered before the author evidence was exposed. It remains unchanged:

    examiner-initial.md
    SHA256 90b584673c4fa8a2e7f5042eb08e0735a691b9a080d5dd53f1f8241910ba6cba

Its verdict was NOT-BROKEN. The independently built PARI computation found the positive leading coefficient 11+8t, but did not complete transport from a finite Newton approximation to the exact root. That limitation is not hidden or retroactively changed. The present proof audit discharges the precision obligation using a checked implementation and proof different from the failed initial interval attempts.

## Load-bearing arithmetic argument

I read all of local_field.py and certify_mu.py, MU-PROOF.md, the submitted JSON certificate, and the permitted exact construction prefix of paper-draft/scripts/check_certificates.py. I checked the following inference chain.

1. The defining polynomial is exactly Phi_13(1-pi), with coefficients E_i=(-1)^i binom(13,i+1) below its leading term. It is Eisenstein of degree 12. The residue polynomial t^2-2 is irreducible over F_13. The integral power basis is therefore {pi^i,t*pi^i: 0<=i<12}. The ideal (13^20) is (pi^240). The minimum coefficient valuation formula is valid: distinct pi exponents have distinct valuation classes modulo 12, and 1,t are independent in the residue field.

2. rmul implements convolution with t^2=2 and then monic reduction by the stated Eisenstein polynomial, modulo 13^20. The quotient calculation rdivpi is correct: if a=pi*b, then b_11=-a_0/13 and b_i=a_(i+1)+E_(i+1)*b_11. Its representative is determined modulo pi^239 rather than pi^240, as required. Repeated normalization keeps the old absolute P while increasing the factor valuation s; this decreases relative precision by exactly the number of divisions and does not manufacture digits.

3. A Ball(a,s,P) encloses pi^s*a+O(pi^P). Its constructor caps P at cap+s before normalization. The uncertainty-zero case stores s=P. Addition uses the smaller absolute bound; multiplication uses min(P_a+s_b,P_b+s_a). That multiplication bound also covers the product of both input errors, since P_a>=s_a and P_b>=s_b. For a ball separated from zero, inversion uses P_a-2*s_a. The inverse of its normalized unit is obtained from its nonzero residue by eight Newton doublings in the exact finite ring, and a multiplication check verifies the stored inverse modulo 13^20. Every inversion of an unresolved zero raises an error. Shifts, truncations, subtraction and integer powers preserve the enclosure semantics.

4. Exact rational coefficients enter through numerator and denominator balls. Horner conversion of SymPy's descending ANP coefficients evaluates at omega=1-pi. Thus the converted fixed matrices enclose the characteristic-zero objects in the packet. The exact source prefix reconstructs U,W,u,f and their supports, constructs G with the correct C/T rows, checks all F[I,B]G equations, constructs V, and checks the row valuations and det(M) valuation. The source hash matches the certificate. No prior numerical endpoint output is used as an input.

5. The gradient and Hessian are formed from G and the normalized V rows. Dividing a V row by its stated pi power changes its logarithm only by a constant. All row coefficients are integral and all evaluated forms are units throughout their starting residue discs. Their reciprocals therefore have integral convergent local power series. The Hessian determinant is separated from zero with valuation zero at the Newton steps.

6. Ball arithmetic encloses the exact Newton sequence starting at the specified algebraic initial point. A gradient ball of valuation at least r proves that the exact gradient at the enclosed Newton point has valuation at least r. With a unit Jacobian, the integral analytic Hensel argument gives the unique exact zero within O(pi^r) of that point. After the bounds 1,2,4,8,16,32,64,128,232, the program explicitly truncates the chart coordinates to r=232. This enlarges their balls to include the exact root, rather than treating the last iterate as exact. Every subsequent quantity is evaluated on those root-enclosing balls. This is the missing transport step from INITIAL, and it is valid here.

7. The w calculation has the correct bilinear transpose and sign. It sets w_Ic=1/v_Ic, w20=0, and solves F[C,D]w_D=1/g_C-F[C,Ic]w_Ic with F[C,D]=M^T. The exact critical-point premise supplies the other equations. The displayed full constraint residual bound 208 is a control; the proof of their exact compatibility is the supplied premise. The h formula matches the packet.

8. The principal L minor deleting coordinates 4,20 is valid. The two evaluation functionals separate ker L=span(u,w), because u4=0, w20=0 and u20*w4 is nonzero. If a vector in the complementary principal kernel is extended by zeros, its L-image is supported at 4,20 and is orthogonal to ker L. The invertible evaluation map forces that image to be zero, and then the vector itself is zero. Also u^T h=|J|-|I|=0 and w^T h=kappa=0, so the full symmetric system is compatible.

9. Complete-pivot Gauss-Jordan in solve keeps row operations, column permutations, and the right-hand side aligned. Every pivot is a ball separated from zero. Consequently the exact root's restricted system is among the systems enclosed by every operation, and the output balls contain its exact solution. The finite pivot list in the certificate is reproduced. s has minimum valuation -16 and absolute precision at least 200. The full residual bound 200 is an additional control, not a substitute for the enclosure argument.

10. The expression q2-h^T s has the correct sign and normalization. Exact compatibility gives -h^T s=s^T Ls; the alternative contraction is also checked computationally. The final mu balls have valuation -14 and absolute precision 193, so they exclude zero by a margin of 207 powers of pi. The plus residue is [11,8] and the minus residue is [11,5], i.e. 11-8t. The minus endpoint is recomputed from its own initialization. The comparison of conjugate outputs does not stand in for that computation.

These steps establish the exact local claim. Agreement with the independent positive leading coefficient is supporting evidence, not the logical basis of the precision proof.

## Replay and controls

The author certificate was replayed through examiner-replay.py using the designated isolated interpreter. The sole source substitution replaces the final certificate write with an equality check against the submitted endpoint records. Every endpoint field, including all precision bounds and pivot valuations, reproduced exactly. The submitted JSON hash remained unchanged. The replay used 41.105 CPU seconds.

A final control run used the submitted 240-digit ring balls and compared their enclosures against independent exact characteristic-zero PARI arithmetic. Fifteen checks passed: initial negative valuation, normalization involving division by pi, addition, subtraction, product, inverses of negative- and positive-valuation elements, quotient, positive and negative shifts, power, complete cancellation, truncation followed by inversion, and both coordinates of a solve requiring a column permutation. The test also rejected inversion of an unresolved-zero ball and rejected a deliberately corrupted leading coefficient. These checks target precision and permutation failures relevant to the certificate.

One additional optional conjugation control did not pass. Its proposed exact reference used substitution inside nested PARI polynomial-modulus objects; that substitution's action was not established, so this result is not admitted as an arithmetic comparison. The control run is not described as wholly successful, and its error log is preserved. The author certificate never calls Ball.conjugate: both endpoints are recomputed separately. The helper's formula itself is justified directly by the basis automorphism t -> -t, which negates exactly the twelve t coefficients and fixes pi. No further run was made after the two-run audit allowance was exhausted.

## Dependencies, omissions, and scope

The earlier certified nondegeneracy/kernel statement, existence of the two exact critical lifts, reflection-fixedness and exact kappa=0 were explicit premises. This audit checks their use, and reconstructs/checks the permitted fixed-data prefix, but does not claim to have independently re-audited every earlier proof. The necessary branch-coefficient implication supplied in the packet permits exclusion only of branches with these prescribed two-level directions. It gives no uniform obstruction, no other-support result, and no statement about all fourteen complex points.

No new mathematical gap was found in the submitted finite certificate or its precision argument. No author-source change was needed for this verdict. No unseen or failed examiner run is counted as proof.

ERRATA / PROCEDURE: The coordinator reported after INITIAL that an author charter had imposed a pi^240 representation ceiling. That ceiling was not present in the examiner's initial packet. The initial PARI experiments used 100 and 140 digits in 13-adic coefficients, exceeding that representation ceiling even though the successful root approximation was only through pi^128. This procedural deviation must remain recorded. The proof-audit replay uses the author's pi^240 model, and the control balls use the same cap; exact characteristic-zero reference arithmetic has no claimed finite local precision. The exact local theorem rests on the compliant author model, not on the over-cap initial attempt.

EXPOSURE: No author evidence was seen before INITIAL sealing. Stage 2 read only the authorized author files, the authorized exact input prefix, and examiner-generated files. The forbidden sibling quarantine was not read. No other support sets, search, complex-point enumeration, Groebner calculation, homotopy, floating arithmetic, external publication, or email was used.

RESOURCES: Stage 2 began 2026-10-26 12:43:28 UTC. Two substantive runs were made: the 41.105-CPU-second replay and the subsecond exact control run. Total stage-2 computation is conservatively under 43 CPU seconds, within the 180-CPU-second limit. The report was completed within the 12-minute wall allocation. Stage 1 used under 32 CPU seconds. Combined examiner CPU is conservatively under 75 seconds. All Python scripts used ~/Documents/hm-ai/quarantine/bjorck-saffari-chatgpt-2026-10-25/.venv/bin/python explicitly, with isolated-prefix checks; replay/control used -B to avoid writing import caches. Only examiner-* files were written.

## Evidence revisions

- Packet: 33b589d7a1ab628e305c0ca17271da482e6eb43f0d30e064af985ce644da44eb
- MU-PROOF.md: a98871d2cded5dce8265af2f54ff6607051b819be77c03c66beb439b12c0b929
- local_field.py: 172a8e1e830fe11c6ad1934f07e0d569201c9d9a37623d8cb3d4cae7f0307568
- certify_mu.py: c93db091f006b6a063f88781a10ba4a3992c4c4f1c9c6e8c0c8808658f14a146
- mu-certificate.json: 50626c324a188679439ced80b287e173e20f1de375d71091e34064487c83c00c
- Exact input checker: 8ac5791fd5869671ced0ae6b3aa6033a68bb9a73f8237d947c4ee9615c7245a1
- examiner-replay.py: 5e839e53ac9371f0cb23befc081c76ff7331908cbf24269ef21dad336cf02ed7
- examiner-replay.out: 5b17f2f91d8ca55a5a5bfaf0e3b5a0f0bd165b520acfe9885a735b2713056f22
- examiner-ball-control.py: e182b0de891a2cd91c30ae6efc358f1179bf45c3412354efa2356b16a1e4a5ff
- examiner-ball-control.gp: ec189f1948da65b7c2741c5ed9d7134a2e1380ccb84b6fd077247ccd0579aa77
- examiner-ball-control.out: 38f95d09f13ec6da8b7951b24344bd3b1d0a20c73f99cc825921b857d368a9d5
