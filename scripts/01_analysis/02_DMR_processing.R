  # ==========================
# 0. Libraries
# ==========================
library(dplyr)
library(data.table)

# ==========================
# 1. Input
# ==========================
data_dir <- "data"

dmr_file <- file.path(data_dir, "DMR_full_results.tsv")

# ==========================
# 2. Load data
# ==========================
dmr_all <- fread(dmr_file)

# ==========================
# 3. DMR Type
# ==========================
dmr_all$Type <- ifelse(
  dmr_all$methyl_diff > 0,
  "Hypermethylated",
  "Hypomethylated"
)

# ==========================
# 4. Length
# ==========================
dmr_all$Length <- dmr_all$end - dmr_all$start

# ==========================
# 5. Count summary
# ==========================
dmr_count <- dmr_all %>%
  group_by(Comparison, Type) %>%
  summarise(Number = n(), .groups="drop")

# ==========================
# 6. Length table
# ==========================
length_table <- dmr_all %>%
  select(Comparison, chr, start, end, Length, Type, methyl_diff)

# ==========================
# 7. Save outputs
# ==========================
write.table(dmr_count,
file="DMR_summary.tsv",
sep="\t", row.names=FALSE, quote=FALSE)

write.table(length_table,
file="DMR_length_table.tsv",
sep="\t", row.names=FALSE, quote=FALSE)

write.table(dmr_all,
file="DMR_full_results.tsv",
sep="\t", row.names=FALSE, quote=FALSE)

cat("DMR processing completed.\n")
