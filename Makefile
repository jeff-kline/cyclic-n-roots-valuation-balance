PYTHON ?= python3
PDFLATEX ?= pdflatex
.PHONY: paper verify
paper:
	PDFLATEX="$(PDFLATEX)" "$(PYTHON)" -I scripts/build_paper.py
verify:
	mkdir -p build
	"$(PYTHON)" -I scripts/check_certificates.py > build/certificate-result.json
	cmp build/certificate-result.json evidence/certificate-result.json
	@echo "PASS: certificate output matches evidence/certificate-result.json"
