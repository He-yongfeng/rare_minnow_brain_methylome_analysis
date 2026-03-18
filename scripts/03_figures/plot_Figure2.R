# ==========================
# Figure 2: Feature methylation (NO statistics)
# ==========================

library(tidyverse)
library(patchwork)

# ==========================
# 1. Input
# ==========================
data_dir <- "data"
file_feature <- file.path(data_dir, "feature_methylation_matrix.tsv")

df <- read_tsv(file_feature)

# ==========================
# 2. Factor levels
# ==========================
df <- df %>%
mutate(
  Age_group = factor(
    Age_group,
    levels = c("8 months","44 months","74 months")
  ),
  Feature = factor(
    Feature,
    levels = c("Up2k","CDS","mRNA","Down2k","CpG island","Repeat")
  )
)

# ==========================
# 3. Long format
# ==========================
df_long <- df %>%
pivot_longer(
  cols = c(`mCG%`,`mCHG%`,`mCHH%`),
  names_to = "Context",
  values_to = "Methylation"
)

# ==========================
# 4. Colors
# ==========================
cols <- c(
"8 months" = "#3C5488",
"44 months" = "#00A087",
"74 months" = "#E64B35"
)

# ==========================
# 5. Plot function
# ==========================
plot_context <- function(context_name){

data_sub <- df_long %>% filter(Context == context_name)

pd <- position_dodge(0.35)

ggplot(data_sub,
aes(Feature, Methylation,
color = Age_group,
shape = Age_group)) +

stat_summary(
fun = mean,
geom = "point",
size = 3.2,
position = pd
) +

stat_summary(
fun.data = mean_sdl,
fun.args = list(mult = 1),
geom = "errorbar",
width = 0.1,
linewidth = 0.25,
alpha = 0.7,
position = pd
) +

scale_color_manual(values = cols) +
scale_shape_manual(values = c(16,17,15)) +

theme_classic(base_size = 8.5) +

theme(
axis.text.x = element_text(angle = 25, hjust = 1, size = 8),
axis.text.y = element_text(size = 8),
axis.title.y = element_text(size = 9, face = "bold"),
legend.position = "bottom",
legend.title = element_blank(),
legend.text = element_text(size = 8),
plot.title = element_text(hjust = 0.5, size = 10, face="bold"),
plot.margin = margin(4,6,4,6)
) +
labs(
title = gsub("^m|%","",context_name),
y = "Mean methylation (%)",
x = NULL
)
}

# ==========================
# 6. Generate panels
# ==========================
p1 <- plot_context("mCG%")
p2 <- plot_context("mCHG%")
p3 <- plot_context("mCHH%")

# ==========================
# 7. Save 
# ==========================
final_plot <-
(p1 + p2 + p3) +
plot_layout(ncol = 3, guides = "collect") +
plot_annotation(tag_levels = "a")

final_plot <- final_plot &
theme(
plot.tag = element_text(size = 12, face = "bold"),
plot.tag.position = c(0.01,0.98),
legend.position="bottom",
legend.key.width = unit(0.6,"cm"),
legend.direction="horizontal"
)

final_plot

ggsave(
"Figure2.tiff",
final_plot,
width=180,
height=110,
units="mm",
dpi=600,
compression="lzw",
device = ragg::agg_tiff
)
