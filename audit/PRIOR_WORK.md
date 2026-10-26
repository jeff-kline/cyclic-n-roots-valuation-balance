# Prior work, searches and their limits

Draft of version 0.1.0. Novelty is bounded to the searched corpus; a search
that failed or was rate-limited is recorded as NOT PERFORMED, never as "no
hits".

## Records

| Date | Record | Scope |
|---|---|---|
| 2026-10-25 | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/LITERATURE.md (SHA-256 083c4bd6…) | status of the conjecture, settled cases, Haagerup and Zhou statements; arXiv, GitHub, Zenodo, openai/math, OpenAlex |
| 2026-10-25 | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/NOVELTY.md (SHA-256 62106fc0…) | valuation, gap, coefficient and symmetry claims; arXiv, GitHub code, OpenAlex, Zenodo; Semantic Scholar NOT PERFORMED |
| 2026-10-26 | [reports/prior-art.md](reports/prior-art.md) | citing-paper screens, full texts of Adrovic–Verschelde and Sommars–Verschelde, master-function and likelihood formulations, fast-follow scan, bibliography |

## Findings that shape the paper

- **Valuation balance (Theorem 2.1).** Sattelberger and van der Veer
  (arXiv:2101.03570, IMRN 2023, Prop. 2.10) prove that when a curve of
  critical points of $\prod f_i^{\alpha_i}$ tends to boundary components
  $E_j$ of a simple-normal-crossings compactification, the weights satisfy
  $\sum_i \mathrm{ord}_{E_j}(f_i)\alpha_i=0$ for each such $E_j$. Root's
  inference (not checked line by line against a source): on the wonderful
  compactification of the arrangement of the $2n$ forms $x_i$ and $(Fx)_k$
  with weights $\pm1$, a Laurent solution meets the divisor of each flat
  $\lbrace \ell : \nu(\ell)>c\rbrace$, and the balance condition there is
  exactly the equality of the counts at threshold $c$. The derivation was then checked against the sources
  (audit/mu/bridge-source-audit.md and bridge-source-addendum.md: Prop. 2.10
  covers formal arcs and intersections of boundary divisors; the maximal
  projective wonderful model of De Concini–Procesi has a divisor for every
  nonempty proper flat, per Feichtner Thm. 2.5 and Secs. 4.1–4.2 and
  Feichtner–Sturmfels Prop. 3.6, Thm. 4.1; DP1 itself was not reopened). The
  paper now states that Theorem 2.1 is a consequence of the principle, gives
  the derivation and a direct proof, and claims no priority.
- **Next-coefficient conditions.** Adrovic and Verschelde (CASC 2013,
  Sec. 5.1) test for the second term of a Puiseux series from a regular
  isolated root of the initial system. The scalars $\kappa,\mu$ are explicit
  conditions of this kind at nondegenerate normal critical points.
- **Order-26 example.** SOURCE-NEGATIVE in the bounded scans.
- **Symmetries.** Führ and Rzeszotnik (LAA 2015, Sec. 10.3) list shifts,
  modulations, dilations, conjugation and the Fourier transform for
  unimodular vectors; scalars and the extension to complex solutions are
  the note's own routine additions.

## Not performed or not read

- Semantic Scholar citation lists for Haagerup and Zhou (HTTP 429 again on
  2026-10-26); OpenAlex lists were screened instead (27 and 0 citing works;
  data thin after 2024). The Führ–Rzeszotnik and Sattelberger–van der Veer
  lists were obtained in the pre-tag rescan below.
- arXiv postings dated 2026-10-24 to 2026-10-26 may be incomplete (API index
  lag).
- Primary texts of Björck–Saffari (1995) and Backelin (1989); their
  bibliographic data agree across four citing sources.
- Benedetto, Cordwell and Magsino, *CAZAC sequences and Haagerup's
  characterization of cyclic N-roots* (2019, doi 10.1007/978-3-030-32353-0_1),
  screened by title only; no abstract was available.

## Pre-freeze fast-follow scan, 2026-10-26

| Source | Query | Result |
|---|---|---|
| GitHub (control) | `gh search repos butson` | acprk/butson-hadamard-prime-once present (PASS) |
| GitHub repos | cyclic n-roots; bjorck saffari; biunimodular; cyclic roots fourier | 0, 0, 1 (brackxm/even-biunimodular-lean, known; last commit a Lean upgrade), 0 |
| GitHub code | `cyclic n-roots valuation`; `Bjorck Saffari` (separate terms) | word-match noise only; the openai/math hits are p-adic section-conjecture and lattice preprints |
| Zenodo | "cyclic n-roots"; biunimodular; "Bjorck-Saffari"; CAZAC | 1 (known), 1 (known), 0, 27 (none on topic) |
| arXiv API, newest first | "cyclic n-roots"; biunimodular; CAZAC; "complex Hadamard" AND circulant; "master function" AND "critical points" | newest on-topic item is Zhou (2026-08-06); nothing new on topic. The API's coverage of the last two days is not guaranteed. |

Raw outputs: build/scan/ (not tracked). Repeat within 7 days of any tag.

## Pre-tag fast-follow rescan, 2026-10-26

| Source | Query | Result |
|---|---|---|
| GitHub (controls) | `gh search repos planar-steiner-diversities`; `gh search code cyclic_laurent_system` | known repository and janverschelde/PHCpack found (PASS) |
| GitHub repos | cyclic n-roots; cyclic roots; Bjorck Saffari; biunimodular; cyclic p-roots; Haagerup cyclic | only this repository and brackxm/even-biunimodular-lean (known; prime order 11) |
| GitHub code | Puiseux, Bjorck Saffari, Haagerup, Sattelberger, valuation and biunimodular term sets (separate terms) | word-match noise; checked: dcposch/jc2 (plane Jacobian conjecture), a daily arXiv digest of 2026-10-26 (Haagerup–Izumi fusion categories), a copy of Zhou's TeX source |
| arXiv API, 2026-09-01 to 2026-10-26 | cyclic n-roots, cyclic roots, biunimodular, Saffari, cyclic p-roots, complex Hadamard with Fourier | one hit, not on topic (2609.19535, fermionic correlations); control query finds Zhou in August |
| Zenodo | "cyclic n-roots"; biunimodular; "Bjorck-Saffari"; "cyclic roots" | brackxm record (known), same, 0, 1 not on topic |
| Semantic Scholar, citing Führ–Rzeszotnik | 41 works | closest: conference signals (2610.09169), Fourier transform in cyclic groups (2406.11529), Komlós for complex discrepancy (2609.15071); none treats valuations or local lifting of cyclic n-roots |
| Semantic Scholar, citing Sattelberger–van der Veer | 10 works | likelihood degenerations, logarithmic discriminants and related; none concerns cyclic n-roots |
| Semantic Scholar, citing Haagerup and Zhou | | NOT PERFORMED (HTTP 429) |
| OpenAlex, citing Haagerup | 27 works | none treats valuations or local lifting; the 2019 CAZAC chapter is screened by title only |

Nothing found changes a claim. Valid for a tag on or before 2026-11-02.
