DOC_DIR=./_build/default/_doc/_html/
KATEX_HEADER=./assets/katex-header.html

find "$DOC_DIR" -name "*.html" \
| while read fname; do
    echo "Procesing $fname ...";
    cat "$KATEX_HEADER" >> "$fname"
  done

echo "Done."
