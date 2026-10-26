"""Check the saved GitHub Markdown rendering, expressions and local links."""
import hashlib
from html import unescape
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import sys

assert sys.prefix != sys.base_prefix, "Use the explicitly selected virtual environment"
assert not sys.flags.optimize
root = Path(__file__).resolve().parents[1]
source = (root / "README.md").read_text()
rendered = (root / "build/readme.html").read_text()

class MathParser(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.kind = None
        self.buffer = []
        self.math = {"inline": [], "display": []}

    def handle_starttag(self, tag, attrs):
        if tag == "math-renderer":
            classes = dict(attrs).get("class", "").split()
            self.kind = "inline" if "js-inline-math" in classes else "display"
            assert "js-{}-math".format(self.kind) in classes
            self.buffer = []

    def handle_data(self, data):
        if self.kind:
            self.buffer.append(data)

    def handle_endtag(self, tag):
        if tag == "math-renderer":
            assert self.kind
            self.math[self.kind].append(unescape("".join(self.buffer)).strip("$\n "))
            self.kind = None

parser = MathParser()
parser.feed(rendered)
blocks = re.findall(r"^```math\n(.*?)^```$", source, flags=re.M | re.S)
without_fences = re.sub(r"^```[^\n]*\n.*?^```$", "", source, flags=re.M | re.S)
inlines = re.findall(r"(?<!\\)\$([^$\n]+)\$", without_fences)
assert len(inlines) * 2 == without_fences.count("$"), "Unpaired source dollar"
assert inlines == parser.math["inline"], (inlines, parser.math["inline"])
assert [x.strip() for x in blocks] == parser.math["display"]
assert not re.search(r"^[ \t]+```math", source, flags=re.M)
assert "\\operatorname" not in source
assert not any("\\{" in x for x in inlines)
assert not re.search(r"\$(?:th|st|nd|rd)\b|\"\$", without_fences)
for forbidden in ("ℓ", "₁", "≥", "≤", "Θ", "Ω"):
    assert forbidden not in source, ("use rendered math", forbidden)
links = re.findall(r"\]\(([^)]+)\)", source)
local = [url for url in links if not re.match(r"https?://", url)]
assert all((root / url.split("#")[0]).is_file() for url in local), local
headings = re.findall(r"^## (.+)$", source, flags=re.M)
assert headings[0] == "What is new" and "Earlier work" in headings
assert re.search(r"^\*\*Status: (draft of version 0\.1\.0|version 0\.1\.0 admitted)[ ,]", source, flags=re.M)
report = {"inline_math": len(inlines), "display_math": len(blocks),
          "matching_expressions": True, "existing_local_links": len(local),
          "readme_sha256": hashlib.sha256(source.encode()).hexdigest(),
          "rendered_html_sha256": hashlib.sha256(rendered.encode()).hexdigest()}
(root / "build/readme-check.json").write_text(json.dumps(report, indent=2)+"\n")
print("PASS README: {} inline + {} display math expressions render as math; "
      "all expressions match; {} local links exist".format(len(inlines), len(blocks), len(local)))
print("README SHA-256 " + report["readme_sha256"])
