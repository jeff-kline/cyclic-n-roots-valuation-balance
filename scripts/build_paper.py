"""Build twice in clean directories and require byte-identical reading PDFs."""
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

root = Path(__file__).resolve().parents[1]
compiler = os.environ.get("PDFLATEX", "/opt/local/bin/pdflatex")
env = dict(os.environ, SOURCE_DATE_EPOCH="1792886400", FORCE_SOURCE_DATE="1", TZ="UTC")
outputs, logs = [], []
for build in range(2):
    with tempfile.TemporaryDirectory(prefix="cyclic-roots-build-") as temp:
        work = Path(temp)
        shutil.copyfile(root / "paper/main.tex", work / "main.tex")
        for pass_number in range(2):
            result = subprocess.run([compiler, "-no-shell-escape", "-interaction=nonstopmode",
                                     "-halt-on-error", "main.tex"], cwd=work, env=env,
                                    stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
            if result.returncode:
                raise SystemExit(result.stdout)
        log = (work / "main.log").read_text()
        bad = [line for line in log.splitlines() if any(x in line for x in
               ("Warning:", "Overfull", "Underfull", "Undefined control sequence"))]
        if bad:
            (root / "build").mkdir(exist_ok=True)
            (root / "build/failed-main.log").write_text(log)
            raise SystemExit("Final TeX log is not clean:\n" + "\n".join(bad))
        outputs.append((work / "main.pdf").read_bytes())
        logs.append(log)
if outputs[0] != outputs[1]:
    raise SystemExit("FAIL: two clean builds produced different PDF bytes")
(root / "paper/main.pdf").write_bytes(outputs[0])
(root / "build").mkdir(exist_ok=True)
(root / "build/main.log").write_text(logs[-1])
print("PASS: two clean two-pass builds are byte-identical; final logs have no warnings")
print("paper/main.pdf SHA-256 " + hashlib.sha256(outputs[0]).hexdigest())
