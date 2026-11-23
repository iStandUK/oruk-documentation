<#
  Builds the draft service classification as an iStandUK-branded website and print document, with the
  SKOS vocabularies (vocab/*.ttl and vocab/*.jsonld) and the page metadata, and as a PDF when
  DesignSystemPDF is available.

  Needs: Java 17+, DITA-OT 4.4.1+ with the org.istanduk.gov-uk plugin 1.4 or later installed (the SKOS
  switch arrived in 1.4), and DesignSystemPDF on the PATH (or pass -PdfCmd) for the PDF. See README.md.

  The SKOS files need the address the site will be published at, because every concept's identifier is
  an address. Pass it with -SiteUrl. The default is a placeholder, so no real address is claimed.
#>
param(
  [string]$Dita    = "$env:USERPROFILE\tools\dita-ot-4.4.1\bin\dita.bat",
  [string]$Map     = "service-classification.ditamap",
  [string]$Out     = "out\classification",
  [string]$SiteUrl = "https://example.org/oruk/classification-draft/",
  [string]$PdfCmd  = ""
)
$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$outDir = if ([IO.Path]::IsPathRooted($Out)) { $Out } else { "$root\$Out" }
$dargs = @(
  "--input=$root\$Map",
  "--format=govuk",
  "--output=$outDir",
  "-Dgovuk.branding=istanduk",
  "-Dgovuk.print=yes",
  "-Dgovuk.skos=yes",
  "-Dgovuk.metadata=full",
  "-Dgovuk.site.url=$SiteUrl",
  "-Dargs.css=istanduk-print.css",
  "-Dargs.cssroot=$root\theme",
  "-Dargs.copycss=yes",
  "-Dgovuk.css.assets=$root\theme\assets"
)
if ($PdfCmd) { $dargs += "-Dgovuk.pdf.cmd=$PdfCmd" }
& $Dita @dargs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Built: $outDir\index.html, the print document, the vocab\ SKOS files and (if the generator was found) the PDF."
