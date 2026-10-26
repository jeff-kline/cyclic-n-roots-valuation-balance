# Evidence and provenance

Draft of version 0.1.0, October 26, 2026.

## Imported draft

The paper, checker, certificate output and requirements were copied on
2026-10-26 from a local, non-Git draft prepared by a ChatGPT/Codex session
under Jeff Kline's direction:
`~/Documents/hm-ai/quarantine/bjorck-saffari-chatgpt-2026-10-25/paper-draft/`.
That workspace is read-only for this repository and was not modified.
`audit/imports.sha256` lists the SHA-256 of every imported file as it stood
in the source; the hashes of `paper/main.tex` (20ae9081…) and
`scripts/check_certificates.py` (8ac5791f…) equal those recorded by the
draft's own reviews. The draft's status records and reviews are kept
unchanged under `audit/draft-records/` and `audit/draft-reviews/` as process
evidence. Their "local draft" and "no release authorized" statements describe
the draft before this repository existed.

Two AI systems, ChatGPT/Codex and Claude, worked on the same program in
parallel under Jeff Kline's direction, and ideas passed between them through
him. The list below records where each artifact was first recorded; it does
not assign authorship of individual results.

Where the artifacts were first recorded:

- Valuation multiset lemma, every-gap complementarity, the local scalar
  reduction, the order-26 support, the split-prime witness and the residual
  data: the ChatGPT workstream, rounds 1–4.
- The observation that an affine reflection forces $\kappa=0$ at the two
  symmetric endpoints: a separate Claude workstream, with an independent
  two-stage examination by a different model. The paper's proof of it is the
  ChatGPT draft's reconstruction from the statement, now re-examined here.

Records of the Claude workstream (not copied; hashes on 2026-10-26):

| SHA-256 | Path |
|---|---|
| a74e4d829e1d343adec34c2f40872019c79e73cf9c3c00edcf84149d16ac7365 | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/D4-SYMMETRY.md |
| 550acde38586464ce25a3d75f9e42f80f0d7b4f728fa874a444821f002e8338d | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/reviews/D5-stage1.md |
| 2074f1ef896096bf1683fa1df914ec0cd436dbaff8110f00ad536ca5f7af37b9 | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/reviews/D5-stage2.md |
| 083c4bd62e9ba2f6e4245baed8bb50081b5069e8b8bc0fff5f3d4dbeb79d310a | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/LITERATURE.md |
| 62106fc0cf07ceecdf284f0a7ab52ef05d73491e3f364c434cfd4f9939c143f0 | ~/Documents/hm-ai/quarantine/bjorck-saffari-2026-10-25/NOVELTY.md |

All AI reviews are process evidence, not peer review, and agreement between
AI systems is not independent validation.

## Bridge and mu follow-up (imported 2026-10-26)

The bridge derivation (Sattelberger–van der Veer Prop. 2.10 on the maximal
wonderful model) and the mu certificate were prepared in the ChatGPT/Codex
workspace `~/Documents/hm-ai/quarantine/bjorck-saffari-chatgpt-2026-10-25/bridge-mu-2026-10-26/`
and examined there by a same-provider two-stage examiner. Copied unchanged:
`scripts/local_field.py`; `audit/packets/mu-cold-packet.md`; `audit/mu/*.md`
(proof, source audits, run record, examiner reports, regroup record);
`evidence/mu-certificate.imported.json` (the author's output). Adapted:
`scripts/certify_mu.py` (reads `scripts/check_certificates.py`, writes
`build/mu-certificate.json`, adds the script directory to `sys.path` for
`python -I`). Source hashes are in `audit/imports.sha256`. The root's rerun
(`evidence/mu-certificate.json`) agrees with the author's output in every
field except CPU time, Python version and checker hash. A cross-provider
cold check of the certificate is recorded in AUDIT_LEDGER.md. Home-directory
and scratchpad paths were later redacted in three copied records (see the
ledger); every other copied file is byte-identical to its source.
