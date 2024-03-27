wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', sep = ',',col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

media <- apply(wines[,-1], 2, mean)
media_df <- data.frame(Média = media)
rownames(media_df) <- names(media)
media_df

desvio_padrao <- apply(wines[,-1], 2, sd)
desvio_padrao_df <- data.frame(`Desvio Padrão` = desvio_padrao)
rownames(desvio_padrao_df) <- names(desvio_padrao)
desvio_padrao_df