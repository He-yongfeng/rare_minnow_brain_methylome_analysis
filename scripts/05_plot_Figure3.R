# ==========================
# 1. Input
# ==========================
data_dir <- "data"

file_chromosome <- file.path(data_dir, "chromosome_methylation_summary.tsv")
df <- read_tsv(file_chromosome)

# rename
df <- df %>%
rename(
Chromosome = Chromoso
)
# fix age group
df$Age_group <- factor(
  df$Age_group,
  levels = c("8 months","44 months","74 months")
)

# chromosome sort
df$Chromosome <- factor(df$Chromosome,
                        levels = paste0("Chr.",1:26))
#-----------------------------
# 2 long format
#-----------------------------
df_long <- df %>%
pivot_longer(
cols = -c(Chromosome, Age_group),
names_to = c("Context",".value"),
names_pattern = "(CG|CHG|CHH)_(.*)"
)

#-----------------------------
# 3 color
#-----------------------------
age_colors <- c(
"8 months" = "#4C72B0",
"44 months" = "#DD8452",
"74 months" = "#55A868"
)
#-----------------------------
# 4 plot
#-----------------------------
plot_context <- function(context_name){

df_long %>%
filter(Context == context_name) %>%

ggplot(aes(x=Chromosome,
           y=mean,
           fill=Age_group))+

geom_bar(stat="identity",
         position=position_dodge(0.8),
         width=0.7)+

geom_errorbar(aes(ymin=mean-SD,
                  ymax=mean+SD),
              position=position_dodge(0.8),
              width=0.2,
              size=0.3)+

scale_fill_manual(values=age_colors, breaks = c("8 months","44 months","74 months"))+


theme_bw(base_size=10)+

theme(
axis.text.x=element_text(angle=45,hjust=1,size=8),
legend.position="top",
legend.title=element_blank(),
panel.grid.major=element_blank(),
panel.grid.minor=element_blank()
)+

labs(
x=NULL,
y=paste0(context_name," methylation (%)")
)

}
#-----------------------------
# 5 three panels
#-----------------------------
p1 <- plot_context("CG")

p2 <- plot_context("CHG") +
theme(legend.position="none")

p3 <- plot_context("CHH") +
theme(legend.position="none") +
labs(x="Chromosome")

#-----------------------------
# 6 Combined Figure
#-----------------------------
Figure3 <- (p1 / p2 / p3) +
plot_annotation(tag_levels="a")

Figure3

#-----------------------------
# 7 save
#-----------------------------
tiff(
  "Figure3.tiff",
  width = 10,
  height = 8,
  units = "in",
  res = 600,
  compression = "lzw"
)

print(Figure3)

dev.off()
