# Carregar o pacote ggplot2
library(ggplot2)

wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data',sep = ',', col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

plots = list()

for(col_name in colnames(wines)[-1]) {
  plots[[col_name]] = plot_boxplot_class(wines %>% select(Type, all_of(col_name)), 'Type', 
                      label_x = paste(col_name, 'by wine Type'), 
                      colors = c('#0099e5', '#ff4c4c', '#34bf49'))
  
}

boxplot_grouped = grid.arrange(grobs = plots, ncol = 5)

rm(plots)

