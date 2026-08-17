# SLC38A4 in alcoholic hepatitis — analysis code

Analysis notebooks and data supporting the manuscript submitted to the *Journal of
Hepatology* (Cebola lab, Imperial College London, in collaboration with Mark Thursz).
<!-- TODO once available: paper title, author list, DOI/preprint link -->

## Repository structure

```
.
├── *.ipynb                  Analysis notebooks, one (or a small group) per figure/table
├── *.csv / *.xlsx / *.bed   Intermediate and result data used by the notebooks
├── *.pdf                     Rendered figure panels (PDF only)
├── liver_cCREs/              ENCODE Registry of cCREs (liver) — see its own README
├── luciferase_data/           Luciferase assay metadata
└── requirements.txt
```

Data and figure files sit next to the notebook that produces them (flat, not in
subfolders) so each notebook's inputs/outputs are easy to find by filename.

## Notebook → figure/table mapping

One notebook per dataset/analysis (not strictly one per panel) — panels that share a differential-expression
run or an experiment are grouped into a single notebook. Figure and table numbers below were checked
directly against the current main-figure artwork (`../02_Main_figures/source/Figure N.ai`) and the live
Supplementary Information as of 2026-08-14. `../01_Manuscript/SI_figure_renumbering_crosswalk.md`,
`../01_Manuscript/Figure_Table_renumbering_crosswalk.md` and `../01_Manuscript/Table_numbering_audit.md`
are historical working documents from earlier renumbering passes — superseded by this table, kept for
the record only.

| Notebook | Produces |
|---|---|
| `Fig1_SLC_dysregulation_InTEAM.ipynb` | Fig. 1B (violin), Fig. 1C (heatmap), Fig. 1D (trajectory), Fig. S1A–C (correlation/scatter/trajectory), Fig. S2A (InTEAM per-sample SLC38A4 expression), Table S2 (all 456 detected SLC genes, full DE results) |
| `Fig1_ISAIAH_validation.ipynb` | Fig. 1E (MELD correlation, combined timepoints, plus an rmcorr repeated-measures sensitivity check), Fig. 1F (MELD change by direction), Fig. S3A (MELD correlation by timepoint), Fig. S3B,C (paired longitudinal detail), plus QC/treatment-group panels (not separately numbered) |
| `Fig2C_SLC38A4_cell_type_expression_analysis.ipynb` | Fig. 2C — SLC38A4 cell-type expression |
| `Fig2D_SLC38A4_SAH_mediators_analysis.ipynb` | Fig. 2D — SAH mediators |
| `Fig3A_SLC38A4_KO_confirmation_analysis.ipynb` | Fig. 3A — KO confirmation (RT-qPCR) + Fig. S6C — TaqMan validation (guide-RNA region) |
| `Fig3BC_S7_KO_RNAseq_overview.ipynb` | Fig. 3B (PCA), Fig. 3C (volcano), Fig. S7 (cross-clone concordance), Table S5 (full KO1+KO2-vs-WT differential expression, combined + per clone) |
| `Fig3_KO_RNAseq_metabolism.ipynb` | Fig. 3D (pathway enrichment, `Fig3D_KO_pathway_enrichment.pdf` — automated cross-method deduplication + pre-registered category filter; `_v1_manual.pdf` superseded prior version, kept for the record), Fig. 3E (urea-cycle pathway schematic, `Fig3E_urea_cycle_diagram.pdf`, genes coloured by KO-vs-WT log2FC), Fig. S8A (leading-edge bar + expression heatmap, two panels), Table S6 (full cross-method pathway-enrichment results), plus several unnumbered reviewer-facing exports (`SuppFig_all_pathway_enrichment_overview.pdf`, `TableSx_full_pathway_enrichment_ALL_terms.xlsx` — every tested term, no top-N cutoff; user is resolving this table's naming separately), `FigS_urea_cycle_GSEA_classic.pdf`, `FigS_urea_cycle_KO_barchart_reviewer.pdf`, `FigS_urea_cycle_KO_vs_SAH_reviewer.pdf`. Re-derives enrichment from Enrichr/MSigDB live by default (`REFRESH_FROM_INTERNET = True`). **Actively being edited as of 2026-08-14** (recent `_backup_TableS6_*` snapshots in this folder) — check freshness before relying on exact figures. See `SLC38A4_KO_GSEA_clone_robustness_check.ipynb` below for Fig. S8B, the per-clone robustness companion to S8A/Fig. 3D. |
| `SLC38A4_KO_GSEA_clone_robustness_check.ipynb` | Fig. S8B (`Fig_S8B_clone_robustness_forest.pdf`) — per-clone (KO1 vs WT, KO2 vs WT) robustness forest plot for Fig. 3D's KEGG pathway-enrichment terms, plus the SAH-up/SAH-down signature (Fig. 4E) and the one developmental signature (Fetal hepatocyte) that held up as clone-concordant. Confirmed not duplicated by any other notebook: the main Fig. 3/4 notebooks only run the pooled/combined KO analysis, this is the only place the per-clone sensitivity check exists. Its "per-sample cross-check" cell reads `DevSig_module_scores.csv` (from `SLC38A4_KO_developmental_signature_analysis.ipynb`, below) purely for internal QC reference — this cell used to claim it was "the Fig. S10E panel B analysis," which was wrong on two counts (there is no Fig. S10E — Fig. S10 has panels A-D only — and this per-sample check isn't itself a published panel at all); fixed 2026-08-14, along with a stale "Fig. 4F" left over from an earlier renumbering pass. The actual publication-relevant developmental-signature result (per SI Methods §5, "Developmental-signature concordance analysis") is Fig. S8B. |
| `SLC38A4_KO_developmental_signature_analysis.ipynb` (added 2026-08-14, brought in from `05_Data/RNAseq/`) | "Does SLC38A4 loss drive fetal reprogramming, or loss of mature hepatocyte identity?" — the original exploratory analysis behind the Fig. S8B developmental-signature GSEA (combined KO1+KO2 contrast only; the per-clone breakdown that completes Fig. S8B is in `SLC38A4_KO_GSEA_clone_robustness_check.ipynb` above). Three unnumbered internal panels (stage-marker gradient, GSEA NES bar, per-sample module-score boxplots — none independently cited in the manuscript) plus an auto-generated interpretation. Repointed from its original pre-mincount10 input files (`SLC38A4_KO_RNA-seq/limma_KO_vs_WT_combined.csv` etc., 10,597 genes) to the current `Fig3C_limma_KO_vs_WT_combined_mincount10.csv`/`Fig3B_voom_logCPM_mincount10.csv` (14,113 genes) already used by every other notebook here, and re-executed — pooled-contrast NES/FDR values and the qualitative per-sample verdicts (Hepatoblast and Adult-hepatocyte discordant between clones, Fetal hepatocyte concordant) are unchanged from the stale version, confirming the switch didn't alter any reported conclusion. Also regenerated `DevSig_module_scores.csv` (the file `SLC38A4_KO_GSEA_clone_robustness_check.ipynb` reads) from the current data, replacing the version that had been silently computed from the old, superseded DE result. Reference files (`liver_developmental_signatures.gmt`, `PMC7617064_liver_atlas_Fig1_hepatocyte_DEG.xlsx`) added under `reference/`. |
| `Fig3F_Fig3IJ_ureagenesis_CYP.ipynb` | Fig. 3F (urea secretion following NH4Cl challenge), Fig. 3I (RT-qPCR of CYP3A4 + bile-acid pathway: CYP7A1, ABCB11/BSEP, ABCC2/MRP2), Fig. 3J (CYP3A4 drug-metabolising activity, P450-Glo). Replaces the three former single-panel notebooks (now archived — see below); all three statistics are one-tailed/two-tailed Welch's t-tests, WT vs each KO clone. |
| `Fig3H_transporter_concordance.ipynb` | Fig. 3H — System A/N amino-acid transporter concordance, SLC38A4-KO vs SAH liver. Builds its ReSOLUTE-annotated SLC differential-expression table transparently in the open from `ReSOLUTE_SLC_ 464_genes_annotation.xlsx`, `Fig3C_limma_KO_vs_WT_combined_mincount10.csv` and `InTEAM_AH_vs_normal_DESeq2.csv` (as `slc_de`) rather than reading a pre-merged file — no separate supplementary table is generated |
| `Fig3G_S9AB_metabolomics.ipynb` | SLC38A4-overexpression metabolomics (ReSOLUTE, HEK293) — one dataset/enrichment run: Fig. 3G (System A substrates + urea-cycle intermediates, main figure), Fig. S9A (full 186-metabolite volcano plot), Fig. S9B (MetaboAnalyst pathway enrichment), Fig. S9C (KO transcripts vs OE metabolites, loss-/gain-of-function mirror), Table S7 (full ReSOLUTE targeted metabolomics results), Table S8 (full MetaboAnalyst pathway enrichment, all 81 pathways) |
| `Fig4_KO_RNAseq_dedifferentiation.ipynb` | Fig. 4B (foetal HNF4A/P2 isoform fraction, main panel narrow bar + P1/P2-separate supplementary companion), Fig. S10A (identity/dedifferentiation marker RT-qPCR), Fig. S10D (CCK-8 proliferation assay — not a main-figure panel), Fig. 4D (cell-cycle/checkpoint gene-signature panel), Fig. 4E (pre-ranked GSEA, SAH-up/SAH-down vs KO transcriptome). Also contains an exploratory "candidate upstream pathways for dedifferentiation" panel not yet assigned a Supp. Fig. number (`SuppFig_dedifferentiation_pathway_candidates.pdf`, flagged in-notebook for the next SI renumbering pass). Fig. 4A (KO validation IF images) and Fig. 4C (HNF4A P1/P2 RNA-seq coverage tracks) are not produced by any notebook here — likely composed directly as images/browser tracks, not a code gap. |
| `Fig5_LD_expansion_cCRE_filtering.ipynb` | Table S13 (CAGE evidence for SLC38A4 transcript isoforms), Table S14 (per-variant LD + cCRE evidence prioritising rs4994910), Table S15 (per-dataset/biosample chromatin evidence at rs4994910). Also produces an unnumbered CAGE locus plot (`SuppFig_SLC38A4_CAGE_locus_scan.pdf`). Does not produce Fig. 5A itself (the genome-browser locus figure) — that appears to be composed separately from this notebook's evidence tables. |
| `Fig5B_luciferase_mixed_model.ipynb` | Fig. 5B — luciferase reporter assay, linear mixed model |
| `Table1_variant_coordinate_liftover.ipynb` | Table 1 — GRCh37→GRCh38 variant liftover |

`SuppFig_urea_cycle_diagram.ipynb` (2026-08-14) → deleted. Confirmed to be an older, simpler draft of
the exact same urea-cycle-schematic-by-log2FC diagram that `Fig3_KO_RNAseq_metabolism.ipynb`'s Fig. 3E
cell now builds (same metabolite layout, same enzyme set, same colour-by-log2FC approach) — the main
notebook's version is the current, more polished one actually embedded in `Figure 3.ai`. No manuscript,
SI, or README content outside this repo referenced the old file.

Fig. 5C (transcription-factor motif-disruption panel, MotifBreakR) has a finished data file
(`Table_S16_TF_motif_disruption.xlsx`, generated 2026-08-14) but no notebook/script producing it in
this repo — reproducibility gap, being resolved separately (not by this repo's maintainer).
Fig. 2B (Aizarani et al. scRNA-seq/Seurat pipeline) has the same kind of gap: fully described in SI
Methods, no notebook. Both are tracked outside this README.

### `_archive/` — superseded per-panel notebooks

Kept for provenance only; do not edit or cite — use the consolidated notebooks above instead:

- `Fig3BC_RNAseq_PCA_volcano.ipynb` → merged into `Fig3BC_S7_KO_RNAseq_overview.ipynb`
- `Fig3D_KO_pathway_enrichment.ipynb`, `Fig3E_urea_cycle_genes.ipynb` → merged into `Fig3_KO_RNAseq_metabolism.ipynb`
- `Fig4B_HNF4A_isoform_usage.ipynb`, `Fig4D_proliferation_genes.ipynb`, `Fig4E_GSEA_KO_vs_SAH.ipynb` → merged into `Fig4_KO_RNAseq_dedifferentiation.ipynb`
- `TableSx_ReSOLUTE_SLC_DE.ipynb` (2026-08-14) → retired. Its formatted-export role is gone entirely (no supplementary table is generated for this data); the dataframe it used to build is instead assembled transparently, in the open, inside `Fig3H_transporter_concordance.ipynb` (as `slc_de`), from the same raw annotation/DE files rather than from a pre-merged intermediate CSV
- **Fig 3E–J renumbering (2026-08-05)**, to match the manuscript text's citation order: `Fig3H_transporter_concordance.ipynb` content (formerly embedded in `Fig3_KO_RNAseq_metabolism.ipynb`, mislabelled "Fig 3H") → moved out to its own notebook. `Fig3F_functional_markers.ipynb` (RT-qPCR, internally mislabelled "Fig 3F") → renamed `Fig3G_hepatocyte_function_qPCR.ipynb` (archived below). `Fig3G_functional_assays.ipynb` (internally labelled "Fig 3G", but bundled two separate functional readouts) → split into `Fig3F_ureagenesis_assay.ipynb` and `Fig3H_CYP3A4_activity_assay.ipynb` (both later superseded, see next bullet). `Fig3I_metabolomics.ipynb` → renamed, eventually becoming today's `Fig3G_S9AB_metabolomics.ipynb`.
- **Fig 3F/3G/3H merge (2026-08-13/14)**: `Fig3G_hepatocyte_function_qPCR.ipynb` and `Fig3H_CYP3A4_activity_assay.ipynb` (both in `_archive/`) plus `Fig3F_ureagenesis_assay.ipynb` (deleted outright rather than archived — only its orphaned output files, `Fig3F_ureagenesis_assay.pdf`/`_data.csv`, remain at top level) → merged into `Fig3F_Fig3IJ_ureagenesis_CYP.ipynb`, and relettered to match the current, final Fig. 3 artwork: the RT-qPCR panel is now Fig. 3I and the CYP3A4-activity panel is now Fig. 3J (Fig. 3G was reassigned to the ReSOLUTE/HEK293 metabolomics panel; Fig. 3H to the transporter-concordance panel — see `Fig3G_S9AB_metabolomics.ipynb` and `Fig3H_transporter_concordance.ipynb` above).
- `SecondBatch_new_panels_analysis.ipynb` is **deliberately not in this repo** — corrected 2026-08-14, twice.
  First correction: an earlier finding that it had been "deleted without archiving" was wrong; it lives at
  `../05_Data/Functional_assays/second batch of data/SecondBatch_new_panels_analysis.ipynb`, alongside the raw
  "Nelisa" qPCR summary spreadsheet it reads directly by row/column position. Second correction: a *different*
  parallel session had, earlier the same day, explicitly decided this notebook should stay *in* this repo as
  the sole reproducibility record for how the Fig. 2C/3F/3I/3J CSVs were extracted from that raw file — but the
  user, asked directly, decided to keep it in `05_Data/` instead (its path was fixed in place so it still runs
  from there). **Consequence: this repo does not contain the code that produced `Fig2C_SLC38A4_cell_type_expression.csv`,
  `Fig3F_ureagenesis_assay_data.csv`, `Fig3I_CYP_ABC_expression_data.csv`, or `Fig3J_CYP3A4_activity_assay_data.csv`
  from the raw qPCR spreadsheet — a known, accepted gap of the same kind as the Fig. 2B/Fig. 5C notebook gaps
  below, not something to "fix" unilaterally.** It covers three datasets, all later rebuilt as clean, dedicated
  notebooks reading tidy CSVs instead: (1) SLC38A4 across 5 cell models → became `Fig2C_...` (4 cell types; the
  5th, iPSC-derived hepatocytes, was dropped — see below); (2) a 7-gene qPCR panel (CYP3A4, CYP7A1, BSEP, MRP2,
  ALB, F7, Transferrin) → became Fig. 3I's 4-gene panel (ALB/F7/Transferrin dropped); (3) CYP3A4 activity + urea
  secretion → became Fig. 3F/3J. The two data-integrity caveats it raised are **resolved by author decision
  (2026-08-14, documented in the notebook itself)**, not open questions: iPSC-derived hepatocyte values being
  identical to HepG2's in the source file is an old Nelisa labelling error — iPSC data is excluded from the
  paper, consistent with its absence from the final Fig. 2C; and the TNFα mediator condition (the only new
  condition beyond what `Fig2D_SLC38A4_SAH_mediators_analysis.ipynb` already covers) is out of scope for this
  paper and will not be added to Fig. 2D.

## Data folders

- **`liver_cCREs/`** — ENCODE Registry of candidate cis-regulatory elements,
  liver biosamples. Full documentation, caveats, and re-download instructions
  are in `liver_cCREs/README.md`.
- **`luciferase_data/`** — plate/construct metadata for the luciferase reporter assay.

## Reproducing an analysis

```bash
pip install -r requirements.txt
jupyter notebook
```

Each notebook is self-contained: it reads its input file(s) from this folder and
writes its output CSV/PDF back into it. Refer to the accompanying `.pdf`/`.csv`
for the version used in the manuscript, or re-run a notebook to regenerate its
results.

## Working in this repo

This folder is both the working directory (where figures for the paper get
generated/updated) and the git repository — there's no separate "clean" copy to
keep in sync. Two things make that safe:

- **`.gitignore`** already excludes scratch/debug output (`_archive/`, `_run_log/`,
  `_gsea_tmp/`, `_clone_relabel_backup/`, `.ipynb_checkpoints/`), so working
  messily doesn't leak into the repo.
- **`nbstripout`** keeps notebook outputs out of git history without touching your
  local files — your notebooks keep their plots/output on disk when you run them
  in Jupyter/VS Code as normal; only what git records is stripped of outputs.
  One-time setup after cloning:

  ```bash
  pip install nbstripout
  nbstripout --install
  ```

  After that, just work and commit normally (`git add` / `git commit`, or the
  VS Code Source Control panel) — no manual output-clearing step needed.

## Status

Repository prepared for peer review (private). Will be made public on acceptance.
