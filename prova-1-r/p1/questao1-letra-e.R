wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', sep = ',',col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

wines$Type <- as.factor(wines$Type)

plots <- list()

attrs <- colnames(wines)[-1]
len <- 5

for(i in 1:len) {
  for(j in 1:len) {
    if(i < j) {
      plots[[paste(attrs[i], attrs[j], sep = 'x')]] <- ggplot(wines, aes_string(x = attrs[i], y = attrs[j], color = 'Type')) +
        geom_point() +
        labs(x = attrs[i], y = attrs[j], color = "Type") +
        scale_color_manual(values = c('#0099e5', '#ff4c4c', '#34bf49'))
    }
  }
}

scatter_plot_grouped <- gridExtra::grid.arrange(grobs = plots, ncol = 5)

print(scatter_plot_grouped)

rm(plots)

