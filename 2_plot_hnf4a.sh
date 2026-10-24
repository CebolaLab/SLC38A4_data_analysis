#!/bin/bash
# =============================================================================
# Render the HNF4A P1/P2 coverage figure with pyGenomeTracks.
# Run from the coverage output dir (where per_group/*.bpm.bw live), after
# copying hnf4a_tracks.ini here and creating hnf4a.gtf (see step A).
#
#   module load miniforge/3   # (or whatever `module spider` shows on your cluster)
#   conda activate coverage
#   bash 2_plot_hnf4a.sh
# =============================================================================
set -euo pipefail

# ---- A. gene model: extract HNF4A from a GENCODE/Ensembl GTF ----------------
# Use the SAME annotation build as your BAMs (GRCh38 here). Point GTF at your
# reference, e.g. gencode.v44.primary_assembly.annotation.gtf.
GTF=/path/to/reference/Homo_sapiens.GRCh38.96.gtf   # Ensembl 96
if [[ ! -f hnf4a.gtf ]]; then
  awk -F'\t' '$3=="transcript" || $3=="exon"' "$GTF" | grep 'gene_name "HNF4A"' > hnf4a.gtf
  echo "hnf4a.gtf: $(wc -l < hnf4a.gtf) lines"
fi

# ---- B. coordinates (GRCh38, Ensembl chrom '20', + strand) ------------------
# Ensembl 96 names the chromosome '20' (no 'chr'); this must match your BAMs.
# Confirm from the BAM @SQ header (step 0 of the .pbs).
FULL="20:44,350,000-44,440,000"     # whole HNF4A locus, both promoters + margin

pyGenomeTracks --tracks hnf4a_tracks.ini --region "$FULL" \
    --dpi 300 --trackLabelFraction 0.15 -o HNF4A_locus_coverage.pdf
echo "Wrote HNF4A_locus_coverage.pdf"

# ---- C. zoom on each promoter ------------------------------------------------
# In the full-locus view, two clusters of transcript start sites are visible:
#   * the DISTAL (5', lower-coordinate) first exon  = P2 promoter (foetal, exon 1D)
#   * the PROXIMAL/internal first exon (~45.6 kb 3') = P1 promoter (adult, exon 1A)
#
# Render windows actually used for the published figure (2,000 bp each,
# pyGenomeTracks '20:' naming, no 'chr' prefix to match the Ensembl 96 BAMs):
P2_REGION="20:44,354,752-44,356,751"
P1_REGION="20:44,400,370-44,402,369"

pyGenomeTracks --tracks hnf4a_tracks.ini --region "$P2_REGION" --dpi 300 -o HNF4A_P2_foetal.pdf
pyGenomeTracks --tracks hnf4a_tracks.ini --region "$P1_REGION" --dpi 300 -o HNF4A_P1_adult.pdf

# NOTE ON THE PUBLISHED FIGURE: HNF4A_P2_foetal.pdf and HNF4A_P1_adult.pdf were
# each subsequently cropped to half their rendered width in Illustrator, keeping
# the same centre position, for the final Fig. 4C panel. The displayed (post-crop)
# windows are therefore:
#   P2 (foetal): chr20:44,355,252-44,356,251  (1,000 bp)
#   P1 (adult):  chr20:44,400,870-44,401,869  (1,000 bp)
