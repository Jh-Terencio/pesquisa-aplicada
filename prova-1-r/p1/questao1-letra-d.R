wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', sep = ',',col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

plot_boxplot_class <- function(data, variable, label_x, colors) {
  ggplot(data, aes(x = factor(Type), y = !!sym(variable), fill = factor(Type))) +
    geom_boxplot(alpha = 0.7, outlier.shape = NA) +
    labs(title = paste("Boxplot of", label_x),
         x = "Wine Type",
         y = label_x) +
    scale_fill_manual(values = colors) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

plots <- list()

for(col_name in colnames(wines)[-1]) {plots[[col_name]] <- plot_boxplot_class(wines, col_name, paste(col_name,'by Wine Type'), colors = c('#0099e5', '#ff4c4c', '#34bf49'))}

boxplot_grouped <- do.call(grid.arrange, c(plots, ncol = 3))
boxplot_grouped

