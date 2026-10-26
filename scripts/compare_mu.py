"""Compare a fresh mu certificate with evidence/mu-certificate.json.

Run-dependent fields (CPU time, interpreter path, checker hash) are ignored.
"""
import json
from pathlib import Path
import sys

assert sys.prefix != sys.base_prefix and not sys.flags.optimize
root = Path(__file__).resolve().parents[1]
volatile = ("cpu_seconds", "python", "source_sha256")
fresh, saved = (json.loads((root / p).read_text()) for p in
                ("build/mu-certificate.json", "evidence/mu-certificate.json"))
for d in (fresh, saved):
    for k in volatile:
        d.pop(k)
assert fresh == saved, "mu certificate differs from evidence"
print("PASS: mu certificate matches evidence/mu-certificate.json "
      "(ignoring " + ", ".join(volatile) + ")")
