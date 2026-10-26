# Exact local certificate for the two specified endpoint directions

Status: AUTHOR CERTIFICATE; awaiting separate cold proof audit.

This document uses precisely the fixed data and normalization in
`mu-cold-packet.md`. Put pi=1-omega_13 and use the unramified quadratic
extension obtained by adjoining t with t^2=2. At the two exact Hensel lifts,
the computed statement is

    v_pi(mu_+)=v_pi(mu_-)=-14,
    pi^14 mu_+ = 11+8t mod pi,
    pi^14 mu_- = 11-8t mod pi.

The norm of either displayed residue is 11^2-2*8^2=6 mod 13, so neither
is zero. The output is `mu-certificate.json`. These are the two lifts of
z=(9+/-4t,8+/-3t,9+/-4t), in the invariant chart
z0+6*z1+zeta^14*z2=1, with the factored u specified in the packet.

## Arithmetic and precision model

The polynomial Phi_13(1-pi) is monic Eisenstein of degree 12. Its coefficients
below the leading term are E_i=(-1)^i binom(13,i+1). Since 2 is a nonsquare
modulo 13, adjoining t gives an unramified quadratic extension. Its integer
ring has the basis pi^i and t*pi^i, 0<=i<12, over Z_13.

The program stores 24 coefficients modulo 13^20. Thus the underlying ring
arithmetic is exact modulo pi^240. A ball is

    pi^s * a + O(pi^P),

where a is an integral stored representative and P is an absolute error
bound. A nonzero ball is normalized so a is a unit and s<P; an unresolved
zero has s=P. The valuation of a stored element is the minimum of
12*v_13(c_i)+i over each basis component. Terms of different i cannot cancel
because their valuations have different residues modulo 12; the two t
components at one i cannot cancel because 1,t are residue-linearly independent.

Multiplication reduces modulo the two defining polynomials. Dividing an
integral representative by pi uses the identity pi^12=-sum E_i*pi^i and
lowers its guaranteed absolute precision by one. Unit inversion starts with
the exact F_169 inverse and uses eight Newton doublings, giving at least
256 pi digits before truncation to the working ring. Its product with the
input is checked to be 1 modulo 13^20.

For balls a,b with lower valuation bounds s_a,s_b, the operations use:

    P(a+b) >= min(P_a,P_b),
    P(ab)  >= min(P_a+s_b,P_b+s_a),
    P(1/a) >= P_a-2*s_a, provided s_a<P_a.

Shifts by pi^k add k to both s and P. Every operation also caps its precision
at that justified by the stored ring coefficients. Zero balls are never
inverted. Nonvanishing is asserted only when s<P. This is conservative ball
arithmetic: it never treats a cancellation as additional known digits.

Exact characteristic-zero inputs are rebuilt by executing only the
construction prefix of our sealed exact checker, through its exact valuation
assertions. The file is read-only. Only its process resource-limit line is
removed from the in-memory source, since this combined calculation has its
own 180-second limit. Each rational field coefficient is converted using
the same ball arithmetic. No residue output from an earlier experiment is
used as the matrix input.

## Hensel step and root enclosure

Each V row is divided by its known pi-power (4 or 8) before evaluating
logarithmic derivatives. This changes Psi only by a constant and prevents
the degenerate naive reduction. All 28 normalized forms are units on each
entire residue disc. Their coefficients are integral, so the chart gradient
is an integral analytic function there. The supplied reduced Hessian has
unit determinant at both points and hence everywhere in either disc.

Newton iteration is applied to both chart variables. The successive lower
bounds for the gradient valuation are

    1, 2, 4, 8, 16, 32, 64, 128, 232.

At the last numerical center the exact gradient vanishes modulo pi^232.
The unit-Jacobian Hensel theorem places the unique exact critical point in
the ball of radius O(pi^232) around that center. The program explicitly
truncates the coordinates to this root-error bound before computing mu.
Consequently subsequent balls enclose the exact Hensel point, not merely
the final Newton iterate. The chart map is integral; it preserves this bound.
The reflection-fixed identity is checked through this precision as a control;
its exact validity and kappa=0 are the previously proved symmetry facts.

## Linear equations and obstruction

The gauge w20=0 is valid because u20!=0. Set w_Ic=v_Ic^{-1}, then solve the
11 equations indexed by C using M^{-T}. The exact critical-point condition
supplies the remaining equations. The calculated full constraint residual
has valuation at least 208. All g entries have valuation 0; the v entries
retain exactly the stipulated valuations 4 and 8. The minimum w valuation
is -8. The kappa ball vanishes to order at least 202, a control consistent
with the exact symmetry proof, not a new proof of exact vanishing.

To solve Ls=-h, impose s4=s20=0. The evaluation map on ker L=span{u,w}
at these two coordinates is invertible: its determinant, up to sign, is
u20*w4!=0, because u4=0. For a symmetric matrix with this kernel, the
principal submatrix deleting rows and columns 4,20 is invertible. Indeed,
a vector in its kernel extended by zeros has L-image supported at 4,20;
orthogonality of this image to ker L forces it to vanish. The vector then
belongs to ker L and the two zero coordinates force the vector itself to
vanish. Since kappa=0 and u^T h=0, the full system is compatible.

Complete-pivot Gaussian elimination in ball arithmetic solves this 24 by 24
system. Each selected pivot is separated from zero. The pivot valuations are

    0,0,2,2,4,4,6,6,8,8,8,8,8,8,8,8,10,12,16,16,16,16,16,16.

The minimum s valuation is -16, its minimum certified absolute precision is
200, and the full Ls+h residual vanishes to at least order 200. Residual
agreement is a control; the rigorous enclosure comes from the ball solve
and the exact compatibility argument above.

For the plus point, the two contractions have initial terms

    q2 = pi^-14*(5+3t+O(pi)),
    h^T s = pi^-14*(7+8t+O(pi)).

Their difference gives mu=pi^-14*(11+8t+O(pi)), with absolute precision 193.
The equivalent expression q2+s^T Ls gives the same initial term, with
absolute precision 184. The two contractions agree through order 184.
The minus point is recomputed from its own Newton initialization; its results
are the t-conjugates, including the nonzero residue 11-8t. Thus neither the
leading term nor its sign is inferred from a floating approximation.

## Exact scope

The nondegenerate two-level reduction states that a solution branch with
the prescribed endpoint directions u and w requires every coefficient of
the effective scalar derivative to vanish. Here kappa=0 exactly, but its
next coefficient -mu is nonzero. Hence no such branch exists with those
specified directions. This does not exclude all branches through a coarse
boundary point, other directions, degenerate endpoints, or further strata.
It neither proves nor advances a uniform obstruction for M1.

Reproduce with the owning quarantine's explicit environment:

    ../.venv/bin/python certify_mu.py

from this directory. The successful author run used 41.555 CPU seconds.
The preceding setup run stopped before local computation because the imported
checker had lowered the process hard CPU limit; that import issue was repaired
in memory as described above. The sealed input source is unchanged.
