library(tidyverse)
library(patchwork)

source("scripts/utils.R")

data_dir <- "data"
fig_dir  <- "figures"
res_dir  <- "results"

dir_create_safe(data_dir)
dir_create_safe(fig_dir)
dir_create_safe(res_dir)
