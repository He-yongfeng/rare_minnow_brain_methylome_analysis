# =========================================================
# PCA analysis (no plotting)
# =========================================================

library(data.table)
# -----------------------------
# 1. Paths
# -----------------------------
data_dir <- "data"
output_dir <- "results/PCA"

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# 输入：Figshare提供的数据
CG_file  <- file.path(data_dir, "PCA_top10000_methylation_matrix_CG.tsv")
CHG_file <- file.path(data_dir, "PCA_top10000_methylation_matrix_CHG.tsv")
CHH_file <- file.path(data_dir, "PCA_top10000_methylation_matrix_CHH.tsv")

# -----------------------------
# 2. PCA function
# -----------------------------
run_pca <- function(matrix_file){

  cat("Processing:", matrix_file, "\n")

  mat <- fread(matrix_file)

  context_name <- gsub("PCA_top10000_methylation_matrix_|_.tsv", "", basename(matrix_file))

  # 第一列是 CpG_ID
  cpg_id <- mat[[1]]
  mat <- as.data.frame(mat[,-1])

  rownames(mat) <- cpg_id

  # 转置：行=sample，列=CpG
  mat <- t(mat)

  # -----------------------------
  # PCA计算
  # -----------------------------
  pca <- prcomp(mat, scale. = TRUE)

  # 保存 PCA坐标（核心中间结果）
  pca_coords <- data.frame(
    Sample_ID = rownames(pca$x),
    pca$x
  )

  outfile <- file.path(
    output_dir,
    paste0("PCA_coordinates_", context_name, ".tsv")
  )

  fwrite(pca_coords, outfile, sep = "\t")

  cat("Saved:", outfile, "\n")
}

# -----------------------------
# 3. Run PCA
# -----------------------------
run_pca(CG_file)
run_pca(CHG_file)
run_pca(CHH_file)

cat("PCA analysis completed.\n")
