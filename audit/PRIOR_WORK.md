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
  exactly the equality of the counts at threshold $c$. A process-separated examiner judged this sketch sound but did
  not check it against the source. The paper says Theorem 2.1 is expected to
  follow from this residue principle, gives a direct proof, and claims no
  priority for it.
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

- Semantic Scholar citation lists for Haagerup, Zhou and Führ–Rzeszotnik
  (HTTP 429); OpenAlex lists were screened instead (27, 0 and 35 citing works;
  data thin after 2024).
- arXiv postings dated 2026-10-24 to 2026-10-26 (API index lag).
- Primary texts of Björck–Saffari (1995) and Backelin (1989); their
  bibliographic data agree across four citing sources.
- The fast-follow scan must be repeated within 7 days before any tag.
