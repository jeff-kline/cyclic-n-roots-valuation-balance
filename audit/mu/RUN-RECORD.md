# Run and review record

## Scope and unchanged inputs

Only this follow-up directory is writable for the scoped work. The shared
release repository was clean at commit 75dcdccbd078e7bccc92bb80c675d01b55a52596
at entry and remained clean at the 12:38 UTC check. No file there was edited.
Earlier own sealed work is input only. No sibling Claude quarantine was read.

The author computation reads the construction prefix of the earlier exact
checker, SHA-256
8ac5791fd5869671ced0ae6b3aa6033a68bb9a73f8237d947c4ee9615c7245a1.

## Author computations

1. Setup run: stopped after exact reconstruction, before the local calculation,
   because the imported checker had lowered the hard CPU limit to 95 seconds
   and the enclosing program tried to raise it. No certificate was produced.
   CPU charged conservatively at the 95-second hard ceiling.
2. In-memory import correction: remove only the earlier resource-limit statement
   from the source string; do not edit the sealed checker. Combined run has a
   hard 180-second CPU allocation, with termination grace to 185 seconds.
3. Successful certificate: 41.554896 CPU seconds. Both discs, both Newton solves,
   both 24-dimensional normal solves, tracked precision through every operation.
   Result: v_pi(mu)=-14; normalized residues 11+8t and 11-8t.

Current author CPU charge <=136.555 seconds. The 900-second aggregate ceiling
includes the independent examiner, with separately recorded use below.

## Source bridge

Fresh source/substitution reviewer checked the two primary sources and supplied
the full derivation in bridge-source-audit.md. Verdict VERIFIED, under the
routine-source-consequence mode of the cold-examiner skill.
Report SHA-256:
08521957d91193bcc8be22db6b68295d0fded53397af4dde2b2e1563773f0abe.

The coordinator checked the logarithmic critical-point substitution,
projectivization using total weight zero, the upper-threshold flat condition,
the primitive divisor residues, and cumulative-count conclusion. The alternate
coefficient-truncation proof was checked as an algebraic cross-check; no draft
proof was replaced. This is not a new prior-art priority claim.

## Mu cold review

Model requested: gpt-6-astra, xhigh, fresh context, no inherited conversation.
Packet: mu-cold-packet.md. The initial stage was instructed not to read the
author code, output, or proof. Initial allocation: 10 minutes wall, 180 CPU
seconds. A separate proof audit follows only after the INITIAL report is
sealed and its hash recorded here.

INITIAL report sealed before exposure:
`examiner-initial.md`, SHA-256
90b584673c4fa8a2e7f5042eb08e0735a691b9a080d5dd53f1f8241910ba6cba.
Verdict NOT-BROKEN, not a proof verdict. The independent PARI implementation
found the same candidate valuation and residue. Its interval variants lost
precision in nested-polmod inversions and are explicitly rejected as proofs.
Reviewer reported four substantive runs, a negligible syntax setup failure,
and less than 32 CPU seconds. Current aggregate charge is therefore <168.6
CPU seconds, with six substantive runs used. Two runs remain within the
original eight-run ceiling. Exact-root transport is the load-bearing remaining
proof-audit obligation. Author proof/code/output were released only after this
hash was checked and recorded.

Procedural precision-cap deviation: the initial packet did not pass on the
author charter's pi^240 representation ceiling. The independent PARI probes
used 100 and 140 digits of 13-adic coefficient precision to compensate for
its nested-polmod inversion losses; the successful critical approximation
itself reached only pi^128. Thus the reviewer exceeded that representation
ceiling, although its CPU, wall time, fixed instances, and run count stayed
within their bounds. This is recorded as a deviation, not silently treated as
compliance. No enlargement to new points or higher obstruction coefficients
occurred. The accepted author certificate uses pi^240 throughout.

Proof-audit allocation: 12 minutes wall, 180 CPU seconds, at most two additional
substantive runs. Final outcome: VERIFIED, for the exact finite two-lift claim
conditional on the packet's previously certified premises. Report:
`examiner-proof-audit.md`, SHA-256
f3f9cd3f35c85162074aca4fca1dcad10414ca8a9a3cabfe1399bc88a1c72210.
The coordinator read the report and checked its hashes and inference chain.

The replay matched every certificate field without altering the author JSON.
Fifteen load-bearing ball/solve controls passed against exact PARI arithmetic;
uncertain-zero inversion and deliberate coefficient corruption were rejected.
An optional control of the unused conjugate helper failed because its nested
PARI substitution reference was invalid. That test is not counted as passed;
its error log is retained. The helper is unused in the certificate, which
recomputes both endpoints. No additional runs were made after the cap.

Stage 2 used under 43 CPU seconds; combined examiner use under 75 seconds.
Together with the conservative author charge, aggregate CPU is under 212
seconds. Eight substantive runs were used. Completed within the 60-minute
wall allocation. All 147 earlier sealed files were checked unchanged; the
shared release checkout was still clean at the original commit on the final
12:52 UTC check. No release or manuscript mutation was made.

Review provenance identifies the selected model; fresh context and a different
model do not constitute human peer review or a correctness guarantee.
