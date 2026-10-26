# Admission record

State: NOT YET ADMITTED. Release candidate for version 0.1.0. The repository
is public; no tag, archive or DOI exists yet. Admission, when granted, is a project release
decision under the
[public research standard](https://jeff-kline.github.io/posts/research-program/index.html),
not peer review or a correctness certificate.

| Gate | Status | Evidence / outstanding |
|---|---|---|
| P1 prior work and credit | PASS (bounded) | Scans of 2026-10-25 and 2026-10-26, the pre-freeze fast-follow scan and the pre-tag rescan of 2026-10-26 (audit/PRIOR_WORK.md, audit/reports/prior-art.md). Valuation theorem shown to be a consequence of Sattelberger–van der Veer Prop. 2.10 (audit/mu/bridge-source-*.md); no priority claimed. Citing lists screened for five anchors. Not read: primary texts of Backelin and Björck–Saffari. The rescan supports a tag on or before 2026-11-02. |
| A1 claim and artifact consistency | PASS | Cold two-stage proof examination, delta review, cross-provider cold check of the mu certificate (A1-mu), final end-to-end and consistency audit (A1-F); all findings dispositioned in AUDIT_LEDGER.md. No mathematical errors found. |
| R1 release and stewardship | PARTIAL | `make verify`, `make verify-mu` and `make paper` pass; README renders; license, citation, correction policy and manifest present. Repository public since 2026-10-26; Zenodo GitHub integration enabled. Pending authorization: tag, GitHub Release, archive, DOI, site listing. |

External actions and owners: repository creation and push, public visibility,
tag, GitHub Release, Zenodo and the site listing all belong to Jeff Kline and
need his explicit authorization. Planned archive route: Zenodo GitHub
integration, as for the predecessor.
