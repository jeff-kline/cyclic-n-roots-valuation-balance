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
| A1-C | 2026-10-26 | Claude Sonnet, fresh context | claims consistency across all surfaces | main.tex 367e531c…, README 2026-10-26 | PASS-WITH-FIXES, 21 findings (audit/reports/consistency.md) |

## Dispositions

| Finding | Label | Disposition |
|---|---|---|
| Draft: "finite field of definition" | error (wording) | now "number field of definition" with the embedding extending $\omega\mapsto e^{2\pi i/13}$ |
| P1: SvdV Prop. 2.10 uncited; V not source-negative | gap | cited; Thm 2.1 presented as expected to follow from the residue principle, no priority claimed; README "Not new" lists it |
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

The manuscript changed after A1-Δ only by the A1-Δ items above; a final
end-to-end re-read of the assembled manuscript is still to be done before
freeze.
| Records | documentation | home and scratchpad paths in audit/reports replaced by ~ and <session scratchpad>; contents otherwise unchanged |
