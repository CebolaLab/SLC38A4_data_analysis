Updated on 12/06/2025
Updated by Hannah

Copying ATAC-seq files from an internal lab directory to be stored here. Peak calling carried out by Lowri.

### Peak calling for individual datasets
Scripts are contained within each folder (e.g. ENCSR516CPW_liver_right_lobe_female_DONE/ENCSR516CPW_macs2.sh) and call macs2 to define peaks in narrow mode:

$ macs2 callpeak -f BAMPE --nomodel --shift 37 --extsize 73 --call-summits -B -g 2805636331 -q 0.01 --keep-dup all \
	--cutoff-analysis -n ENCSR952SPO -t rep1.shifted.bam rep2.shifted.bam --outdir ENCSR952SPO_macs2 

### Peak calling for COMBINED datasets
Peaks were called for ALL combined samples, the script can be seen at "macs2_peak_calling_ALL_combined_liver.sh"

Files originally from:
$ cp ../../../Lowri/pooled.pooled_ATAC.sh macs2_peak_calling_ALL_combined_liver.sh
$ cp -r ../../../Lowri/pooled.pooled_macs2 ALL_combined_macs2

$ macs2 callpeak -f BAMPE --nomodel \
	--shift 37 \
	--extsize 73 \
	--call-summits -B \
	-g 2805636331 \
	-q 0.01 \
	--keep-dup all \
	--cutoff-analysis \
	-n pooled_ENCODE_wholeLiver \
	-t ENCSR952SPO_rep1.shifted.bam ENCSR952SPO_rep2.shifted.bam ENCSR836FIL_rep1.shifted.bam \
		ENCSR836FIL_rep2.shifted.bam ENCSR685ZMP_rep1.shifted.bam ENCSR685ZMP_rep2.shifted.bam \
		ENCSR624ODL_rep1.shifted.bam ENCSR624ODL_rep2.shifted.bam ENCSR607BTF_rep1.shifted.bam \
		ENCSR607BTF_rep2.shifted.bam ENCSR516CPW_rep1.shifted.bam ENCSR516CPW_rep2.shifted.bam \
	--outdir pooled.pooled_macs2

The narrowPeak files contain redundant peaks, so I created sorted and non-redundant bed files:

$ chrName=/path/to/reference/GRCh38_gencode44/chrName.txt 
$ bedtools sort -g "${chrName}" -i pooled_ENCODE_wholeLiver_peaks.narrowPeak | cut -f 1-3 | uniq > pooled_ENCODE_wholeLiver_peaks_SORTED.bed
$ bedtools sort -g "${chrName}" -i ENCSR516CPW_peaks.narrowPeak | cut -f 1-3 | uniq > ENCSR516CPW_peaks_SORTED.bed
$ bedtools sort -g "${chrName}" -i ENCSR607BTF_peaks.narrowPeak | cut -f 1-3 | uniq > ENCSR607BTF_peaks_SORTED.bed
$ bedtools sort -g "${chrName}" -i ENCSR624ODL_peaks.narrowPeak | cut -f 1-3 | uniq > ENCSR624ODL_peaks_SORTED.bed
$ bedtools sort -g "${chrName}" -i ENCSR685ZMP_peaks.narrowPeak | cut -f 1-3 | uniq > ENCSR685ZMP_peaks_SORTED.bed
$ bedtools sort -g "${chrName}" -i ENCSR836FIL_peaks.narrowPeak | cut -f 1-3 | uniq > ENCSR836FIL_peaks_SORTED.bed
$ bedtools sort -g "${chrName}" -i ENCSR952SPO_peaks.narrowPeak | cut -f 1-3 | uniq > ENCSR952SPO_peaks_SORTED.bed

### Defining replicated peaks

Replicated peak calling repeated 12/06/2025 to use the new define_replicated_peaks.sh which requires a 50% overlap for consistency with ENCODE.

The file Liver_ATAC_replicated_peaks.bed should be used. Note it is a symbolic link to replicated_peaks/replicated_peaks_min3.bed.

$ eval "$(~/anaconda3/bin/conda shell.bash hook)"
$ source activate ATAC
$ sh replicated_peaks/define_replicated_peaks.sh \
	-p pooled_ENCODE_wholeLiver_peaks_SORTED.bed \
	-i ENCSR516CPW_peaks_SORTED.bed,ENCSR952SPO_peaks_SORTED.bed,ENCSR836FIL_peaks_SORTED.bed,ENCSR685ZMP_peaks_SORTED.bed,ENCSR624ODL_peaks_SORTED.bed,ENCSR607BTF_peaks_SORTED.bed \
	-m 3 > replicated_peaks.log
