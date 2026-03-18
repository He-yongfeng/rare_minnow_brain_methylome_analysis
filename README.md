# WGBS methylation analysis during aging

## Overview
This repository provides R scripts used to analyze whole-genome bisulfite sequencing (WGBS) data across three age groups (8, 44, and 74 months). The analyses include principal component analysis (PCA), identification of differentially methylated regions (DMRs), and generation of figures presented in the manuscript.

The workflow includes:
- Principal component analysis (PCA)
- Identification and summarization of differentially methylated regions (DMRs)
- Generation of all figures presented in the manuscript

All analyses are fully reproducible using publicly available processed data.

---

## Data availability
All processed methylation data are publicly available on Figshare:

DOI: https://doi.org/10.6084/m9.figshare.31769062

The dataset includes:
- CpG methylation matrices (top variable sites for PCA)
- Chromosome_methylation_matrix
- Feature_methylation_matrix
- Genome-wide DMR results
- DMR summary statistics
- Genomic feature annotation tables
- Gene lists used for Venn diagram analysis

---

## Repository structure

- data/       # Input data (download from figshare)
- scripts/    # R scripts for analysis and plotting
- figures/    # Output figures

---

## Requirements

- R (>= 4.2)
- Required packages:
  - data.table
  - dplyr
  - ggplot2
  - patchwork
  - VennDiagram
  - ggplotify
Install dependencies in R:
install.packages(c("data.table","dplyr","ggplot2","patchwork","VennDiagram","ggplotify"))

---

## Reproducibility

All results can be reproduced by running the complete workflow:
Rscript run_all.R

---

## Stepwise execution
Alternatively, scripts can be executed step by step:
- Rscript scripts/01_processing/DMR_processing.R
- Rscript scripts/02_analysis/PCA_analysis.R
- Rscript scripts/03_figures/plot_Figure1.R
- Rscript scripts/03_figures/plot_Figure2.R
- Rscript scripts/03_figures/plot_Figure3.R
- Rscript scripts/03_figures/plot_Figure4.R

## Output

All figures will be saved in the figures/ directory.
Figure panels for Figure 4 are generated individually in R and can be assembled into composite figures if needed.


## Usage notes
Download all processed data from Figshare and place them in the data/ directory before running any scripts.
File paths within scripts may require minor adjustment depending on the local computing environment.
The workflow assumes preprocessed methylation data and does not include raw sequencing data processing steps.


## Code availability
All scripts used in this study are provided in this repository and allow full reproduction of the reported results.


## Citation
If you use this repository or the associated dataset, please cite the corresponding publication and Figshare dataset.
