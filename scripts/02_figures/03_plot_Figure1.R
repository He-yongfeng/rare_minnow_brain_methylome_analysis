# =========================================================
# Plot Figure 1 from PCA results
# =========================================================

library(data.table)
library(ggplot2)
library(patchwork)

# -----------------------------
# 1. Paths
# -----------------------------
data_dir <- "data"
input_dir <- "results/PCA"
output_dir <- "results/figures"

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

meta_file <- file.path(data_dir, "sample_metadata.tsv")

# PCA½á¹ûÎÄ¼þ
CG_pca  <- file.path(input_dir, "PCA_coordinates_PCA_methylation_matrix_CG.tsv")
CHG_pca <- file.path(input_dir, "PCA_coordinates_PCA_methylation_matrix_CHG.tsv")
CHH_pca <- file.path(input_dir, "PCA_coordinates_PCA_methylation_matrix_CHH.tsv")

# -----------------------------
# 2. Load metadata
# -----------------------------
metadata <- fread(meta_file)

metadata$Age_group <- factor(
  metadata$Age_group,
  levels = c("8 months", "44 months", "74 months")
)

# -----------------------------
# 3. Plot function
# -----------------------------
plot_pca <- function(pca_file, title){

  pca_df <- fread(pca_file)

  pca_df <- merge(pca_df, metadata, by = "Sample_ID")

  p <- ggplot(pca_df, aes(PC1, PC2, color = Age_group)) +
    geom_point(size = 2.8, alpha = 0.9) +

    labs(
      x = "PC1",
      y = "PC2",
      title = title
    ) +

    scale_color_manual(values = c(
      "#1f78b4",
      "#33a02c",
      "#e31a1c"
    )) +

    coord_equal() +
    theme_bw(base_size = 6) +

    theme(
      panel.grid = element_blank(),
      legend.title = element_blank(),
      legend.position = "right",
      legend.key.height = unit(0.35,"cm"),
      legend.spacing.y = unit(0.02,"cm"),
      legend.text = element_text(size = 5),
      axis.title = element_text(size = 6),
      axis.text = element_text(size = 5),
      plot.title = element_text(size = 7, face = "bold", hjust = 0.5)
    )

  return(p)
}

# -----------------------------
# 4. Generate plots
# -----------------------------
p1 <- plot_pca(CG_pca,  "CG context")
p2 <- plot_pca(CHG_pca, "CHG context")
p3 <- plot_pca(CHH_pca, "CHH context")

# -----------------------------
# 5. Combine panels
# -----------------------------
Figure1 <- (p1 | p2 | p3) +
  plot_layout(guides = "collect") +
  plot_annotation(tag_levels = "a") &
  theme(legend.position = "right")

# -----------------------------
# 6. Save
# -----------------------------
outfile <- file.path(output_dir, "Figure1_PCA.tiff")

tiff(outfile, width = 180, height = 70, units = "mm", res = 600, compression = "lzw")
print(Figure1)
dev.off()

cat("Figure saved:", outfile, "\n")
