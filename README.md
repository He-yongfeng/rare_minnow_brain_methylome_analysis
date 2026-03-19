# WGBS methylation analysis during aging

## Overview
This repository contains R scripts for analyzing whole-genome bisulfite sequencing (WGBS) data across three age groups (8, 44, and 74 months). The analyses include principal component analysis (PCA), identification of differentially methylated regions (DMRs), and generation of all figures presented in the study.

The workflow is fully reproducible using publicly available processed datasets.

---

## Data availability
All processed data required to reproduce the analyses are publicly available on Figshare:

DOI: https://doi.org/10.6084/m9.figshare.31769062

The dataset includes:

- PCA_top10000_methylation_matrix_CG.tsv  
- PCA_top10000_methylation_matrix_CHG.tsv  
- PCA_top10000_methylation_matrix_CHH.tsv  
- chromosome_methylation_summary.tsv  
- chromosome_methylation_matrix.tsv  
- feature_methylation_summary.tsv  
- feature_methylation_matrix.tsv  
- DMR_full_results.tsv  
- DMR_feature_summary.tsv  
- DMR_gene_list.tsv  

**Note:**  
`DMR_summary.tsv` is not included in the Figshare repository. This file is generated from `DMR_full_results.tsv` using the script:

scripts/01_processing/DMR_processing.R


All files in the Figshare repository are provided in a flat structure (no subdirectories).

After downloading, please place all files into the following directory:

data/processed/

Ensure that the original file names are preserved, as the analysis scripts rely on fixed file paths.

---

## Repository structure

data/
  processed/        # Processed datasets (download from Figshare)
  metadata/         # Sample metadata

scripts/
  00_setup.R        # Environment setup
  utils.R           # Utility functions
  run_all.R         # Master pipeline script

  01_processing/    # Data processing scripts
  02_analysis/      # Statistical analysis scripts
  03_figures/       # Figure generation scripts

results/            # Intermediate analysis outputs
figures/            # Final figures

---

## Requirements

- R (>= 4.2)

Required R packages:
- data.table
- dplyr
- ggplot2
- patchwork
- VennDiagram
- ggplotify

Install dependencies in R:

install.packages(c(
  "data.table",
  "dplyr",
  "ggplot2",
  "patchwork",
  "VennDiagram",
  "ggplotify"
))

---

## Reproducibility

All analyses can be reproduced using a single command:

Rscript scripts/run_all.R

This script will:
1. Check all required input files  
2. Perform PCA analysis  
3. Process DMR results  
4. Generate all figures  
5. Save session information  

---

## Stepwise execution

Alternatively, scripts can be run step by step:

Rscript scripts/01_processing/DMR_processing.R  
Rscript scripts/02_analysis/PCA_analysis.R  
Rscript scripts/03_figures/plot_Figure1.R  
Rscript scripts/03_figures/plot_Figure2.R  
Rscript scripts/03_figures/plot_Figure3.R  
Rscript scripts/03_figures/plot_Figure4.R  

---

## Output

- All figures are saved in the `figures/` directory  
- Intermediate results are stored in `results/`  
- Session information is saved in `results/env/sessionInfo.txt`  

---

## Usage notes

1. Download all processed data from Figshare  
2. Place files in the `data/processed/` directory  
3. Run the pipeline using `run_all.R`  

No modification of file paths is required if the directory structure is preserved.

---

## Code availability
All scripts used in this study are provided in this repository and enable full reproduction of the reported results.

---

## Citation
If you use this repository or the associated dataset, please cite the corresponding publication and the Figshare dataset.
