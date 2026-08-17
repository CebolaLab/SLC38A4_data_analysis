# Liver cCRE files — ENCODE Registry of cCREs V4

Downloaded from SCREEN (https://screen.wenglab.org/downloads) on 30 July 2026.

## Contents

| File | What it is |
|---|---|
| `liver.all.cCREs.bed` | Full registry, classification aggregated over **all** liver biosamples |
| `ENCFF*.bed` (18 files) | **Deleted after subsetting** — re-downloadable from the URL above |
| `chr12q/` | The same files subset to chromosome 12q — use these |
| `manifest.tsv` | ENCFF → biosample mapping for the notebook (18 rows, completed and validated). |
| `liver_cCRE_biosample_files.xlsx` | The same table for reading/sharing, with per-file assay coverage, class counts and the calls at both variants |

## Important: these are not liver-filtered subsets

Every file contains **all 2,348,854 cCREs** of the Registry. The liver-specific call is in
**column 10**. Liver-active means *column 10 ≠ `Low-DNase`* — roughly 93–96% of rows are
`Low-DNase`. Treating file membership as the filter would pass every element.

**Column 11 is a data-completeness flag, not a biosample label**, and across the 18
biosamples there are **three** distinct assay-coverage types, which are not interchangeable:

| Type | n | Vocabulary in column 10 |
|---|---|---|
| **FULL** — DNase + H3K4me3 + H3K27ac + CTCF | 3 | PLS, pELS, dELS, CA-CTCF, CA-TF, CA-only, CA-H3K4me3, Low-DNase |
| **DNase only** | 10 | CA-only, Low-DNase |
| **Marks only** (no DNase) | 5 | High-H3K4me3, High-H3K27ac, High-CTCF, Unclassified |

**Define active with an explicit allowlist, not "anything except Low-DNase".** The five
marks-only files contain no `Low-DNase` at all, so a negated rule marks all 84,656 of their
elements active and the filter becomes vacuous.

- cCRE-active: `PLS`, `pELS`, `dELS`, `CA-CTCF`, `CA-TF`, `CA-only`, `CA-H3K4me3`
- High-mark (supporting evidence only, not a cCRE class): any class starting `High-`
- Not active: `Low-DNase`, `Unclassified`

The biosample is therefore recoverable only from the ENCFF accessions in the filename, via
https://www.encodeproject.org/files/<ENCFF>/ — hence `manifest.tsv`.

## The two aggregate files are not a max over the per-biosample files

Tested directly on 12q: **10–48% of elements called active in a per-biosample file are
`Low-DNase` in `liver.all`**, and 257 elements are active in `liver.all` but in no member
file. SCREEN's aggregate classification is computed from pooled signal, not by combining
member biosample classes.

Two consequences:

- A member biosample's call cannot be recovered from, and need not appear in, the aggregates.
- **`primary` vs `cell_line` cannot be inferred** from the aggregate. That grouping must come
  from the ENCODE portal, which is why `manifest.tsv` requires it.

A `liver.noccl` aggregate (liver biosamples excluding cancer cell lines) is also distributed by
SCREEN. It was **deleted from this folder and is not used**: it is computed from a smaller pool
of samples, many with only one assay, and is correspondingly less well powered than
`liver.all`.

## chr12q subsets

`SLC38A4` lies at chr12:~46.8 Mb (GRCh38), on the long arm. The subsets retain chr12 rows
with `end > 37,200,000` (GRCh38 chr12 centromere ends ≈ 37.2 Mb). The locus sits 9.6 Mb
distal to that boundary, so its precise value is not critical; it is recorded here for
reproducibility.

84,656 elements per file. 2.0 GB → 73 MB.

## Git

The full-genome files exceed GitHub's 100 MB limit and are excluded by `.gitignore`.
Commit only `chr12q/`, this README and `manifest.tsv`; the full files are reproducible from
the SCREEN URL above.
