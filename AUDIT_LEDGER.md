# Audit ledger

Draft of version 0.1.0. Not released. Reviews are AI process evidence, not
peer review, and agreement between AI systems is not independent validation.

## Reviews

| ID | Date | Reviewer | Scope | Packet | Verdict |
|---|---|---|---|---|---|
| R0a | 2026-10-26 | fresh agent of the drafting (ChatGPT/Codex) session | whole draft manuscript, proof-aware, no blind stage | draft main.tex 20ae9081… | VERIFIED within scope; one missing hypothesis repaired (audit/draft-reviews/proof-review.md) |
| R0b | 2026-10-26 | fresh agent of the drafting session | checker and Section 4, one execution | checker 8ac5791f… | VERIFIED within scope; -O guard added (audit/draft-reviews/certificate-review.md) |
| A1-S1 | 2026-10-26 | Claude Opus, fresh context, different provider from the drafter | statements only | audit/packets/claims.md b621d0ef… | all NOT-BROKEN except Thm 3.2 UNRESOLVED (Q_eff undefined in packet); own exact PARI/GP checks of F1–F3 (audit/reports/proof-stage1.md) |
| A1-S2 | 2026-10-26 | same examiner, after sealing S1 | full manuscript, checker run, independent recomputation | main.tex 445cbd51… | all results VERIFIED except Thm 3.2 GAP D1 (branch ⇒ $Q_{\rm eff}'\equiv0$); D2–D9 documentation or sharpening (audit/reports/proof-stage2.md) |
| A1-Δ | 2026-10-26 | same examiner | root's changes after S2 | main.tex 367e531c… | Thm 3.2 and Prop 3.1 VERIFIED (D1, D3 closed; D2 withdrawn); one minor gap ($Rz\ne z$ projectively) and two documentation items (audit/reports/proof-delta.md) |
| P1 | 2026-10-26 | Claude Sonnet, fresh context | citing-paper screens, Adrovic–Verschelde and Sommars–Verschelde full text, formulations, fast-follow, bibliography | main.tex 445cbd51… | V, G, K PARTIAL; order-26 example SOURCE-NEGATIVE; SvdV Prop. 2.10 uncited (audit/reports/prior-art.md) |
| B1 | 2026-10-26 | ChatGPT/Codex session, with a same-provider (gpt-6-astra) two-stage examiner | bridge to SvdV Prop. 2.10 via the maximal wonderful model; mu certificate | audit/mu/ | bridge VERIFIED; mu VERIFIED (audit/mu/examiner-proof-audit.md) |
| A1-mu | 2026-10-26 | Claude Opus, fresh context, different provider from the certificate's author | Stage 1 statement only (independent PARI/GP leading term to pi^720), then Stage 2 code and proof audit | audit/packets/mu-cold-packet.md 33b589d7…; certify_mu.py 1abbcd45…; local_field.py 172a8e1e… | NOT-BROKEN, then VERIFIED given the kappa = 0 and R-fixed premises; independent value matches; no errors or gaps (audit/reports/mu-stage1.md, mu-stage2.md) |
| A1-F | 2026-10-26 | Claude Opus, fresh context | assembled manuscript end to end; all surfaces | main.tex 53b8b748… | PASS-WITH-FIXES, no mathematical errors, 19 findings (audit/reports/final-a1.md) |
| A1-C | 2026-10-26 | Claude Sonnet, fresh context | claims consistency across all surfaces | main.tex 367e531c…, README 2026-10-26 | PASS-WITH-FIXES, 21 findings (audit/reports/consistency.md) |

## Dispositions

| Finding | Label | Disposition |
|---|---|---|
| Draft: "finite field of definition" | error (wording) | now "number field of definition" with the embedding extending $\omega\mapsto e^{2\pi i/13}$ |
| P1: SvdV Prop. 2.10 uncited; V not source-negative | gap | cited; Thm 2.1 first presented as expected to follow from the residue principle, later (B1) as a consequence of it; no priority claimed; README "Not new" lists it |
| P1: conjecture forms, $n=14$, AV locator and hypothesis, FR symmetries, DOIs | gap / documentation / missing hypothesis | fixed in paper and README |
| S2 D1: branch ⇒ $Q_{\rm eff}'\equiv0$ | gap | branch defined in Thm 3.2; coefficient-recursion fill added; verified in A1-Δ |
| S2 D2: $Lw=0$ needs $Hz=0$ | — | not adopted; direct argument $DNw=\Lambda z$ written; examiner withdrew D2 |
| S2 D3, D7; Δ: $Rz\ne z$ | documentation / gap | branch definition and normal-system use stated; "points" justified, with proof that $Rz$ is a different projective point ($z_1\ne0$) |
| S2 D4, D5; Δ abstract | documentation | abstract and introduction hedged ("the sources we read"); abstract no longer calls Thm 2.1 a special case |
| S2 D6 symbol overloads | documentation | series renamed $\xi$; other overloads left (local and unambiguous in context) |
| S2 D8 checker modulus link | documentation | checker now asserts $\Phi_{13}(5992)\equiv0$ and $-5992^7\equiv5215$ modulo 10037; output unchanged |
| S2 D9 sharpenings | sharpening | not adopted in 0.1.0 |
| S2 D10: 14 $R$-fixed points over $\mathbb{C}$, $\mu$ numerically nonzero at all | sharpening (floating point) | not claimed; recorded as a reopening lead |
| A1-C F1–F21 | various | README rewritten (hypotheses, hedges, credit, Weiqi Zhou, "at least two"), CITATION.cff marks draft and lists limits, VERIFICATION page count fixed |
| Records | documentation | home and scratchpad paths in audit/reports replaced by ~ and <session scratchpad>; contents otherwise unchanged |
| B1 bridge | — | adopted: "is a consequence of", with De Concini–Procesi, Feichtner and Feichtner–Sturmfels cited for the maximal model; direct proof kept; no priority |
| B1 mu | — | adopted as part of Theorem 4.1 and new Section 4.4, after the A1-mu cross-provider check |
| A1-mu documentation (MU-PROOF wording on precision, reproduce path, C((t)) vs 13-adic, packet omits abs(I) = abs(J)) | documentation | MU-PROOF.md kept as an unchanged imported record; the paper's Section 4.4 states the transfer (mu is an algebraic number, nonzero under every embedding) and the paper states the equal-size hypothesis; BUILD.md gives the reproduce command |
| A1-mu sharpenings (fail-safe pivot rule; parity and square class of v(mu) are scale-invariant) | sharpening | not adopted |
| Privacy | documentation | certify_mu.py now records the Python version, not the interpreter path; home and scratchpad paths redacted in evidence/mu-certificate.imported.json, audit/mu/examiner-proof-audit.md and audit/reports/mu-stage2.md (original hashes in audit/imports.sha256) |
| Credit | documentation | joint statement naming ChatGPT/Codex and Claude in paper and README; EVIDENCE.md records where artifacts were first recorded, not authorship |

| A1-F (final end-to-end and consistency, 19 findings) | gap / documentation / sharpening | Section 1 now states the mu clause; paper and README both list three additions; AGENTS, VERIFICATION, BUILD, EVIDENCE, ledger and ADMISSION synced; abstract says composite square-free; "rigorous pi-adic computation"; "simple normal-crossings"; README defines t and pi and adds abs(I) = abs(J); Adrovic–Verschelde wording aligned. Not adopted: renaming the chart L and the Laurent t (local and unambiguous), print venues for Feichtner and Feichtner–Sturmfels (unverified) |
