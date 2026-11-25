# Refreshing the guide

How to bring *Finding local services by what they mean* up to date when the ORUK work has
moved on. Written so that a person, or an AI assistant given this repository, can do the
refresh without the original conversation.

The guide was first written on 19 November 2026 from the sibling repositories as they stood
that day. Everything in it that can go stale is listed below with the place it came from.

## 1. When to refresh

Refresh when any of these happens:

- a phase in the research study's phasing table (section 14) completes, especially the first
  complete harvest, the first clustering run, or a taxonomy release
- a README "Status" line changes in any sibling repository
- a decision in the study's decision table (section 1) is added or reversed
- a feed is added, removed, or comes back (Cumbria, Hull, Pennine Lancashire)
- the guide is about to be shown to someone outside the project

## 2. Where the facts come from

All paths are relative to the folder that holds this repository (`..` from here).

| Source | What it settles |
|---|---|
| `oruk-service-taxonomy/docs/research-study.md` | Design, decisions, feed counts, dimensions, pipeline, search, phasing. The main source |
| `oruk-service-taxonomy/oruk-taxonomy-chain.md` | How the repositories connect; status table |
| `oruk-service-taxonomy/docs/toolchain.md` | Clustering tools and where they run |
| `oruk-service-taxonomy/README.md` and `releases/` (when it exists) | Whether a taxonomy version has been published |
| `oruk-harvest/README.md`, `docs/implementation-plan.md` | Harvest progress, feed list, record counts |
| `oruk-harvest/examples/records/` | Real example records (the North Lincolnshire example) |
| `oruk-enrich/README.md`, `benchmarks/README.md` | Reader speed and repeatability; assignment progress |
| `oruk-semantic-search/README.md` | Search progress |
| `oruk-dotnet/README.md`, `CHANGELOG.md` | Shared packages |

Pull each repository first, and note the commit you read, so the next refresh can diff from it:

```powershell
foreach ($r in 'oruk-harvest','oruk-service-taxonomy','oruk-enrich','oruk-semantic-search','oruk-dotnet') {
  git -C ..\$r pull --ff-only
  "{0}  {1}" -f $r, (git -C ..\$r log -1 --format='%h %cs %s')
}
```

Record those lines in section 9.

## 3. Fact map: what to check, and in which topic

Check every row. The "Guide says" column is the wording on 19 November 2026.

| Topic file (`topics/`) | Guide says | Check against |
|---|---|---|
| `the-problem` | About 18,900 listings; eight named directories | Study section 2; harvest manifest counts once a snapshot exists |
| `labels-disagree` | Three use local-government lists, one its own scheme, two older schemes, two none | Study section 2 table |
| `lists-describe-the-council` | North Lincolnshire teaching team tagged "Health and wellbeing strategy" and "Sports and physical activity" | `oruk-harvest/examples/records/openplace-northlincs.json` (`weak_signals`) |
| `untidy-text` | About 170 Neighbourhood Watch schemes; "-1" age placeholder | Study section 2.1 |
| `word-matching-fails` | 63 keyword rules; about one listing in seven unmatched | Study section 3.2 (about 14% fallback) |
| `dimension-list` | Seven dimensions | Study section 4 table |
| `for-and-only-for` | Eligibility, intended audience, exclusion | Study section 4.1 |
| `browsing-menus` | Two lenses planned | Study section 4.6; open question on a third, "who it is for" (taxonomy issue 3) |
| `language-model` | Runs on the project's own computer; evidence quotes required | Study sections 5.2 and 9 |
| `embedding` | "Around a thousand directions" | Study section 10.1 (1,024) and the embedding model chosen |
| `clustering` | UMAP and HDBSCAN | Study section 5.2; `toolchain.md` |
| `step-group` | One dance school appears 76 times in Open Sessions | Study section 5.5 |
| `step-draft` | Claude drafts names; used only for that and for testing | Decision D3 |
| `step-decide` | Four-question test; safety-critical categories always kept | Study section 5.6 |
| `frozen-versions` | Published as numbered versions, never regenerated | Study section 5.2, stage 5 |
| `applying-nightly` | Ten nearest categories; one main plus at most two others; escalation; "none of these" | Study section 7 |
| `label-records` | Version, model and instructions recorded | Study sections 7 and 9.4 |
| `search-safeguards` | Place, keywords, eligibility, "nothing close", crisis routing | Study section 10.3 |
| `search-users` | AI assistants, then professionals, then the public | Decision D4; study section 11.2 |
| `why-trust` | Needs catalogue is the quality test; hand-checked sample | Study section 8 |
| `repositories` | Six repositories and what each produces | Study section 12; each README |
| `status` | State of each part; "one to two nights" to process everything | Each README "Status" line; chain document section 4; enrich benchmarks |
| `in-brief` | Three aims; proof of concept, not a national service | Study section 1 |

Also check:

- `glossary/` for any term the guide now uses that has no entry
- `images/meaning-map.svg` and `images/dimensions.svg`: the examples are illustrative, not data.
  Once real clusters exist, consider replacing them with real category names
- `images/components.svg` and `images/two-jobs.svg` against the chain document's diagrams

## 4. What will most likely need rewriting

In rough order of how soon it will date:

1. **`status`**: rewrite the table from the README status lines. When a part is finished, say
   what it produced, in plain words.
2. **Tense.** The guide says "will", "planned" and "designed, not built" in places. As parts are
   built, change these to the present tense and say what was found.
3. **Real results.** After the first clustering run and taxonomy release, add topics for: how many
   categories there are, examples of real categories, what did not fit, and how the needs
   catalogue scored. These belong in new topics, not in the existing explanations.
4. **Numbers** in section 3 above, once a full harvest replaces the November 2026 probe.
5. **Design changes.** If the study changes a method, change the explaining topic and its diagram
   together.

Known gaps in the design on 19 November 2026 that the guide passes over. If they have been
settled, say how; if not, do not imply they are:

- the "what it helps with" dimension has no field in the extraction form, so it is not yet
  clear whether purpose is stated or inferred
- no written rule separates purpose from circumstance
- no rule set for how the dimensions combine (which are required, how many values each takes)
- the extraction step's accuracy has not been measured; the hand-checked sample and the needs
  catalogue had not been started

## 5. How to make the changes

1. Work on a branch.
2. Edit the topic that holds the fact. One matter per topic: if the update adds a second matter,
   add a new topic and reference it from `finding-services-by-meaning.ditamap`.
3. Keep each `shortdesc` true; it is the lead paragraph in print and is read on its own.
4. Keep the reader in mind: a literate professional with no knowledge of language models,
   embeddings or vector databases. No unexplained jargon, repository names only where the topic
   is about repositories, and no figures the reader cannot use.
5. Add or amend `glossary/` entries, and add a `keydef` to `keys.ditamap` for a new one.
6. Update the bookmap's `bookmeta`: add a `<revised modified="YYYY-MM-DD"/>` under `critdates`
   and change the `edition`.
7. Follow the SVG and quotation-mark conventions in `README.md`.

### The executive summary

`executive-summary.ditamap` reuses topics from the full guide, so edits to those topics change
both publications. It is meant to cover the aim, the problem and the dimensions only, and to
leave out the technology, the processes, search, the repositories and current status.

- Before adding a topic to it, read the topic for technology or process wording.
- If a shared topic gains such wording, split the topic so the summary can keep the plain part.
- A glossary term used by a summary topic needs a `keydef` in `keys-summary.ditamap` as well.
- Keep its `bookmeta` edition and dates in step with the full guide's.

## 6. Rebuild and check

```powershell
.\build.ps1
.\build.ps1 -Map executive-summary.ditamap -Out out\summary
```

Then check, in `out\` (and `out\summary\`):

- the build log has no `Error:` lines and no new `GOVK` or `DSPDF` warnings
- `finding-services-by-meaning.pdf`: cover shows the logo, edition and date; every diagram is
  drawn (a missing one means the PDF renderer rejected the SVG); no table or diagram runs off
  the page
- contents list matches the chapters you expect
- glossary lists every term
- `index.html` opens and the diagrams show

Read the changed pages as the intended reader would. If a sentence needs the research study to
make sense, rewrite it.

## 7. Known tool limits (re-test when the plugin is updated)

Found on 19 November 2026 with plugin `org.istanduk.gov-uk` 1.4.1 (dev) and DesignSystemPDF 0.1.1.
If a newer version fixes one, remove the workaround and delete the line here.

| Limit | Workaround in this repository |
|---|---|
| `govuk.branding=istanduk` does not brand the print document or PDF | `theme/istanduk-print.css` passed as `args.css` |
| Figure and table captions are all numbered 1 in the print document | None; captions carry descriptive titles |
| The `q` element prints without quotation marks in the PDF | Quotation marks are typed as characters |
| SVG `orient="auto-start-reverse"` stops a diagram being drawn in the PDF | `orient="auto"` |
| SVG `font-weight="600"` is drawn bold italic in the PDF | `font-weight="bold"` |
| No brand font is bundled; the PDF uses Noto Sans | Supply licensed fonts with `-Dgovuk.pdf.fonts=<folder>` |

## 8. Asking an AI assistant to do the refresh

Give it access to this repository and its siblings, and a prompt along these lines:

> Read `ORUK-Documentation/maintenance/REFRESHING.md` and follow it. Pull the sibling
> repositories, compare them with the commits recorded in section 9, and check every row of the
> fact map. List what has changed and what you propose to rewrite before editing. Keep one matter
> per topic and the plain-English register. Rebuild, look at the PDF pages, and report anything
> you could not verify. Then add a row to section 9.

Ask it to show the list of proposed changes first; the guide makes claims about work in
progress, and a person should confirm what is now true.

## 8a. The draft service classification

`service-classification.ditamap` and `classification/` are generated from a pilot run, not written by hand
(README, *The draft service classification*). They do not follow the fact map above. To refresh them:

1. Run the pipeline (harvest, corpus, extraction, embeddings, clustering, naming, needs test) in oruk-enrich and
   keep the run's folder (for 23 Nov: `oruk-data/pilot-2`).
2. Regenerate: `python ..\oruk-enrich\extract\export_dita.py --pilot-dir <run folder> --out . --date <date>`.
   It deletes and rewrites `classification/service-type`, `audience`, `eligibility`, `needs`, `review` and
   `schemes`, and the bookmap, keys and status page. It leaves `how-to-read.dita` and `machine-readable.dita`.
3. Rebuild with `build-classification.ps1` and check: no DITA-OT errors, the plugin's `check_links.py` and
   `check_metadata.py` clean, and the SKOS files present.
4. Read `read-this-first.dita` as built. Its numbers come from the run; its wording about what is *not* true
   (not reviewed, not de-duplicated, not a release) must stay true until a person has done those things. When
   they have, change the generator's wording, not the generated page.
5. Identifiers (`svc-044`) are cluster numbers of one run and are renumbered by every run. Nothing outside this
   repository may cite them until a release assigns stable ids.

## 9. Refresh log

Add a row at each refresh.

| Date | By | Sources read (repository and commit) | What changed |
|---|---|---|---|
| 2026-11-19 | Nicholas Oughtibridge with Claude | oruk-service-taxonomy `3961a39` (plus uncommitted `oruk-taxonomy-chain.md`); oruk-harvest, oruk-enrich, oruk-semantic-search, oruk-dotnet at their heads on this date (commits not recorded) | First edition, converted from `oruk-service-taxonomy/docs/oruk-taxonomy-explained.md` |
| 2026-11-24 | Nicholas Oughtibridge with Claude | Draft classification only (section 8a), regenerated from `oruk-data/pilot-5` with oruk-enrich `a31eb8a`; the guide's topics were not re-checked | Classification regenerated: 115 service-type, 76 audience and 29 eligibility categories from a six-directory pilot (Lancashire added; Open Sessions sampled as a domain feed); needs links remapped; the needs-based test has not been re-run, so its page says so; local build clean (no broken links, 0 metadata findings), PDF not built here (DesignSystemPDF not installed) |
| 2026-11-25 | Nicholas Oughtibridge with Claude | Draft classification only, regenerated from `oruk-data/pilot-5` with oruk-enrich `a31eb8a`, now with `pilot-5/needs-test-0.6B` | Needs-based test run on pilot-5 (33 needs, 5 places, 165 cases, 1,843 model-made judgements, 0 human-checked; Open Sessions left out because it is not a place) and its page and results added; against the placeholder bars 0 of 3 safety needs pass (search or browse) and 4 of 18 important needs pass search, 2 of 18 browse; local build clean (316 pages, no broken links, 0 metadata findings), PDF not built here |
