# ORUK-Documentation

Plain-English documentation for the Open Referral UK (ORUK) service classification and search
work, written in DITA with SVG diagrams and published with the DITA Open Toolkit and the
[GOV.UK DITA plugin](https://github.com/iStandUK/govuk-dita-plugin) in iStandUK branding.

## What is here

| Path | Contents |
|---|---|
| `finding-services-by-meaning.ditamap` | Bookmap for the guide *Finding local services by what they mean* |
| `executive-summary.ditamap` | Bookmap for the executive summary: the aim, the problem and the dimensions, reusing the guide's topics |
| `keys.ditamap` | Key definitions for the glossary entries |
| `keys-summary.ditamap` | Glossary keys for the executive summary only |
| `topics/` | One topic per matter (concept and reference topics) |
| `glossary/` | One `glossentry` per term |
| `images/` | SVG diagrams, in the iStandUK palette |
| `theme/` | Publisher stylesheet and logo that brand the print document and PDF |
| `build.ps1`, `build.sh` | Build the website, print document and PDF into `out/` |
| `maintenance/REFRESHING.md` | How to bring the guide up to date as the work progresses |

The guide explains the work in [oruk-harvest](https://github.com/iStandUK/oruk-harvest),
[oruk-service-taxonomy](https://github.com/iStandUK/oruk-service-taxonomy),
[oruk-enrich](https://github.com/iStandUK/oruk-enrich) and
[oruk-semantic-search](https://github.com/iStandUK/oruk-semantic-search) for readers with no
background in language models, embeddings or vector databases. It was first written as
`docs/oruk-taxonomy-explained.md` in oruk-service-taxonomy; this repository is now its source.

## Building

You need:

- Java 17 or later
- DITA-OT 4.4.1 or later
- the `org.istanduk.gov-uk` plugin, version 1.4 or later, installed in that toolkit
- [DesignSystemPDF](https://github.com/iStandUK/govuk-dita-plugin/tree/dev/designsystempdf)
  on the `PATH`, for the PDF. Without it the build still writes the website and `print.html`.

To install the plugin from a local checkout of its `dev` branch (here `..\DITA-OT`):

```powershell
cd ..\DITA-OT\org.istanduk.gov-uk
Compress-Archive -Path * -DestinationPath $env:TEMP\govuk-plugin.zip -Force
& $env:USERPROFILE\tools\dita-ot-4.4.1\bin\dita.bat uninstall org.istanduk.gov-uk
& $env:USERPROFILE\tools\dita-ot-4.4.1\bin\dita.bat install $env:TEMP\govuk-plugin.zip
```

Then build:

```powershell
.\build.ps1
```

The output is in `out/`: `index.html` (website), `print.html` (print document) and
`finding-services-by-meaning.pdf`.

To build the executive summary instead, into its own folder:

```powershell
.\build.ps1 -Map executive-summary.ditamap -Out out\summary
```

## Branding

- `govuk.branding=istanduk` gives the website the iStandUK masthead, logo and colours.
- The plugin leaves the print document plain, so `theme/istanduk-print.css` is passed as
  `args.css`. It puts the logo on the cover at the guideline's A4 width (75 mm) and sets
  headings, links and table headers in brand blue (`#003888`).
- `theme/assets/brand/istanduk-logo.svg` is the outlined logo shipped with the plugin.
- No brand font is bundled. The PDF uses DesignSystemPDF's bundled Noto Sans unless you supply
  licensed TrueType fonts (for example Arial) with `-Dgovuk.pdf.fonts=<folder>`.

## Writing conventions

- One matter per topic. If a topic needs a second heading, it is probably two topics.
- Every topic has a `shortdesc`; it is the lead paragraph in print and is weighted in search.
- Plain English for a professional reader with no AI background: explain a term on first use
  and add it to `glossary/`.
- Diagrams are hand-written SVG, 900 units wide, using Arial and the palette in
  `theme/istanduk-print.css`. Use `orient="auto"` on arrow markers and `font-weight="bold"`;
  the PDF renderer does not accept `auto-start-reverse` or numeric weights such as `600`.
- Write quotation marks as characters (“ ”), not with the `q` element, which prints without
  marks in the PDF.
