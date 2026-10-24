# SLC38A4 in alcohol-related hepatitis — analysis code

Analysis notebooks and data supporting:

> **Cebola I, Tebeka NN, Atkinson SR, *et al.*
> Systematic Interrogation of Hepatic SLC Transporters Identifies SLC38A4 as a Driver of
> Severe Alcohol-Related Hepatitis.** Submitted to the *Journal of Hepatology*.

Cebola lab, Imperial College London.

## Repository structure

```
.
├── *.ipynb                   Analysis notebooks, one (or a small group) per figure/table
├── *.csv / *.xlsx / *.bed    Input and result data used by the notebooks
├── *.pdf                     Rendered figure panels
├── enrichment_cache_.../     Cached pathway-enrichment queries (see Reproducing, below)
├── liver_cCREs/              ENCODE Registry of cCREs, liver biosamples — see its own README
├── luciferase_data/          Luciferase assay plate and construct metadata
├── reference/                Reference gene sets and published signatures
└── requirements.txt
```

Data and figure files sit next to the notebook that produces them, flat rather than in
per-notebook subfolders, so each notebook's inputs and outputs are easy to find by filename.

## Notebook → figure/table mapping

One notebook per dataset or analysis rather than strictly one per panel: panels sharing a
differential-expression run or an experiment are grouped together.

| Notebook | Produces |
|---|---|
| `Fig1_SLC_dysregulation_InTEAM.ipynb` | Fig. 1B (violin), 1C (heatmap), 1D (trajectory); Fig. S1A–C; Fig. S2A; Table S2 |
| `Fig1_ISAIAH_validation.ipynb` | Fig. 1E (MELD correlation, with an rmcorr repeated-measures sensitivity check), 1F; Fig. S3A, S3B–C |
| `Fig2C_SLC38A4_cell_type_expression_analysis.ipynb` | Fig. 2C — SLC38A4 cell-type expression |
| `Fig2D_SLC38A4_SAH_mediators_analysis.ipynb` | Fig. 2D — SAH mediators |
| `Fig3A_SLC38A4_KO_confirmation_analysis.ipynb` | Fig. 3A (RT-qPCR KO confirmation); Fig. S6C (TaqMan validation, guide-RNA region) |
| `Fig3BC_S7_KO_RNAseq_overview.ipynb` | Fig. 3B (PCA), 3C (volcano); Fig. S7 (cross-clone concordance); Table S5 |
| `Fig3_KO_RNAseq_metabolism.ipynb` | Fig. 3D (pathway enrichment), 3E (urea-cycle schematic); Fig. S8A (leading-edge bar and heatmap); Table S6 |
| `SLC38A4_KO_GSEA_clone_robustness_check.ipynb` | Fig. S8B — per-clone robustness forest plot for the Fig. 3D KEGG terms, the Fig. 4E SAH signature, and the developmental signatures |
| `SLC38A4_KO_developmental_signature_analysis.ipynb` | Pooled-contrast developmental-signature GSEA underlying Fig. S8B |
| `Fig3F_Fig3IJ_ureagenesis_CYP.ipynb` | Fig. 3F (urea secretion after NH₄Cl challenge), 3I (RT-qPCR: CYP3A4, CYP7A1, ABCB11, ABCC2), 3J (CYP3A4 activity, P450-Glo) |
| `Fig3G_S9AB_metabolomics.ipynb` | Fig. 3G (System A substrates and urea-cycle intermediates); Fig. S9A–C; Tables S7, S8 |
| `Fig3H_transporter_concordance.ipynb` | Fig. 3H — System A/N transporter concordance, SLC38A4-KO vs SAH liver |
| `Fig4_KO_RNAseq_dedifferentiation.ipynb` | Fig. 4B (foetal HNF4A P2 isoform fraction), 4D (cell-cycle signature), 4E (pre-ranked GSEA); Fig. S10A, S10D |
| `Fig5_LD_expansion_cCRE_filtering.ipynb` | Tables S12 (CAGE transcript evidence), S13 (per-variant LD and cCRE evidence), S14 (per-dataset chromatin evidence at rs4994910) |
| `Fig5B_luciferase_mixed_model.ipynb` | Fig. 5B — luciferase reporter assay, linear mixed model |
| `Table1_variant_coordinate_liftover.ipynb` | Table 1 — GRCh37→GRCh38 variant liftover |

Several notebooks also export supporting panels that are not numbered in the paper — QC plots,
pathway-enrichment overviews, per-clone sensitivity checks and alternative renderings of
published panels. These are kept so the supporting analyses behind each figure can be
inspected, and are identifiable by filenames that carry no figure number.

### Panels not produced by code in this repository

- **Fig. 2A** — GTEx expression, sourced externally and composed in Illustrator; described in
  SI Methods.
- **Fig. 2B** — scRNA-seq UMAP (Aizarani *et al.*); the pipeline is described in SI Methods,
  the notebook is not included here.
- **Fig. 4A** — immunofluorescence KO validation images.
- **Fig. 4C** — HNF4A P1/P2 RNA-seq coverage tracks, composed from a genome browser. The
  underlying coverage job is in `1_hnf4a_coverage.pbs` / `2_plot_hnf4a.sh` / `hnf4a_tracks.ini`.
- **Fig. 5A** — genome-browser locus figure, composed from the evidence tables produced by
  `Fig5_LD_expansion_cCRE_filtering.ipynb`.
- **Fig. 5C** — transcription-factor motif disruption (motifBreakR). The result file
  (`Table_S15_TF_motif_disruption.xlsx`) and its PWM inputs are included; the script that
  produced them is not.

## Data folders

- **`liver_cCREs/`** — ENCODE Registry of candidate cis-regulatory elements for liver
  biosamples, plus pooled liver ATAC-seq and H3K27ac peak sets. Full documentation, caveats and
  re-download instructions are in `liver_cCREs/README.md`.
- **`luciferase_data/`** — plate and construct metadata for the luciferase reporter assay.
- **`reference/`** — published liver developmental signatures and the liver-atlas hepatocyte
  DEG table they derive from.
- **`enrichment_cache_FDR0.05_FC1/`** — cached Enrichr and MSigDB pre-ranked GSEA results.

## Reproducing an analysis

```bash
pip install -r requirements.txt
jupyter notebook
```

Each notebook is self-contained: it reads its inputs from this folder and writes its outputs
back into it. Notebooks are committed with their outputs, so the results reported in the paper
can be read without re-running anything.

`Fig3_KO_RNAseq_metabolism.ipynb` queries Enrichr and MSigDB over the internet. Its
`REFRESH_FROM_INTERNET` toggle controls whether those analyses are re-queried live or read from
the cache shipped in `enrichment_cache_FDR0.05_FC1/`; the cached results are the ones behind the
figures in the paper. Deleting a cache file forces a live re-query for that analysis.

## Status

Repository prepared for peer review (private). Will be made public on acceptance.
