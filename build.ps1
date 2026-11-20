<#
  Builds the guide as an iStandUK-branded website, print document and PDF.

  Needs: Java 17+, DITA-OT 4.4.1+ with the org.istanduk.gov-uk plugin installed,
  and DesignSystemPDF on the PATH (or pass -PdfCmd). See README.md.
#>
param(
  [string]$Dita   = "$env:USERPROFILE\tools\dita-ot-4.4.1\bin\dita.bat",
  [string]$Map    = "finding-services-by-meaning.ditamap",
  [string]$Out    = "out",
  [string]$PdfCmd = ""
)
$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$dargs = @(
  "--input=$root\$Map",
  "--format=govuk",
  "--output=$root\$Out",
  "-Dgovuk.branding=istanduk",
  "-Dgovuk.print=yes",
  "-Dargs.css=istanduk-print.css",
  "-Dargs.cssroot=$root\theme",
  "-Dargs.copycss=yes",
  "-Dgovuk.css.assets=$root\theme\assets"
)
if ($PdfCmd) { $dargs += "-Dgovuk.pdf.cmd=$PdfCmd" }
& $Dita @dargs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Built: $root\$Out\index.html and the PDF beside it."
