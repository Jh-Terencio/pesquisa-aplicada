# Lendo os dados
wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', sep = ',', col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

vinhos_discretizados = wines %>%
  mutate(across(.cols = !(Type), .fns = function(x) {
    breaks = quantile(x, probs = seq(0, 1, by = 1/3))
    labels = c('Baixo', 'Médio', 'Alto')
    cut(x, breaks, labels, include.lowest = TRUE)
  }))

cm = categ_mapping('Type')

categorias_mapeadas = cbind(transform(cm, vinhos_discretizados), vinhos_discretizados[-1])
categorias_mapeadas