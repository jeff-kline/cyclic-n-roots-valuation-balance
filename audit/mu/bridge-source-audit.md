# Valuation-multiset bridge: source and substitution audit

STAGE: PROOF-AUDIT — source/substitution check of existing results.

VERDICT: VERIFIED.

The claimed multiset equality follows from Sattelberger–van der Veer Proposition 2.10 and the **maximal** wonderful compactification / fine Bergman fan. Corollary 3.3 is not needed. The source route needs the explicit substitutions below; merely citing Corollary 3.3, a coarse Bergman fan, or the minimal wonderful model would not establish all threshold equalities.

## Claim and exposure

Let K=C((t)), let n>=2, and let F be the constant complex symmetric invertible Fourier matrix. Suppose x in K^n has every x_i and every y_k=(Fx)_k nonzero, and F(y^{-1})=x^{-1}, with reciprocals taken coordinatewise. Then the multisets {val(x_i)} and {val(y_k)} are equal, including multiplicities.

Reviewed: the coordinator's statement packet; the installed cold-examiner skill; the two primary sources listed below, in HTML and PDF. No author proof, sibling quarantine material, release material, or other review was read. This is the skill's permitted source/substitution mode for a consequence of existing results, not a claim of independent cold rediscovery or a new initial failure-search report.

## Exact sources checked

1. Anna-Laura Sattelberger and Robin van der Veer, *Maximum Likelihood Estimation from a Tropical and a Bernstein–Sato Perspective*, IMRN 2023(6), 5263–5292, DOI [10.1093/imrn/rnac016](https://doi.org/10.1093/imrn/rnac016). The checked full text is the authors' accepted [arXiv v2 PDF](https://arxiv.org/pdf/2101.03570), dated 3 March 2022, and its [HTML](https://arxiv.org/html/2101.03570).

   - Proposition 2.10, PDF pp. 6–7: a formal critical arc limiting to several SNC boundary components forces its limiting weights to annihilate every corresponding divisorial valuation.
   - Section 3.1, PDF pp. 8–9: the smooth tropical compactification setup requires reduced SNC boundary; on each component the coordinate valuations equal the primitive ray vector.
   - Corollary 3.3, PDF pp. 9–10: a logarithmic critical point on a boundary stratum produces an arc whose valuation is the sum of the stratum's primitive rays. This is a converse existence statement, not the required necessity step.
   - Formal discs are expressly Spec C[[t]]; generic points are Spec C((t)), PDF p. 4. No convergence hypothesis is present.

   Publisher metadata confirms the journal citation. The publisher's full-text redirect failed, so the page numbers above are **arXiv PDF page numbers**, not asserted journal proposition-page locations.

2. Eva Maria Feichtner and Bernd Sturmfels, *Matroid polytopes, nested sets and Bergman fans*, checked [arXiv PDF math/0411260](https://arxiv.org/pdf/math/0411260) and [HTML](https://arxiv.org/html/math/0411260).

   - Section 3, PDF p. 7: the maximal building set gives the order complex of proper flats, hence chains.
   - Definition 3.5, pp. 8–9: flat indicator vectors generate the nested-set cones. Proposition 3.6(1), p. 9: these fans are unimodular.
   - Theorem 4.1, p. 13, and Corollary 4.3, p. 14: nested-set fans refine the Bergman fan; taking the maximal building set gives the flat-chain subdivision.
   - Section 6, pp. 18–21, relates arrangement compactifications and toric fans. Theorem 6.1, p. 19, concerns the model built from **connected** flats. Its statement must not be mistaken for an assertion that the minimal model has a divisor for every flat.

The geometric input used below is the usual maximal wonderful model: blow up all proper arrangement intersection subspaces in increasing dimension, retaining the hyperplane transforms. It is smooth, projective, has SNC boundary indexed by the nonempty proper flats, and realizes the maximal nested-set fan. The fine/maximal choice, rather than an identification with the coarse tropical compactification in Theorem 6.1, is essential to this presentation.

## Substitution and load-bearing checks

### 1. The correct projective variety and weights

Use 2n indexed linear forms on V=C^n:

    ell_i(z)=z_i                 (1<=i<=n),       alpha_i=-1,
    ell_{n+k}(z)=(Fz)_k          (1<=k<=n),       alpha_{n+k}=+1.

Let U be their common nonvanishing locus and X=P(U). Their total weight is zero. Thus

    Phi([z]) = product_k (Fz)_k / product_i z_i

is a regular invertible function on X. Fix an index e and set f_a=ell_a/ell_e for a!=e. These are globally regular invertible functions on X; their map identifies X with a closed subvariety of the (2n-1)-dimensional torus, since the original map z -> (z,Fz) is a linear embedding. The projective logarithmic form is

    omega = sum_(a!=e) alpha_a dlog(f_a)
          = sum_a alpha_a dlog(ell_a).

The last expression is written on U; total weight zero makes it descend. In the affine tangent coordinates on V,

    omega_x(h) = (F^T y^{-1} - x^{-1})^T h.

Symmetry F^T=F is exactly the substitution that turns the given equation into omega_x=0. Invertibility guarantees the coordinate changes and avoids zero Fourier forms; no use of F^2 or a particular Fourier normalization is required here.

### 2. Essential, simple, connected arrangement; schönness

The coordinate forms already span V*, so the arrangement is essential. For a Fourier matrix every matrix entry is nonzero. For n>=2, no Fourier row is proportional to a coordinate form; invertibility makes the Fourier rows pairwise nonproportional. Hence all 2n hyperplanes are distinct. Also each Fourier form, together with all n coordinate forms, is a circuit: its expression uses every coordinate with nonzero coefficient, and those coordinates are a basis. These circuits connect the whole matroid. This discharges the connectedness convention used in Feichtner–Sturmfels Section 6.

The very affine variety is a projective linear-space complement. Its initial degenerations are torus-open parts of linear spaces: initial ideals of constant-coefficient linear ideals are generated by linear initial relations, obtainable by weight-compatible row reduction. They are smooth wherever nonempty. Quotienting the homogeneous description by the diagonal torus gives the projective description. Thus this is a schön arrangement embedding. Alternatively, Proposition 2.10 itself needs only the smooth proper SNC model, so its application does not depend on invoking schönness separately.

### 3. Every valuation threshold is a flat, with the correct sign

Put w_a=val(ell_a(x)). All are finite integers. Let c_0<...<c_s be their distinct values. For 1<=j<=s define

    A_j = {a : w_a >= c_j}.

Each A_j is a nonempty proper matroid flat. Indeed, if ell_b belongs to the complex span of the ell_a with a in A_j, evaluation at x and the nonarchimedean inequality give w_b>=c_j, so b belongs to A_j. The argument uses upper level sets, not lower level sets. These flats form a chain, and

    w = c_0 * 1 + sum_(j=1)^s (c_j-c_(j-1)) * 1_(A_j).

All displayed coefficients are positive. Consequently the projective valuation class lies in the relative interior of precisely the fine-fan cone generated by the indicators of this threshold chain. Each indicator is primitive modulo Z*1: an inside/outside coordinate difference is 1. The fine fan is smooth; its cones have the unimodularity recorded in Proposition 3.6.

### 4. The formal arc meets all the needed divisors

The point [x] defines a K-point of X. Properness of the maximal wonderful model Y extends it uniquely to Spec C[[t]] -> Y. A torus arc whose valuation lies in the relative interior of a cone limits to the corresponding toric orbit. This can also be read in a smooth toric chart: the orders of its boundary coordinates are exactly the positive coefficients in the cone expansion. Therefore its center on Y lies on every divisor D_(A_j).

No algebraicity of the coefficients as functions of t, analytic convergence, genericity of the data weights, nonzero Euler characteristic, or genericity of the critical point is required. The fixed weight vector defines a constant map to the source's projective weight space, and the generic point of the pair is in its critical locus. Positive-dimensional critical loci cause no problem.

### 5. Divisorial orders have multiplicity one

For a nonempty proper flat A, let Z_A be its projective linear intersection. At a general point of Z_A, ell_a vanishes to first order exactly when a lies in A. Blowing up this linear center therefore gives

    ord_(D_A)(ell_a/ell_e) = 1_(a in A) - 1_(e in A).

For rank-one flats this is the corresponding strict transform of a hyperplane. Earlier blowups affect proper subspaces of the generic center, and later blowups do not change the divisor's generic valuation. Thus no hidden ramification factor enters. This is also the primitive-ray / reduced-boundary calculation in Sattelberger–van der Veer Section 3.1.

The residue of omega on D_A is therefore

    sum_(a!=e) alpha_a [1_(a in A)-1_(e in A)]
      = sum_(a in A) alpha_a,

where total weight zero is used in the equality. Notice that the arc's contact multiplicity c_j-c_(j-1) can exceed one; it does not multiply the divisor's intrinsic order and does not weaken the individual residue conditions.

### 6. Proposition 2.10 yields the multiset conclusion

Apply Proposition 2.10 to the extended arc with its constant weights. For every threshold flat A_j,

    0 = sum_(a in A_j) alpha_a
      = #{k : val(y_k)>=c_j} - #{i : val(x_i)>=c_j}.

The total counts at c_0 are both n. Subtracting adjacent cumulative equalities gives equality of the multiplicities at every c_j. If s=0, both multisets consist of n copies of c_0, so the boundary argument is unnecessary. This proves exactly the stated conclusion.

## Degenerate cases and limitations of attribution

- **n=2:** the arrangement is four distinct points of P^1, so its boundary is already SNC and the maximal model introduces no nontrivial blowup. All proper nonempty flats are rank one. The same proof applies. The original critical equations are nonvacuous: for the unnormalized 2x2 Fourier matrix, x=(1,i) and x=(1,-i) work.
- **Repeated or proportional forms in a more general matrix problem:** they do not occur for the stated Fourier matrices. More generally, group proportional forms and add their weights. Their valuations agree because proportionality constants lie in C*. Apply the geometry to the distinct hyperplanes with the summed weights. If all summed weights vanish, the weighted threshold statement is immediate. One must preserve weights under this simplification; deleting repeated forms without adding their weights is incorrect.
- **Minimal versus maximal model:** a threshold flat may be disconnected. The minimal building set has only connected flats, so one cannot simply assert that it contains every D_(A_j). The maximal building set supplies the needed divisors.
- **Corollary 3.3:** it is unnecessary and should not be cited as proving individual threshold orthogonality. Proposition 2.10 does that. Theorems involving general weights, rigid rays, or nonzero Euler characteristics are also unnecessary.
- This audit establishes a conditional theorem and its source derivation. It makes no claim of novelty or of existence/classification of all Fourier critical points.

## Independent algebraic cross-check (complete alternative proof)

The conclusion also has a short proof requiring no compactification. This verifies the substitution independently of the geometric presentation; it is not an assertion that the cited papers contain this proof.

Write x=sum_(m>=m_0) x_m t^m with x_m in C^n. For any integer r let h_r=sum_(m_0<=m<=r) x_m t^m, a finite Laurent polynomial vector (zero if r<m_0). The critical equation implies

    0 = sum_a alpha_a ell_a(h_r)/ell_a(x).

Because every ell_a has constant coefficients, ell_a(h_r) is precisely the truncation through degree r of ell_a(x). If w_a>r, its numerator is identically zero. If w_a<=r, then

    ell_a(h_r)/ell_a(x) = 1 + O(t^(r+1-w_a)),

whose constant coefficient is 1. All terms lie in C[[t]]. Taking the constant coefficient gives

    sum_(w_a<=r) alpha_a = 0.

With the specified +/-1 weights, all lower cumulative valuation counts agree, hence the multisets agree. There is no illegal differentiation of the t-dependent vector h_r: the stationary covector at x is evaluated on a vector over K, so this is simply a linear pairing. This argument in fact establishes the corresponding weighted statement for any finite collection of constant-coefficient linear forms and any exact logarithmic critical K-point.

## Resources and remaining obligations

Allocation: at most 12 minutes wall time, 60 CPU seconds, and 10 web calls. Used 9 web calls; no numerical experiment, enumeration, Python interpreter, package installation, or project workload. Local commands were read-only skill/directory inspection plus creation and inspection of this report. No emails or email tools were used. No sibling quarantine or release workspace was inspected or modified.

No mathematical gap remains in the stated substitution. For publication, cite the exact accepted preprint page numbering above or check the typeset journal locations separately; do not relabel arXiv page numbers as journal page numbers. A separate adversarial examiner should review any newly adopted elementary alternative if it becomes the release's primary proof.
