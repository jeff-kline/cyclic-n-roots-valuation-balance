# Maximal wonderful model: attribution addendum

VERDICT: VERIFIED; the original report remains unchanged.

This addendum closes the distinction between the minimal connected-flat model discussed in Feichtner–Sturmfels Theorem 6.1 and the maximal model used in the valuation proof.

## Explicit source locations

Eva Maria Feichtner, *De Concini–Procesi wonderful arrangement models: A discrete geometer's point of view*, [arXiv:math/0403183v2 PDF](https://arxiv.org/pdf/math/0403183), [HTML](https://arxiv.org/html/math/0403183):

- **Theorem 2.5, PDF p. 7** is expressly presented as the theorem on the maximal model and attributes it to **De Concini–Procesi [DP1, §3.1 Theorem and §3.2 Theorem]**.
- **Section 4.1, PDF p. 18**, explicitly describes construction for an arbitrary geometric building set by either product closure or successive blowups. It states that boundary divisors are indexed by the building-set elements and their nonempty intersections by nested sets.
- **Section 4.2, PDF p. 20**, explicitly gives the projective model: projectivize the ambient space in the constructions, obtaining a smooth projective variety. It points to **[DP1, §4]** for details.

Here DP1 is De Concini and Procesi, *Wonderful models of subspace arrangements*. The original sections are thus identified precisely, but were not directly reopened in this bounded addendum; the checked accessible statement is Feichtner's author exposition. This distinction should remain explicit in the provenance record.

## How this closes the substitution

Take the whole nonzero intersection lattice as the building set. Its nested sets are chains. After projectivization, omit the full-rank flat whose linear intersection is the origin; the remaining nonempty proper matroid flats index the boundary divisors needed in the report. The smooth projective model and its normal-crossing boundary are exactly the geometric input for Sattelberger–van der Veer Proposition 2.10.

For the toric description, combine this model construction with Feichtner–Sturmfels Definition 3.5, Proposition 3.6, and Theorem 4.1, already checked in the sealed report. The resulting fan has primitive rays 1_A modulo the all-ones vector and cones indexed by chains of proper flats. In particular, every upper valuation threshold A occurs. There is no need to assert that the minimal model in their Theorem 6.1 already contains every threshold divisor, or that it equals the coarse tropical compactification.

Suggested citation in the proof: “Use the maximal projective wonderful model (De Concini–Procesi, §§3.1–3.2 and §4; see Feichtner, Theorem 2.5 and §§4.1–4.2), whose fan is the maximal nested-set subdivision (Feichtner–Sturmfels, Proposition 3.6 and Theorem 4.1).”

Resources: two additional web calls; no experiment, Python execution, or other workspace writes. The original report's SHA-256 remains 08521957d91193bcc8be22db6b68295d0fded53397af4dde2b2e1563773f0abe.
