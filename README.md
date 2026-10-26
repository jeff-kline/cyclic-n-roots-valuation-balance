# Valuation balance and local lifting for cyclic n-roots

**Status: draft of version 0.1.0, October 26, 2026. Not released.** There is
no tag, archive or DOI yet. Release under the
[public research standard](https://jeff-kline.github.io/posts/research-program/index.html)
is a project decision, not peer review or a correctness certificate; see
[ADMISSION.md](ADMISSION.md) for the open gates.

A cyclic $n$-root is a vector $a\in\mathbb{C}^n$ whose cyclic products of
every length $r<n$ sum to zero and whose full product is 1. Björck and Saffari
conjectured that when $n$ is square-free there are only finitely many such
vectors with entries of modulus 1; the usual modern form asks the same for all
complex solutions. Finiteness is proved for prime $n$, by Haagerup. Among
composite square-free orders, the sources we read settle only $n=6$ and
$n=10$, by computer algebra; at $n=14$ the isolated roots have been counted,
but finiteness is not established.

Writing $x_j=a_0a_1\cdots a_{j-1}$ turns the equations into a statement about
$x$ and its discrete Fourier transform $Fx$. The support of a vector is the
set of its nonzero coordinates. Haagerup's proof starts from the fact that an
infinite solution set yields two nonzero vectors with disjoint supports whose
Fourier transforms also have disjoint supports. Zhou showed in 2026 that such
pairs exist at every composite order, so that step alone cannot decide the
composite case.

This note shows that the equations force more. Follow a curve of solutions
to infinity, written as Laurent series in a parameter $t$. The orders in $t$
of the coordinates of $x$ and of $Fx$ then agree as multisets. As a result,
every gap between these orders, not just the extreme one, gives supports in
$x$ and in $Fx$ that are exact complements of each other and have equal size.
The note then asks whether a solution curve can actually leave such a boundary
point. When the boundary point is nondegenerate in a precise sense, the answer
is governed by one analytic function of one variable, and its first two
conditions are explicit numbers, $\kappa=0$ and $\mu=0$. At order 26,
$\kappa$ is nonzero at some boundary points of one support pair and is
forced to vanish at others by a reflection symmetry. So $\kappa$ is a real
test, but it cannot exclude every boundary point. The note proves no
finiteness theorem for any composite order.

Read the [paper](paper/main.pdf) or its [TeX source](paper/main.tex).

## What is new

Haagerup proved that an infinite set of cyclic $n$-roots gives nonzero
vectors $u,v$ with disjoint supports and disjoint Fourier supports, and closed
the prime case using Chebotarev's theorem on the minors of the Fourier matrix
and the uncertainty principle of Tao (found independently by Haagerup). Zhou
showed that such pairs exist for every composite $n$. Sattelberger and van der
Veer proved that a curve of critical points of a product of powers of linear
forms can reach a boundary divisor of a normal-crossings compactification only
if the weights balance there. Adrovic and Verschelde computed Puiseux
expansions of cyclic $n$-roots from initial forms and gave a linear test for
the existence of a second term.

New for cyclic $n$-roots:

- **Exact complements at every gap.** Let $F$ be the unnormalized Fourier
  matrix and $x$ a vector of Laurent series solving $F(Fx)^{-1}=x^{-1}$
  (inverses taken coordinatewise), with all coordinates of $x$ and $Fx$
  nonzero. Take a real $c$ that is not the order of any of these coordinates
  and lies strictly between the smallest and largest orders. Let $I$ and $J$
  be the indices of $x$ and of $Fx$ with order below $c$. Then $|I|=|J|$, and
  there are constant vectors $u$ and $v$ with $u$ supported exactly on $I$,
  $Fu$ exactly on $J$, $v$ exactly on the complement of $I$ and $F^{-1}v$
  exactly on the complement of $J$. Haagerup's lemma is the extreme gap,
  without the size equality.
- **Two scalar conditions.** Suppose the boundary vector $u$ has a
  one-dimensional kernel in the sense of the paper's Section 3, all relevant
  coordinates are nonzero, and the normal equations have a nondegenerate
  critical point. Then a solution branch leaving $u$ in the first transverse
  direction $w$ exists exactly when one analytic function of one variable is
  constant. Its first two conditions are the explicit scalars $\kappa=0$ and,
  when $\kappa=0$, $\mu=0$.
- **Principal result (order 26).** For one support pair at $n=26$, there are
  nondegenerate boundary points with $\kappa\ne0$ (certified modulo 53) and at
  least two with $\kappa=0$ exactly. At the latter, an affine reflection makes
  $\kappa$ odd and fixes both unique Hensel lifts.

Not new: the equality of the valuation multisets, which we expect to follow
from Sattelberger and van der Veer's balance condition (we have not checked
that derivation in detail, and the paper gives a direct proof); the
second-term test in the form of Adrovic and Verschelde, of which $\kappa$ and
$\mu$ are explicit instances; the Fourier form of the equations (Haagerup);
the symmetries of the problem (Führ and Rzeszotnik); master functions of
hyperplane arrangements (Cohen, Denham, Falk and Varchenko); and the
implicit-function method. The note leaves open whether $\mu$ vanishes at the
symmetric boundary points, how many coefficient conditions can be needed,
whether these points lift to solution branches, and the cases of degenerate
points and larger kernels.

A bounded search, logged in [audit/PRIOR_WORK.md](audit/PRIOR_WORK.md), found
the general results above but none of the three items stated for cyclic
$n$-roots. This is not a novelty certificate.

| Statement | Status |
|---|---|
| Valuation balance (direct proof; related to a cited principle); every-gap complements | proved on paper |
| Kernel dimensions; scalar reduction to $\kappa$ and $\mu$ | proved on paper |
| Order-26 supports, rank 11 (minor checked modulo 10037), reflection identities, residual points | certified computation (exact arithmetic) |
| $\kappa\ne0$ at a boundary point | certified computation modulo 53, then Hensel lifting on paper |
| $\kappa=0$ exactly at at least two boundary points | proved on paper from the certified residual points |

## Earlier work

Uffe Haagerup's [*Cyclic p-roots of prime length p and related complex
Hadamard matrices*](https://arxiv.org/abs/0803.2629) (2008) gives the Fourier
form, the limiting-support lemma for every $n$, and finiteness with a count
for prime $n$. Weiqi Zhou's [*On number of cyclic n-roots and disjointness of
Fourier supports*](https://arxiv.org/abs/2608.06335v2) (2026) shows that the
disjoint-support pairs exist exactly at composite orders. Hartmut Führ and
Ziemowit Rzeszotnik's [*On biunimodular vectors for unitary
matrices*](https://doi.org/10.1016/j.laa.2015.06.019) (2015) states the
conjecture in its unimodular form, tabulates the known cases and lists the
symmetries. Danko Adrovic and Jan Verschelde's [*Polyhedral methods for space
curves exploiting symmetry applied to the cyclic n-roots
problem*](https://doi.org/10.1007/978-3-319-02297-0_2) (CASC 2013) develops
Puiseux expansions from initial forms. Anna-Laura Sattelberger and Robin van
der Veer's [*Maximum likelihood estimation from a tropical and a
Bernstein–Sato perspective*](https://doi.org/10.1093/imrn/rnac016) (2023)
proves the balance condition for critical curves at the boundary (Prop. 2.10).
Backelin (1989) proved infinitude when $n$ has a square factor, and Björck and
Saffari (1995) did so for the unimodular solutions; those two papers were not
read here.

## Evidence and artifacts

The general statements rest on the proofs in the paper. The order-26
certificates are checked in exact arithmetic over $\mathbb{Q}(\omega_{13})$,
modulo the prime 10037 for the rank, and over the finite fields with 53 and
169 elements; the checker does not compute Hensel lifts, $\mu$ or branches,
and finite checks do not prove the general statements.

- [BUILD.md](BUILD.md): dependencies and reproducible commands.
- [VERIFICATION.md](VERIFICATION.md): what the checker and build verify.
- [AUDIT_LEDGER.md](AUDIT_LEDGER.md): review scope and dispositions.
- [audit/EVIDENCE.md](audit/EVIDENCE.md): provenance and hashes of the imported draft.
- [audit/PRIOR_WORK.md](audit/PRIOR_WORK.md): searches, sources and their limits.
- [CORRECTIONS.md](CORRECTIONS.md): correction policy.
- [CITATION.cff](CITATION.cff): citation metadata.
- [MANIFEST.sha256](MANIFEST.sha256): hashes of all tracked files.

## Reproduction

From the repository root, with a Python virtual environment holding the
packages in `requirements.txt` (SymPy and mpmath) and pdfLaTeX:

```sh
make verify PYTHON=/path/to/venv/bin/python
make paper PYTHON=/path/to/venv/bin/python PDFLATEX=pdflatex
```

The checker refuses to run outside a virtual environment or under `python -O`,
and caps itself at 90 CPU seconds; it takes about 25 seconds. The paper build
runs twice and requires identical PDF bytes and warning-free logs. See
[BUILD.md](BUILD.md).

## AI assistance and responsibility

AI systems helped find the results, attack and check the proofs, verify the
certificates, search prior work and draft the text, under Jeff Kline's
direction. AI is not an author or a referee, AI review is not peer review, and
agreement between AI systems is not independent validation. Jeff Kline is
responsible for the claims and their presentation.

## Citation and status

Jeff Kline. *Valuation balance and local lifting for cyclic n-roots*. Draft of
version 0.1.0, October 26, 2026. Not yet released; see
[CITATION.cff](CITATION.cff).

## License

Original paper, source, prose and code: copyright 2026 Jeff Kline, GNU General
Public License version 3 only (`GPL-3.0-only`); see [LICENSE](LICENSE). Cited
works keep their authors' rights and are not bundled.
