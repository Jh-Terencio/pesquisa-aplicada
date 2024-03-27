wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', sep = ',',col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

plot_density_class <- function(data, variable, label_x, colors, alpha) {
  ggplot(data, aes(x = !!sym(variable), fill = factor(Type))) +
    geom_density(alpha = alpha) +
    labs(title = paste("Density Plot of", label_x),
         x = label_x,
         y = "Density") +
    scale_fill_manual(values = colors) +
    theme_minimal()
}

plots <- list()

for(col_name in colnames(wines)[-1]) { plots[[col_name]] <- plot_density_class(wines, col_name, paste(col_name 'by Wine Type'), colors = c('#0099e5', '#ff4c4c', '#34bf49'), alpha = 0.7)}

density_plot_grouped <- do.call(grid.arrange, c(plots, ncol = 3))
density_plot_grouped