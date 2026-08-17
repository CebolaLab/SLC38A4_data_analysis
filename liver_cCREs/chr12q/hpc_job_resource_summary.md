# HPC Job Resource Summary

| Job | Walltime | CPU Time | CPU % | Peak Memory |
|---|---|---|---|---|
| slc38a4_ko_limma.o3404972 | 00:05:14 | 00:00:31 | 44% | 266 MB |
| slc38a4_ko_limma_mincount10.o3445067 | 00:00:43 | 00:00:00 | 0% | 0 MB |
| rsem_scwt5_rerun.o3407601 | 00:53:17 | 03:27:45 | 590% | 34.4 GB |
| hnf4a_coverage.o3494041 | 01:42:10 | 09:54:25 | 792% | 640 MB |
| slc38a4_ko_limma.o3408263 | 00:07:00 | 00:00:29 | 19% | 265 MB |

**Notes:**
- `slc38a4_ko_limma_mincount10.o3445067` ran for 43s with 0% CPU and 0 MB memory — likely failed before starting; needs investigation.
- `rsem_scwt5_rerun.o3407601` was a resource-intensive rerun (~7 cores, 34.4 GB RAM, 53 min walltime).
- `hnf4a_coverage.o3494041` was the longest and most parallelized job (~8 cores, 1h42m walltime).
- A prior failed attempt (`rsem_scwt5_rerun.o3407401`) is excluded from this summary.
