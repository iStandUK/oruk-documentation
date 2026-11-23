<#
  Builds the draft service classification as an iStandUK-branded website and print document, with the
  SKOS vocabularies (vocab/*.ttl and vocab/*.jsonld) and the page metadata, and as a PDF when
  DesignSystemPDF is available.

  Needs: Java 17+, DITA-OT 4.4.1+ with the org.istanduk.gov-uk plugin 1.4 or later installed (the SKOS
  switch arrived in 1.4), and DesignSystemPDF on the PATH (or pass -PdfCmd) for the PDF. See README.md.

  The SKOS files need the address the site is published at, because every concept's identifier is an
  address. The default is where the website is published (https://istanduk.github.io/oruk-documentation/
  classification/), so a local build gives the same identifiers as the published one, and the print document
  and PDF print that address as "available at". For a copy that should not claim an address, build with
  -SiteUrl "" (no SKOS, no page metadata, no address).
#>
param(
  [string]$Dita    = "$env:USERPROFILE\tools\dita-ot-4.4.1\bin\dita.bat",
  [string]$Map     = "service-classification.ditamap",
  [string]$Out     = "out\classification",
  [string]$SiteUrl = "https://istanduk.github.io/oruk-documentation/classification/",
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
  "-Dargs.css=istanduk-print.css",
  "-Dargs.cssroot=$root\theme",
  "-Dargs.copycss=yes",
  "-Dgovuk.css.assets=$root\theme\assets"
)
if ($SiteUrl) {
  # SKOS identifiers and the page metadata are addresses, so they need the site's address
  $dargs += @("-Dgovuk.skos=yes", "-Dgovuk.metadata=full", "-Dgovuk.site.url=$SiteUrl")
} else {
  Write-Host "No -SiteUrl: building without SKOS, page metadata or the 'available at' address."
}
if ($PdfCmd) { $dargs += "-Dgovuk.pdf.cmd=$PdfCmd" }
& $Dita @dargs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Built: $outDir\index.html, the print document, the vocab\ SKOS files and (if the generator was found) the PDF."
