#!/usr/bin/env bash
# Builds the guide as an iStandUK-branded website, print document and PDF.
# Needs: Java 17+, DITA-OT 4.4.1+ with org.istanduk.gov-uk installed, and
# designsystempdf on the PATH. See README.md.
set -euo pipefail
root="$(cd "$(dirname "$0")" && pwd)"
dita="${DITA:-dita}"
"$dita" --input="$root/finding-services-by-meaning.ditamap" --format=govuk --output="$root/${OUT:-out}" \
  -Dgovuk.branding=istanduk -Dgovuk.print=yes \
  -Dargs.css=istanduk-print.css -Dargs.cssroot="$root/theme" -Dargs.copycss=yes \
  -Dgovuk.css.assets="$root/theme/assets"
