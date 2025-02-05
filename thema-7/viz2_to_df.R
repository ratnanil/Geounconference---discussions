library(tidyverse)
library(plotly)

rawdata <- yaml::read_yaml("viz3.rawgraphs")

mat <- do.call(rbind, rawdata$rawData)
df <- as.data.frame(mat)

colnames(df) <- c("Kategorie", "Initiative",	"Betreiber",	"Steuerung", "Nutzer",	"Aufwand",	"Beschreibung",	"color")

df <- df |> 
  select(Kategorie, Initiative, Betreiber) |> 
  distinct()

write_csv(df, "data.csv")

level1 <- unique(df$Kategorie)
level1_parents <- rep("", length(level1))
level1_ids <- paste(level1, level1_parents, sep = "-")

level2 <- df$Initiative
level2_parents <- df$Kategorie
level2_ids <- paste(level2, level2_parents, sep = "-")

level3 <- df$Betreiber
level3_parents <- df$Initiative
level3_ids <- paste(level3, level3_parents, sep = "-")


df2 <- data.frame(
  lables = c(level1, level2),
  parents = c(level1_parents, level2_parents),
  ids = c(level1_ids, level2_ids)
) |> 
  distinct(lables, parents)

df2 |> 
  mutate(ids = paste(lables, parents, sep = "-")) |> 
  plot_ly(
  labels = ~lables,
  parents = ~parents,
  type = "sunburst"
)

df2$lables[df2$parents == "Grundlegende Geodienste"] |> duplicated()


df[1:n, c("V1", "V4")]

plot_ly(labels = df$V4, parents = df$V1, values = as.integer(as.factor(df$V4)), type = "sunburst")
