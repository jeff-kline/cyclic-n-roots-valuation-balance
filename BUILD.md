# Build and verification

Draft of version 0.1.0, October 26, 2026. Not released; not peer reviewed.

The certificate checker needs Python 3 with SymPy 1.14.0 and mpmath 1.3.0
(`requirements.txt`). It refuses to run outside a virtual environment or with
`python -O` (assertions would be skipped), and sets a 90 CPU-second limit on
itself. The author runs it in `$HOME/.venvs/claude` (Python 3.9.6, SymPy
1.14.0, mpmath 1.3.0); a run takes about 24 CPU seconds.

The checked compiler is `/opt/local/bin/pdflatex`, pdfTeX 1.40.22
(TeX Live 2021/MacPorts). Required TeX packages: geometry, amsmath, amssymb,
amsthm and hyperref. Fonts are the installation's default Computer Modern.
No shell escape or external bibliography tool is used.

From the repository root:

```sh
make verify PYTHON="$HOME/.venvs/claude/bin/python"
make paper PYTHON="$HOME/.venvs/claude/bin/python" PDFLATEX=/opt/local/bin/pdflatex
```

`make verify` runs `scripts/check_certificates.py` and requires its output to
equal `evidence/certificate-result.json` byte for byte.

The builder (`scripts/build_paper.py`, adapted from the author's predecessor
repository) uses two clean temporary directories, running pdfLaTeX twice in
each. It fixes `SOURCE_DATE_EPOCH=1792886400`, `FORCE_SOURCE_DATE=1` and
`TZ=UTC`; this is a reproducibility parameter, not a publication date. It
rejects final warnings, undefined references and overfull or underfull boxes,
requires identical PDF bytes, then writes `paper/main.pdf` and ignored
`build/main.log`. Other TeX versions may change bytes or pagination.

For visual inspection with Poppler:

```sh
mkdir -p build/pages
pdftoppm -r 110 -png paper/main.pdf build/pages/page
```

The README rendering check uses the GitHub Markdown API, which renders
content and publishes nothing:

```sh
gh api markdown -f mode=gfm -f text="$(cat README.md)" > build/readme.html
$HOME/.venvs/claude/bin/python -I scripts/check_readme.py
```

It compares inline and fenced math in the source with the rendered math
elements and checks that local links exist.
