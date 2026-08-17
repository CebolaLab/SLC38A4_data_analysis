Updated on 16/05/2025 by Hannah.

Redefined hepatocyte replicated peaks using narrow peak calling. Required replication in at least 3/6 donors.

Individual peaks called using -p 0.05.

sh define_replicated_peaks.sh -p Ins_pooled_narrow_peaks.narrowPeak \
	-i PHH4190-Ins_peaks.narrowPeak,PHH191381-Ins_peaks.narrowPeak,PHH183231-Ins_peaks.narrowPeak,PHH183001-Ins_peaks.narrowPeak,PHH182851-Ins_peaks.narrowPeak,PHH180051-Ins_peaks.narrowPeak \
	-m 3 \
	-g chrName.txt 

Pooled peaks defined using:
macs2 callpeak -f BAMPE --nomodel --shift 37 --extsize 73 -B -q 0.01 \
	-g 2862010578 --keep-dup all --cutoff-analysis \
	-n "$condition"_pooled_narrow \
	-t *blacklist-filtered.bam --outdir "$condition"_pooled_narrow