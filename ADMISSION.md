# Admission record

Current verdict: ADMITTED with stated qualifications; P1 is bounded.
Admission date: October 26, 2026 UTC. Version 0.1.0.
Tag: v0.1.0 at 8eb57658c870518de2e2985a843551af6991d4f7 (annotated tag object 0e99306).
Version DOI: [10.5281/zenodo.23669925](https://doi.org/10.5281/zenodo.23669925).
Concept DOI: [10.5281/zenodo.23669924](https://doi.org/10.5281/zenodo.23669924).
Record: <https://zenodo.org/records/23669925>.
PASS: public-site listing live (site commit 0463780) before this admitted
metadata was pushed.

Admission is a project release decision under the
[public research standard](https://jeff-kline.github.io/posts/research-program/index.html),
not peer review or a correctness certificate.

| Gate | Status | Evidence / outstanding |
|---|---|---|
| P1 prior work and credit | PASS (bounded) | Scans of 2026-10-25 and 2026-10-26, the pre-freeze fast-follow scan and the pre-tag rescan of 2026-10-26 (audit/PRIOR_WORK.md, audit/reports/prior-art.md). Valuation theorem shown to be a consequence of Sattelberger–van der Veer Prop. 2.10 (audit/mu/bridge-source-*.md); no priority claimed. Citing lists screened for five anchors. Not read: primary texts of Backelin and Björck–Saffari. Novelty is not established. |
| A1 claim and artifact consistency | PASS | Cold two-stage proof examination, delta review, cross-provider cold check of the mu certificate (A1-mu), final end-to-end and consistency audit (A1-F); all findings dispositioned in AUDIT_LEDGER.md. No mathematical errors found. |
| R1 release and stewardship | PASS | `make verify`, `make verify-mu` and `make paper` pass; README renders; license, citation, correction policy and manifest present. Annotated tag, GitHub Release, Zenodo archive with byte-identical file, resolving DOIs and site listing (below). |

## Archive verification

Route: Zenodo GitHub integration. The author enabled the repository in the
Zenodo portal on October 26, 2026. After the tag was pushed and before the
GitHub Release was created, the GitHub API zipball for v0.1.0 was downloaded
twice; both copies were 436,791 bytes with SHA-256
`d1e559072b8de8bd7589cfa7d7b36f4f8253ba34b8b8a9f04177663a3444422c`.
The release was published at 2026-10-26T15:49:48Z.

Zenodo record 23669925 is published and open: title "Valuation balance and
local lifting for cyclic n-roots", creator Kline, Jeff, version v0.1.0,
publication date 2026-10-26, license GPL-3.0, related identifier the v0.1.0
tree (isSupplementTo). Its file
`jeff-kline/cyclic-n-roots-valuation-balance-v0.1.0.zip` is 436,791 bytes,
provider checksum md5:c17ea8af505ee31475b37fac757dc9fb, and is byte-identical
(`cmp`) to the pinned zipball; local SHA-256 and MD5 match. Both DOIs resolve
to the record. All 71 files in the archive match the root MANIFEST.sha256,
and the archive holds no other files. The automated release audit reports
one failure, "archive contains 2 manifests": the second is the imported
draft's own manifest, kept unchanged as process evidence at
audit/draft-records/MANIFEST.sha256, and the check was done by hand instead.

A secondary deterministic `git archive --format=zip` of the tag, generated
twice, is 427,961 bytes with SHA-256
`0180ae7d7d1f1c0f4bb161466bd186405ef985b0ba342b09dd6fbdbab1f513e6`; it is a
different file from the provider zipball and is not claimed to equal it.

Residual: the Zenodo resource type was imported as Software. The author may
change it to Publication / Preprint in the portal; that is a metadata edit
and does not change the DOI or the archived file.

The tag keeps its candidate wording (NOT YET ADMITTED). Living metadata in
README.md, CITATION.cff, paper/main.tex, paper/main.pdf, CORRECTIONS.md and
the status lines of AGENTS.md, BUILD.md, NOTICE and VERIFICATION.md record the
admission.

External actions and owners: public pushes, tags, releases, Zenodo and the
site listing belong to Jeff Kline and need his explicit authorization. Never
move or rewrite the public tag v0.1.0.
