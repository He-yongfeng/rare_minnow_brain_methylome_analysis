# ==========================
# 0. Libraries
# ==========================
library(ggplot2)
library(dplyr)
library(patchwork)
library(VennDiagram)
library(grid)
library(ggplotify)

# ==========================
# 1. Input
# ==========================
data_dir <- "data"

dmr_file <- file.path(data_dir, "DMR_full_results.tsv")
summary_file <- file.path(data_dir, "DMR_summary.tsv")
feature_file <- file.path(data_dir, "DMR_feature_summary.tsv")
gene_file <- file.path(data_dir, "DMR_gene_list.tsv")

# ==========================
# 2. Load data
# ==========================
dmr_all <- read.delim(dmr_file)
dmr_count <- read.delim(summary_file)
anno <- read.delim(feature_file)
gene_data <- read.delim(gene_file)

# ==========================
# 3. Factor order
# ==========================
dmr_count$Comparison <- factor(
dmr_count$Comparison,
levels=c("8m vs 44m","44m vs 74m","8m vs 74m")
)

anno$Comparison <- factor(
anno$Comparison,
levels=c("8m vs 44m","44m vs 74m","8m vs 74m")
)

# ==========================
# 4. Figure A
# ==========================
p1 <- ggplot(dmr_count,
aes(x=Comparison,y=Number,fill=Type))+
geom_bar(stat="identity",width=0.7)+
scale_fill_manual(values=c(
Hypermethylated="#E64B35",
Hypomethylated="#4DBBD5"
))+
theme_classic()+
theme(legend.position="top")

# ==========================
# 5. Figure B
# ==========================
p2 <- ggplot(dmr_all,aes(x=Length))+
geom_histogram(binwidth=20,
fill="#7E6148",color="white")+
coord_cartesian(xlim=c(0,1000))+
theme_classic()

# ==========================
# 6. Figure C
# ==========================
p3 <- ggplot(anno,
aes(x=Comparison,y=Number,fill=element))+
geom_bar(stat="identity",position="fill")+
theme_classic()+
theme(legend.position="top")

# ==========================
# 7. Figure D (Venn)
# ==========================
genes_8_44 <- unique(gene_data$GeneSymbol[gene_data$Comparison=="8m vs 44m"])
genes_44_74 <- unique(gene_data$GeneSymbol[gene_data$Comparison=="44m vs 74m"])
genes_8_74 <- unique(gene_data$GeneSymbol[gene_data$Comparison=="8m vs 74m"])

venn.grob <- draw.triple.venn(
area1=length(genes_8_44),
area2=length(genes_44_74),
area3=length(genes_8_74),
n12=length(intersect(genes_8_44,genes_44_74)),
n23=length(intersect(genes_44_74,genes_8_74)),
n13=length(intersect(genes_8_44,genes_8_74)),
n123=length(Reduce(intersect,list(genes_8_44,genes_44_74,genes_8_74))),
category=c("8m vs 44m","44m vs 74m","8m vs 74m"),
fill=c("#4DBBD5","#E64B35","#00A087"),
alpha=0.5,
scaled=FALSE
)

p4 <- as.ggplot(grobTree(venn.grob)) + theme_void()

# =========================
# 8. Save panels individually
# ==========================

ggsave(
"Figure2A_DMR_count.tiff",
p1,
width = 85,
height = 70,
units = "mm",
dpi = 600
)

ggsave(
"Figure2B_DMR_length.tiff",
p2,
width = 85,
height = 70,
units = "mm",
dpi = 600
)

ggsave(
"Figure2C_DMR_annotation.tiff",
p3,
width = 85,
height = 70,
units = "mm",
dpi = 600
)

ggsave(
"Figure2D_DMR_venn.tiff",
p4,
width = 85,
height = 70,
units = "mm",
dpi = 600
)

