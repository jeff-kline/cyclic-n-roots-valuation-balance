# Regroup — bridge and the two order-26 mu values

Scoped follow-up COMPLETE. Source bridge VERIFIED; finite mu certificate
VERIFIED by a sealed two-stage cold examination. M1 stays PARKED. This is
not an admission verdict for the shared release repository.

## 1. Prior-art bridge

The valuation-multiset theorem is a consequence of Sattelberger–van der Veer's
Proposition 2.10, applied on the maximal projective wonderful model. Every
upper valuation threshold is a flat. Its boundary residue is the sum of the
weights on that flat, so each threshold has equally many time and Fourier
coordinates. Differences of cumulative counts give the multiset equality.

The required geometric model is available for this projective arrangement
complement. Total weight n-n=0 is required for the projective master function.
Use the maximal building set, not just connected flats. Corollary 3.3 is a
converse and is unnecessary for this implication. Exact source locations are
in bridge-source-audit.md and bridge-source-addendum.md.

Recommended wording change for the release owner, not applied here:
replace “expected to follow” with “is a consequence of,” with the maximal-model
substitution stated or cited. Keep the direct proof and no-priority statement.

## 2. Finite sharpening of the example

Verified exact certificate in the stated normalization:

    v_pi(mu_+)=v_pi(mu_-)=-14,
    pi^14 mu_+ mod pi = 11+8t,
    pi^14 mu_- mod pi = 11-8t,       t^2=2 over F_13.

These are the two specified Hensel lifts in the invariant chart, with exactly
the u and g normalizations in mu-cold-packet.md. The nonzero residues have
norm 6. There is no floating-point input. V-row valuations 4 and 8 are retained
and normalized before the Hensel solve; mu is evaluated with propagated
absolute precision, reported as 193 in the author computation.

The example's verified conclusion becomes:
“Reflection forces kappa to vanish at these two nondegenerate endpoints, but
mu is nonzero; hence these prescribed two-level directions do not lift to
solution branches.” This excludes neither all directions through a coarse
boundary point nor other strata. M1 remains parked.

## Release implication

This is a useful sharpening of the same finite example. It does not
restore novelty to the valuation theorem or supply a uniform obstruction.
The principal-example claim and its certificate would need the A1 claim audit
reopened, followed by the final consistency/read-through already outstanding.
The fourteen numerical complex points were not investigated.

No manuscript, README, admission record, citation metadata, or commit in the
shared release checkout was changed. No release action is authorized here.

## Review and provenance

A fresh gpt-6-astra examiner first independently rebuilt the positive local
calculation in PARI/GP, without seeing the author proof or coefficient. Its
INITIAL report was sealed before exposure. It then checked the actual integer
ring arithmetic, precision propagation, exact-root Hensel enclosure and linear
solve, and replayed every author certificate field. Final verdict VERIFIED for
the finite two-lift claim, conditional on the earlier certified premises.
The full report is examiner-proof-audit.md; its hash is
f3f9cd3f35c85162074aca4fca1dcad10414ca8a9a3cabfe1399bc88a1c72210.

The immutable author snapshot MU-PROOF.md retains its creation-time pending
status; the subsequent proof audit and this record supply the final status.
RUN-RECORD.md discloses unsuccessful examiner interval attempts, an unused
conjugation-control reference failure, and the initial examiner representation
cap deviation. None is counted as a passed certificate. The final proof uses
the compliant pi^240 author calculation with justified error bound 193.

Eight substantive runs were used, with aggregate CPU conservatively below
212 seconds, within the one-hour wall allocation. All 147 previously sealed
files verified unchanged. The release checkout remained clean at the original
75dcdccbd078e7bccc92bb80c675d01b55a52596 commit at the final check.
