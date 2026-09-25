#!/usr/bin/env bash

set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
main_file="iclr2027_conference.tex"
job_name="${main_file%.tex}"

usage() {
    cat <<'EOF'
Usage: ./compile.sh [--clean|--rebuild]

  --clean    Remove generated LaTeX files without compiling.
  --rebuild  Clean generated files, then compile from scratch.
EOF
}

clean() {
    rm -f -- "$job_name".{aux,bbl,bcf,blg,fdb_latexmk,fls,idx,ilg,ind,lof,log,lot,nav,out,run.xml,snm,synctex.gz,toc,vrb,xdv,pdf}
}

mode="build"
case "${1:-}" in
    "")
        ;;
    --clean)
        mode="clean"
        ;;
    --rebuild)
        mode="rebuild"
        ;;
    -h|--help)
        usage
        exit 0
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac

if (($# > 1)); then
    usage >&2
    exit 2
fi

cd "$project_root"

if [[ ! -f "$main_file" ]]; then
    printf 'Main TeX file not found: %s\n' "$main_file" >&2
    exit 1
fi

if [[ "$mode" == "clean" || "$mode" == "rebuild" ]]; then
    clean
fi

if [[ "$mode" == "clean" ]]; then
    printf 'Clean complete.\n'
    exit 0
fi

if command -v latexmk >/dev/null 2>&1; then
    latexmk \
        -pdf \
        -interaction=nonstopmode \
        -file-line-error \
        -halt-on-error \
        -synctex=1 \
        "$main_file"
elif command -v pdflatex >/dev/null 2>&1 && command -v bibtex >/dev/null 2>&1; then
    latex_args=(
        -interaction=nonstopmode
        -file-line-error
        -halt-on-error
        -synctex=1
        "$main_file"
    )
    pdflatex "${latex_args[@]}"
    bibtex "$job_name"
    pdflatex "${latex_args[@]}"
    pdflatex "${latex_args[@]}"
else
    printf 'No usable LaTeX toolchain found. Install latexmk, or both pdflatex and bibtex.\n' >&2
    exit 1
fi

pdf_path="$project_root/$job_name.pdf"
if [[ ! -f "$pdf_path" ]]; then
    printf 'Compilation finished without producing %s.\n' "$pdf_path" >&2
    exit 1
fi

printf 'Build succeeded: %s (%s bytes)\n' "$pdf_path" "$(stat -c %s "$pdf_path")"
